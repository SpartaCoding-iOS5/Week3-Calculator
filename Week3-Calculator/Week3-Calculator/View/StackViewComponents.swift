// iOS App Project file for Week3-Calculator - View/HorizontalStackViewComponents
// 작성일: 2024.11.14 (목요일)
//
// 작성자: Jamong
// 이 파일은 4개의 버튼을 스택 뷰에 담는 컴포넌트를 저장한다.

import UIKit
import SnapKit

/// 4개의 버튼을 담는 HorizontalstackView
public class HorizontalStackViewComponents: UIStackView {
    
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
        super.init(coder: coder)
    }
}


/// 버튼들이 담긴 4개의 HorizontalStackView를 담는 VerticalStackView
public class VerticalStackViewComponents: UIStackView {
    
    /// VerticalStackView 커스텀 UI 컴포넌트 초기화
    /// - Parameter addStackView: 버튼 모음 HorizontalStackView (왼쪽 부터 들어감)
    init(addStackView: [UIStackView]) {
        super.init(frame: .zero)
        self.axis = .vertical
        self.spacing = 10
        self.distribution = .fillEqually
        
        addStackView.forEach { addArrangedSubview($0) }
        
        self.snp.makeConstraints {
            $0.width.equalTo(350)
            $0.height.equalTo(350)
        }
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}

/// HorizontalStackView 생성 및 버튼 구성 함수
/// - Parameter buttonData: ButtonData를 받음(이중배열-튜플)
/// - Returns: 버튼이 들어간 HorizontalStackView를 반환
func createHorizontalStackView(form buttonData: [[(title: String, color: UIColor)]]) -> [HorizontalStackViewComponents] {
    var horizontalStackView: [HorizontalStackViewComponents] = []
    
    for data in buttonData {
        // 버튼 배열 생성
        var buttons: [ButtonComponents] = []
        
        for (title, color) in data {
            let button = ButtonComponents(title: title, backgroundColor: color)
            buttons.append(button)
        }
        
        let stackView = HorizontalStackViewComponents(addButtton: buttons)
        horizontalStackView.append(stackView)
    }
    
    return horizontalStackView
}
