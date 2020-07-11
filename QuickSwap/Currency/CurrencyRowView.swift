//
//  CurrencyRowView.swift
//  QuickSwap
//
//  Created by Piotr Szadkowski on 10/07/2020.
//

import SwiftUI

struct CurrencyRowView: View {
    
    @State var viewModel: CurrencyViewModel
    @EnvironmentObject var userDetails: UserDetails
    
    var body: some View {
        HStack(alignment: .center) {
            Text(viewModel.flagEmoji)
                .font(.title)
                .padding(.all, 8)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(color: Color(UIColor.black.withAlphaComponent(0.15)), radius: 5, x: 0, y: 5)
            VStack(alignment: .leading) {
                Text(viewModel.name)
                    .font(.callout)
                    .bold()
                Text(String(format: "%.2f", viewModel.rate * userDetails.money))
            }
            .padding(.vertical, 4)
            .padding(.leading, 8)
            Spacer()
        }
        .padding(.all, 10)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color(UIColor.black.withAlphaComponent(0.1)), radius: 3, x: 0, y: 3)
    }
}

struct CurrencyRowView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRowView(viewModel: .init(.plnMock)).environmentObject(UserDetails.mock)
    }
}
