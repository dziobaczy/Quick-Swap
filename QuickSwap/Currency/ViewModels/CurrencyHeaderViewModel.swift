//
//  CurrencyHeaderViewModel.swift
//  QuickSwap
//
//  Created by Piotr Szadkowski on 10/07/2020.
//

import Foundation
import Combine

protocol CurrencyHeaderRepresentable {
    var name: String { get }
    var date: String { get }
    var emojiFlag: String { get }
}

struct CurrencyHeaderViewModel: CurrencyHeaderRepresentable {
    
    private let currencyConversion: CurrencyConversion
    
    init(_ currencyConversion: CurrencyConversion) {
        self.currencyConversion = currencyConversion
    }
    
    var name: String {
        currencyConversion.base
    }
    
    var date: String {
        DateFormatter.exchangeratesApiDateFormat.string(from: currencyConversion.date)
    }
    
    var emojiFlag: String {
        .emojiFlag(for: currencyConversion.base)
    }
    
}

struct LoadingCurrency: CurrencyHeaderRepresentable {
    var name: String { "---" }
    
    var date: String { "||||-||-||" }
    
    var emojiFlag: String { "🏳️" }
}
