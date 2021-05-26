//
//  ModuleFactory.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 25/05/21.
//

final class ModuleFactory {
    
    private let viewModelFactory = ViewModelFactory()
    
    func makeConversionModule() -> ConversionViewController {
        ConversionViewController(viewModel: viewModelFactory.makeConversionViewModel())
    }

    func makeCurrencyModule() -> CurrencyViewController {
        CurrencyViewController()
    }
    
}
