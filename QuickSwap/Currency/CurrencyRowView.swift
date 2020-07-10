//
//  CurrencyRowView.swift
//  QuickSwap
//
//  Created by Piotr Szadkowski on 10/07/2020.
//

import SwiftUI

struct CurrencyRowView: View {
    
    @State var viewModel: CurrencyViewModel
    
    var body: some View {
        HStack(alignment: .center) {
            Text(viewModel.flagEmoji)
                .font(.title)
                .padding(.all, 8)
                .background(Color.black.opacity(0.1))
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(viewModel.name)
                    .font(.callout)
                    .bold()
                Text(viewModel.rate)
            }
            .padding(.vertical, 4)
            .padding(.leading, 8)
        }
    }
}

struct CurrencyRowView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRowView(viewModel: .init(.plnMock))
    }
}
