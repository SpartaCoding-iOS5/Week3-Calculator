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
    
    private var expression = "0" {
        didSet { // Exception Handling: Expressions that start with 0
            if self.expression.count > 1 && self.expression[expression.startIndex] == "0" {
                if expression[expression.index(expression.startIndex, offsetBy: 1)].isNumber {
                    self.expression.removeFirst()
                }
            } // Update expressionLabel when value changed
            delegate?.didUpdateExpression(expression)
        }
    }
}

extension CalculatorLogic {
    internal func resetExpression() { self.expression = "0" }
    internal func appendExpression(_ input: String) { self.expression.append(input)}
}

extension CalculatorLogic {
    internal func calculate() {
        if let result = calculateExpression(expression) {
            self.expression = String(result)
        }
    }
    
    private func calculateExpression(_ expression: String) -> Int? {
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
