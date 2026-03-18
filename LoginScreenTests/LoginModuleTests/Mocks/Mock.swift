//
//  MockSessionManager.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 18/03/26.
//

import Foundation
@testable import LoginScreen

class MockSessionManager: SessionManagerProtocol {
    
    var result: Result<Data, NetworkError> = .success(Data())
    var isExecuted: Bool = false
    var lastRequest: URLRequest?
    
    func exectute(request: URLRequest) async throws -> Result<Data, NetworkError> {
        isExecuted = true
        lastRequest = request
        return result
    }
}

class MockDecoder: DecoderProtocol {
    
    var isCalled: Bool = false
    var result: Result<UserModel?, NetworkError> = .success(UserModel(userName: "Swayambhu", token: "Bearer"))
    func decode<T>(data: Data) throws -> Result<T?, NetworkError> where T : Decodable {
        isCalled = true
        return result as! Result<T?, NetworkError>
    }
}
    
