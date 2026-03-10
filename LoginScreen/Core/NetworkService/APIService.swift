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
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}


enum NetworkError: Error {
    case badrequest
    case decodingError
    case invalidResponse
    case serverError(statusCode: Int)
    case emptyResponse
    case defaultError
}

struct Endpoint {
    var baseURL: String
    var path: String
    
    var method: HTTPMethod
    var header: [String: String]?
    var body: Any?
    
    var urlRequest: URLRequest? {
        let completeURL = baseURL + path
        
        guard let url = URL(string: completeURL) else { return nil }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = header
        // Where to encode the data instead of in the viewmodel class(Here)
        if let body = body {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
        }
        return urlRequest
    }
}

extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
}
