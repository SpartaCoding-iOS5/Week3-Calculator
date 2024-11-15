// iOS App Project file for Week3-Calculator - View/HorizontalStackViewComponents
// 작성일: 2024.11.14 (목요일)
//
// 작성자: Jamong
// 이 파일은 4개의 버튼을 스택 뷰에 담는 컴포넌트를 저장한다.

import UIKit
import SnapKit

/// 4개의 버튼을 담는 HorizontalstackView
class HorizontalStackViewComponents: UIStackView {
    
    /// HorizontalStackView 커스텀 UI 컴퍼넌트 초기화
    /// - Parameter addButtton: HorizontalStackView에 넣을 버튼 (왼쪽 부터 들어감)
    init(addButtton: [UIButton]) {
        super.init(frame: .zero)
        self.axis = .horizontal
        self.spacing = 10
        self.distribution = .fillEqually
        
        addButtton.forEach{addArrangedSubview($0)}
        
        self.snp.makeConstraints {
            $0.height.equalTo(80)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("이 초기화 메서드는 구현되지 않았습니다.")
    }
}
