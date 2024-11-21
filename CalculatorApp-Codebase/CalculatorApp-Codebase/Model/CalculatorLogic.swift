//
//  CalculatorLogic.swift
//  CalculatorApp-Codebase
//
//  Created by t0000-m0112 on 2024-11-20.
//

import UIKit

// MARK: CalculatorLogic Class
/// Handles all the calculation logic, including managing expressions and results.
class CalculatorLogic {
    weak var delegate: CalculatorLogicDelegate?
    
    // MARK: Properties
    private var isLastInputOperator = false
    private var isLastInputZero = true
    private var expression = "0" {
        didSet {
            delegate?.didUpdateExpression(expression)
        }
    }
}

// MARK: - Input Handler
/// Handles input actions and updates the expression accordingly.
extension CalculatorLogic {
    internal func buttonAction(from sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        
        switch buttonTitle {
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            handleLeadingZeroIfNeeded() // Exception Handling: Numbers with starting zero
            appendNumberToExpression(buttonTitle)
            handleFirstZeroIfNeeded() // Exception Handling: Expressions with starting zero
        case "+", "-", "×", "÷":
            handleLastOperatorIfNeeded() // Exception Handling: Expressions with duplicated operators
            appendOperatorToExpression(buttonTitle)
        case "AC":
            resetExpression()
        case "=":
            handleLastOperatorIfNeeded() // Exception Handling: Expressions with an operator in the end
            calculateExpression()
        default:
            break
        }
    }
}

// MARK: - Input Validation (Exception Handling)
/// Validates and corrects invalid input cases like duplicated operators or starting zero.
extension CalculatorLogic {
    private func handleLastOperatorIfNeeded() {
        if isLastInputOperator {
            self.expression.removeLast()
        }
    }
    
    private func handleFirstZeroIfNeeded() {
        if self.expression.count > 1 && self.expression[expression.startIndex] == "0" {
            if expression[expression.index(expression.startIndex, offsetBy: 1)].isNumber {
                self.expression.removeFirst()
            }
        }
    }
    
    private func handleLeadingZeroIfNeeded() {
        guard self.expression.count > 2 else { return }
        if isLastInputZero && !expression[expression.index(expression.endIndex, offsetBy: -2)].isNumber {
            self.expression.removeLast()
        }
    }
}

// MARK: - Expression Modification
/// Modifies the current expression by appending numbers or operators.
extension CalculatorLogic {
    internal func appendNumberToExpression(_ input: String) {
        self.expression.append(input)
        self.isLastInputOperator = false
        if input == "0" {
            self.isLastInputZero = true
        } else {
            self.isLastInputZero = false
        }
    }
    
    internal func appendOperatorToExpression(_ input: String) {
        self.expression.append(input)
        self.isLastInputOperator = true
        self.isLastInputZero = false
    }
    
    internal func resetExpression() {
        self.expression = "0"
        self.isLastInputOperator = false
        self.isLastInputZero = true
    }
    
    internal func calculateExpression() {
        if let result = calculate(expression) {
            self.expression = String(result)
            self.isLastInputOperator = false
            self.isLastInputZero = false
        }
    }
}

// MARK: - Math Engine
/// Handles the mathematical calculations based on the current expression.
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
