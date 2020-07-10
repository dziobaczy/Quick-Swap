//
//  CurrencyViewModel.swift
//  QuickSwap
//
//  Created by Piotr Szadkowski on 10/07/2020.
//

import Combine

struct CurrencyViewModel: Identifiable {
    
    private let exchangeRate: ExchangeRate
    
    var id: String {
        name + rate + flagEmoji
    }
    
    init(_ exchangeRate: ExchangeRate) {
        self.exchangeRate = exchangeRate
    }
    
    var name: String {
        exchangeRate.currency
    }
    
    var rate: String {
        String(exchangeRate.conversionRate)
    }
    
    var flagEmoji: String {
        .emojiFlag(for: exchangeRate.currency)
    }
    
}

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
