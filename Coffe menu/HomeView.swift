//
//  ContentView.swift
//  Coffe menu
//
//  Created by Ali Murad on 31/08/2022.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            Navigation(navBody: AnyView(
                Text("NOP")
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
