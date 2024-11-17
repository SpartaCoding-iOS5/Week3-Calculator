// iOS App Project file for Week3-Calculator - View/LabelComponents
// 작성일: 2024.11.14 (목요일)
//
// 작성자: Jamong
// 이 파일은 메인 화면의 라벨 컴포넌트를 저장한다.

import UIKit
import SnapKit

/// Label 커스텀 UI 컴퍼넌트
class LabelComponents: UILabel {
    
    /// Label 커스텀 UI 컴퍼넌트 초기화
    /// - Parameter title: 화면 숫자 값
    init(title: String) {
        super.init(frame: .zero)
        self.text = "0"
        self.textColor = .white
        self.textAlignment = .right
        self.font = .systemFont(ofSize: 60, weight: .bold)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
}
