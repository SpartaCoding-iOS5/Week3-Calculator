//
//  ButtonDataDelegate.swift
//  CalculatorApp
//
//  Created by 장상경 on 11/17/24.
//

import UIKit

protocol ButtonManagerDelegate: AnyObject {
    func didTapButton(with status: InputStatus)
}
