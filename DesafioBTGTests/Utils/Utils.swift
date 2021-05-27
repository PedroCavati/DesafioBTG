//
//  Utils.swift
//  DesafioBTGTests
//
//  Created by Pedro Henrique Cavalcante de Sousa on 27/05/21.
//

import Foundation

class Utils {
    class func loadJSONData(for anyClass: AnyClass, fileName: String) -> Data {
        guard let url = Bundle(for: anyClass).url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url)
        else {
            assertionFailure("Failed to load mock data")
            return Data()
        }
        
        return data
    }
}
