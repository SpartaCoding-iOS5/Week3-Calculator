// iOS App Project file for Week3-Calculator - View/ButtonComponents
// 작성일: 2024.11.14 (목요일)
//
// 작성자: Jamong
// 이 파일은 메인 화면의 버튼 컴포넌트를 저장한다

import UIKit
import SnapKit


/// 게산기 버튼 커스텀 UI 컴포넌트
public class ButtonComponents: UIButton {
    
    /// 계산기 버튼 컴포넌트 초기화
    /// - Parameters:
    ///   - title: 버튼의 숫자 및 연산자
    ///   - backgroundColor: 버튼 색상
    init(title: String, backgroundColor: UIColor) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        self.frame.size.width = 80
        self.frame.size.height = 80
        self.layer.cornerRadius = 40
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
