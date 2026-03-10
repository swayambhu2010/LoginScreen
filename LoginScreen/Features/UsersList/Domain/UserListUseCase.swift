//
//  UserListUseCase.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 10/03/26.
//

import Foundation

protocol UserListUseCaseProtocol {
    func saveUser(userName: String, passWord: String)
    func getAllUsers() -> [UserData]
    func deleteUser(indexSet: IndexSet)
    func updateUser()
}

class UserListUseCase: UserListUseCaseProtocol {
    
    private let userListRepository: UsersListRepositoryProtocol
    var users: [UserData] = []
    
    init(userListRepository: UsersListRepositoryProtocol) {
        self.userListRepository = userListRepository
    }
    
    func saveUser(userName: String, passWord: String) {
        userListRepository.saveUser(userName: userName, passWord: passWord)
    }
    
    func getAllUsers() -> [UserData] {
        users = userListRepository.getAllUsers()
        return users
    }
    
    func deleteUser(indexSet: IndexSet) {
        indexSet.forEach { index in
            let user = users[index]
            userListRepository.deleteUser(user: user)
        }
    }
    
    func updateUser() {
        userListRepository.updateUser()
    }
}
