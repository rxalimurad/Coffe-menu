//
//  BasketListener.swift
//  Coffe menu
//
//  Created by Ali Murad on 01/09/2022.
//

import Foundation
import Firebase

class BasketListener: ObservableObject {
    @Published var orderBasket: OrderBasket!
    
    init() {
        downloadBasket()
    }
    
    func downloadBasket() {
        if FUser.currentUser() != nil {
            firebaseReference(.Basket).whereField(kOWNERID, isEqualTo: FUser.currentId()).addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else { return }
            if !snapshot.isEmpty {
                let basketData = snapshot.documents.first!.data()
                self.getDrinksFromFirestore(withIds: basketData[kDRINKID] as? [String] ?? []) { drinkArry in
                    let basket = OrderBasket()
                    basket.ownerId = basketData[kOWNERID] as? String ?? ""
                    basket.id = basketData[kID] as? String ?? ""
                    basket.items = drinkArry
                    self.orderBasket = basket
                }
            }
        }
        }
    }
    
    func getDrinksFromFirestore(withIds: [String], completion: @escaping (_ drinkArry: [Drink]) -> Void) {
        
        var drinkArray = [Drink]()
        if withIds.isEmpty {
            completion(drinkArray)
            return
        }
        
        for drinkId in withIds {
            firebaseReference(.Menu).whereField(kID, isEqualTo: drinkId).getDocuments { snapshot, error in
                guard let snapshot = snapshot else { return }
                if !snapshot.isEmpty {
                    let drinkData = snapshot.documents.first!
                    drinkArray.append(
                        Drink(
                            id: drinkData[kID] as? String ?? UUID().uuidString,
                            name: drinkData[kNAME] as? String ?? "UNKNOWN",
                            imageName: drinkData[kIMAGENAME] as? String ?? "UNKNOWN",
                            category: Category(rawValue: drinkData[kCATEGORY] as? String ?? "cold") ?? .cold,
                            description:  drinkData[kDESCRIPTION] as? String ?? "Discription is missing",
                            price: drinkData[kPRICE] as? Double ?? 0.0
                        )
                    )
                    
                } else {
                    print("Have not drink")
                    completion(drinkArray)
                }
                if drinkArray.count == withIds.count {
                    completion(drinkArray)
                }
                
            }
        }
    }
}



