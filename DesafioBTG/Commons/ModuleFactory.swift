//
//  ModuleFactory.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 25/05/21.
//

final class ModuleFactory {
    
    func makeConversionModule() -> ConversionViewController {
        ConversionViewController()
    }
    
    func makeCurrencyModule() -> CurrencyViewController {
        CurrencyViewController()
    }
    
}
