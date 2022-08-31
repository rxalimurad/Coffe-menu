//
//  FirebaseReference.swift
//  Coffe menu
//
//  Created by Ali Murad on 31/08/2022.
//

import Foundation
import FirebaseFirestore
import SwiftUI

enum FCollectionReference: String {
    case User
    case Menu
    case Order
    case Basket
}


func firebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
}
