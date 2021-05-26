//
//  ConversionService.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 25/05/21.
//

import Foundation

protocol ConversionService: Service {
    func getQuotes(_ completion: @escaping (Result<QuotesModel, Error>) -> Void)
}

struct BTGConversionService: ConversionService {
    var network: Networking
    
    func getQuotes(_ completion: @escaping (Result<QuotesModel, Error>) -> Void) {
        network.execute(.quotes, completion: completion)
    }
}
