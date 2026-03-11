//
//  AppContainer.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 11/03/26.
//

import Foundation

final class AppContainer {
    
    static let shared = AppContainer()
    lazy var databaseManager: DataBaseManager = {
        DataBaseManager()
    }()
    
    private init() { }
    
    func makeLoginViewModel() -> LoginViewModel {
        let networkService: NetworkServiceProviderProtocol = NetworkService()
        let dataBaseService: DataBaseProviderProtocol = DataBaseProvider(databaseManager: databaseManager)
        
        let loginRepository = LoginRepository(networkProvider: networkService, dataBaseProvider: dataBaseService)
        let loginUseCase = LoginUseCase(loginRepository: loginRepository)
        
        let loginViewModel = LoginViewModel(loginUseCase: loginUseCase)
        return loginViewModel
    }
    
    
    func makeUserDetailsViewModel() -> UserDetailViewModel {
        let userDetailsRepository = UserDetailsRepository(databaseManager: databaseManager)
        let userDetailsUseCase = UserDetailsUseCase(userDetailsRepository: userDetailsRepository)
        
        let userDetailsViewModel = UserDetailViewModel(userDetailsUseCase: userDetailsUseCase)
        return userDetailsViewModel
    }
    
    func makeUserListViewModel() -> UserListViewModel {
        let userListRepository = UsersListRepository(databaseManager: databaseManager)
        let userListUseCase = UserListUseCase(userListRepository: userListRepository)
        
        let userListViewModel = UserListViewModel(userListUseCase: userListUseCase)
        return userListViewModel
    }
}
