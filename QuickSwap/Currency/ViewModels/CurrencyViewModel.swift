//
//  CurrencyViewModel.swift
//  QuickSwap
//
//  Created by Piotr Szadkowski on 10/07/2020.
//

import Combine

struct CurrencyViewModel: Hashable {
    
    private let exchangeRate: ExchangeRate
    
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
        String.flagDictionary[exchangeRate.currency] ?? "🏳️"
    }
    
}

private extension String {
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
