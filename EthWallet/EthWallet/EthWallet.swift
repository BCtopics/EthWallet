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
//        self.ethUSDAmount = ethBalance
    }
    
    convenience init?(jsonDicForWeiAmount: [String:String]) {
        let ethBalance = jsonDicForWeiAmount["result"]
        self.init(ethBalance: ethBalance!)
    }
    
//    convenience init?(newWalletDictionary: [String: Any]) {
//        guard let ethUSDAmount = newWalletDictionary["ethusd"] as? String else {return}
//        self.init(ethUSDAmount: ethUSDAmount!)
//    }
    
    
}
