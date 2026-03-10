//
//  Untitled.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 10/03/26.
//

import Foundation
import Combine

class UserListViewModel: ObservableObject {
    @Published var users: [UserData] = []
    
    private let userListUseCase: UserListUseCaseProtocol
    
    init(userListUseCase: UserListUseCaseProtocol) {
        self.userListUseCase = userListUseCase
    }
    
    func saveUser(userName: String, passWord: String) {
        userListUseCase.saveUser(userName: userName, passWord: passWord)
        getAllUsers()
        
    }
    
    func getAllUsers() {
        users = userListUseCase.getAllUsers()
    }
    
    func deleteUser(indexSet: IndexSet) {
        userListUseCase.deleteUser(indexSet: indexSet)
        getAllUsers()
    }
    
    func updateUser() {
        userListUseCase.updateUser()
        getAllUsers()
    }
}
