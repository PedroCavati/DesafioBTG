//
//  BTGNetworking.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 25/05/21.
//

import Foundation

enum Errors: Error {
    case invalidUrl
    
    var localizedDescription: String {
        switch self {
        case .invalidUrl:
        return "Invalid URL"
        }
    }
}

protocol Networking {
    func execute<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void)
}

final class BTGNetworking: Networking {
    
    func execute<T>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        guard let urlRequest = endpoint.urlRequest else {
            completion(.failure(Errors.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
            do {
//                if let error = error {
//                    completion(.failure(error))
//                    return
//                }
                
                guard let data = data else {
                    preconditionFailure("No error was received but we also don't have data...")
                }
                
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                
                completion(.success(decodedObject))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
