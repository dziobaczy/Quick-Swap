//
//  IntentHandler.swift
//  IntentHandler
//
//  Created by Piotr Szadkowski on 18/07/2020.
//

import Intents

class IntentHandler: INExtension, DynamicCurrencySelectionIntentHandling {
    
    func provideCurrencyOptionsCollection(for intent: DynamicCurrencySelectionIntent, with completion: @escaping (INObjectCollection<DynamicCurrency>?, Error?) -> Void) {
        print(intent.currency?.identifier)

        let remoteCurrencies = ["GBP", "CAD"].map { countryCode in
            return DynamicCurrency(identifier: countryCode, display: countryCode)
        }

        let collection = INObjectCollection(items: remoteCurrencies)

        completion(collection,nil)
    }
    
    override func handler(for intent: INIntent) -> Any {
        return self
    }
    
}
