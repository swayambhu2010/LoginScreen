//
//  UserDetailViewModel.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 10/03/26.
//

import Foundation
import Combine

@MainActor
class UserDetailViewModel: ObservableObject {
    
    private let userDetailsUseCase: UserDetailsUseCaseProtocol
    
    @Published var userName: String
    private var loginModel: LoginModel
    
    init(user: LoginModel, userDetailsUseCase: UserDetailsUseCaseProtocol) {
        self.loginModel = user
        self.userName = user.username
        self.userDetailsUseCase = userDetailsUseCase
    }
    
    func updateUser() {
        userDetailsUseCase.updateUser(user: loginModel)
    }
}
