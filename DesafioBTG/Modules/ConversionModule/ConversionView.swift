//
//  ConversionView.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 25/05/21.
//

import UIKit

class ConversionView: UIView {
    
    private let containerView = UIView()
    
    private let originTextField: UITextField = {
        var textField = UITextField()
        textField.adjustsFontSizeToFitWidth = true
        textField.isUserInteractionEnabled = true
        textField.placeholder = "Digite o valor a ser convertido..."
        textField.keyboardType = .numbersAndPunctuation
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let originButton: BTGButton = {
        var button = BTGButton()
        button.setTitle("USD", for: .normal)
        return button
    }()
    
    private let destinationTextField: UITextField = {
        var textField = UITextField()
        textField.adjustsFontSizeToFitWidth = true
        textField.isUserInteractionEnabled = false
        textField.text = "Aguardando valor..."
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let destinationButton: BTGButton = {
        var button = BTGButton()
        button.setTitle("BRL", for: .normal)
        return button
    }()
    
    private let convertButton: BTGButton = {
        var button = BTGButton()
        button.setTitle("CONVERTER", for: .normal)
        return button
    }()
    
    weak var conversionDelegate: ConversionDelegate?
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func convertButtonTapped() {
        if let value = Double(originTextField.text?.replacingOccurrences(of: ",", with: ".") ?? "") {
            destinationTextField.text = conversionDelegate?.convert(value: value,
                                                                    origin: originButton.title(for: .normal) ?? "",
                                                                    destination: destinationButton.title(for: .normal) ?? "")
        }
    }
    
}

extension ConversionView: ViewCodable {
    func buildViewHierarchy() {
        containerView.addSubview(originTextField)
        containerView.addSubview(originButton)
        containerView.addSubview(destinationTextField)
        containerView.addSubview(destinationButton)
        addSubview(containerView)
        addSubview(convertButton)
    }
    
    func setupConstraints() {
        originTextField
            .anchorVertical(top: containerView.topAnchor)
            .anchorHorizontal(leading: containerView.leadingAnchor)
        
        originButton
            .anchorSizeWithMultiplier(width: containerView.widthAnchor, widthMultiplier: 0.2, height: originTextField.heightAnchor)
            .anchorVertical(top: originTextField.topAnchor)
            .anchorHorizontal(leading: originTextField.trailingAnchor, trailing: containerView.trailingAnchor, leadingConstant: 10)
        
        destinationTextField
            .anchorVertical(top: originTextField.bottomAnchor, topConstant: 50)
            .anchorHorizontal(leading: containerView.leadingAnchor)
        
        destinationButton
            .anchorSizeWithMultiplier(width: containerView.widthAnchor, widthMultiplier: 0.2, height: destinationTextField.heightAnchor)
            .anchorVertical(top: destinationTextField.topAnchor)
            .anchorHorizontal(leading: destinationTextField.trailingAnchor, trailing: containerView.trailingAnchor, leadingConstant: 10)
        
        containerView
            .anchorSizeWithMultiplier(width: widthAnchor, widthMultiplier: 0.8)
            .anchorCenterXToSuperview()
            .anchorVertical(top: layoutMarginsGuide.topAnchor, bottom: destinationTextField.bottomAnchor, topConstant: 100)
        
        convertButton
            .anchorCenterToSuperview()
            .anchorSizeWithMultiplier(width: widthAnchor, widthMultiplier: 0.5)
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .systemBackground
        
        convertButton.addTarget(self, action: #selector(convertButtonTapped), for: .touchUpInside)
    }
}
