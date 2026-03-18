//
//  Untitled.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 05/03/26.
//

import Foundation
import Combine

@MainActor
class LoginViewModel: ObservableObject {
    
    @Published var userName: String = ""
    @Published var password: String = "" {
        didSet {
            validatePassword(password)
        }
    }
    @Published var isLoading: Bool = false
    @Published var passwordHintText = ""
    @Published var errorMessage: String?
    
    var loginSuccessClosure: (() -> Void)
    
    private let loginUseCase: LoginUseCaseProtocol
    
    init(loginUseCase: LoginUseCaseProtocol, loginSuccess: @escaping () -> Void) {
        self.loginUseCase = loginUseCase
        self.loginSuccessClosure = loginSuccess
    }
    
    func validation() {
        Task {
           let result = await loginUseCase.loginValidation(userName: userName, password: password)
            switch result {
            case .success(_):
                // Original Code should be there
               /* let loginModel = LoginModel(username: userName, password: password)
                loginUseCase.saveUser(user: loginModel)*/
                loginSuccessClosure()
            case .failure(_):
                // Hard coded for demo project
                let loginModel = LoginModel(username: userName, password: password, uuid: UUID())
                loginUseCase.saveUser(user: loginModel)
                loginSuccessClosure()
               // errorMessage = error.localizedDescription
            }
        }
    }
    
    func validatePassword(_ password: String) {
        passwordHintText = loginUseCase.validatePassword(password)
    }
    
}
