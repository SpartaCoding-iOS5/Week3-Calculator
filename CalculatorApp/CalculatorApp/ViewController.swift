//
//  ViewController.swift
//  CalculatorApp
//
//  Created by 장상경 on 11/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    private let displayLabel: UILabel = UILabel()
    
    private let buttons = ButtonData()
    
    private let firstRowStack = ButtonStackView()
    private let secondRowStack = ButtonStackView()
    private let thirdRowStack = ButtonStackView()
    private let fourthRowStack = ButtonStackView()
    
    private let numberButtonsStack = ButtonStackView(axix: .vertical)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setDisplayLabel()
        setVStack()
    }

    ///  숫자 및 수식 입력, displayLabel의 기본 세팅
    private func setDisplayLabel() {
        displayLabel.text = "12345"
        displayLabel.textColor = UIColor.white
        displayLabel.textAlignment = .right
        displayLabel.font = UIFont.systemFont(ofSize: 60, weight: .bold)
        displayLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(displayLabel)
                
        NSLayoutConstraint.activate([
            displayLabel.heightAnchor.constraint(equalToConstant: 100),
            displayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            displayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            displayLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        ])
    }
    
    /// 다수의 스택뷰에 아이템을 추가하는 메소드
    /// - Parameter stackViews: 아이템을 추가할 스택뷰 배열
    ///
    /// ``setButtonRow``
    private func setHStack(_ stackViews: [UIStackView]) {
        for (index, stackView) in stackViews.enumerated() {
            let item = buttons.setButtonRow(buttons.buttonRowList)
            stackView.addArrangedSubviews(item[index])
        }
    }
    
    /// vertical 스택뷰를 세팅하는 메소드
    ///
    /// ``setHStack``
    private func setVStack() {
        setHStack([firstRowStack,
                   secondRowStack,
                   thirdRowStack,
                   fourthRowStack])
        
        numberButtonsStack.addArrangedSubviews([firstRowStack,
                                                secondRowStack,
                                                thirdRowStack,
                                                fourthRowStack])
        
        numberButtonsStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(numberButtonsStack)
        
        NSLayoutConstraint.activate([
            numberButtonsStack.widthAnchor.constraint(equalToConstant: 350),
            numberButtonsStack.topAnchor.constraint(equalTo: displayLabel.bottomAnchor, constant: 60),
            numberButtonsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
