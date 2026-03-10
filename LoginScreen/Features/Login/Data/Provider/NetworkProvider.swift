//
//  NetworkProvider.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 08/03/26.
//

import Foundation

protocol NetworkServiceProviderProtocol {
    func loginValidation(userName: String, password: String) async throws -> Result<UserModel, NetworkError>
}

class NetworkService: NetworkServiceProviderProtocol {
    
    let network: NetworkManager
    
    init() {
        let session = SessionManager()
        let decoder = Decoder(decoder: JSONDecoder())
        self.network = NetworkManager(session: session, decode: decoder)
    }
    
    func loginValidation(userName: String, password: String) async throws -> Result<UserModel, NetworkError> {
        
        let userLogin = LoginModel(username: userName, password: password)
        let loginEndpoint = Endpoint(baseURL: "https://www.example.com", path: "/user", method: .post, header: ["Content-Type": "application/json"], body: userLogin)
        
        guard let result: UserModel = try await network.send(url: loginEndpoint) else {
            // How to propagate the exact error?
            return .failure(NetworkError.decodingError)
        }
        
        return .success(result)
    }
}
