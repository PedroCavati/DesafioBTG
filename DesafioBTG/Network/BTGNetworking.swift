//
//  BTGNetworking.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 25/05/21.
//

import Foundation
import Network

enum Errors: Error {
    case invalidUrl
    case noConnection
    
    var localizedDescription: String {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
            
        case .noConnection:
            return "Internet Connection not Available"
        }
    }
}

protocol Networking {
    var monitor: NWPathMonitor { get }
    
    func execute<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void)
}

final class BTGNetworking: Networking {
    internal var monitor = NWPathMonitor()
    
    func execute<T>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                guard let urlRequest = endpoint.urlRequest else {
                    completion(.failure(Errors.invalidUrl))
                    return
                }
                
                URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                    do {
                        if let error = error {
                            completion(.failure(error))
                            self?.monitor.cancel()
                            return
                        }
                        
                        guard let data = data else {
                            self?.monitor.cancel()
                            preconditionFailure("No error was received but we also don't have data...")
                        }
                        
                        let decodedObject = try JSONDecoder().decode(T.self, from: data)
                        self?.monitor.cancel()
                        completion(.success(decodedObject))
                    } catch {
                        self?.monitor.cancel()
                        completion(.failure(error))
                    }
                }.resume()
            }
        }
        
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
    }
    
}
