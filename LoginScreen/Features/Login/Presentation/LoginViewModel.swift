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
    
    func validation() {
        Task {
           let result = await loginUseCase.loginValidation(userName: userName, password: password)
            switch result {
            case .success(_):
                isValidPassword = true
            case .failure(_):
                // Hard coded for demo project
                isValidPassword = true
               // errorMessage = error.localizedDescription
            }
        }
    }
    
    func validatePassword(_ password: String) {
        passwordHintText = loginUseCase.validatePassword(password)
    }
    
}
