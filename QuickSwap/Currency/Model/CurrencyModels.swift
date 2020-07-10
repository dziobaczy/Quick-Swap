//
//  CurrencyModels.swift
//  QuickSwap
//
//  Created by Piotr Szadkowski on 10/07/2020.
//

import Foundation

typealias Currency = String

struct CurrencyConversion: Decodable {
    var base: Currency
    var date: Date
    
    var exchangeRates: [ExchangeRate] {
        rates.rates
    }
    
    private var rates: ExchangeRate.List
}


struct ExchangeRate: Decodable, Hashable {
    let currency: Currency
    let conversionRate: Double
}

extension ExchangeRate {
    struct List: Decodable {
        let rates: [ExchangeRate]
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let dictionary = try container.decode([String: Double].self)
            
            rates = dictionary.map { key, value in
                ExchangeRate(currency: key, conversionRate: value)
            }
        }
        
        init(rates: [ExchangeRate]) {
            self.rates = rates
        }
        
    }
}

// MARK: - Mocks

extension ExchangeRate {
    static let plnMock = ExchangeRate(currency: "PLN", conversionRate: 2.13)
    static let usdMock = ExchangeRate(currency: "USD", conversionRate: 3.14)
    static let gbpMock = ExchangeRate(currency: "GBP", conversionRate: 4.15)
}

extension CurrencyConversion {
    static let plnMock = CurrencyConversion(base: "PLN", date: Date(), rates: .init(rates: [.usdMock, .gbpMock]))
}
