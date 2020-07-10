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

class UserDetails: ObservableObject {
    @Published var moneyString: String = "10.0"
    
    var money: Double {
        (moneyString as NSString).doubleValue
    }
}

struct QuickSwapApp_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyListView()
    }
}
