// iOS App Project file for Week3-Calculator - Controller/ButtonTappedAction
// 작성일: 2024.11.17 (일요일)
//
// 작성자: Jamong
// 이 파일은 계산기 버튼에 대한 기능을 관리한다.


import UIKit

/// 버튼 액션 관리 클래스
class ButtonTappedAction {
    
    private var calculatorModel: CalculatorModel
    private let resultLabel: LabelComponents
    
    init(calculatorModel: CalculatorModel, resultLabel: LabelComponents) {
        self.calculatorModel = calculatorModel
        self.resultLabel = resultLabel
    }

    /// 숫자 버튼이 눌렀을 때 호출
    func numberButtonTapped(number: String) {
        if calculatorModel.currentInput == "0" {
            calculatorModel.currentInput = number
        } else {
            calculatorModel.currentInput += number
        }
        
        // 모델 업데이트 후 라벨 변경
        resultLabel.text = calculatorModel.currentInput
    }
}
