//
//  ViewController.swift
//  CalculatorApp-Codebase
//
//  Created by t0000-m0112 on 2024-11-14.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private enum CalculatorButton {
        case number(Int), operation(String), allClear, equal
        
        var title: String {
            switch self {
            case .number(let value): return "\(value)"
            case .operation(let symbol): return symbol
            case .allClear: return "AC"
            case .equal: return "="
            }
        }
        
        var backgroundColor: UIColor {
            switch self {
            case .number: return .systemGray
            case .operation: return .systemOrange
            case .allClear: return .systemOrange
            case .equal: return .systemOrange
            }
        }
        
        var button: UIButton {
            let button = UIButton()
            button.frame.size.height = 80
            button.frame.size.width = 80
            button.layer.cornerRadius = 40
            button.backgroundColor = self.backgroundColor
            button.setTitle(self.title, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = .boldSystemFont(ofSize: 30)
            return button
        }
    }
    
    private let expressionLabel = UILabel()
    private let superStack = UIStackView()
    private let horizontalStacks: [UIStackView] = (0..<4).map { _ in UIStackView() }
    private let button0 = CalculatorButton.number(0).button
    private let button1 = CalculatorButton.number(1).button
    private let button2 = CalculatorButton.number(2).button
    private let button3 = CalculatorButton.number(3).button
    private let button4 = CalculatorButton.number(4).button
    private let button5 = CalculatorButton.number(5).button
    private let button6 = CalculatorButton.number(6).button
    private let button7 = CalculatorButton.number(7).button
    private let button8 = CalculatorButton.number(8).button
    private let button9 = CalculatorButton.number(9).button
    private let buttonAdd = CalculatorButton.operation("+").button
    private let buttonSubtract = CalculatorButton.operation("-").button
    private let buttonMultiply = CalculatorButton.operation("×").button
    private let buttonDivide = CalculatorButton.operation("÷").button
    private let buttonAllClear = CalculatorButton.allClear.button
    private let buttonEqual = CalculatorButton.equal.button
    private var expression = "0" {
            didSet { // Exception Handling: Expressions that start with 0
                if self.expression.count > 1 && self.expression[expression.startIndex] == "0" {
                    if expression[expression.index(expression.startIndex, offsetBy: 1)].isNumber {
                        self.expression.removeFirst()
                    }
                } // Update expressionLabel when value changed
                self.expressionLabel.text = self.expression
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .black
        configureExpressionLabel()
        configureSuperStack()
        configureButton()
    }
    
    // Button Actions:
    @objc private func button0Action() { self.expression.append("0") }
    @objc private func button1Action() { self.expression.append("1") }
    @objc private func button2Action() { self.expression.append("2") }
    @objc private func button3Action() { self.expression.append("3") }
    @objc private func button4Action() { self.expression.append("4") }
    @objc private func button5Action() { self.expression.append("5") }
    @objc private func button6Action() { self.expression.append("6") }
    @objc private func button7Action() { self.expression.append("7") }
    @objc private func button8Action() { self.expression.append("8") }
    @objc private func button9Action() { self.expression.append("9") }
    @objc private func buttonAddAction() { self.expression.append("+") }
    @objc private func buttonSubtractAction() { self.expression.append("-") }
    @objc private func buttonMultiplyAction() { self.expression.append("×") }
    @objc private func buttonDivideAction() { self.expression.append("÷") }
    @objc private func buttonAllClearAction() { resetExpression() }
    @objc private func buttonEqualAction() { if let result = calculate(expression) { expression = String(result) } }
    
    private func resetExpression() { self.expression = "0" }
        
    private func calculate(_ expression: String) -> Int? {
        let expression = NSExpression(format: inputSanitization(expression))
        if let result = expression.expressionValue(with: nil, context: nil) as? Int {
            return result
        } else {
            return nil
        }
    }
    
    private func inputSanitization(_ expression: String) -> String {
        expression // Change math symbols
            .replacingOccurrences(of: "×", with: "*")
            .replacingOccurrences(of: "÷", with: "/")
    }
    
    // UI Configurations:
    
    private func configureExpressionLabel() {
        expressionLabel.backgroundColor = .black
        expressionLabel.text = "0"
        expressionLabel.textColor = .white
        expressionLabel.textAlignment = .right
        expressionLabel.font = UIFont.boldSystemFont(ofSize: 60)
        view.addSubview(expressionLabel)
        expressionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.top.equalToSuperview().offset(200)
            $0.height.equalTo(100)
        }
    }
    
    private func configureSuperStack() {
        superStack.axis = .vertical
        superStack.backgroundColor = .black
        superStack.spacing = 10
        superStack.distribution = .fillEqually
        view.addSubview(superStack)
        superStack.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(expressionLabel.snp.bottom).offset(60)
            $0.width.equalTo(350)
        }
        
        horizontalStacks.forEach {
            superStack.addArrangedSubview($0)
            setupHorizontalStack(for: $0)
        }
    }
    
    private func setupHorizontalStack(for stack: UIStackView) {
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.snp.makeConstraints {
            $0.height.equalTo(80)
        }
    }
    
    private func configureButton() {
        [button7, button8, button9, buttonAdd]
            .forEach { horizontalStacks[0].addArrangedSubview($0) }
        [button4, button5, button6, buttonSubtract]
            .forEach { horizontalStacks[1].addArrangedSubview($0) }
        [button1, button2, button3, buttonMultiply]
            .forEach { horizontalStacks[2].addArrangedSubview($0) }
        [buttonAllClear, button0, buttonEqual, buttonDivide]
            .forEach { horizontalStacks[3].addArrangedSubview($0) }
        
        button0.addTarget(self, action: #selector(button0Action), for: .touchDown)
        button1.addTarget(self, action: #selector(button1Action), for: .touchDown)
        button2.addTarget(self, action: #selector(button2Action), for: .touchDown)
        button3.addTarget(self, action: #selector(button3Action), for: .touchDown)
        button4.addTarget(self, action: #selector(button4Action), for: .touchDown)
        button5.addTarget(self, action: #selector(button5Action), for: .touchDown)
        button6.addTarget(self, action: #selector(button6Action), for: .touchDown)
        button7.addTarget(self, action: #selector(button7Action), for: .touchDown)
        button8.addTarget(self, action: #selector(button8Action), for: .touchDown)
        button9.addTarget(self, action: #selector(button9Action), for: .touchDown)
        buttonAdd.addTarget(self, action: #selector(buttonAddAction), for: .touchDown)
        buttonSubtract.addTarget(self, action: #selector(buttonSubtractAction), for: .touchDown)
        buttonMultiply.addTarget(self, action: #selector(buttonMultiplyAction), for: .touchDown)
        buttonDivide.addTarget(self, action: #selector(buttonDivideAction), for: .touchDown)
        buttonAllClear.addTarget(self, action: #selector(buttonAllClearAction), for: .touchDown)
        buttonEqual.addTarget(self, action: #selector(buttonEqualAction), for: .touchDown)
    }
}

#Preview {
    ViewController()
}
