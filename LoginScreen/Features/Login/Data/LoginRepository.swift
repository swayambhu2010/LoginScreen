//
//  LoginRepository.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 08/03/26.
//

import Foundation

protocol LoginRepositoryProtocol {
    func loginValidation(userName: String, password: String) async -> Result<UserModel?, NetworkError>
}

class LoginRepository: LoginRepositoryProtocol {
    
    private let networkProvider: NetworkServiceProviderProtocol
    
    init(networkProvider: NetworkServiceProviderProtocol) {
        self.networkProvider = networkProvider
    }
    
    func loginValidation(userName: String, password: String) async -> Result<UserModel?, NetworkError> {
         await networkProvider.loginValidation(userName: userName, password: password)
    }
}
