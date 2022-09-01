//
//  DrinkListener.swift
//  Coffe menu
//
//  Created by Ali Murad on 01/09/2022.
//

import Foundation
import Firebase

class DrinkListener:  ObservableObject {
    
    @Published var drinks: [Drink] = []
    
    init() {
        downloadDrinks()
    }
    
    
    func downloadDrinks() {
        firebaseReference(.Menu).getDocuments { snapshot, error in
            guard let snapshot = snapshot else { return }
            guard  !snapshot.isEmpty else { return }
            self.drinks = self.drinkFromDictionary(snapshot)
        }
    }
    
    func drinkFromDictionary(_ snapshot: QuerySnapshot) -> [Drink] {
        var drinks = [Drink]()
        for snapshot in snapshot.documents {
            let drinkData = snapshot.data()
            drinks.append(
                Drink(
                    id: drinkData[kID] as? String ?? UUID().uuidString,
                    name: drinkData[kNAME] as? String ?? "UNKNOWN",
                    imageName: drinkData[kIMAGENAME] as? String ?? "UNKNOWN",
                    category: Category(rawValue: drinkData[kCATEGORY] as? String ?? "cold") ?? .cold,
                    description:  drinkData[kDESCRIPTION] as? String ?? "Discription is missing",
                    price: drinkData[kPRICE] as? Double ?? 0.0
                )
            )
        }
        return drinks
    }
    
}
