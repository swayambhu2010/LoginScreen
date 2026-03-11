//
//  UserListProvider.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 10/03/26.
//

import Foundation

protocol UsersListRepositoryProtocol {
    // CRUD operation (Create, Read, Update, Delete)
    func saveUser(user: LoginModel)
    func getAllUsers() -> [LoginModel]
    func deleteUser(user: LoginModel)
}

class UsersListRepository: UsersListRepositoryProtocol {
    
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
}
