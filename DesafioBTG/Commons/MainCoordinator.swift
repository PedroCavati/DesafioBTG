//
//  MainCoordinator.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 25/05/21.
//

import UIKit

final class MainCoordinator: Coordinator {
    // MARK: - Properties
    private let navigationController: UINavigationController
    private let moduleFactory: ModuleFactory
    
    // MARK: - Initializers
    init(navigationController: UINavigationController, moduleFactory: ModuleFactory) {
        self.navigationController = navigationController
        self.moduleFactory = moduleFactory
    }
    
    // MARK: - Methods
    func start() {
        let conversionModule = moduleFactory.makeConversionModule()
        conversionModule.currencyButtonTapped = { [weak self] buttonType in
            self?.presentCurrencyModule(delegate: conversionModule, buttonType: buttonType)
        }
        navigationController.pushViewController(conversionModule, animated: true)
    }
    
    /**
     Method responsible for intecting data into a CurrencyViewController and presenting it
     - parameters:
        - delegate: CurrencyPassDelegate responsible for transferring data from one view to another
        - buttonType: ButtonType the type of the button that will receive the new currency
     */
    private func presentCurrencyModule(delegate: CurrencyPassDelegate, buttonType: ButtonType) {
        let currencyModule = moduleFactory.makeCurrencyModule()
        currencyModule.currencyDelegate = delegate
        currencyModule.buttonType = buttonType
        currencyModule.cancel = { [weak self] in
            self?.navigationController.dismiss(animated: true, completion: nil)
        }
        currencyModule.done = { [weak self] in
            self?.navigationController.dismiss(animated: true, completion: nil)
        }
        let navController = UINavigationController(rootViewController: currencyModule)
        navigationController.present(navController, animated: true, completion: nil)
    }
    
}
