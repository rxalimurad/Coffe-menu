//
//  OrderBasketView.swift
//  Coffe menu
//
//  Created by Ali Murad on 01/09/2022.
//

import SwiftUI

struct OrderBasketView: View {
    @ObservedObject var basketListner = BasketListener()
    var body: some View {
        NavigationView{
            List{
                Section {
                    ForEach(self.basketListner.orderBasket?.items ?? [] ) {
                        drink in
                        HStack {
                            Text(drink.name)
                            Spacer()
                            Text("$\(drink.price.toString())")
                        }
                    }.onDelete { indexSet in
                        print("Delete at \(indexSet)")
                    }
                }
                Section {
                    Text("Place Order")
                        .disabled(self.basketListner.orderBasket?.items.isEmpty ?? true)
                }
            }
            .navigationTitle("Basket")
        }
        
        .listStyle(.grouped)
        
    }
}

struct OrderBasketView_Previews: PreviewProvider {
    static var previews: some View {
        OrderBasketView()
    }
}
