//
//  CalculatorLogicDelegate.swift.swift
//  CalculatorApp-Codebase
//
//  Created by t0000-m0112 on 2024-11-20.
//

// MARK: CalculatorLogicDelegate Protocol
/// A protocol to handle updates from the CalculatorLogic class.
protocol CalculatorLogicDelegate: AnyObject {
    /// Called when the expression is updated.
    /// - Parameter expression: The updated expression string.
    func didUpdateExpression(_ expression: String)
}
