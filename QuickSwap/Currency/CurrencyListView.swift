//
//  CurrencyListView.swift
//  QuickSwap
//
//  Created by Piotr Szadkowski on 10/07/2020.
//

import SwiftUI
import Combine

struct CurrencyListView: View {
    
    @ObservedObject private var viewModel: CurrencyListViewModel
    @EnvironmentObject var userDetails: UserDetails
    
    init(_ currencyListViewModel: CurrencyListViewModel = CurrencyListViewModel()) {
        self.viewModel = currencyListViewModel
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: CurrencyHeaderView(viewModel.currencyHeaderViweModel)) {
                    ForEach(viewModel.currencyViewModels) { viewModel in
                        CurrencyRowView(viewModel: viewModel)
                            .padding(.all, 12)
                            .onTapGesture {
                                self.viewModel.changeHeader(to: viewModel)
                            }
                    }
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .animation(.default)
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
