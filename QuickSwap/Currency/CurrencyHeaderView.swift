//
//  CurrencyHeaderView.swift
//  QuickSwap
//
//  Created by Piotr Szadkowski on 10/07/2020.
//

import SwiftUI

struct CurrencyHeaderView: View {
    
    @EnvironmentObject var userDetails: UserDetails
    
    private var viewModel: CurrencyHeaderRepresentable
    
    init(_ representable: CurrencyHeaderRepresentable) {
        self.viewModel = representable
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.name)
                    .font(.title)
                Text(viewModel.date)
                    .font(.caption)
            }
            Spacer()
            TextField("Enter a value", text: $userDetails.moneyString)
                .multilineTextAlignment(.trailing)
                .font(.title)
                .padding(.trailing, 10)
            Text(viewModel.emojiFlag)
                .font(.title)
                .padding(.all, 4)
                .background(Color.blue)
                .clipShape(Circle())
        }
        .padding(.bottom, 35)
        .padding(.top, 15)
        .padding(.horizontal, 18)
        .background(Color(.systemBackground))
    }
}

struct CurrencyHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyHeaderView(LoadingCurrency())
    }
}
