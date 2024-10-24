//
//  AuthorizationManager+Initialization.swift
//  fusionauth-quickstart-swift-ios-native
//
//  Created by Colin Frick on 31.08.24.
//

import Foundation
import FusionAuth

extension AuthorizationManager {
    
    public static let shared: AuthorizationManager = {
        let instance = AuthorizationManager.instance
        instance.initialize(configuration: AuthorizationConfiguration(
            clientId: "e9fdb985-9173-4e01-9d73-ac2d60d1dc8e",
            fusionAuthUrl: "http://localhost:9011",
            additionalScopes: ["email", "profile"]))
        return instance
    }()
    
}
