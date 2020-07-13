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
        get {
            rates.rates
        }
        set {
            rates = ExchangeRate.List(rates: newValue)
        }
    }
    
    private var rates: ExchangeRate.List
}


struct ExchangeRate: Decodable, Hashable {
    let currency: Currency
    let conversionRate: Double
}

extension ExchangeRate: Comparable {
    
    static func < (lhs: ExchangeRate, rhs: ExchangeRate) -> Bool {
        if let leftFlag = String.flagDictionary[lhs.currency], let rightFlag = String.flagDictionary[rhs.currency] {
            return leftFlag < rightFlag
        } else if String.flagDictionary[lhs.currency] != nil {
            return true
        } else if String.flagDictionary[rhs.currency] != nil {
            return false
        } else {
            return lhs.currency < rhs.currency
        }
    }
    
    static func == (lhs: ExchangeRate, rhs: ExchangeRate) -> Bool {
        lhs.currency == rhs.currency
    }
    
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
    static let plnMock = ExchangeRate(currency: "PLN", conversionRate: 1.00)
    static let usdMock = ExchangeRate(currency: "USD", conversionRate: 3.14)
    static let gbpMock = ExchangeRate(currency: "GBP", conversionRate: 4.15)
}

extension CurrencyConversion {
    static let plnMock = CurrencyConversion(base: "PLN", date: Date(), rates: .init(rates: [.usdMock, .gbpMock, .plnMock]))
}

// MARK: - Helper Extension

extension String {
    
    static func emojiFlag(for country: String) -> String {
        String.flagDictionary[country] ?? "🏳️"
    }
    
    static let flagDictionary: [String: String] = [
        "CAD": "🇨🇦",
        "DKK": "🇩🇰",
        "GBP": "🇬🇧",
        "CHF": "🇨🇭",
        "USD": "🇺🇸",
        "MXN": "🇲🇽",
        "PLN": "🇵🇱"
    ]
}
