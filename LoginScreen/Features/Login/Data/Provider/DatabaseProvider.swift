//
//  DatabaseProvider.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 08/03/26.
//

import Foundation

protocol DataBaseProviderProtocol {
    // CRUD operation (Create, Read, Update, Delete)
    func saveUser(user: LoginModel)
    func getAllUsers() -> [LoginModel]
    func deleteUser(user: LoginModel)
    func updateUser(user: LoginModel) throws -> Bool
}

class DataBaseProvider: DataBaseProviderProtocol {
    
    let databaseManager: DataBaseManagerProtocol
    
    init(databaseManager: DataBaseManagerProtocol) {
        self.databaseManager = databaseManager
    }
    
    func saveUser(user: LoginModel) {
        databaseManager.saveUser(userModel: user)
    }
    
    func getAllUsers() -> [LoginModel] {
        databaseManager.getAllUsers()
    }
    
    func deleteUser(user: LoginModel) {
        databaseManager.deleteUser(user: user)
    }
    
    func updateUser(user: LoginModel) throws -> Bool {
       try databaseManager.updateUser(user: user)
    }
}
