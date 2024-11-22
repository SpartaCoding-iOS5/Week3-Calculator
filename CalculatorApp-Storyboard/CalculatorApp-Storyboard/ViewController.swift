//
//  ViewController.swift
//  CalculatorApp-Storyboard
//
//  Created by t0000-m0112 on 2024-11-14.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var expressionLabel: UILabel!
    @IBAction func zeroButtonAction(_ sender: Any) { self.expression.append("0") }
    @IBAction func oneButtonAction(_ sender: Any) { self.expression.append("1") }
    @IBAction func twoButtonAction(_ sender: Any) { self.expression.append("2") }
    @IBAction func threeButtonAction(_ sender: Any) { self.expression.append("3") }
    @IBAction func fourButtonAction(_ sender: Any) { self.expression.append("4") }
    @IBAction func fiveButtonAction(_ sender: Any) { self.expression.append("5") }
    @IBAction func sixButtonAction(_ sender: Any) { self.expression.append("6") }
    @IBAction func sevenButtonAction(_ sender: Any) { self.expression.append("7") }
    @IBAction func eightButtonAction(_ sender: Any) { self.expression.append("8") }
    @IBAction func nineButtonAction(_ sender: Any) { self.expression.append("9") }
    @IBAction func addButtonAction(_ sender: Any) { self.expression.append("+") }
    @IBAction func subtractButtonAction(_ sender: Any) { self.expression.append("-") }
    @IBAction func multiplyButtonAction(_ sender: Any) { self.expression.append("×") }
    @IBAction func divideButtonAction(_ sender: Any) { self.expression.append("÷") }
    @IBAction func allClearButtonAction(_ sender: Any) { resetExpression() }
    @IBAction func equalButtonAction(_ sender: Any) {
        if let result = calculate(expression) {
            self.expression = String(result)
        } else {
            self.expression = "Error"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private var expression = "0" {
        didSet {
            if self.expression.count > 1 && self.expression[expression.startIndex] == "0" {
                if expression[expression.index(expression.startIndex, offsetBy: 1)].isNumber {
                    self.expression.removeFirst()
                }
            }
            self.expressionLabel.text = self.expression
        }
    }
    
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
        expression
            .replacingOccurrences(of: "×", with: "*")
            .replacingOccurrences(of: "÷", with: "/")
    }
    
}

