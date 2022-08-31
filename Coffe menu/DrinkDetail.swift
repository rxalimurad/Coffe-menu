//
//  DrinkDetail.swift
//  Coffe menu
//
//  Created by murad on 01/09/2022.
//

import SwiftUI

struct DrinkDetail: View {
    @State private var showingAlert = false
    
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
            .listRowInsets(EdgeInsets())
            Text(drink.description)
                .foregroundColor(.primary)
                .font(.body)
                .lineLimit(5)
                .padding()
            
            HStack {
                Spacer()
                OrderButton(showAlert:$showingAlert, drink: drink).b
                Spacer()
                
            }
            .padding(.top, 50)
            
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarHidden(true)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Added to Basket!"),dismissButton: .default(Text("Ok")))
        }
    }
}

struct SDrinkDetail_Previews: PreviewProvider {
    static var previews: some View {
        DrinkDetail(drink: drinkData[0])
    }
}


struct OrderButton: View {
    @Binding var showAlert: Bool
    var drink: Drink
    var body: some View {
        Button {
            print ("ordered \(drink.name)")
            self.showAlert.toggle()
        } label: {
            Text("Add to basket")
        }
        .frame(width: 200, height: 50)
        .foregroundColor(.white)
        .background(Color.blue)
        .font(.headline)
        .cornerRadius(10)

    }
}
