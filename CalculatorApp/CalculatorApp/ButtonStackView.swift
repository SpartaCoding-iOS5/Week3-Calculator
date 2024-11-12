//
//  ButtonStackView.swift
//  CalculatorApp
//
//  Created by 장상경 on 11/12/24.
//

import UIKit

/// 커스텀 스택뷰
class ButtonStackView: UIStackView {
    
    init(axix: NSLayoutConstraint.Axis = .vertical, spacing: CGFloat = 10) {
        super.init(frame: .zero)
        
        // 스택 뷰 기본 설정
        self.axis = axix
        self.spacing = spacing
        self.alignment = .fill
        self.distribution = .fillEqually
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIStackView {
    /// 스택뷰에 2개 이상의 아이템을 넣어줄 수 있는 메소드
    /// - Parameter views: 스택뷰에 넣어줄 아이템 배열
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}

