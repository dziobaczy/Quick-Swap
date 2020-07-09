//
//  CurrencySwapView.swift
//  QuickSwap
//
//  Created by Piotr Szadkowski on 09/07/2020.
//

import SwiftUI

struct CurrencySwapView: View {
    
    @Namespace private var animation
    @State private var isFlipped = false
    
    private let leadingCapsuleId = "Leading.Capsule"
    private let trailingCapsuleId = "Trailing.Capsule"
    
    var body: some View {
        HStack {
            if isFlipped {
                CurrencyCapsuleView()
                    .matchedGeometryEffect(id: leadingCapsuleId, in: animation)
            } else {
                CurrencyCapsuleView()
                    .matchedGeometryEffect(id: trailingCapsuleId, in: animation)
            }
            
            Spacer()
            Image(systemName: "arrow.swap")
                .rotationEffect(.degrees(isFlipped ? 90 : -90), anchor: .center)
                .font(.title)
                .foregroundColor(isFlipped ? .blue : .red)
                .onTapGesture {
                    withAnimation {
                        isFlipped.toggle()
                    }
                }
            Spacer()
            if isFlipped {
                CurrencyCapsuleView()
                    .matchedGeometryEffect(id: trailingCapsuleId, in: animation)
            } else {
                CurrencyCapsuleView()
                    .matchedGeometryEffect(id: leadingCapsuleId, in: animation)
            }
        }
        .padding(.horizontal, 40)
    }
    
}

struct CurrencyCapsuleView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text("128")
                .font(.title)
            Text("PLN")
                .font(.callout)
                .foregroundColor(Color(.darkGray))
        }
        .padding()
        .background(Color.white)
        .clipShape(Capsule())
        .shadow(color: Color.init(UIColor.lightGray.withAlphaComponent(0.35)), radius: 10, x: 0, y: 5)
    }
}

struct CurrencySwapView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySwapView()
    }
}
