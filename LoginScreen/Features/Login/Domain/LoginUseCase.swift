//
//  LoginUseCase.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 08/03/26.
//

import Foundation

protocol LoginUseCaseProtocol {
    func loginValidation(userName: String, password: String) async -> Result<UserModel?, NetworkError>
    func validatePassword(_ password: String) -> String
    func saveUser(user: LoginModel)
}

class LoginUseCase: LoginUseCaseProtocol {
   
    let loginRepository: LoginRepositoryProtocol
    
    init(loginRepository: LoginRepositoryProtocol) {
        self.loginRepository = loginRepository
    }
    
    func loginValidation(userName: String, password: String) async -> Result<UserModel?, NetworkError> {
        await loginRepository.loginValidation(userName: userName, password: password)
    }
    
    func validatePassword(_ password: String) -> String {
        guard password.count >= 8 else {
            return "Please enter minimum 8 characters"
        }
        return ""
    }
    
    func saveUser(user: LoginModel) {
        loginRepository.saveUser(user: user)
    }
}
