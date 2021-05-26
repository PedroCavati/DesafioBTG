//
//  UserDefaults.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 26/05/21.
//

import Foundation

@propertyWrapper struct UserDefault<T> {
    let key: String
    var storage: UserDefaults = .standard
    
    var wrappedValue: T? {
        get { storage.value(forKey: key) as? T }
        set { storage.setValue(newValue, forKey: key) }
    }
}

struct Storage {
    @UserDefault<Data>(key: "quotes")
    static var quotes
    
    @UserDefault<Data>(key: "currencies")
    static var currencies
    
    @UserDefault<[String: Bool]>(key: "favorites")
    static var favorites
}
