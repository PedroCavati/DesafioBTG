//
//  BTGButton.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 26/05/21.
//

import UIKit

final class BTGButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .systemTeal : .systemBlue
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupButton()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        titleLabel?.adjustsFontSizeToFitWidth = true
        backgroundColor = .systemBlue
        layer.cornerRadius = 5
    }
    
}
