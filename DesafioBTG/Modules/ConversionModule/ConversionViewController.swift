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
    
    init(viewModel: ConversionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = conversionView
    }
    
}
