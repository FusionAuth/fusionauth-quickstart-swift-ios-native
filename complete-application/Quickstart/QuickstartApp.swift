//
//  QuickstartApp.swift
//  Quickstart
//
//  Created by Colin Frick on 24.04.24.
//

import SwiftUI
import FusionAuth

@main
struct QuickstartApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AuthorizationManager.shared.fusionAuthState())
                .onOpenURL(perform: { url in
                    OAuthAuthorization.resume(with: url)
                })
        }
    }
}
