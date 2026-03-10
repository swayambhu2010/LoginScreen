//
//  File.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 05/03/26.
//

import Foundation

struct UserModel: Codable {
    var userName: String
    var token: String
}

struct LoginModel: Codable {
    var username: String?
    var password: String?
}
