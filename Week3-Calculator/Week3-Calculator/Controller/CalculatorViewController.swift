// iOS App Project file for Week3-Calculator - /CalculatorViewController
// 작성일: 2024.11.14 (목요일)
//
// 작성자: Jamong
// 이 파일은 계산기 앱의 메인 뷰를 담당한다.

import UIKit
import SnapKit

class CalculatorViewController: UIViewController {
    
    private let resultLabel = LabelComponents(title: "0")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        view.addSubview(resultLabel)
        
        // SnapKit을 사용하여 제약 조건 설정
        resultLabel.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.leading.equalTo(view.snp.leading).inset(30)
            $0.trailing.equalTo(view.snp.trailing).inset(30)
            $0.top.equalTo(view.snp.top).inset(200)
        }
    }
}

