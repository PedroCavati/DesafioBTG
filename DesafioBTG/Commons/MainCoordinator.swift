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
        start()
    }
    
    func start() {
//        let conversionModule = moduleFactory.makeConversionModule()
    }
    
    func telaNova() {
//        let telaNova = moduleFactory.makeCurrencyModule()
    }
    
}
