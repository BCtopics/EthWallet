//
//  EthWallet.swift
//  EthWallet
//
//  Created by ALIA M NEELY on 4/27/17.
//  Copyright © 2017 Wylan. All rights reserved.
//

import Foundation

class EthWallet{
    
    var ethBalance: String = ""
    var ethUSDAAmount: String = ""
    
    init(ethBalance: String){
        self.ethBalance = ethBalance
    }
    
    init(ethUSDAmount: String){
        self.ethUSDAAmount = ethUSDAmount
    }
    
    convenience init?(jsonDicForWeiAmount: [String:String]) {
        let ethBalance = jsonDicForWeiAmount["result"]
        self.init(ethBalance: ethBalance!)
    }
    
}
