//
//  NetworkManager.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 05/03/26.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func send<T: Decodable>(url: Endpoint) async throws -> T?
}

final class NetworkManager: NetworkServiceProtocol {
    
    let session: SessionManagerProtocol
    let decoder: DecoderProtocol
    
    init(session: SessionManagerProtocol, decode: DecoderProtocol) {
        self.session = session
        self.decoder = decode
    }
    
    func send<T>(url: Endpoint) async throws -> T? where T : Decodable {
        
        guard let urlRequest = url.urlRequest else { return nil }
    
        let data = try await session.exectute(request: urlRequest)
        
        switch data {
        case .success(let data):
            let user: Result<T?, NetworkError> = try decoder.decode(data: data)
            switch user {
            case .success(let model):
                return model
            case .failure(let error):
                debugPrint("Handle the Error")
            }
            
        case .failure(let error):
            debugPrint("Handle the Error")
        }
        return nil
    }
}
