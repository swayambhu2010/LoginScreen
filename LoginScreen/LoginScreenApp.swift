//
//  LoginScreenApp.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 05/03/26.
//

import SwiftUI

@main
struct LoginScreenApp: App {
    
    @StateObject var databaseManager = DataBaseManager()
    
    var body: some Scene {
        WindowGroup {
            LoginScreenView().environmentObject(databaseManager)
        }
    }
}
