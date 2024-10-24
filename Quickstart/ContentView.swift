//
//  ContentView.swift
//  Quickstart
//
//  Created by Colin Frick on 24.04.24.
//

import SwiftUI
import FusionAuth
import UIKit

struct ContentView: View {

    @EnvironmentObject var authState: FusionAuthState

    var body: some View {
        VStack {
            if authState.isLoggedIn() {
                LoggedInView()
            } else {
                LoginView()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
