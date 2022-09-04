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
    @State private var showingLogin = false

    var body: some View {
        NavigationView {
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
                    OrderButton(showAlert:$showingAlert, showingLogin: $showingLogin, drink: drink)
                    Spacer()
                    
                }
                .padding(.top, 50)
                
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarHidden(true)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Added to Basket!"),dismissButton: .default(Text("Ok")))
            }.navigationBarBackButtonHidden(false)
            
        }.foregroundColor(Color.white)
    }
}

struct SDrinkDetail_Previews: PreviewProvider {
    static var previews: some View {
        DrinkDetail(drink: drinkData[0])
    }
}


struct OrderButton: View {

    @ObservedObject var basketListner = BasketListener()
    @Binding var showAlert: Bool
    @Binding var showingLogin: Bool

    var drink: Drink
    var body: some View {
        Button {
            if FUser.currentUser() != nil && FUser.currentUser()!.onBoarding {
                self.showAlert.toggle()
                addItemtoBasket()
            } else {
                self.showingLogin.toggle()
            }
            
        } label: {
            Text("Add to basket")
        }
        .frame(width: 200, height: 50)
        .foregroundColor(.white)
        .background(Color.blue)
        .font(.headline)
        .cornerRadius(10)
        .sheet(isPresented: $showingLogin) {
            if FUser.currentUser() != nil {
                FinishRegistractionView()
            } else {
                LoginView()
            }
        }

    }
    
    private func addItemtoBasket() {
        var orderBaseket: OrderBasket!
        if basketListner.orderBasket != nil {
            orderBaseket = self.basketListner.orderBasket
        } else {
            orderBaseket = OrderBasket()
            orderBaseket.ownerId = FUser.currentId()
            orderBaseket.id = UUID().uuidString
        }
        orderBaseket.add(self.drink)
        orderBaseket.saveBaseketToFirestore()
        
    }
}
