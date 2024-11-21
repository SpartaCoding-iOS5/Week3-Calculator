//
//  CalculatorLogic.swift
//  CalculatorApp-Codebase
//
//  Created by t0000-m0112 on 2024-11-20.
//

import UIKit

// Manage and calculate epxression
class CalculatorLogic {
    weak var delegate: CalculatorLogicDelegate?
    
    private var isLastInputOperator = false
    private var isCurrentInputOperator = false
    private var expression = "0" {
        didSet {
            // Exception Handling: Expressions that start with 0
            if self.expression.count > 1 && self.expression[expression.startIndex] == "0" {
                if expression[expression.index(expression.startIndex, offsetBy: 1)].isNumber {
                    self.expression.removeFirst()
                }
            }
            // Update expressionLabel when value changed
            delegate?.didUpdateExpression(expression)
        }
    }
    
    // Exception Handling: Expressions that has duplicated operators
    private func handleLastCharIfNeeded() {
        if isLastInputOperator && isCurrentInputOperator {
            self.expression.removeLast()
        }
    }
}

extension CalculatorLogic {
    internal func buttonAction(from sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        
        switch buttonTitle {
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            appendNumberToExpression(buttonTitle)
        case "+", "-", "×", "÷":
            handleLastCharIfNeeded()
            appendOperatorToExpression(buttonTitle)
        case "AC":
            resetExpression()
        case "=":
            calculateExpression()
        default:
            break
        }
    }
}

extension CalculatorLogic {
    internal func appendNumberToExpression(_ input: String) {
        self.isCurrentInputOperator = false
        self.expression.append(input)
        self.isLastInputOperator = false
    }
    
    internal func appendOperatorToExpression(_ input: String) {
        self.isCurrentInputOperator = true
        self.expression.append(input)
        self.isLastInputOperator = true
    }
    
    internal func resetExpression() {
        self.isCurrentInputOperator = false
        self.expression = "0"
        self.isLastInputOperator = false
    }
    
    internal func calculateExpression() {
        if let result = calculate(expression) {
            self.isCurrentInputOperator = false
            self.expression = String(result)
            self.isLastInputOperator = false
        }
    }
}

extension CalculatorLogic {
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
}
