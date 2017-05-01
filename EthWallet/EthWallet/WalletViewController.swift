//
//  WalletViewController.swift
//  EthWallet
//
//  Created by Bradley Gilmore on 4/27/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            EthWalletController.fetchUSDollarAmount(completion: { (wallet) in
                let usd = wallet[0]
                DispatchQueue.main.async {
                    var ethDollarAmount = "Ether is currently at: $\(usd.ethUSDAAmount)"
                    self.USDollarAmount.text = ethDollarAmount
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
            }
            print(newBrad)
    }
    
    //MARK: - Properties
    
    var balance = ""
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var enterWalletAddress: UITextField!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var USDollarAmount: UILabel!
    
    
    //MARK: - IBActions
    
    @IBAction func showButtonTapped(_ sender: Any) {
        DispatchQueue.main.async {
            EthWalletController.fetchWei(walletAdress: self.enterWalletAddress.text!) { (wallet) in
                let newWallet = wallet[0]
                self.balance += newWallet.ethBalance
                self.weiToEther(balance: self.balance)
            }
        }
    }
}
