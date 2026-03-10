//
//  NetworkManager.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 05/03/26.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func send<T: Decodable>(url: Endpoint) async -> Result<T?, NetworkError>
}

final class NetworkManager: NetworkServiceProtocol {
    
    let session: SessionManagerProtocol
    let decoder: DecoderProtocol
    
    init(session: SessionManagerProtocol, decode: DecoderProtocol) {
        self.session = session
        self.decoder = decode
    }
    
    func send<T>(url: Endpoint) async -> Result<T?, NetworkError> where T : Decodable {
        
        guard let urlRequest = url.urlRequest else { return .failure(NetworkError.badrequest) }
        do {
            let data = try await session.exectute(request: urlRequest)
            
            switch data {
            case .success(let data):
                let user: Result<T?, NetworkError> = try decoder.decode(data: data)
                switch user {
                case .success(let model):
                    return .success(model)
                case .failure(let error):
                    return .failure(error)
                }
            case .failure(let error):
                return .failure(error)
            }
        } catch {
            return .failure(NetworkError.defaultError)
        }
    }
}
