//
//  JsonRatesProvider.swift
//  BasketCase
//
//  Created by Marco Marengo on 04/06/2017.
//  Copyright © 2017 Marco Marengo. All rights reserved.
//

import Foundation



class JsonRatesProvider: RateProvider {
    let supportedCurrencies: [Currency] = [.USD, .EUR, .GBP, .CAD, .AUD]
    
    private func getUrl(from localCurrency: Currency) -> URL? {
        let supportedCurrenciesString = supportedCurrencies.map { $0.name }.joined(separator: ",")
        
        var urlComponents = URLComponents(string: "http://apilayer.net/api/live")!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "access_key", value: "2ea774221e03d6cceb690ee8c744bbf4"),
            URLQueryItem(name: "source", value: localCurrency.name),
            URLQueryItem(name: "format", value: "1"),
            URLQueryItem(name: "currencies", value: supportedCurrenciesString)
        ]
        
        return urlComponents.url
    }
    
    func getQuotes(from localCurrency: Currency, handler: @escaping RatesProviderHandler) {

        guard let url = getUrl(from: localCurrency) else {
            handler([], RateProviderError.generic)
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) -> Void in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
                print(json)
                
                if let quotes = json["quotes"] as? [String:AnyObject] {
                    let rates = quotes.flatMap({ (key, value) -> Rate? in
                        let destCurrencyName = key.replacingOccurrences(of: localCurrency.name, with: "")
                        
                        if let destCurrency = Currency(rawValue: destCurrencyName) {
                            if let quoteValue = value as? NSNumber {
                                return Rate(from: localCurrency, to: destCurrency, quote: quoteValue.floatValue)
                            }
                            else {
                                return nil
                            }
                        }
                        else {
                            return nil
                        }
                    })
                    handler(rates, nil)
                }
                else {
                    handler([], RateProviderError.jsonParsingFailed)
                }
                
            }
            catch {
                print("json error: \(error)")
                handler([], error)
            }
            
        })
        task.resume()
    }
}
