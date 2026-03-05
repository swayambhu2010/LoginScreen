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
    
    
    func validation() {
        
        Task {
            let userLogin = LoginModel(username: username, password: password)
            validatePassword(password)
            do {
                let data = try JSONEncoder().encode(userLogin)
                let loginEndpoint = Endpoint(baseURL: "https://www.example.com", path: "/user", method: .post, header: ["Content-Type": "application/json"], body: data)
                
                let user: UserModel? = await NetworkManager.shared.send(url: loginEndpoint)
                
            } catch {
                
            }
        }
    }
    
    func validatePassword(_ password: String) {
        guard password.count > 8 else {
            passwordHintText = "Please enter minimum 8 characters"
            return
        }
        
        passwordHintText = ""
    }
    
}
