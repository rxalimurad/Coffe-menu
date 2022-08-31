//
//  ContentView.swift
//  Coffe menu
//
//  Created by Ali Murad on 31/08/2022.
//

import SwiftUI

struct HomeView: View {
    var categories: [String: [Drink]] {
        Dictionary(grouping: drinkData, by: { $0.category.rawValue })
    }
    var body: some View {
        NavigationView {
            Navigation(navBody: AnyView(
                List(categories.keys.sorted(), id: \String.self) {
                    key in
                    DrinkView(categoryName: "\(key) Drink".uppercased(), drinks: self.categories[key]!)
                        .frame(height: 320)
                        .padding(.top)
                        .padding(.bottom)
                }
            ))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}





struct Navigation: View {
    var navBody: AnyView
    init(navBody: AnyView) {
        self.navBody = navBody
    }
    var body: some View {
        navBody
            .navigationTitle("MyCoffee")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Logout") {
                        print("Logging out")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("YOOO")
                    } label: {
                        Image("basket")
                    }
                    
                }
            }
    }
}
