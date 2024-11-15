//
//  ViewController.swift
//  Week3-Calculator
//
//  Created by CHYUN on 11/15/24.
//

import UIKit

class ViewController: UIViewController {
    
    let valueLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureUI() {
    
        view.backgroundColor = .black
        
        valueLabel.text = "12345"
        valueLabel.textColor = .white
        valueLabel.textAlignment = .right
        valueLabel.font = .systemFont(ofSize: 60)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(valueLabel)
        
        valueLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        valueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        valueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        valueLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }

}

