//
//  CurrencyViewController.swift
//  DesafioBTG
//
//  Created by Pedro Henrique Cavalcante de Sousa on 26/05/21.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    // MARK: - View
    private let currencyView = CurrencyView()
    
    // MARK: - ViewModel
    private let viewModel: CurrencyViewModel
    
    // MARK: - DataSources
    private var favoritesDataSource: [CurrencyData]? {
        didSet {
            currencyView.tableView.reloadData()
        }
    }
    
    private var currenciesDataSource: [CurrencyData]? {
        didSet {
            currencyView.tableView.reloadData()
        }
    }
    
    // MARK: - Callback
    private var selectedModel: CurrencyData?
    var buttonType: ButtonType?
    var cancel: (() -> Void)?
    var done: (() -> Void)?
    
    // MARK: - Delegate
    weak var currencyDelegate: CurrencyPassDelegate?
    
    // MARK: - Initializers
    init(viewModel: CurrencyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCurrencies()
        setNavigationItems()
    }
    
    override func loadView() {
        currencyView.tableView.delegate = self
        currencyView.tableView.dataSource = self
        view = currencyView
    }
    
    @objc
    private func doneButtonTapped() {
        guard let model = selectedModel, let buttonType = buttonType else {
            return
        }
        currencyDelegate?.returned(with: model, as: buttonType)
        done?()
    }
    
    @objc
    private func cancelButtonTapped() {
        cancel?()
    }
    
    private func fetchCurrencies() {
        view.startLoading()
        viewModel.fetchCurrencies { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async { [weak self] in
                    let dataSource = self?.viewModel.buildDataSource(model: model)
                    guard let dt1 = dataSource?.1, let dt2 = dataSource?.0 else {
                        return
                    }
                    self?.favoritesDataSource = self?.viewModel.sortDatasource(dataSource: dt1)
                    self?.currenciesDataSource = self?.viewModel.sortDatasource(dataSource: dt2)
                    self?.view.stopLoading()
                }
            case .failure(_):
                DispatchQueue.main.async { [weak self] in
                    self?.view.stopLoading()
                }
            }
        }
    }
    
    private func updateDataSource() {
        guard let currenciesDataSource = currenciesDataSource, let favoritesDataSource = favoritesDataSource else {
            return
        }
        let dataSource = viewModel.updateDataSource(dataSource: (currenciesDataSource, favoritesDataSource))
        self.currenciesDataSource = viewModel.sortDatasource(dataSource: dataSource.0)
        self.favoritesDataSource = viewModel.sortDatasource(dataSource: dataSource.1)
    }
    
    private func setNavigationItems() {
        navigationItem.title = "Moedas"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
}

// MARK: - UITableViewDelegate/DataSource
extension CurrencyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationItem.rightBarButtonItem?.isEnabled = true
        isModalInPresentation = true
        
        if indexPath.section == 0 {
            selectedModel = favoritesDataSource?[indexPath.row]
            return
        }
        selectedModel = currenciesDataSource?[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Favoritos"
        }
        return "Todas"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return favoritesDataSource?.count ?? 0
        }
        return currenciesDataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.reuseIdentifier) as? CurrencyCell else {
            return UITableViewCell()
        }
        
        if indexPath.section == 0 {
            
            if self.favoritesDataSource?[indexPath.row] == selectedModel {
                tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            }
            
            cell.viewModel = self.favoritesDataSource?[indexPath.row]
            cell.favoriteItem = { [weak self] in
                self?.favoritesDataSource?[indexPath.row].toggleFavorite()
                self?.updateDataSource()
            }
            return cell
        }
        
        if self.currenciesDataSource?[indexPath.row] == selectedModel {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        }
        
        cell.viewModel = self.currenciesDataSource?[indexPath.row]
        cell.favoriteItem = { [weak self] in
            self?.currenciesDataSource?[indexPath.row].toggleFavorite()
            self?.updateDataSource()
        }
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension CurrencyViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText.isEmpty {
//            currenciesDataSource = currencies
//            favoritesDataSource = favorites
//            return
//        }
//
//        currenciesDataSource = currencies?.filter({ viewModel -> Bool in
//            let filter1 = viewModel.key.contains(searchText)
//            let filter2 = viewModel.description.contains(searchText)
//            return filter1 || filter2
//        })
//
//        favoritesDataSource = favorites?.filter({ viewModel -> Bool in
//            let filter1 = viewModel.key.contains(searchText)
//            let filter2 = viewModel.description.contains(searchText)
//            return filter1 || filter2
//        })
//    }
}
