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
            handleLeadingZeroIfNeeded() // Input Invalidation: Numbers with starting zero (Case B)
            appendNumberToExpression(buttonTitle)
            handleFirstZeroIfNeeded() // Input Invalidation: Numbers with starting zero (Case A)
        case "+", "-", "×", "÷":
            handleLastOperatorIfNeeded() // Input Invalidation: Expressions with duplicated operators
            appendOperatorToExpression(buttonTitle)
        case "AC":
            resetExpression()
        case "=":
            handleLastOperatorIfNeeded() // Input Invalidation: Expressions with an operator in the end
            calculateExpression()
        default:
            break
        }
    }
}

// MARK: - Input Validation (Exception Handling)
/// Validates and corrects invalid input cases like duplicated operators or starting zero.
extension CalculatorLogic {
    /// Handles the case where the expression starts with a leading zero (e.g., "0123") - Case A.
    /// If the second character in the expression is a number, the leading zero is removed.
    private func handleFirstZeroIfNeeded() {
        guard self.expression.count > 1 else { return }
        if self.expression[expression.startIndex] == "0" && self.expression[expression.index(expression.startIndex, offsetBy: 1)].isNumber {
            self.expression.removeFirst()
        }
    }
    
    /// Handles the case where the expression has an invalid leading zero (e.g., "+001" or "×03") - Case B.
    /// Removes the last zero if it is invalid.
    private func handleLeadingZeroIfNeeded() {
        guard self.expression.count > 2 else { return }
        if isLastInputZero && !self.expression[expression.index(expression.endIndex, offsetBy: -2)].isNumber {
            self.expression.removeLast()
        }
    }
    
    /// Handles the case where the last input is an operator.
    /// If the last character in the expression is an operator, it is removed.
    private func handleLastOperatorIfNeeded() {
        if isLastInputOperator {
            self.expression.removeLast()
        }
    }
    
    /// Determines whether handling zero input is necessary.
    /// - Parameter input: The current input character.
    /// - Returns: A boolean indicating if the input can proceed.
    /// - If the input is "0", checks if the last character is "÷" to prevent division by zero.
    /// - Updates the `isLastInputZero` flag based on the input.
    private func isHandlingZeroInputNeeded(_ input: String) -> Bool {
        if input == "0" {
            guard self.expression[expression.index(expression.endIndex, offsetBy: -1)] != "÷" else { return false }
            self.isLastInputZero = true
        } else {
            self.isLastInputZero = false
        }
        return true
    }
}

// MARK: - Expression Modification
/// Modifies the current expression by appending numbers or operators.
extension CalculatorLogic {
    internal func appendNumberToExpression(_ input: String) {
        guard isHandlingZeroInputNeeded(input) else { return } // Input Invalidation: Expressions that devides with zero
        self.expression.append(input)
        self.isLastInputOperator = false
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
