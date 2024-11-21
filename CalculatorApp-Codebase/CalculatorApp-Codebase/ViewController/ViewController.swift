//
//  ViewController.swift
//  CalculatorApp-Codebase
//
//  Created by t0000-m0112 on 2024-11-14.
//

import UIKit
import SnapKit

// MARK: ViewController Class
/// This class handles the UI and user interactions for the Calculator app.
/// It integrates `CalculatorLogic` for handling the calculation logic.
class ViewController: UIViewController {
    // MARK: Properties
    /// Calculator logic instance responsible for calculations and state management.
    private let calculatorLogic = CalculatorLogic()
    
    /// Displays the current calculation expression.
    private let expressionLabel = UILabel()
    
    /// The main stack containing all button rows (horizontal stacks).
    private let superStack = UIStackView()
    
    /// An array of horizontal stacks, each containing buttons for one row.
    private let horizontalStacks: [UIStackView] = (0..<4).map { _ in UIStackView() }
    
    /// Buttons for numbers, operators, and special actions.
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
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatorLogic.delegate = self
        configureUI()
    }
}

// MARK: - UI Configuration
extension ViewController {
    /// Configures the overall UI components of the ViewController.
    private func configureUI() {
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        configureExpressionLabel()
        configureSuperStack()
        configureButton()
    }
    
    /// Configures the expression label displaying the current input or result.
    private func configureExpressionLabel() {
        expressionLabel.backgroundColor = .black
        expressionLabel.text = "0"
        expressionLabel.textColor = .white
        expressionLabel.textAlignment = .right
        expressionLabel.font = UIFont.boldSystemFont(ofSize: 60)
        expressionLabel.adjustsFontSizeToFitWidth = true
        expressionLabel.minimumScaleFactor = 0.5
        expressionLabel.numberOfLines = 0
        expressionLabel.baselineAdjustment = .alignBaselines
        view.addSubview(expressionLabel)
        expressionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.bottom.equalToSuperview().offset(-574)
            $0.top.greaterThanOrEqualToSuperview().offset(50)
            $0.height.greaterThanOrEqualTo(100)
            $0.height.lessThanOrEqualTo(250)
        }
    }
    
    /// Configures the main vertical stack view (superStack) that contains all button rows.
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
        
        // Add horizontal stacks to the super stack
        horizontalStacks.forEach {
            superStack.addArrangedSubview($0)
            setupHorizontalStack(for: $0)
        }
    }
    
    /// Configures a horizontal stack view for a given row of buttons.
    private func setupHorizontalStack(for stack: UIStackView) {
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.snp.makeConstraints {
            $0.height.equalTo(80)
        }
    }
    
    /// Configures all calculator buttons and places them in the horizontal stacks.
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

// MARK: - Button Configuration and Actions
extension ViewController {
    /// Represents different types of calculator buttons.
    private enum CalculatorButton {
        case number(Int), operation(String), allClear, equal
        
        /// The display title of the button.
        var title: String {
            switch self {
            case .number(let value): return "\(value)"
            case .operation(let symbol): return symbol
            case .allClear: return "AC"
            case .equal: return "="
            }
        }
        
        /// The background color of the button.
        var backgroundColor: UIColor {
            switch self {
            case .number: return .systemGray
            case .operation: return .systemOrange
            case .allClear: return .systemOrange
            case .equal: return .systemOrange
            }
        }
        
        /// Creates and configures a UIButton for this type.
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
            button.addTarget(self, action: #selector(buttonAnimation(from:)), for: .touchDown)
            return button
        }
    }
    
    /// Handles the action when a button is pressed.
    @objc private func buttonAction(from sender: UIButton) {
        calculatorLogic.buttonAction(from: sender)
    }
    
    /// Adds an animation to the button when it is pressed.
    @objc private func buttonAnimation(from sender: UIButton) {
        let originalColor = sender.backgroundColor
        UIView.animate(withDuration: 0.05,
                       animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            sender.backgroundColor = originalColor?.withAlphaComponent(0.9)
        }, completion: { _ in
            UIView.animate(withDuration: 0.05) {
                sender.transform = .identity
                sender.backgroundColor = originalColor
            }
        })
    }
}

// MARK: - Delegate Implementation
extension ViewController: CalculatorLogicDelegate {
    /// Updates the expression label with the latest calculation expression.
    internal func didUpdateExpression(_ expression: String) {
        self.expressionLabel.text = expression
    }
}

// MARK: - Preview
#Preview {
    ViewController()
}