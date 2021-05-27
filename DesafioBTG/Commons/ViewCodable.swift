//
//  ViewCodable.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 25/05/21.
//

protocol ViewCodable {
    
    /// Method responsible for building the view's hierarchy
    func buildViewHierarchy()
    
    /// Method responsible for setting all subviews' constraints
    func setupConstraints()
    
    /// Method responsible for setting any other view configurations
    func setupAdditionalConfiguration()
    
}

extension ViewCodable {
    
    /**
     This method is responsible for calling all the supporting functions
     
     - important: you should always call this method instead of the individual methods
     */
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
    
    func setupAdditionalConfiguration() {}
    
}
