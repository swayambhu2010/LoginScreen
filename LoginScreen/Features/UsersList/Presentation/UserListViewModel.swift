//
//  Untitled.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 10/03/26.
//

import Foundation
import Combine

@MainActor
class UserListViewModel: ObservableObject {
    @Published var users: [LoginModel] = []
    
    private let userListUseCase: UserListUseCaseProtocol
    
    init(userListUseCase: UserListUseCaseProtocol) {
        self.userListUseCase = userListUseCase
    }
    
    func saveUser(user: LoginModel) {
        userListUseCase.saveUser(user: user)
    }
    
    func getAllUsers() {
        users = userListUseCase.getAllUsers()
        print(users)
    }
    
    func deleteUser(indexSet: IndexSet) {
        userListUseCase.deleteUser(indexSet: indexSet)
        getAllUsers()
    }
}
