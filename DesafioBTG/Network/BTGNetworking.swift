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
    case noData
    case noStoredData
    case decoding
    
    var localizedDescription: String {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
            
        case .noConnection:
            return "Internet connection not available"
            
        case .noData:
            return "There is no data available"
            
        case .noStoredData:
            return "Internet connection not available and there was no data in your storage"
            
        case .decoding:
            return "There was a problem trying to read your data"
        }
    }
}

protocol Networking {
    func execute<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void)
}

final class BTGNetworking: Networking {
    func execute<T>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let monitor = NWPathMonitor()
        
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                guard let urlRequest = endpoint.urlRequest else {
                    // There is a connection, but it's an invalid URLRequest
                    monitor.cancel()
                    completion(.failure(Errors.invalidUrl))
                    return
                }
                
                URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                    do {
                        if let error = error {
                            // There was an error while performing the URLSession
                            monitor.cancel()
                            completion(.failure(error))
                            return
                        }
                        
                        guard let data = data else {
                            // The URLSession succeded but there is no data
                            monitor.cancel()
                            completion(.failure(Errors.noData))
                            return
                        }
                        
                        self?.saveUserDefaults(object: T.self, data: data)
                        let decodedObject = try JSONDecoder().decode(T.self, from: data)
                        
                        // The URLSession succeded and the data was decoded
                        monitor.cancel()
                        completion(.success(decodedObject))
                    } catch {
                        
                        // The decoding failed
                        monitor.cancel()
                        completion(.failure(Errors.decoding))
                    }
                }.resume()
            } else {
                guard let data = self?.fetchUserDefaults(object: T.self) else {
                    // There is no connection and no stored data
                    monitor.cancel()
                    completion(.failure(Errors.noStoredData))
                    return
                }
                do {
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    
                    // There is no connection, but the stored data was decoded
                    monitor.cancel()
                    completion(.success(decodedObject))
                } catch {
                    
                    // The decoding failed
                    monitor.cancel()
                    completion(.failure(Errors.decoding))
                }
            }
        }
        
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
    }
    
    private func fetchUserDefaults(object: Any.Type) -> Data? {
        if object == QuotesModel.self {
            return Storage.quotes
        }
        if object == CurrenciesModel.self {
            return Storage.currencies
        }
        return nil
    }
    
    private func saveUserDefaults(object: Any.Type, data: Data) {
        if object == QuotesModel.self {
            Storage.quotes = data
        }
        if object == CurrenciesModel.self {
            Storage.currencies = data
        }
    }
    
}
