//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Ankit Sharma on 19/10/23.
//

import SwiftUI

@main
struct PokedexApp: App {
    // registering app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        initialAppSetup()
        return true
    }
    
    //Initial setup
    private func initialAppSetup() {
        PokemonGenderManager.shared.fetchGenderData()
    }
    
    //Added for firebase metrix
    func applicationWillResignActive(_ application: UIApplication) {
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
}
