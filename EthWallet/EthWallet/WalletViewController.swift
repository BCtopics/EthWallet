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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.amountLabel.text = self.balance
        }
    }
    
  
        func wei(balance: String) {
            var newBalance = balance
            let newBalanceChanged = newBalance.remove(at: balance.index(before: balance.endIndex))
            guard let bradley:Int64 = Int64(newBalance) else { return }
            let value:Int64 = 100000000000000000
            
            let newBrad = Float(bradley)/Float(value)
            amountLabel.text = String(newBrad)
            print(newBrad)
    }
    
    
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBAction func showButtonTapped(_ sender: Any) {
        DispatchQueue.main.async {
            EthWalletController.fetchResponses(walletAdress: self.enterWalletAddress.text!) { (wallet) in
                let newWallet = wallet[0]
                self.balance += newWallet.balance
//                self.amountLabel.text = self.balance
                self.wei(balance: self.balance)
            }
        }
    }
    
    var balance = ""
    
  
    
    
}
