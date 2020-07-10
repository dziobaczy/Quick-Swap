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
            List {
                Section(header: CurrencyHeaderView()) {
                    ForEach(viewModel.currencyViewModels, id: \.self) { viewModel in
                        CurrencyRowView(viewModel: viewModel)
                            .padding(.all, 12)
                    }
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .navigationBarTitle("Currencies")
            .onAppear {
                viewModel.fetchCurrencies()
            }
        }
    }
}

struct CurrencyListView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyListView()
    }
}
