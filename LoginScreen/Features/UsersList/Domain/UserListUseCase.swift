//
//  UserListUseCase.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 10/03/26.
//

import Foundation

protocol UserListUseCaseProtocol {
    func saveUser(user: LoginModel)
    func getAllUsers() -> [LoginModel]
    func deleteUser(indexSet: IndexSet)
}

class UserListUseCase: UserListUseCaseProtocol {
    
    private let userListRepository: UsersListRepositoryProtocol
    var users: [LoginModel] = []
    
    init(userListRepository: UsersListRepositoryProtocol) {
        self.userListRepository = userListRepository
    }
    
    func saveUser(user: LoginModel) {
        userListRepository.saveUser(user: user)
    }
    
    func getAllUsers() -> [LoginModel] {
        users = userListRepository.getAllUsers()
        return users
    }
    
    func deleteUser(indexSet: IndexSet) {
        indexSet.forEach { index in
            let user = users[index]
            userListRepository.deleteUser(user: user)
        }
    }
}
