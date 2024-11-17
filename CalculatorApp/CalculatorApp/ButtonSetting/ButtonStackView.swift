//
//  ButtonStackView.swift
//  CalculatorApp
//
//  Created by 장상경 on 11/12/24.
//

import UIKit

/// 커스텀 스택뷰
class ButtonStackView: UIStackView {
    
    init(axix: NSLayoutConstraint.Axis = .horizontal) {
        super.init(frame: .zero)
        
        // 스택 뷰 기본 설정
        self.axis = axix
        self.spacing = 10
        self.alignment = .fill
        self.distribution = .fillEqually
        self.backgroundColor = UIColor.black
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        // fatalError는 앱을 강제 종료 시키기 때문에 super.init으로 대체
        // 스토리보드 혹은 인터페이스 빌더에서 클래스 초기화시 객체 생성
        super.init(coder: coder)
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

