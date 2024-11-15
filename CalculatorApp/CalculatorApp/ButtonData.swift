//
//  ButtonData.swift
//  CalculatorApp
//
//  Created by 장상경 on 11/12/24.
//

import UIKit

// 계산기에 들어갈 버튼 선언
let firstRow = ["7", "8", "9", "+"]
let secondRow = ["4", "5", "6", "-"]
let thirdRow = ["1", "2", "3", "*"]
let fourthRow = ["AC", "0", "=", "/"]

/// 파라미터 변수를 UIButton 배열로 반환해주는 함수
/// - Parameter rows: UIButton으로 변환할 데이터
/// - Returns: 변환된 UIButton을 담은 배열 -> [UIButton]
func setButtonRow(_ rows: [String]) -> [UIButton] {
    var buttons = [UIButton]()
    
    for row in rows {
        let button = UIButton()
        
        button.setTitle(row, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 30)
        button.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
        button.layer.cornerRadius = 40
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 80),
            button.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        buttons.append(button)
    }
    
    return buttons
}
