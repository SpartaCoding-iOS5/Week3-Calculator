//
//  ViewController.swift
//  Calculate
//
//  Created by mun on 11/14/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

  var calculatorModel: CalculatorModel!
  var calculatorView: CalculatorView!

  override func viewDidLoad() {
    super.viewDidLoad()

    calculatorModel = CalculatorModel()
    calculatorView = CalculatorView(frame: view.bounds)

    view.addSubview(calculatorView)

    configureActions()
  }

  // 버튼에 action 연결
  private func configureActions() {
    for stackView in calculatorView.verticalStackView.arrangedSubviews {
      let stackView = stackView as! UIStackView

      for button in stackView.arrangedSubviews {
        let button = button as! UIButton

        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
      }
    }
  }

  // 버튼 클릭시 실행
  @objc
  func buttonTapped(_ sender: UIButton) {
    let buttonTitle = sender.currentTitle!

    if buttonTitle == "AC" {
      calculatorView.setLabelText("0")
    } else if buttonTitle == "=" {
      if let result = calculatorModel.calculate(expression: calculatorView.label.text!) {
        calculatorView.setLabelText("\(result)")
      }
    } else {
      if calculatorView.label.text == "0" {
        calculatorView.setLabelText(buttonTitle)
      } else {
        calculatorView.setLabelText(calculatorView.label.text! + buttonTitle)
      }
    }
  }
}


#Preview("ViewController") {
  ViewController()
}
