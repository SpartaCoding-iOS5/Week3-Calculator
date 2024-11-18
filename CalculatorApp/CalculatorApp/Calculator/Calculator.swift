//
//  Calculator.swift
//  CalculatorApp
//
//  Created by 장상경 on 11/17/24.
//

import UIKit

class Calculator {
    
    weak var terminate: FatalErrorTerminate?
    
    var currentInput: String?
    
    /// 레이블의 값을 계산하는 메소드
    /// - Parameter expression: 레이블의 값을 파라미터로 받는다
    /// - Returns: 에러가 있다면 에러를 반환하고 아니라면 계산 결과를 반환한다.
    ///
    /// - **Error Type**:
    ///     1. 계산할 값이 없을 경우 - CalculatorError.lackOfValue
    ///     2. 입력 값이 잘못된 경우 - CalculatorError.invalidInput
    ///     3. 계산기의 스펙으로 계산을 할 수 없는 경우 - CalculatorError.performanceOver
    ///
    /// ``inputCheck(_:)``
    /// ``CalculatorError``
    func calculate() -> Int? {
        var answer: Int?
        
        do {
            answer = try inputCheck(self.currentInput ?? "")
            
        } catch CalculatorError.lackOfValue {
            print(CalculatorError.lackOfValue.errorDescription)
        } catch CalculatorError.invalidInput {
            print(CalculatorError.invalidInput.errorDescription)
        } catch CalculatorError.performanceOver {
            print(CalculatorError.performanceOver.errorDescription)
        } catch {
            print(error.localizedDescription)
            print("An unknown error has occurred.")
            self.terminate?.showAlert()
        }
        
        return answer
    }
    
    /// 현재 레이블 값(입력값)에 오류가 있는지 확인하는 메소드
    /// - Parameter input: 현재 레이블의 값
    /// - Returns: 에러를 체크하여 에러를 던지거나 계산 결과 혹은 nil을 반환
    private func inputCheck(_ input: String)throws -> Int? {
        var check: [String] = []
        var answer: Int?
        
        guard input != "Error" else {
            throw CalculatorError.lackOfValue
        }
        
        let arr = input.components(separatedBy: "+")
        let arr2 = input.components(separatedBy: "-")
        let arr3 = input.components(separatedBy: "*")
        let arr4 = input.components(separatedBy: "/")
        
        check += arr + arr2 + arr3 + arr4
        
        guard !check.contains("") else {
            throw CalculatorError.invalidInput
        }
        
        let expression = NSExpression(format: input)
        if let result = expression.expressionValue(with: nil, context: nil) as? Int {
            answer = result
        } else {
            answer = nil
            throw CalculatorError.performanceOver
        }
        
        return answer
    }
}
