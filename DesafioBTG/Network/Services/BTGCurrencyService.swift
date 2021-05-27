//
//  BTGQuotesService.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 25/05/21.
//

import Foundation

protocol CurrencyService: Service {
    func getCurrencies(_ completion: @escaping (Result<CurrenciesModel, Error>) -> Void)
}

struct BTGCurrencyService: CurrencyService {
    var network: Networking
    
    func getCurrencies(_ completion: @escaping (Result<CurrenciesModel, Error>) -> Void) {
        network.execute(.currencies, completion: completion)
    }
}
