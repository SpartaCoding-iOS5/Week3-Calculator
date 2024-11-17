//
//  FatalErrorTerminate.swift
//  CalculatorApp
//
//  Created by 장상경 on 11/17/24.
//

import UIKit

protocol FatalErrorTerminate: AnyObject {
    func compulsoryTermination(second: Double)
    
    func showAlert()
}
