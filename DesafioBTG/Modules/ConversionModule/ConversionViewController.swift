//
//  ConversionViewController.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 25/05/21.
//

import UIKit

class ConversionViewController: UIViewController {
    
    private var viewModel: ConversionViewModel
    private var conversionView = ConversionView()
    
    private var quotes: [String: Double]?
    
    init(viewModel: ConversionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        fetchQuotes()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        conversionView.conversionDelegate = self
        view = conversionView
    }
    
    private func fetchQuotes() {
        view.startLoading()
        viewModel.fetchQuotes { result in
            switch result {
            case .success(let model):
                self.quotes = model.quotes
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

extension ConversionViewController: ConversionDelegate {
    func convert(value: Double, origin: String, destination: String) -> String {
        if let originQuote = quotes?["USD\(origin)"], let destinationQuote = quotes?["USD\(destination)"] {
            return viewModel.convert(value: value, originQuote: originQuote, destinationQuote: destinationQuote)
        }
        return "Erro ao converter. Tente novamente."
    }
}
