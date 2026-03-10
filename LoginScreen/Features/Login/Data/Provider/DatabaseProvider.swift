//
//  DatabaseProvider.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 08/03/26.
//

import Foundation

protocol DataBaseProviderProtocol {
    // CRUD operation (Create, Read, Update, Delete)
    func saveUser(userName: String, passWord: String)
    func getAllUsers() -> [UserData]
    func deleteUser(user: UserData)
    func updateUser()
}

class DataBaseProvider: DataBaseProviderProtocol {
    
    let databaseManager: DataBaseManagerProtocol
    
    init(databaseManager: DataBaseManagerProtocol) {
        self.databaseManager = databaseManager
    }
    
    func saveUser(userName: String, passWord: String) {
        databaseManager.saveUser(userName: userName, passWord: passWord)
    }
    
    func getAllUsers() -> [UserData] {
        databaseManager.getAllUsers()
    }
    
    func deleteUser(user: UserData) {
        databaseManager.deleteUser(user: user)
    }
    
    func updateUser() {
        databaseManager.updateUser()
    }
}
