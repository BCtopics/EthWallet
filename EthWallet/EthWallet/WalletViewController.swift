//
//  WalletViewController.swift
//  EthWallet
//
//  Created by Bradley Gilmore on 4/27/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController, UITextFieldDelegate, UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.refresh()
    }
    //Change the textField to be a searchbar later.
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        self.refresh()
        return false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.enterWalletAddress.delegate = self
        DispatchQueue.main.async {
            EthWalletController.fetchUSDollarAmount(completion: { (wallet) in
                guard let usd = wallet else { NSLog("wallet in fetchUSDDollarAmount was nil"); return }
                DispatchQueue.main.async {
                    let ethDollarAmount = "Ether is currently at: $\(usd.ethUSDAAmount)"
                    self.USDollarAmount.text = ethDollarAmount
                    self.tempStore = "\(usd.ethUSDAAmount)"
                }
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.amountLabel.text = self.balance
        }
    }
    
  
    //MARK: - weiToEther Calculation
    
        func weiToEther(balance: String) {
            var newBalance = balance
            _ = newBalance.remove(at: balance.index(before: balance.endIndex))
            guard let bradley:Int64 = Int64(newBalance) else { return }
            let value:Int64 = 100000000000000000
            
            let newBrad = Float(bradley)/Float(value)
            DispatchQueue.main.async {
                let wei = "You currently have \(String(newBrad)) Ether"
                self.amountLabel.text = wei
                
                self.balance = String(newBrad)
            }
            print(newBrad)
    }
    
    //MARK: - Properties
    
    var balance = ""
    var tempStore = ""
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var enterWalletAddress: UITextField!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var USDollarAmount: UILabel!
    @IBOutlet weak var yourUSDTotal: UILabel!
    
    
    //MARK: - IBActions
    
    @IBAction func showButtonTapped(_ sender: Any) {
        self.refresh()
    }
    
    
    //Search/Show Function
    
    func refresh(){
        DispatchQueue.main.async {
            EthWalletController.fetchWei(walletAdress: self.enterWalletAddress.text!) { (wallet) in
                guard let newWallet = wallet else { NSLog("Wallet in refresh function was nil") ;return }
                self.balance += newWallet.ethBalance
                self.weiToEther(balance: self.balance)
                
                let usdText = self.tempStore
                guard let usdValue = Float(usdText)?.rounded() else { return }
                guard let balance = Float(self.balance) else { NSLog("balance in refresh function is nil"); return }
                let newAmount = usdValue * balance
                self.yourUSDTotal.text = "Your Eth Balance is currently worth $\(newAmount)"
            }
        }
    }
}
