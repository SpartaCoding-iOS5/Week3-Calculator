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
            button.addTarget(self, action: #selector(buttonAction(from:)), for: .touchDown)
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
    @objc private func buttonAction(from sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }

        switch buttonTitle {
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            self.expression.append(buttonTitle)
        case "+", "-", "×", "÷":
            self.expression.append(buttonTitle)
        case "AC":
            resetExpression()
        case "=":
            if let result = calculate(expression) {
                expression = String(result)
            }
        default:
            break
        }
    }

    private func resetExpression() { self.expression = "0" }
        
    private func calculate(_ expression: String) -> Int? {
        let expression = NSExpression(format: changeMathSymbols(expression))
        if let result = expression.expressionValue(with: nil, context: nil) as? Int {
            return result
        } else {
            return nil
        }
    }
    
    private func changeMathSymbols(_ expression: String) -> String {
        expression
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
    }
}

#Preview {
    ViewController()
}
