//
//  ethWalletController.swift
//  EthWallet
//
//  Created by ALIA M NEELY on 4/27/17.
//  Copyright © 2017 Wylan. All rights reserved.
//

import Foundation

class EthWalletController{
    
    static let baseURL = URL(string: "https://api.etherscan.io/api")
    
    
    static func fetchResponses(walletAdress: String, completion: @escaping (_ responses: [EthWallet]) -> Void) {
        
        guard let url = baseURL else {
            fatalError("URL is nil") }
        
        let urlParameters = [
            "module" : "account",
            "action": "balance",
            "address": "\(walletAdress)",
            "tag":"latest",
            "apikey":"DCKQBK1DZJ5NNV25KDWJSSQHTARUDXBY2J"
        ]
        
        
        
        NetworkController.performRequest(for: url, httpMethod: .get, urlParameters: urlParameters) { (data, error) in
            var wallets: [EthWallet] = []
            
            guard let data = data else { return }
            
            let responseDataString = String(data: data, encoding: .utf8) ?? ""
            
            guard error == nil else { print("Error: \(String(describing: error?.localizedDescription))"); return }
            
            guard let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any] else { completion([]); return }
            
            
            guard let walletDictionary = jsonDictionary["result"] as? String else { return }
        
            let newWallet = EthWallet(balance: walletDictionary)
            wallets.append(newWallet)
            completion(wallets)
        }
    }
}
