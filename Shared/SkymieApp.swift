//
//  SkymieApp.swift
//  Shared
//
//  Created by Nethan on 2/7/22.
//

import SwiftUI
import Firebase

@main
struct SkymieApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
