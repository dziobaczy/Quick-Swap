//
//  UserDetails.swift
//  QuickSwap
//
//  Created by Piotr Szadkowski on 11/07/2020.
//

import Foundation
import Combine

class UserDetails: ObservableObject {
    @Published var moneyString: String
    
    init(initialMoney: String = "10.0") {
        self.moneyString = initialMoney
    }
    
    var money: Double {
        (moneyString as NSString).doubleValue
    }
}

extension UserDetails {
    static let mock = UserDetails()
}
