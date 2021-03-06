//
//  ModuleFactory.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 25/05/21.
//

import UIKit

final class ModuleFactory {
    private let viewModelFactory = ViewModelFactory()
    
    func makeConversionModule() -> ConversionViewController {
        ConversionViewController(viewModel: viewModelFactory.makeConversionViewModel())
    }

    func makeCurrencyModule() -> CurrencyViewController {
        CurrencyViewController(viewModel: viewModelFactory.makeCurrencyViewModel())
    }
    
}
