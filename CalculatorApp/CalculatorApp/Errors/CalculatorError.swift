//
//  CalculatorError.swift
//  CalculatorApp
//
//  Created by 장상경 on 11/17/24.
//

import UIKit

enum CalculatorError: LocalizedError {
    case lackOfValue
    case invalidInput
    case performanceOver
    
    var errorDescription: String {
        switch self {
        case .lackOfValue:
            "Error!! There is not enough value to proceed with the calculation"
        case .invalidInput:
            "Error!! Invalid input, please use at least two values and at least one operator to proceed with the calculation"
        case .performanceOver:
            "Error!! It is a task that goes beyond the performance of the calculator."
        }
    }
}
