//
//  CurrencyViewModelTests.swift
//  DesafioBTGTests
//
//  Created by Pedro Henrique Cavalcante de Sousa on 25/05/21.
//

import XCTest
import Network
@testable import DesafioBTG

class CurrencyViewModelTests: XCTestCase {

    lazy var network: Networking = BTGNetworking()
    lazy var service: CurrencyService = BTGCurrencyService(network: network)
    lazy var sut: CurrencyViewModel = CurrencyViewModel(service: service)
    
    func testFetch() {
        
        let expectation = expectation(description: #function)
        var models: CurrenciesModel? = nil
        var fetchError: Error? = nil
        
        sut.fetchCurrencies { result in
            switch result {
            case .success(let quotes):
                models = quotes
                expectation.fulfill()
            case .failure(let error):
                fetchError = error
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5)
        XCTAssertNil(fetchError)
        XCTAssertNotNil(models)
        
    }

}
