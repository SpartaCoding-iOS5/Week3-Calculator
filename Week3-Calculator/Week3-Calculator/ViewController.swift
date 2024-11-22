//
//  ViewController.swift
//  Week3-Calculator
//
//  Created by CHYUN on 11/15/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var valueLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        configureLabel()
        
        let elementRows = [
            ["7", "8", "9", "+"],
            ["4", "5", "6", "-"],
            ["1", "2", "3", "*"],
            ["AC", "0", "=", "/"]
        ].map(makeButtonRow)
        makeVStackView(elementRows)
    }
    
    // MARK: - 라벨
    private func configureLabel() {
        
        valueLabel.text = "0"
        valueLabel.textColor = .white
        valueLabel.textAlignment = .right
        valueLabel.font = .labelFont
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(valueLabel)
        
        valueLabel.snp.makeConstraints{
            $0.height.equalTo(LayoutSize.labelHeight)
            $0.top.equalToSuperview().offset(LayoutSize.labelTopSpacing)
            $0.leading.equalToSuperview().offset(LayoutSize.horizontalPadding)
            $0.trailing.equalToSuperview().offset(-LayoutSize.horizontalPadding)
        }
    }
    
    // MARK: - 버튼
    private func configureButton(buttonTitle: String) -> UIButton {

        let numberButton = UIButton()
        
        numberButton.setTitle(buttonTitle, for: .normal)
        numberButton.setTitleColor(.white, for: .normal)
        numberButton.titleLabel?.font = .buttonFont
        
        let backgroundColor = Int(buttonTitle) == nil
                            ? UIColor.calculatorOperatorButton
                            : UIColor.calculatorNumberButton
        
        numberButton.backgroundColor = backgroundColor
        
        numberButton.frame.size.width = LayoutSize.buttonSize
        numberButton.frame.size.height = LayoutSize.buttonSize
        numberButton.layer.cornerRadius = LayoutSize.buttonCornerRadius
        numberButton.addTarget(self, action: #selector(onTapButton), for: .touchUpInside)
        
        return numberButton
    }
    
    @objc
    private func onTapButton(sender: UIButton) {
        
        guard sender.currentTitle != "AC" else {
            valueLabel.text = "0"
            return
        }
        
        guard sender.currentTitle != "=" else {
            valueLabel.text = String(calculate(expression: valueLabel.text ?? "") ?? 0)
            return
        }
        
        valueLabel.text = valueLabel.text == "0"
                        ? sender.currentTitle ?? ""
                        : (valueLabel.text ?? "") + (sender.currentTitle ?? "")
    }
    
    // MARK: - 가로로 버튼 4개 가지는 StackView
    private func makeHStackView(_ views: [UIButton]) -> UIStackView {
        
        let hStackView = UIStackView()
        hStackView.axis = .horizontal
        hStackView.backgroundColor = .black
        hStackView.spacing = LayoutSize.stackSpacing
        hStackView.distribution = .fillEqually
        for view in views {
            hStackView.addArrangedSubview(view)
        }
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hStackView)
        
        hStackView.snp.makeConstraints{
            $0.height.equalTo(LayoutSize.buttonSize)
            $0.leading.equalToSuperview().offset(LayoutSize.horizontalPadding)
            $0.trailing.equalToSuperview().offset(-LayoutSize.horizontalPadding)
        }
        return hStackView
    }
    
    // MARK: - 버튼 요소 이름 받아서 버튼 만들고 StackView로 4개 묶어서 리턴
    private func makeButtonRow(buttonTitles: [String]) -> UIStackView {
      
        let buttons = buttonTitles.map{ configureButton(buttonTitle: $0) }
        return makeHStackView(buttons)
    }
  
    // MARK: - 세로 ButtonRow(가로 버튼 4개) 4줄
    private func makeVStackView(_ buttonRows: [UIStackView]) {
        
        let vStackView = UIStackView()
        vStackView.axis = .vertical
        vStackView.backgroundColor = .black
        vStackView.spacing = LayoutSize.stackSpacing
        vStackView.distribution = .fillEqually
        for buttonRow in buttonRows {
            vStackView.addArrangedSubview(buttonRow)
        }
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vStackView)
        
        vStackView.snp.makeConstraints{
            $0.width.equalTo(LayoutSize.stackWidth)
            $0.top.equalTo(valueLabel.snp.bottom).offset(LayoutSize.stackSpacingWithLabel)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - 계산 기능
    func calculate(expression: String) -> Int? {
        let expression = NSExpression(format: expression)
        if let result = expression.expressionValue(with: nil, context: nil) as? Int {
            return result
        } else {
            return nil
        }
    }
}
