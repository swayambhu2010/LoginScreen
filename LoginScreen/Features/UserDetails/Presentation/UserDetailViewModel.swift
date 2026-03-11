//
//  UserDetailViewModel.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 10/03/26.
//

import Foundation
import Combine

class UserDetailViewModel: ObservableObject {
    
    private let userDetailsUseCase: UserDetailsUseCaseProtocol
    
    init(userDetailsUseCase: UserDetailsUseCaseProtocol) {
        self.userDetailsUseCase = userDetailsUseCase
    }
    
    func updateUser(user: LoginModel) {
        userDetailsUseCase.updateUser(user: user)
    }
}
