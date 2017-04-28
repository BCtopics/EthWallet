//
//  SendViewController.swift
//  EthWallet
//
//  Created by Bradley GIlmore on 4/27/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import UIKit

class SendViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.amount.text = self.balance
        }
    }
    
var balance = ""

    @IBAction func sendButtonTapped(_ sender: Any) {
        
        WalletController.fetchResponses { (wallet) in
            let newWallet = wallet[0]
            self.balance += newWallet.balance
            self.amount.text = self.balance
        }
    }
    
    
    @IBOutlet weak var amount: UITextField!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
