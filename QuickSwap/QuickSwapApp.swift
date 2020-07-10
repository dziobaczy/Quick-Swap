//
//  QuickSwapApp.swift
//  QuickSwap
//
//  Created by Piotr Szadkowski on 09/07/2020.
//

import SwiftUI

@main
struct QuickSwapApp: App {
    var body: some Scene {
        WindowGroup {
            CurrencyListView()
        }
    }
}

struct QuickSwapApp_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyHeaderView()
    }
}
