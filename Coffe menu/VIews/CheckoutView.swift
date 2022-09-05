//
//  CheckoutView.swift
//  Coffe menu
//
//  Created by Ali Murad on 02/09/2022.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var basketListner = BasketListener()
    
    static let paymentTypes = ["Cash", "Credit Card"]
    static let tipAmounts = [10, 15, 20, 0]
    
    @State private var paymentType = 0
    @State private var tipAmount = 1
    @State private var showingPaymentAlert = false
    
    var totalPrice: Double {
        let total = basketListner.orderBasket.total
        let tipValue = total / 100 * Double(CheckoutView.tipAmounts[tipAmount])
        return total + tipValue
    }
    
    var body: some View {
        Form {
            Section {
                Picker(selection: $paymentType, label: Text("How do you want to pay?")) {
                    ForEach(0 ..< CheckoutView.paymentTypes.count) {
                        Text(CheckoutView.paymentTypes[$0])
                    }
                }
            }
            
            Section(header: Text("Add a tip?")) {
                Picker(selection: $tipAmount, label: Text("Percentage:")) {
                    ForEach(0 ..< CheckoutView.tipAmounts.count) {
                        Text("\(CheckoutView.tipAmounts[$0]) %")
                    }
                }.pickerStyle(SegmentedPickerStyle.init())
            }
            
            Section(header: Text("Total: $\(totalPrice.toString())").font(.largeTitle)) {
                Button {
                    showingPaymentAlert.toggle()
                    createOrder()
                    emptyBasket()
                    
                    
                    
                } label: {
                    Text("Confirm Order")
                }

            }.disabled(self.basketListner.orderBasket?.items.isEmpty ?? true)
            
         
        }.navigationBarTitle(Text("Payment"), displayMode: .inline)
            .alert(isPresented: $showingPaymentAlert) {
                Alert(title: Text("Order confirmed"), message: Text("Thank You!"), dismissButton: .default(Text("OK")))
            }
    }
    
    private func createOrder() {
        let order = Order()
        order.amount = totalPrice
        order.id = UUID().uuidString
        order.customerId = FUser.currentId()
        order.orderItems = self.basketListner.orderBasket.items
        order.saveOrderToFirestore()
    }
    private func emptyBasket() {
        self.basketListner.orderBasket.emptyBaseket()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}
