//
//  Wallet.swift
//  EthWallet
//
//  Created by Bradley GIlmore on 4/27/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import Foundation

class Wallet {
    
//    var value = 0
//    var privateAddress = ""
    var balance: String = ""
    
    init(balance: String = "") {
        self.balance = balance
    }
    
    init?(dictionary: [String: Any]) {
        guard let balance = dictionary["result"] as? String else { return nil }
            self.balance = balance
    }
    
}
