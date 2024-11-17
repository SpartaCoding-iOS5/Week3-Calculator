// iOS App Project file for Week3-Calculator - CalculatorModel
// 작성일: 2024.11.14 (목요일)
//
// 작성자: Jamong
// 이 파일은 계산기의 모델을 정의한다.

import Foundation

// 계산기 상태를 관리하는 구조체
struct CalculatorModel {
    var currentInput: String = "0"  // 현재 입력 중인 값
    var previousValue: Int?         // 이전 계산 값
    var currentOperator: String?    // 현재 연산자
    
    mutating func clear() {
        currentInput = "0"
        previousValue = nil
        currentOperator = nil
    }
}
    
