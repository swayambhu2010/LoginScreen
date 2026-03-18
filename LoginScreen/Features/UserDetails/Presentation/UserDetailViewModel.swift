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
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    private var loginModel: LoginModel
    
    init(user: LoginModel, userDetailsUseCase: UserDetailsUseCaseProtocol) {
        self.loginModel = user
        self.userName = user.username
        self.userDetailsUseCase = userDetailsUseCase
    }
    
    func updateUser() {
        loginModel.username = userName
        do {
            isLoading = try userDetailsUseCase.updateUser(user: loginModel)
        }
        catch {
            errorMessage = "Updation is failed"
        }
    }
}
