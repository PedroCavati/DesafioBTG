//
//  ConversionViewModel.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 25/05/21.
//


final class ConversionViewModel {
    
    private let service: ConversionService
    
    init(service: ConversionService) {
        self.service = service
    }
    
    func fetchQuotes(completion: @escaping (Result<QuotesModel, Error>) -> Void) {
        service.getQuotes(completion)
    }
    
    func convert(value: Double, originQuote: Double, destinationQuote: Double) -> String {
        if destinationQuote == 1.0 {
            return String(format: "%.2f", value / originQuote)
        }
        return String(format: "%.2f", (value / originQuote) * destinationQuote)
    }
}
