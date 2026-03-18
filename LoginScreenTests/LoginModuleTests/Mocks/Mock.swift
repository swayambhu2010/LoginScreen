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
        
    }
    
    
}
