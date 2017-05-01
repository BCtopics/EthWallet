//
//  WalletViewController.swift
//  EthWallet
//
//  Created by ALIA M NEELY on 4/27/17.
//  Copyright © 2017 Wylan. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController {
    
    @IBOutlet weak var enterWalletAddress: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            EthWalletController.fetchUSDollarAmount(completion: { (wallet) in
                let usd = wallet[0]
                DispatchQueue.main.async {
                    self.USDollarAmount.text = usd.ethUSDAAmount
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
    
  
        func weiToEther(balance: String) {
            var newBalance = balance
            _ = newBalance.remove(at: balance.index(before: balance.endIndex))
            guard let bradley:Int64 = Int64(newBalance) else { return }
            let value:Int64 = 100000000000000000
            
            let newBrad = Float(bradley)/Float(value)
            DispatchQueue.main.async {
                self.amountLabel.text = String(newBrad)
            }
            print(newBrad)
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var USDollarAmount: UILabel!
    
    @IBAction func showButtonTapped(_ sender: Any) {
        DispatchQueue.main.async {
            EthWalletController.fetchWei(walletAdress: self.enterWalletAddress.text!) { (wallet) in
                let newWallet = wallet[0]
                self.balance += newWallet.ethBalance
                self.weiToEther(balance: self.balance)
            }
        }
    }
    
    var balance = ""
}
