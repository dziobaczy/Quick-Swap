//
//  CurrencyListViewModel.swift
//  QuickSwap
//
//  Created by Piotr Szadkowski on 10/07/2020.
//

import Foundation
import Combine

class CurrencyListViewModel: ObservableObject {
    
    private let currencyProvider: CurrencyProvider
    
    @Published var currencyViewModels = [CurrencyViewModel]()
    @Published var currencyHeaderViewModel: CurrencyHeaderRepresentable = LoadingCurrency()
    
    init(currencyProvider: CurrencyProvider = CurrencyService()) {
        self.currencyProvider = currencyProvider
    }
    
    var cancellable: AnyCancellable?
    
    func fetchCurrencies(for currency: Currency = "PLN") {
        cancellable = currencyProvider
            .fetchCurrencies(for: currency.uppercased())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { [weak self] conversion in
                guard let self = self else { return }
                self.currencyHeaderViewModel = CurrencyHeaderViewModel(conversion)
                self.currencyViewModels = conversion.exchangeRates.sorted().map(CurrencyViewModel.init)
            })
    }
    
    func changeHeader(to viewModel: CurrencyViewModel) {
        currencyHeaderViewModel = LoadingCurrency()
        fetchCurrencies(for: viewModel.name)
    }
    
}
