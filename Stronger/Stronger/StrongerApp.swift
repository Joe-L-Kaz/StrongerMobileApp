//
//  StrongerApp.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 07/07/2025.
//

import SwiftUI

@main
struct StrongerApp: App {
    @StateObject var authenticationState = AuthenticationState()

    var body: some Scene {
        WindowGroup {
            if authenticationState.isAuthenticated {
                ContentView()
                    .environmentObject(authenticationState)
            } else {
                NavigationStack {
                    LoginView()
                        .environmentObject(authenticationState)
                }
            }
            
        }
    }
}
