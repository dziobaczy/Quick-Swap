//
//  QuickSwapApp.swift
//  QuickSwap
//
//  Created by Piotr Szadkowski on 09/07/2020.
//

import SwiftUI

@main
struct QuickSwapApp: App {
    
    @State private var userDetails = UserDetails()
    
    var body: some Scene {
        WindowGroup {
            CurrencyListView().environmentObject(userDetails)
        }
    }
}

struct QuickSwapApp_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyListView()
    }
}
