//
//  DrinkView.swift
//  Coffe menu
//
//  Created by Ali Murad on 31/08/2022.
//

import SwiftUI

struct DrinkView: View {
    var categoryName: String
    var drinks: [Drink]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(self.categoryName)
                .font(.title)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(drinks) {drink in
                        DrinkItem(drink: drink)
                            .frame(width: 300)
                            .padding(.trailing, 30)
                    }
                }
            }
        }
    }
}

struct DrinkView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkView(categoryName: "HOT DRINKS", drinks: drinkData)
    }
}
