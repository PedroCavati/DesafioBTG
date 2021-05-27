//
//  CurrencyViewModel.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 25/05/21.
//

final class CurrencyViewModel {
    
    private let service: CurrencyService
    
    init(service: CurrencyService) {
        self.service = service
    }
    
    func buildDataSource(model: CurrenciesModel) -> ([CurrencyData], [CurrencyData]) {
        let favorites: [String: Bool] = Storage.favorites ?? [:]
        let currencies = model.currencies
        var currencyDataSource = [CurrencyData]()
        var favoriteDataSource = [CurrencyData]()
        
        currencies.forEach { currency in
            let isFav = favorites[currency.key] ?? false
            
            if isFav {
                favoriteDataSource.append(CurrencyData(key: currency.key, description: currency.value, isFavorited: isFav))
            } else {
                currencyDataSource.append(CurrencyData(key: currency.key, description: currency.value, isFavorited: isFav))
            }
        }
        
        return (currencyDataSource, favoriteDataSource)
    }
    
    func updateDataSource(dataSource: ([CurrencyData], [CurrencyData])) -> ([CurrencyData], [CurrencyData]) {
        var updatedDatasource = dataSource
        
        updatedDatasource.0.enumerated().forEach { (index, model) in
            if model.isFavorited {
                updatedDatasource.1.append(model)
                updatedDatasource.0.remove(at: index)
            }
        }
        
        updatedDatasource.1.enumerated().forEach { (index, model) in
            if !model.isFavorited {
                updatedDatasource.0.append(model)
                updatedDatasource.1.remove(at: index)
            }
        }
        
        return updatedDatasource
    }
    
    func sortDatasource(dataSource: [CurrencyData]) -> [CurrencyData] {
        var sorted = dataSource
        sorted.sort {
            $0.key < $1.key
        }
        
        return sorted
    }
    
    func fetchCurrencies(completion: @escaping (Result<CurrenciesModel, Error>) -> Void) {
        service.getCurrencies(completion)
    }
}

struct CurrencyData: Equatable {
    let key: String
    let description: String
    var isFavorited: Bool
    
    mutating func toggleFavorite() {
        isFavorited.toggle()
        
        var favorites = Storage.favorites ?? [:]
        var updated = false
        favorites.keys.forEach({ storedKey in
            if storedKey == key, !updated {
                favorites[storedKey] = isFavorited
                updated.toggle()
                return
            }
        })
        if !updated {
            favorites[key] = isFavorited
        }
        
        Storage.favorites = favorites
        
    }
}
