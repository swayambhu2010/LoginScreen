//
//  Untitled.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 05/03/26.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var userName: String = ""
    @Published var password: String = "" {
        didSet {
            validatePassword(password)
        }
    }
    @Published var isLoading: Bool = false
    @Published var passwordHintText = ""
    @Published var isValidPassword = false
    @Published var errorMessage: String?
    
    private let loginUseCase: LoginUseCaseProtocol
    
    init(loginUseCase: LoginUseCaseProtocol) {
        self.loginUseCase = loginUseCase
    }
    
    // 532E6B52-9032-453F-8C36-1FEF9550995D
    func validation() {
        Task {
           let result = await loginUseCase.loginValidation(userName: userName, password: password)
            switch result {
            case .success(_):
                // Original Code should be there
               /* let loginModel = LoginModel(username: userName, password: password)
                loginUseCase.saveUser(user: loginModel)*/
                isValidPassword = true
            case .failure(_):
                // Hard coded for demo project
                let loginModel = LoginModel(username: userName, password: password, uuid: UUID())
                loginUseCase.saveUser(user: loginModel)
                isValidPassword = true
               // errorMessage = error.localizedDescription
            }
        }
    }
    
    func validatePassword(_ password: String) {
        passwordHintText = loginUseCase.validatePassword(password)
    }
    
}
