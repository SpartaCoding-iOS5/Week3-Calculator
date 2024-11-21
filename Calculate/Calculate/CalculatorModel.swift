//
//  CalculatorModel.swift
//  Calculate
//
//  Created by mun on 11/21/24.
//
import Foundation

class CalculatorModel {

  // 계산된 결과 반환
  func calculate(expression: String) -> Int? {
    guard isValidExpression(expression) else { return nil }

    let expression = NSExpression(format: expression)
    if let result = expression.expressionValue(with: nil, context: nil) as? Int {
      return result
    } else {
      return nil
    }
  }

  // 수식이 유효한지 확인
  private func isValidExpression(_ text: String) -> Bool {
    let textArray = Array(text)
    var previousChar: String?

    // 시작 문자가 "-"을 제외한 다른 연산 기호라면 false
    if Int(String(textArray.first!)) == nil && textArray.first != "-" {
      return false
    }

    // 마지막 문자가 연산 기호라면 false
    if Int(String(textArray.last!)) == nil {
      return false
    }

    for char in textArray {
      let currentChar = String(char)

      if Int(currentChar) == nil {
        // 연산 기호가 연속으로 나오면 false
        if currentChar == previousChar {
          return false
        }
      }
    }

    return true
  }
}
