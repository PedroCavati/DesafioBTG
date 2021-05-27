//
//  CurrenciesModel.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 25/05/21.
//

struct CurrenciesModel: Codable {
    let success: Bool
    let currencies: [String: String]
}
