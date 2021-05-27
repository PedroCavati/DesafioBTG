//
//  CurrencyPassDelegate.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 26/05/21.
//

protocol CurrencyPassDelegate: AnyObject {
    func returned(with model: CurrencyData, as type: ButtonType)
}

enum ButtonType {
    case origin
    case destination
}
