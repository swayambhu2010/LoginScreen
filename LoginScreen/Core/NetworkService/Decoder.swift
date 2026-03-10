//
//  Decoder.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 08/03/26.
//

import Foundation

protocol DecoderProtocol {
    func decode<T: Decodable>(data: Data) throws -> Result<T?, NetworkError>
}

class Decoder: DecoderProtocol {
    
    let decoder: JSONDecoder
    
    init(decoder: JSONDecoder) {
        self.decoder = decoder
    }
    
    func decode<T>(data: Data) throws -> Result<T?, NetworkError> where T : Decodable {
        let responseData = try decoder.decode(T.self, from: data)
        return .success(responseData)
    }
}

class GraphQLDecoder: DecoderProtocol {
    
    var isSuccess: Bool
    
    init(isSuccess: Bool) {
        self.isSuccess = isSuccess
    }
    
    func decode<T: Decodable>(data: Data) -> Result<T?, NetworkError> {
        guard isSuccess else {
            return .failure(NetworkError.defaultError)
        }
        return .success(T.self as? T)
    }
}


