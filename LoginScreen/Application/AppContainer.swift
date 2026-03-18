//
//  AppContainer.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 11/03/26.
//

import Foundation

final class AppContainer {
    
    lazy var databaseManager: DataBaseManager = {
        DataBaseManager()
    }()
    
    lazy var networkService: NetworkServiceProviderProtocol = {
        NetworkService()
    }()
    
    lazy var dataBaseService: DataBaseProviderProtocol = {
        DataBaseProvider(databaseManager: databaseManager)
    }()
    
    lazy var loginRepository = {
        LoginRepository(networkProvider: networkService, dataBaseProvider: dataBaseService)
    }()
    
    lazy var userDetailsRepository = {
        UserDetailsRepository(databaseManager: databaseManager)
    }()
    
    lazy var userListRepository = {
        UsersListRepository(databaseManager: databaseManager)
    }()
}
