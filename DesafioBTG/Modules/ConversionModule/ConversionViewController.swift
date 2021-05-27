//
//  ConversionViewController.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 25/05/21.
//

import UIKit

class ConversionViewController: UIViewController {
    
    // MARK: - View
    private var conversionView = ConversionView()
    
    // MARK: - ViewModel
    private var viewModel: ConversionViewModel
    private var quotes: [String: Double]?
    
    // MARK: - Callbacks
    var currencyButtonTapped: ((_ : ButtonType) -> Void)?
    
    // MARK: - Initializers
    init(viewModel: ConversionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    override func loadView() {
        navigationItem.title = "Conversor"
        conversionView.conversionDelegate = self
        view = conversionView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        conversionView.navigateToCurrencyModule = self.currencyButtonTapped
        
        fetchQuotes()
    }
    
    private func fetchQuotes() {
        view.startLoading()
        viewModel.fetchQuotes { [weak self] result in
            switch result {
            case .success(let model):
                self?.quotes = model.quotes
                DispatchQueue.main.async { [weak self] in
                    self?.view.stopLoading()
                }
            case .failure(_):
                DispatchQueue.main.async { [weak self] in
                    self?.view.stopLoading()
                }
            }
        }
    }
}

// MARK: - ConversionDelegate
extension ConversionViewController: ConversionDelegate {
    func convert(value: Double, origin: String, destination: String) -> String {
        if let originQuote = quotes?["USD\(origin)"], let destinationQuote = quotes?["USD\(destination)"] {
            return viewModel.convert(value: value, originQuote: originQuote, destinationQuote: destinationQuote)
        }
        return "Erro ao converter. Tente novamente."
    }
}

// MARK: - CurrencyPassDelegate
extension ConversionViewController: CurrencyPassDelegate {
    func returned(with model: CurrencyData, as type: ButtonType) {
        conversionView.setButton(with: model.key, type: type)
    }
}
