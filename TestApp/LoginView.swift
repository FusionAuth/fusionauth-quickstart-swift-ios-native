//
//  LoginView.swift
//  TestApp
//
//  Created by Colin Frick on 15.05.24.
//

import SwiftUI
import FusionAuth

struct LoginView: View {
    
    var body: some View {
        VStack {
            Image("changebank")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text("Welcome to ChangeBank!")
            
            Button("Login") {
                AuthorizationManager.instance
                    .initialize(configuration:
                    AuthorizationConfiguration(
                        clientId: "e9fdb985-9173-4e01-9d73-ac2d60d1dc8e",
                        fusionAuthUrl: "http://localhost:9011",
                        additionalScopes: ["email", "profile"]
                    ), storage:""
                )
                
                Task {
                    do {
                        
                        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                        let presentingView = windowScene?.windows.first?.rootViewController
                        
                        try await AuthorizationManager.instance
                            .oauth()
                            .authorize(options: OAuthAuthorizeOptions(), view: presentingView!)
                    } catch {
                        print("Error occured")
                    }
                }
            }.buttonStyle(PrimaryButtonStyle())
            
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
