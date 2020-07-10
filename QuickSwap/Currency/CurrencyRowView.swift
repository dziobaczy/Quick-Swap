//
//  CurrencyRowView.swift
//  QuickSwap
//
//  Created by Piotr Szadkowski on 10/07/2020.
//

import SwiftUI

struct CurrencyRowView: View {
    var body: some View {
        HStack(alignment: .center) {
            Text("🇵🇱")
                .font(.title)
                .padding(.all, 12)
                .background(Color.black.opacity(0.1))
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text("PLN")
                    .font(.callout)
                    .bold()
                Text("3.23128")
            }
            .padding(.vertical, 4)
            .padding(.leading, 8)
        }
    }
}

struct CurrencyRowView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRowView()
    }
}
