//
//  Order.swift
//  Coffe menu
//
//  Created by Ali Murad on 02/09/2022.
//

import Foundation

class Order: Identifiable {
    var id: String!
    var customerId: String!
    var orderItems: [Drink] = []
    var amount: Double!
    
    func saveOrderToFirestore() {
        firebaseReference(.Order).document(self.id).setData(orderDictionaryFrom(self)) {
            error in
            if error != nil {
                print("error saving order to firestore: ", error!.localizedDescription)
            }
        }
    }
    
    func orderDictionaryFrom(_ order: Order) -> [String: Any] {
        var allDrinkIds: [String] = []
        
        for drink in order.orderItems {
            allDrinkIds.append(drink.id)
        }
        
        return [
            kID: order.id ?? "",
            kCUSTOMERID: order.id ?? "",
            kDRINKID: allDrinkIds ,
            kAMOUNT: order.amount ?? 0.0
        ]
        
    }
    
    
}

