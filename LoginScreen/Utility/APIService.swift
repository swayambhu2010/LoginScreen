//
//  Untitled.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 05/03/26.
//


import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}


enum NetworkError: Error {
    case badrequest
    case decodingError
}

struct Endpoint {
    var baseURL: String
    var path: String
    
    var method: HTTPMethod
    var header: [String: String]?
    var body: Data
    
    var urlRequest: URLRequest? {
        let completeURL = baseURL + path
        
        guard let url = URL(string: completeURL) else { return nil }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = header
        // Where to encode the data instead of in the viewmodel class
        urlRequest.httpBody = body
        
        return urlRequest
    }
}
