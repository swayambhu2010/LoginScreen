//
//  Router.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 18/03/26.
//

import Foundation

enum Route: Hashable {
    case loginScreen
    case userList
    case userDetails(LoginModel)
}
