//
//  ViewModelFactory.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 25/05/21.
//

import Network

final class ViewModelFactory {
    
    private let networking = BTGNetworking()
    private lazy var currencyService: CurrencyService = BTGCurrencyService(network: networking)
    private lazy var conversionService: ConversionService = BTGConversionService(network: networking)
    
    func makeCurrencyViewModel() -> CurrencyViewModel {
        return CurrencyViewModel(service: currencyService)
    }
    
    func makeConversionViewModel() -> ConversionViewModel {
        return ConversionViewModel(service: conversionService)
    }
}
