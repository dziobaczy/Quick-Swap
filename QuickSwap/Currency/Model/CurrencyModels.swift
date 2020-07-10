//
//  CurrencyModels.swift
//  QuickSwap
//
//  Created by Piotr Szadkowski on 10/07/2020.
//

import Foundation

typealias Currency = String

struct CurrencyConversion: Decodable {
    var currency: Currency
    
    var exchangeRates: [ExchangeRate] {
        exchangeRatesList.rates
    }
    
    private var exchangeRatesList: ExchangeRate.List
}


struct ExchangeRate: Decodable {
    let currency: Currency
    let conversionRate: Double
}

private extension ExchangeRate {
    struct List: Decodable {
        let rates: [ExchangeRate]
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let dictionary = try container.decode([String: Double].self)
            
            rates = dictionary.map { key, value in
                ExchangeRate(currency: key, conversionRate: value)
            }
        }
        
    }
}
