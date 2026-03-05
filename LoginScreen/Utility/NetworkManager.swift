//
//  NetworkManager.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 05/03/26.
//

import Foundation

protocol NetworkServiceProtocol {
    func send<T: Decodable>(url: Endpoint) async -> T?
}


final class NetworkManager: NetworkServiceProtocol {
    
    // Figure out dependency injection
    static let shared = NetworkManager()
    
    private init() { }
    
    
    func send<T>(url: Endpoint) async -> T? where T : Decodable {
        
        guard let urlRequest = url.urlRequest else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            
            // Improve with Validation & Retry logic
            // Mostly Exponential Backoff
            let user = try JSONDecoder().decode(T.self, from: data)
            return user
            
        } catch {
            return nil
        }
        
        
    }
    
    
    
}
