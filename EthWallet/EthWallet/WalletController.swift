//
//  WalletController.swift
//  EthWallet
//
//  Created by Bradley GIlmore on 4/27/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import Foundation

class WalletController {
    
    //MARK: - baseURL
    
    static let baseURL = URL(string: "https://api.etherscan.io/api")
    
    //MARK: - Fetch Method
    
    static func fetchResponses(completion: @escaping (_ responses: [Wallet]) -> Void) {
        
        guard let url = baseURL else {
            fatalError("URL is nil") }
        //MARK: - Do I have to even do this with this api?
        
        let urlParameters = [
            "module" : "account",
            "action": "balance",
            "address": "0dc6337fb811eb32473060ca620f010e996ec71c",
            "tag":"latest",
            "apikey":"DCKQBK1DZJ5NNV25KDWJSSQHTARUDXBY2J"
        ]
        
        
        
        //MARK: - Network controller isn't working?!?
        
        NetworkController.performRequest(for: url, httpMethod: .get, urlParameters: urlParameters) { (data, error) in
            var wallets: [Wallet] = []
            
            guard let data = data else { return }
            
            let responseDataString = String(data: data, encoding: .utf8) ?? ""
            
            guard error == nil else { print("Error: \(String(describing: error?.localizedDescription))"); return }
            //            guard !responseDataString.contains("error") else { print("Error resonse: \(responseDataString)"); return }
            
            guard let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any] else { completion([]); return }
            
            //MARK: - After 2 hours and 11 minutes I think i figured out that the as? was wrong... It was missing the extra []
            //MARK: - Returns here, why?
            guard let movieDictionary = jsonDictionary["result"] as? String else { return }
//            wallets = jsonDictionary.flatMap { Wallet(dictionary: $0) }
            //MARK: - Did that wrong?
            //MARK: - Need to get the dictionary one more layer down... but dont know how to do that :(
            let newWallet = Wallet(balance: movieDictionary)
            wallets.append(newWallet)
            completion(wallets)
        }
    }
}









