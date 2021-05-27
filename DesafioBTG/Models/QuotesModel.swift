//
//  QuotesModel.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 25/05/21.
//

struct QuotesModel: Codable {
    let success: Bool
    let quotes: [String: Double]
}
