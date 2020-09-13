//
//  CoinManager.swift
//  CoinApp
//
//  Created by 高橋康之 on 2020/09/13.
//  Copyright © 2020 yasu.com. All rights reserved.
//


import Foundation

protocol CoinManegerDelegate {
    func didUpdatePrice(price: String, virtualCurrency: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate"
    let apiKey = "B545B725-6741-4C15-9368-DB08A3A6821C"
    
    let currencyArray = ["USD","CNY","EUR","JPY","HKD"]
    let virtualCurrencyArray = ["BTC","BCH","ETH","XRP","XEM"]
    
//    プロトコル にアクセスするため
    var delegate:CoinManegerDelegate?
    
    func getCoinPrice(for currency:String){
        print(currency,"これこれ")
        
        let urlString = "\(baseURL)/\(currency)/JPY?apikey=\(apiKey)"
        
        print(urlString)
        
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url){ (data,responce,error)in
                
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    if let bitcoinPrice = self.parseJSON(safeData){
                        let priceString = String(format: "%.2f", bitcoinPrice)
                        self.delegate?.didUpdatePrice(price: priceString, virtualCurrency: currency)
                        
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> Double? {
        
//        JSONの解析用に定義
        let decoder = JSONDecoder()
        
        do {
            let decodeData = try decoder.decode(CoinData.self, from: data)
            
            let lastPrice = decodeData.rate
            
            print(lastPrice)
            return lastPrice
            
        } catch {
            
            delegate?.didFailWithError(error: error)
            return nil
            
        }
    }
}
