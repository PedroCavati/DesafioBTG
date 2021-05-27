//
//  LoadingView.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 26/05/21.
//

import UIKit

final class LoadingView: UIView {
    
    static let tag = 666
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .systemBlue
        return activityIndicator
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimating() {
        activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.backgroundColor = UIColor(white: 0, alpha: 0.9)
        }
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.backgroundColor = UIColor(white: 0, alpha: 0)
        } completion: { [weak self] _ in
            self?.removeFromSuperview()
        }

    }
    
}

extension LoadingView: ViewCodable {
    func buildViewHierarchy() {
        addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        activityIndicator
            .anchorCenterToSuperview()
    }
    
    func setupAdditionalConfiguration() {
        tag = LoadingView.tag
    }
}
