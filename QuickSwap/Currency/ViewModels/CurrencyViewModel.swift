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
        name + String(rate) + flagEmoji
    }
    
    init(_ exchangeRate: ExchangeRate) {
        self.exchangeRate = exchangeRate
    }
    
    var name: String {
        exchangeRate.currency
    }
    
    var rate: Double {
        exchangeRate.conversionRate
    }
    
    var flagEmoji: String {
        .emojiFlag(for: exchangeRate.currency)
    }
    
}
