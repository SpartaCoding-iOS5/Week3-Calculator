//
//  ButtonData.swift
//  CalculatorApp
//
//  Created by 장상경 on 11/12/24.
//

import UIKit

/// 버튼의 데이터를 관리하는 메소드
final class ButtonManager {
    
    // 계산기에 들어갈 버튼 선언
    private let firstRow = ["7", "8", "9", "+"]
    private let secondRow = ["4", "5", "6", "-"]
    private let thirdRow = ["1", "2", "3", "*"]
    private let fourthRow = ["AC", "0", "=", "/"]
    
    weak var delegate: ButtonManagerDelegate?
    
    // 버튼을 관리하는 목록
    var buttonRowList: [[String]]
    
    init() {
        self.buttonRowList = [firstRow, secondRow, thirdRow, fourthRow]
    }
    
    /// UIButton을 생성 및 세팅하고 반환하는 메소드
    /// - Parameter rows: 버튼 title 값을 담은 String 배열
    /// - Returns: 각 row 별로 구분된 UIButton 배열을 담은 배열을 반환
    func setButtonRow(_ rows: [[String]]) -> [[UIButton]] {
        var buttons = [UIButton]()
        var buttonsList = [[UIButton]]()
        
        for row in rows {
            for data in row {
                let button = UIButton()
                var config = UIButton.Configuration.filled()
                
                var titleAttr = AttributedString.init(data)
                titleAttr.font = .systemFont(ofSize: 30, weight: .bold)
                
                config.attributedTitle = titleAttr
                config.baseBackgroundColor = UIColor.highlightColor(for: data)
                config.baseForegroundColor = .white
                config.cornerStyle = .capsule
                
                button.configuration = config
                button.addTarget(self, action: #selector(passDataToDelegate), for: .touchDown)
                button.translatesAutoresizingMaskIntoConstraints = false
                
                button.configurationUpdateHandler = {
                    switch $0.state {
                    case .normal:
                        $0.configuration?.baseBackgroundColor = UIColor.highlightColor(for: data)
                        $0.configuration?.baseForegroundColor = .white
                        
                    case .highlighted:
                        $0.configuration?.baseBackgroundColor = UIColor.highlightColor(for: data).withAlphaComponent(0.7)
                        $0.configuration?.baseForegroundColor = .white.withAlphaComponent(0.7)
                        
                    default:
                        break
                    }
                }
                
                NSLayoutConstraint.activate([
                    button.heightAnchor.constraint(equalToConstant: 80),
                    button.widthAnchor.constraint(equalToConstant: 80)
                ])
                
                buttons.append(button)
            }
            
            buttonsList.append(buttons)
            buttons.removeAll()
            
        }
        
        return buttonsList
    }
    
    /// 버튼 클릭시 버튼의 타이틀 값(String)을 델리게이트로 전달하는 메소드
    /// - Parameter button: 값을 전달할 버튼
    ///
    /// ``didTapButton``
    @objc private func passDataToDelegate(_ button: UIButton) {
        guard let text = button.titleLabel?.text else { return }
        
        // 현재 입력의 상태를 확인 후 반환
        let status = changeButtonState(with: text)
        
        delegate?.didTapButton(with: status)
    }
}

fileprivate extension ButtonManager {
    /// 현재 입력의 상태를 확인하는 메소드
    /// - Parameter text: 현재 입력된 값(버튼)
    /// - Returns: 입력상태를 반환
    func changeButtonState(with text: String) -> InputStatus {
        var status: InputStatus
        
        if text == "AC" {
            status = .AC
            
        } else if text == "=" {
            status = .calculate
            
        } else {
            status = .input(currentInput: text)
        }
        
        return status
    }
}

extension UIColor {
    /// 버튼의 색을 변경하는 메소드
    /// - Parameter button: 컬러를 변경할 버튼 파라미터
    /// - Returns: 조건에 따라 각 타입에 따른 UIColor 값을 반환
    static func highlightColor(for title: String) -> UIColor {
        if let _ = Int(title) {
            return UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
        } else {
            return UIColor.orange
        }
    }
}
