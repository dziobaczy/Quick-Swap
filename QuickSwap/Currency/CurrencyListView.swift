//
//  CurrencyListView.swift
//  QuickSwap
//
//  Created by Piotr Szadkowski on 10/07/2020.
//

import SwiftUI
import Combine

struct CurrencyListView: View {
    
    @ObservedObject private var viewModel = CurrencyListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                CurrencyHeaderView()
                    .padding(.bottom, 35)
                    .padding(.top, 15)
                List(viewModel.currencyViewModels, id: \.self) { viewModel in
                    CurrencyRowView(viewModel: viewModel)
                }
                .navigationBarTitle("Currencies")
                .onAppear {
                    viewModel.fetchCurrencies()
                }
            }
        }
    }
}

struct CurrencyListView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyListView()
    }
}

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
    
}
