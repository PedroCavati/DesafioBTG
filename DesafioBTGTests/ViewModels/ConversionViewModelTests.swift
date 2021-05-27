//
//  ConversionViewModelTests.swift
//  DesafioBTGTests
//
//  Created by Pedro Henrique Cavalcante de Sousa on 25/05/21.
//

import XCTest
import Network
@testable import DesafioBTG

class ConversionViewModelTests: XCTestCase {
    
    lazy var network: Networking = BTGNetworking()
    lazy var service: ConversionService = BTGConversionService(network: network)
    lazy var sut: ConversionViewModel = ConversionViewModel(service: service)
    
    func testFetch() {
        
        let expectation = expectation(description: #function)
        var models: QuotesModel? = nil
        var fetchError: Error? = nil
        
        sut.fetchQuotes { result in
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
    
    func testConversion() {
        
        let value = 4.0
        let ogQuote = 2.0
        let destQuote = 3.0
        
        let converted = sut.convert(value: value, originQuote: ogQuote, destinationQuote: destQuote)
        
        XCTAssertTrue(converted == "6.00")
        
    }

}
