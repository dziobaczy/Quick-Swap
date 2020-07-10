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
    @Published var currencyHeaderViweModel: CurrencyHeaderRepresentable = LoadingCurrency()
    
    init(currencyProvider: CurrencyProvider = CurrencyService()) {
        self.currencyProvider = currencyProvider
    }
    
    var cancellable: AnyCancellable?
    
    func fetchCurrencies(for currency: Currency = "PLN") {
        cancellable = currencyProvider.fetchCurrencies(for: currency.uppercased()).sink(receiveCompletion: { completion in
            print(completion)
        }, receiveValue: { [weak self] currencyConversion in
            guard let self = self else { return }
            self.currencyHeaderViweModel = CurrencyHeaderViewModel(currencyConversion)
            self.currencyViewModels = currencyConversion.exchangeRates.sorted().map(CurrencyViewModel.init)
        })
    }
    
    func changeHeader(to viewModel: CurrencyViewModel) {
        currencyHeaderViweModel = LoadingCurrency()
        fetchCurrencies(for: viewModel.name)
    }
    
}
