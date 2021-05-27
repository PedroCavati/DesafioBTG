//
//  CurrencyViewController.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 26/05/21.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    private let currencyView = CurrencyView()
    
    private let viewModel: CurrencyViewModel
    
    private var dataSource: [CurrencyData]?
    
    init(viewModel: CurrencyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(doneButtonTapped))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    override func loadView() {
        view = currencyView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCurrencies()
    }
    
    @objc
    func doneButtonTapped() {
    }
    
    private func fetchCurrencies() {
        view.startLoading()
        viewModel.fetchCurrencies { [weak self] result in
            switch result {
            case .success(let model):
                self?.dataSource = self?.viewModel.buildDataSource(model: model)
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

extension CurrencyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
