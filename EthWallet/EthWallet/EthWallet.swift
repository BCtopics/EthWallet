//
//  EthWallet.swift
//  EthWallet
//
//  Created by ALIA M NEELY on 4/27/17.
//  Copyright © 2017 Wylan. All rights reserved.
//

import Foundation

class EthWallet{
    
    let balance: String
    
    init(balance: String){
        self.balance = balance
    }
    
    convenience init?(jsonDic: [String:String]) {
        let balance = jsonDic["result"]
        self.init(balance: balance!)
    }
    
    
}
