//
//  UserDetailsRepository.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 10/03/26.
//

import Foundation
import SwiftUI

protocol UserDetailsRepositoryProtocol {
    func updateUser(user: LoginModel)
}

class UserDetailsRepository: UserDetailsRepositoryProtocol {
    
    private let databaseManager: DataBaseManagerProtocol
    
    init(databaseManager: DataBaseManagerProtocol) {
        self.databaseManager = databaseManager
    }
    
    func updateUser(user: LoginModel) {
        databaseManager.updateUser(user: user)
    }
}
