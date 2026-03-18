//
//  LoginScreenApp.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 05/03/26.
//

import SwiftUI

@main
struct LoginScreenApp: App {
    
    @StateObject var coordinator = Coordinator(containter: AppContainer())
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                coordinator.makeLoginView()
                    .navigationDestination(for: Route.self) { route in
                        coordinator.makeScreenView(to: route)
                    }
            }
        }
    }
}
