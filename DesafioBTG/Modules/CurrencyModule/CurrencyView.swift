//
//  CurrencyView.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 26/05/21.
//

import UIKit

class CurrencyView: UIView {
    
    // MARK: - Views
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: CurrencyCell.reuseIdentifier)
        tableView.allowsMultipleSelection = false
        return tableView
    }()
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - ViewCodable
extension CurrencyView: ViewCodable {
    func buildViewHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView
            .fillSuperview()
    }
}
