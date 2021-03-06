//
//  Endpoint.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 25/05/21.
//

import Foundation

enum HTTPMethods: String {
    case get
    case post
    
    var method: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }
}

protocol RequestProviding {
    var urlRequest: URLRequest? { get }
}

enum Endpoint {
    case quotes
    case currencies
}

extension Endpoint: RequestProviding {
    var urlRequest: URLRequest? {
        switch self {
        case .quotes:
            return makeUrlRequest(endpoint: "live")
            
        case .currencies:
            return makeUrlRequest(endpoint: "list")
        }
    }
    
    func makeUrlRequest(endpoint: String, httpMethod: HTTPMethods = .get) -> URLRequest? {
        
        let accessKey = "access_key=1d0fc6f013dff7075a2cdb5639036fe6"
        
        guard let url = URL(string: "http://api.currencylayer.com/\(endpoint)?\(accessKey)") else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.method
        
        return request
    }
}
