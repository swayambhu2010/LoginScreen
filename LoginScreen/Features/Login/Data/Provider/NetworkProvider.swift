//
//  NetworkProvider.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 08/03/26.
//

import Foundation

protocol NetworkServiceProviderProtocol {
    func loginValidation(userName: String, password: String) async -> Result<UserModel?, NetworkError>
}

class NetworkService: NetworkServiceProviderProtocol {
    
    let network: NetworkManager
    
    init() {
        let session = SessionManager()
        let decoder = Decoder(decoder: JSONDecoder())
        self.network = NetworkManager(session: session, decode: decoder)
    }
    
    func loginValidation(userName: String, password: String) async -> Result<UserModel?, NetworkError> {
        
            let userLogin = LoginModel(username: userName, password: password)
            let loginEndpoint = Endpoint(baseURL: "https://www.example.com", path: "/user", method: .post, header: ["Content-Type": "application/json"], body: userLogin.dictionary)
            let result: Result<UserModel?, NetworkError> = await network.send(url: loginEndpoint)
            return result
    }
}
