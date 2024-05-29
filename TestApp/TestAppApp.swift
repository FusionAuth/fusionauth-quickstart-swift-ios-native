//
//  TestAppApp.swift
//  TestApp
//
//  Created by Colin Frick on 24.04.24.
//

import SwiftUI
import FusionAuth

@main
struct TestAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AuthorizationManager.fusionAuthState)
                .onOpenURL(perform: { url in
                    OAuthAuthorization.resume(with: url)
                })
        }
    }
}
