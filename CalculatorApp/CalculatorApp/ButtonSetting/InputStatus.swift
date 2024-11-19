//
//  InputStatus.swift
//  CalculatorApp
//
//  Created by 장상경 on 11/19/24.
//

import UIKit

// 현재 입력의 상태를 정의한 열거형
enum InputStatus {
    case AC
    case calculate
    case input(currentInput: String)
}
