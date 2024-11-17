//
//  ViewController.swift
//  CalculatorApp
//
//  Created by 장상경 on 11/11/24.
//

import UIKit

class ViewController: UIViewController, ButtonDataDelegate, FatalErrorTerminate {
    
    private let displayLabel: UILabel = UILabel()
    
    private let buttons = ButtonData()
    
    private let calculator = Calculator()
    
    private let firstRowStack = ButtonStackView()
    private let secondRowStack = ButtonStackView()
    private let thirdRowStack = ButtonStackView()
    private let fourthRowStack = ButtonStackView()
    
    private let numberButtonsStack = ButtonStackView(axix: .vertical)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        // 델리게이트 프로퍼티 초기화
        buttons.deleget = self
        
        // fatalError
        calculator.terminate = self
        
        setDisplayLabel()
        setVStack()
    }

    ///  숫자 및 수식 입력, displayLabel의 기본 세팅
    private func setDisplayLabel() {
        displayLabel.text = "0"
        displayLabel.textColor = UIColor.white
        displayLabel.textAlignment = .right
        displayLabel.font = UIFont.systemFont(ofSize: 60, weight: .bold)
        displayLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(displayLabel)
                
        NSLayoutConstraint.activate([
            displayLabel.heightAnchor.constraint(equalToConstant: 100),
            displayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            displayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            displayLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        ])
    }
    
    /// 다수의 스택뷰에 아이템을 추가하는 메소드
    /// - Parameter stackViews: 아이템을 추가할 스택뷰 배열
    ///
    /// ``setButtonRow(_:)``
    private func setHStack(_ stackViews: [UIStackView]) {
        for (index, stackView) in stackViews.enumerated() {
            let item = buttons.setButtonRow(buttons.buttonRowList)
            stackView.addArrangedSubviews(item[index])
        }
    }
    
    /// vertical 스택뷰를 세팅하는 메소드
    ///
    /// ``setHStack(_:)``
    private func setVStack() {
        setHStack([firstRowStack,
                   secondRowStack,
                   thirdRowStack,
                   fourthRowStack])
        
        numberButtonsStack.addArrangedSubviews([firstRowStack,
                                                secondRowStack,
                                                thirdRowStack,
                                                fourthRowStack])
        
        numberButtonsStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(numberButtonsStack)
        
        NSLayoutConstraint.activate([
            numberButtonsStack.widthAnchor.constraint(equalToConstant: 350),
            numberButtonsStack.topAnchor.constraint(equalTo: displayLabel.bottomAnchor, constant: 60),
            numberButtonsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    /// 델리게이트를 통해 레이블의 값을 변경하는 메소드
    /// - Parameter text: 버튼액션으로 넘어오는 버튼의 타이틀 값(String)
    ///
    /// **조건 1.** 파라미터 값이 AC일 경우 - 레이블 값을 0으로 초기화
    ///
    /// **조건 2.** 파라미터 값이 AC가 아닐 경우 - 레이블 값을 변경 혹은 추가
    ///
    /// ``passDataToDelegate(_:)``
    func didTapButton(with text: String) {
        if text == "AC" {
            self.displayLabel.text = "0"
            
        } else if text == "=" {
            // 현재 레이블의 값이 0이 아니고 값이 존재하는지 확인
            // 아닐 경우 계산을 진행하지 않음
            guard self.displayLabel.text != "0" && self.displayLabel.text?.count ?? 0 > 0 else {
                return
            }
            
            let resultCalculate = self.calculator.calculate(expression: displayLabel.text!)
            self.displayLabel.text = resultCalculate == nil ? "Error" : String(resultCalculate!)
            
        } else {
            // 현재 레이블의 값이 에러가 아니라면 텍스트 추가
            // AC를 통해 초기화 가능
            guard self.displayLabel.text != "Error" else {
                return
            }
            
            self.displayLabel.text = (displayLabel.text == "0") ? text : (displayLabel.text ?? "") + text
        }
    }
    
    /// 치명적인 에러가 발생할 경우 앱을 우아하게 종료시키는 메소드
    /// - Parameter second: 몇 초 후에 종료시킬 것인지 정하는 파라미터
    func compulsoryTermination(second: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + second) {
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                exit(1)
            }
        }
    }
    
    /// 경고창(Alert)를 띄우는 메소드
    ///
    /// - 5초 후 앱을 종료한다는 경고를 알림
    /// - 버튼을 클릭시 앱을 즉시 종료s
    ///
    /// ``compulsoryTermination(second:)``
    func showAlert() {
        let title = "🚨Fatal Error🚨"
        let message = "This app will shut down in 5 seconds..."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let terminateAction = UIAlertAction(title: "Shut Down", style: .destructive) { _ in
            self.compulsoryTermination(second: 0)
        }
        
        alert.addAction(terminateAction)
        self.present(alert, animated: true) {
            self.compulsoryTermination(second: 5.0)
        }
    }
}
