//
//  MainCoordinator.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 25/05/21.
//

import UIKit

class MainCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private let moduleFactory: ModuleFactory
    
    init(navigationController: UINavigationController, moduleFactory: ModuleFactory) {
        self.navigationController = navigationController
        self.moduleFactory = moduleFactory
    }
    
    /**
     This method will get a ConversionViewController from the ModuleFactory and push it to the navigationController
     */
    func start() {
        let conversionModule = moduleFactory.makeConversionModule()
        navigationController.pushViewController(conversionModule, animated: true)
    }
    
    func presentCurrencyModule() {
        let currencyModule = moduleFactory.makeCurrencyModule()
        navigationController.pushViewController(currencyModule, animated: true)
    }
    
}
