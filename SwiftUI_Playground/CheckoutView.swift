//
//  CheckoutView.swift
//  SwiftUI_Playground
//
//  Created by Andrey Durbalo on 29.01.2020.
//  Copyright © 2020 Andrii Durbalo. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    
    @EnvironmentObject var order: Order
    
    static private let payments = ["Cash", "Card", "Points"]
    @State private var paymentType = 0
    
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    
    var body: some View {
        Form {
            Section {
                Picker("How to pay?", selection: $paymentType) {
                    ForEach( 0 ..< Self.payments.count) {
                        Text(Self.payments[$0])
                    }
                }
                Toggle(isOn: $addLoyaltyDetails) {
                    Text("Add loyalty")
                }
                if addLoyaltyDetails {
                    TextField("Enter loyalty details", text: $loyaltyNumber)
                }
                
            }
            
        }
        .navigationBarTitle(Text("Payments"), displayMode: .inline)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    
    static let order = Order()
    
    static var previews: some View {
        CheckoutView()
    }
}
