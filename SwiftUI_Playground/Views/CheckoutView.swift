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
    static private let tipAmounts = [10, 15, 20, 25, 0]
    
    @State private var paymentType = 0
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    @State private var tipAmount = 1
    
    @State private var alertShowing = false
    
    var totalPrice: Double {
        let total = Double(order.total)
        let tip = total / 100 * Double(Self.tipAmounts[tipAmount])
        return total + tip
    }
    
    var body: some View {
        Form {
            Section {
                Picker("How to pay?", selection: $paymentType) {
                    ForEach( 0 ..< Self.payments.count) {
                        Text("\(Self.payments[$0])")
                    }
                }
                Toggle(isOn: $addLoyaltyDetails.animation()) {
                    Text("Add loyalty")
                }
                if addLoyaltyDetails {
                    TextField("Enter loyalty details", text: $loyaltyNumber)
                }
            }
            
            Section(header: Text("Add a tip?")) {
                Picker("Percentage", selection: $tipAmount) {
                    ForEach( 0 ..< Self.tipAmounts.count) {
                        Text("\(Self.tipAmounts[$0])%")
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("TOTAL: $\(totalPrice, specifier: "%.2f")")
                .font(.largeTitle)
            ) {
                Button("Confirm order") {
                    self.alertShowing.toggle()
                }
            }
        }
        .navigationBarTitle(Text("Payments"), displayMode: .inline)
        .alert(isPresented: $alertShowing) {
            Alert(title: Text("Order Confirmed"),
                  message: Text("Total was $\(totalPrice, specifier: "%2.f")"),
                  dismissButton: .default(Text("Ok"), action: completeOrder))
        }
    }
    
    private func completeOrder() {
        
        order.clear()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    
    static let order = Order()
    
    static var previews: some View {
        CheckoutView()
    }
}
