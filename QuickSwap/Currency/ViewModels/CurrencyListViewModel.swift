//
//  CurrencyListViewModel.swift
//  QuickSwap
//
//  Created by Piotr Szadkowski on 10/07/2020.
//

import Combine

class CurrencyListViewModel: ObservableObject {
    
    private let currencyProvider: CurrencyProvider
    
    @Published var currencyViewModels = [CurrencyViewModel]()
    
    init(currencyProvider: CurrencyProvider = CurrencyService()) {
        self.currencyProvider = currencyProvider
    }
    
    var cancellable: AnyCancellable?
    
    func fetchCurrencies() {
        cancellable = currencyProvider.fetchCurrencies(for: "PLN").sink(receiveCompletion: { error in
            print(error)
        }, receiveValue: { [weak self] currencyConversion in
            guard let self = self else { return }
            self.currencyViewModels = currencyConversion.exchangeRates.map(CurrencyViewModel.init)
        })
    }
    
}