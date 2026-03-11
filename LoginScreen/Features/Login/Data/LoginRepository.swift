//
//  LoginRepository.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 08/03/26.
//

import Foundation

protocol LoginRepositoryProtocol {
    func loginValidation(userName: String, password: String) async -> Result<UserModel?, NetworkError>
    func saveUser(user: LoginModel)
}

class LoginRepository: LoginRepositoryProtocol {
    
    private let networkProvider: NetworkServiceProviderProtocol
    private let dataBaseProvider: DataBaseProviderProtocol
    
    init(networkProvider: NetworkServiceProviderProtocol, dataBaseProvider: DataBaseProviderProtocol) {
        self.networkProvider = networkProvider
        self.dataBaseProvider = dataBaseProvider
    }
    
    func loginValidation(userName: String, password: String) async -> Result<UserModel?, NetworkError> {
         await networkProvider.loginValidation(userName: userName, password: password)
    }
    
    func saveUser(user: LoginModel) {
        dataBaseProvider.saveUser(user: user)
    }
}
