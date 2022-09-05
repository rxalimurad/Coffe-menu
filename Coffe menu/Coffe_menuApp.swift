//
//  Coffe_menuApp.swift
//  Coffe menu
//
//  Created by Ali Murad on 31/08/2022.
//

import SwiftUI
import Firebase

@main
struct Coffe_menuApp: App {
    @Environment(\.scenePhase) var scenePhase

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }.onChange(of: scenePhase) { newScenePhase in
            print(",,..onChange \(newScenePhase)")
        }
    }
}
