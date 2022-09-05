//
//  ContentView.swift
//  Coffe menu
//
//  Created by Ali Murad on 31/08/2022.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var drinkLister = DrinkListener()
    @State var showBasket = false
    var categories: [String: [Drink]] {
        Dictionary(grouping: drinkLister.drinks, by: { $0.category.rawValue })
    }
    var body: some View {
        NavigationView{
            List(categories.keys.sorted(), id: \String.self) {
                key in
                DrinkView(categoryName: "\(key) Drink".uppercased(), drinks: self.categories[key]!)
                    .frame(height: 320)
                    .padding(.top)
                    .padding(.bottom)
            }
            .navigationTitle("iCoffee")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Logout") {
                        FUser.logoutCurrentUser { error in
                            print(",,..Error in loggin out", error?.localizedDescription)
                        }
                    }
                    
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.showBasket.toggle()
                    } label: {
                        Image("basket")
                    }.sheet(isPresented: $showBasket) {
                        if FUser.currentUser() != nil && FUser.currentUser()!.onBoarding {
                            OrderBasketView()
                        } else if FUser.currentUser() != nil {
                            FinishRegistractionView()
                        } else {
                            LoginView()
                        }
                        
                    }
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
            
        }
    }
}




