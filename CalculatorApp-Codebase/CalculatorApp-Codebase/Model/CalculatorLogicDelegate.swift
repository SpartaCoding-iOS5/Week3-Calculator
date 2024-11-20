//
//  CalculatorLogicDelegate.swift.swift
//  CalculatorApp-Codebase
//
//  Created by t0000-m0112 on 2024-11-20.
//

// Send Expression Update Signal from CalculatorLogic to ViewController
protocol CalculatorLogicDelegate: AnyObject {
    func didUpdateExpression(_ expression: String)
}
