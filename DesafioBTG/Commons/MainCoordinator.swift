//
//  MainCoordinator.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 25/05/21.
//

class MainCoordinator: Coordinator {
    
    private let moduleFactory: ModuleFactory
    
    init(moduleFactory: ModuleFactory) {
        self.moduleFactory = moduleFactory
        start()
    }
    
    func start() {
        let conversionModule = moduleFactory.makeConversionModule()
    }
    
}
