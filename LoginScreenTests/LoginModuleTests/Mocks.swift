//
//  Mocks.swift
//  LoginScreenTests
//
//  Created by Swayambhu BANERJEE on 11/03/26.
//

import Foundation
@testable import LoginScreen

// Mock LoginUseCase
class MockLoginUseCase: LoginUseCaseProtocol {
    var loginResult: Result<UserModel?, NetworkError> = .success(nil)
    var validatePasswordResult = ""
    var saveUserCalled = false
    
    func loginValidation(userName: String, password: String) async -> Result<UserModel?, NetworkError> {
        return loginResult
    }
    
    func validatePassword(_ password: String) -> String {
        return validatePasswordResult
    }
    
    func saveUser(user: LoginModel) {
        saveUserCalled = true
    }
}

// Mock Repository
class MockLoginRepository: LoginRepositoryProtocol {
    var loginResult: Result<UserModel?, NetworkError> = .success(nil)
    var saveUserCalled = false
    var savedUser: LoginModel?
    
    func loginValidation(userName: String, password: String) async -> Result<UserModel?, NetworkError> {
        return loginResult
    }
    
    func saveUser(user: LoginModel) {
        saveUserCalled = true
        savedUser = user
    }
}

// Mock Network Provider
class MockNetworkServiceProvider: NetworkServiceProviderProtocol {
    
    var result: Result<UserModel?, NetworkError> = .success(nil)
    var sendValidation = false
    
    func loginValidation(userName: String, password: String) async -> Result<UserModel?, NetworkError> {
        sendValidation = true
        return result
    }
}

// CoreData Mocking need to check this
class MockDataBaseProvider: DataBaseProviderProtocol {
    var saveuserCalled = false
    
    func saveUser(user: LoginModel) {
        saveuserCalled = true
    }
    
    func getAllUsers() -> [LoginModel] {
        []
    }
    
    func deleteUser(user: LoginModel) {}
    
    func updateUser(user: LoginModel) {}
    
}

// Mock Network Service
class MockNetworkService: NetworkServiceProtocol {
    
    var result: Result<UserModel?, NetworkError> = .success(nil)
    var sendCalled = false
    
    func send<T: Decodable>(url: Endpoint) async -> Result<T?, NetworkError> {
        sendCalled = true
        return result as! Result<T?, NetworkError>
    }
}



