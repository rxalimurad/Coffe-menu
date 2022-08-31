//
//  SwiftUIView.swift
//  Coffe menu
//
//  Created by Ali Murad on 31/08/2022.
//

import SwiftUI

struct DrinkItem: View {
    var drink: Drink
    var body: some View {
        VStack(alignment: .center, spacing:16) {
            Image(drink.imageName)
                .resizable()
                .renderingMode(.original)
                .frame(width: 300, height: 170)
                .cornerRadius(15)
                .shadow(radius: 15)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkItem(drink: drinkData[0])
    }
}
