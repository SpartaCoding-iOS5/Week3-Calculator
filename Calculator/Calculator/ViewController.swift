//
//  ViewController.swift
//  Calculator
//
//  Created by 권승용 on 11/18/24.
//

import UIKit

extension UIColor {
    static let numberBackground = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
    static let operatorBackground = UIColor.orange
}

final class ViewController: UIViewController {
    // MARK: - Views
    /// 숫자 디스플레이
    private let numericDisplay: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 60, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    /// 키패드 스택뷰
    private lazy var keypad: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                makeKeypadRow(
                    ["7", "8", "9", "+"],
                    [.numberBackground, .numberBackground, .numberBackground, .orange]
                ),
                makeKeypadRow(
                    ["4", "5", "6", "-"],
                    [.numberBackground, .numberBackground, .numberBackground, .orange]
                ),
                makeKeypadRow(
                    ["1", "2", "3", "*"],
                    [.numberBackground, .numberBackground, .numberBackground, .orange]
                ),
                makeKeypadRow(
                    ["AC", "0", "=", "/"],
                    [.orange, .numberBackground, .orange, .orange]
                )
            ]
        )
        stackView.axis = .vertical
        stackView.backgroundColor = .black
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Configuration
    private func configureUI() {
        view.backgroundColor = .black
        
        let subViews = [
            numericDisplay,
            keypad
        ]
        
        subViews.forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            numericDisplay.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            numericDisplay.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            numericDisplay.bottomAnchor.constraint(equalTo: keypad.topAnchor, constant: -60),
            numericDisplay.heightAnchor.constraint(equalToConstant: 100),
            
            keypad.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            keypad.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            keypad.widthAnchor.constraint(equalToConstant: view.frame.width - 60),
            keypad.heightAnchor.constraint(equalTo: keypad.widthAnchor)
        ])
    }
}

// MARK: View Factories
private extension ViewController {
    func makeButton(_ title: String, backgroundColor: UIColor) -> CircularButton {
        let button = CircularButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 30)
        button.backgroundColor = backgroundColor
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }
    
    func makeHorizontalStackView(_ views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.backgroundColor = .black
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }
    
    func makeKeypadRow(_ titles: [String], _ backgroundColors: [UIColor]) -> UIStackView {
        let buttonViews = zip(titles, backgroundColors).map {
            makeButton($0, backgroundColor: $1)
        }
        let stackView = makeHorizontalStackView(buttonViews)
        return stackView
    }
}

// MARK: - Objc Functions
private extension ViewController {
    @objc
    func buttonTapped(_ sender: UIButton) {
        guard let title = sender.title(for: .normal) else {
            return
        }
        if let number = Int(title) {
            if numericDisplay.text == "0" {
                numericDisplay.text = String(number)
            } else {
                numericDisplay.text?.append(String(number))
            }
        } else {
            handleTitle(title)
        }
    }
}

// MARK: Business logics
private extension ViewController {
    func handleTitle(_ title: String) {
        switch title {
        case "+", "-", "*", "/":
            if lastCharNotOperator {
                numericDisplay.text?.append(title)
            }
            
        case "=":
            ifAvailableCalculateAndShowResult()
            
        case "AC":
            numericDisplay.text = "0"
            
        default:
            break
        }
    }
    
    var lastCharNotOperator: Bool {
        let char = numericDisplay.text?.last
        return !["+", "-", "*", "/"].contains(char)
    }
    
    func ifAvailableCalculateAndShowResult() {
        guard lastCharNotOperator else {
            return
        }
        guard let expression = numericDisplay.text else {
            return
        }
        guard let result = calculate(expression: expression) else {
            return
        }
        numericDisplay.text = String(result)
    }
    
    func calculate(expression: String) -> Int? {
        let expression = NSExpression(format: expression)
        if let result = expression.expressionValue(with: nil, context: nil) as? Int {
            return result
        } else {
            return nil
        }
    }
}

#Preview {
    ViewController()
}
