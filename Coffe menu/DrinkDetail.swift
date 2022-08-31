//
//  DrinkDetail.swift
//  Coffe menu
//
//  Created by murad on 01/09/2022.
//

import SwiftUI

struct DrinkDetail: View {
    var drink: Drink
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack(alignment: .bottom) {
                Image(drink.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Rectangle()
                    .frame(height: 80)
                    .foregroundColor(.black)
                    .opacity(0.35)
                    .blur(radius: 10)
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(drink.name)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    .padding(.leading)
                    .padding(.bottom)
                    Spacer()
                }
            }
            
        }
    }
}

struct SDrinkDetail_Previews: PreviewProvider {
    static var previews: some View {
        DrinkDetail(drink: drinkData[0])
    }
}
