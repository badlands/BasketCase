//
//  RateProvider.swift
//  BasketCase
//
//  Created by Marco Marengo on 04/06/2017.
//  Copyright © 2017 Marco Marengo. All rights reserved.
//

import Foundation

enum Currency: String {
    case EUR = "EUR"
    case USD = "USD"
    case GBP = "GBP"
    case CAD = "CAD"
    case AUD = "AUD"
    
    var name: String {
        return self.rawValue
    }
}

enum RateProviderError: Error {
    case generic
    case jsonParsingFailed
}

struct Rate {
    let from: Currency
    let to: Currency
    let quote: Float
}

typealias RatesProviderHandler = ([Rate], Error?) -> Void

protocol RateProvider {
    var supportedCurrencies: [Currency] { get }
    func getQuotes(from localCurrency: Currency, handler: @escaping RatesProviderHandler)
}
