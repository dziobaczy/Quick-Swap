//
//  Currency.swift
//  QuickSwap
//
//  Created by Piotr Szadkowski on 09/07/2020.
//

import Foundation
import SwiftUI

typealias CurrencyName = String

struct Currency: Identifiable {
    
    var id: String { name }
    var color: Color { .init(colorName) }
    
    let name: CurrencyName
    let convertionRates: Set<[CurrencyName: Double]>
    private let colorName: String
    
}

extension Currency {
    static let mock = Currency(name: "PLN", convertionRates: Set(arrayLiteral: ["EUR":4.12, "USD":3.65]), colorName: "red")
}
