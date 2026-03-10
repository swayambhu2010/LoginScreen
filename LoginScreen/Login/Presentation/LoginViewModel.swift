//
//  Untitled.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 05/03/26.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = "" {
        didSet {
            validatePassword(password)
        }
    }
    @Published var isLoading: Bool = false
    @Published var passwordHintText = ""
    @Published var isValidPassword = false
    
    @Published var users: [UserData] = []
    
   
    
    func validation() {
        
        Task {
            let userLogin = LoginModel(username: username, password: password)
            validatePassword(password)
            do {
                let loginEndpoint = Endpoint(baseURL: "https://www.example.com", path: "/user", method: .post, header: ["Content-Type": "application/json"], body: userLogin)
                
              
                
            }
        }
    }
    
    func localDBSave() {
        DataBaseManager.shared.saveUser(userName: username, passWord: password)
        fetchUser()
    }
    
    func fetchUser() {
        users = DataBaseManager.shared.getAllUsers()
    }
    
    func deleteUser(indexSet: IndexSet) {
        
        indexSet.forEach { index in
          let user = users[index]
          DataBaseManager.shared.deleteUser(user: user)
          fetchUser()
        }
    }
    
    func updateUser() {
        DataBaseManager.shared.updateUser()
        fetchUser()
    }
    
    func validatePassword(_ password: String) {
        guard password.count >= 8 else {
            passwordHintText = "Please enter minimum 8 characters"
            return
        }
        
        passwordHintText = ""
    }
    
}
