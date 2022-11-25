//
//  SkymieApp.swift
//  Shared
//
//  Created by Nethan on 2/7/22.
//

import SwiftUI
import Firebase
import RevenueCat
@main
struct SkymieApp: App {
   
 
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    init() {
        FirebaseApp.configure()
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: "appl_WCpNaXnIYiYrwTCtEXpqfRAtKrK")
    }
}
