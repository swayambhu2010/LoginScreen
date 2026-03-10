//
//  SessionManager.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 08/03/26.
//

import Foundation

protocol SessionManagerProtocol {
    func exectute(request: URLRequest) async throws -> Result<Data, NetworkError>
}

class SessionManager: SessionManagerProtocol {
    
    let session: URLSession
    
    init() {
        session = URLSession(configuration: .default)
    }
    
    func exectute(request: URLRequest) async throws -> Result<Data, NetworkError> {
        
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(NetworkError.invalidResponse)
            }
                    
            guard (200...299).contains(httpResponse.statusCode) else {
                return .failure(NetworkError.serverError(statusCode: httpResponse.statusCode))
            }
                    
            guard data.isEmpty else {
                return .failure(NetworkError.emptyResponse)
            }
            
            return .success(data)
        
    }
}

class AFNetworkSessionManager: SessionManagerProtocol {
    // Extend this
    func exectute(request: URLRequest) async -> Result<Data, NetworkError> {
        return .failure(NetworkError.defaultError)
    }
}


