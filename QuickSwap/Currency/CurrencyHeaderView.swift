//
//  CurrencyHeaderView.swift
//  QuickSwap
//
//  Created by Piotr Szadkowski on 10/07/2020.
//

import SwiftUI

struct CurrencyHeaderView: View {
    
    @State private var value: String = "10,36"
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("PLN")
                    .font(.title)
                Text("2018-04-08")
                    .font(.caption)
            }
            Spacer()
            TextField("Enter a value", text: $value)
                .multilineTextAlignment(.trailing)
                .font(.title)
                .padding(.trailing, 10)
            Text("🇵🇱")
                .font(.title)
                .padding(.all, 4)
                .background(Color.blue)
                .clipShape(Circle())
        }
    }
}

struct CurrencyHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyHeaderView()
    }
}
