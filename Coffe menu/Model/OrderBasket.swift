//
//  OrderBasket.swift
//  Coffe menu
//
//  Created by Ali Murad on 01/09/2022.
//

import Foundation
import Firebase
import SwiftUI

class OrderBasket: Identifiable {
    var id: String = ""
    var ownerId: String = ""
    var items: [Drink] = []
    
    var total: Double {
        if items.count > 0 {
            return items.reduce(0) {$0 + $1.price}
        } else {
            return 0.0
        }
    }
    
    func add(_ item: Drink) {
        items.append(item)
    }
    
    func remove(_ item: Drink) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
    func emptyBaseket() {
        self.items = []
        saveBaseketToFirestore()
    }
    
    func saveBaseketToFirestore() {
        firebaseReference(.Basket).document(self.id).setData(basketDictionaryFrom(self))
    }
    
    func basketDictionaryFrom(_ basket: OrderBasket) -> [String: Any] {
        var allDrinkId: [String] = []
        for item in items {
            allDrinkId.append(item.id)
        }
        
        return [
            kID: basket.id ,
            kOWNERID: basket.ownerId,
            kDRINKID: allDrinkId
                
        ]
        
    }
    
}
