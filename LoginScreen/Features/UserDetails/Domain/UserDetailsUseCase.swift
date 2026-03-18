//
//  UserDetailsUseCase.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 10/03/26.
//

import Foundation

protocol UserDetailsUseCaseProtocol {
    func updateUser(user: LoginModel) throws -> Bool
}

class UserDetailsUseCase: UserDetailsUseCaseProtocol {
    private let userDetailsRepository: UserDetailsRepository
    
    init(userDetailsRepository: UserDetailsRepository) {
        self.userDetailsRepository = userDetailsRepository
    }
    
    func updateUser(user: LoginModel) throws -> Bool {
        return try userDetailsRepository.updateUser(user: user)
    }
    
}
