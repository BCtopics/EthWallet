//
//  ethWalletController.swift
//  EthWallet
//
//  Created by Bradley Gilmore on 4/27/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import Foundation

class EthWalletController{
    
    static let baseURL = URL(string: "https://api.etherscan.io/api")
    
    
    //MARK: - FetchWei Function
    
    static func fetchWei(walletAdress: String, completion: @escaping (_ responses: EthWallet?) -> Void) {
        
        guard let url = baseURL else {
            fatalError("WEI/URL is nil") }
        
        let urlParameters = [
            "module" : "account",
            "action": "balance",
            "address": "\(walletAdress)",
            "tag":"latest",
            "apikey":"DCKQBK1DZJ5NNV25KDWJSSQHTARUDXBY2J"
        ]
        
        NetworkController.performRequest(for: url, httpMethod: .get, urlParameters: urlParameters) { (data, error) in
            
            guard let data = data else { return }
            
            let responseDataString = String(data: data, encoding: .utf8) ?? ""
            
            guard error == nil else { print("Error: \(String(describing: error?.localizedDescription))"); return }
            
            guard let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any] else { completion(nil); return }
            
            
            guard let walletDictionary = jsonDictionary["result"] as? String else { return }
            
            let newWallet = EthWallet(ethBalance: walletDictionary)
            
            completion(newWallet)
        }
    }
    
    //MARK: - FetchUSDDollarAmount Function
    
    static func fetchUSDollarAmount(completion: @escaping (_ responses: EthWallet?) -> Void) {
        
        guard let usdURL = baseURL else { fatalError("USD/URL is nil") }
        
        let urlParameters = [
            "module" : "stats",
            "action": "ethprice",
            "apikey":"DCKQBK1DZJ5NNV25KDWJSSQHTARUDXBY2J"
        ]
        
        
        NetworkController.performRequest(for: usdURL, httpMethod: .get, urlParameters: urlParameters, body: nil) { (data, error) in
            
            guard let data = data else { return }
            let responseDataString = String(data: data, encoding: .utf8) ?? ""
            
            guard error == nil else { print("Error: \(String(describing: error?.localizedDescription))"); return }
            
            guard let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any] else { completion(nil); return }
            
            
            guard let walletDictionary = jsonDictionary["result"] as? [String: Any] else { return }
            guard let newWalletDictionary = walletDictionary["ethusd"] as? String else { return }
            let usdWallet = EthWallet(ethUSDAmount: newWalletDictionary)
            print(usdWallet.ethUSDAAmount)
            
            
            completion(usdWallet)
            
        }
    }
}














