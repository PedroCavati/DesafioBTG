//
//  ConversionDelegate.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 26/05/21.
//

protocol ConversionDelegate: AnyObject {
    func convert(value: Double, origin: String, destination: String) -> String
}
