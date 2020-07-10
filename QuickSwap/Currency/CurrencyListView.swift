//
//  CurrencyListView.swift
//  QuickSwap
//
//  Created by Piotr Szadkowski on 10/07/2020.
//

import SwiftUI

struct CurrencyListView: View {
    var body: some View {
        NavigationView {
            List {
                CurrencyHeaderView()
                    .padding(.bottom, 35)
                    .padding(.top, 15)
                ForEach(0..<10) { i in
                    CurrencyRowView()
                }
                .navigationBarTitle("Currencies")
            }
        }
    }
}

struct CurrencyListView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyListView()
    }
}
