//
//  CurrencyCell.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 26/05/21.
//

import UIKit

class CurrencyCell: UITableViewCell {
    
    // MARK: - ViewModel
    var viewModel: CurrencyData? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            keyLabel.text = viewModel.key
            descriptionLabel.text = viewModel.description
            viewModel.isFavorited ? favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal) : favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    // MARK: - Views
    private let keyLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = .boldSystemFont(ofSize: UIFont.systemFontSize)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        return button
    }()
    
    // MARK: - Callback
    var favoriteItem: (() -> Void)?
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    @objc
    private func favoriteItemTapped() {
        favoriteItem?()
    }
    
}

// MARK: - ViewCodable
extension CurrencyCell: ViewCodable {
    func buildViewHierarchy() {
        contentView.addSubview(keyLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(favoriteButton)
    }
    
    func setupConstraints() {
        keyLabel
            .anchorCenterY(to: contentView)
            .anchorHorizontal(leading: contentView.leadingAnchor, leadingConstant: 20)
        
        descriptionLabel
            .anchorCenterY(to: contentView)
            .anchorHorizontal(leading: contentView.leadingAnchor, leadingConstant: 70)
        
        favoriteButton
            .anchorCenterY(to: contentView)
            .anchorSize(width: favoriteButton.heightAnchor)
            .anchorHorizontal(trailing: contentView.trailingAnchor, trailingConstant: 20)
    }
    
    func setupAdditionalConfiguration() {
        favoriteButton.addTarget(self, action: #selector(favoriteItemTapped), for: .touchUpInside)
    }
}

// MARK: - Reuse Identifier
extension CurrencyCell {
    class var reuseIdentifier: String { String(describing: self) }
}
