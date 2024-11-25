// iOS App Project file for Week3-Calculator - CalculatorModel
// 작성일: 2024.11.14 (목요일)
//
// 작성자: Jamong
// 이 파일은 계산기의 모델을 정의한다.

import Foundation

/// 계산기 상태를 관리하는 구조체
struct CalculatorModel {
    var currentInput: String = "0"  // 현재 입력 중인 값
    var previousValue: Int?         // 이전 계산 값
    var currentOperator: String?    // 현재 연산자
    
    /// AC버튼으로 초기화
    mutating func clear() {
        currentInput = "0"
        previousValue = nil
        currentOperator = nil
    }
    
    /// 결과값 계산
    mutating func calculateResult() -> String? {
        // 옵셔널 해제 과정
        guard let currnetValuse = Int(currentInput),
              let previousValue = previousValue,
              let operation = currentOperator else {
            print("이전 값, 입력값, 현재 연산자 중 없는게 있음")
            return nil
        }
        
        let result: Int
        
        switch operation {
        case "+":
            result = previousValue + currnetValuse
        case "-":
            result = previousValue - currnetValuse
        case "*":
            result = previousValue * currnetValuse
        case "/":
            // 예외처리 : 나누는 값이 0이면 0
            result = currnetValuse == 0 ? 0 : previousValue / currnetValuse
        default:
            return nil
        }
        
        self.previousValue = result
        self.currentOperator = nil
        self.currentInput = "\(result)"
        return "\(result)"
    }
    
    /// 연산자 처리
    mutating func handleOperator(_ sendOperator: String) {
        if let currentValue = Int(currentInput) {
            if previousValue == nil {
                // 이전 값이 없으면 현재 값을 이전 값으로 저장
                previousValue = currentValue
            } else if let operation = currentOperator {
                // 이전 연산자 계산 수행
                let result = calculateResult()
            }
        }
        
        // 연산자 저장 및 입력 초기화
        currentOperator = sendOperator
        currentInput = "0"
    }
}
    
