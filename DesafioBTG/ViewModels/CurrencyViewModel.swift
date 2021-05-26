//
//  CurrencyViewModel.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 25/05/21.
//

final class CurrencyViewModel {
    
    private let service: CurrencyService
    
    init(service: CurrencyService) {
        self.service = service
    }
    
    func fetchCurrencies(completion: @escaping (Result<CurrenciesModel, Error>) -> Void) {
        service.getCurrencies(completion)
    }
}
