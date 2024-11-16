// iOS App Project file for Week3-Calculator - /CalculatorViewController
// 작성일: 2024.11.14 (목요일)
//
// 작성자: Jamong
// 이 파일은 계산기 앱의 메인 뷰를 담당한다.

import UIKit
import SnapKit


/// 계산기 최상단 화면 (RootView)
class CalculatorViewController: UIViewController {
    
    private let resultLabel = LabelComponents(title: "0")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    /// UI 연결 및 조건 설정
    private func setupUI() {
        view.backgroundColor = .black
        
        let horizontalStackViews = createHorizontalStackView(form: ButtonData.buttonData)
        
        let verticalStackView = VerticalStackViewComponents(addStackView: horizontalStackViews)
        
        [resultLabel, verticalStackView]
            .forEach { view.addSubview($0) }
        
        // SnapKit을 사용하여 제약 조건 설정
        resultLabel.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalTo(view.snp.top).inset(200)
        }
        
        verticalStackView.snp.makeConstraints {
            $0.top.equalTo(resultLabel.snp.bottom).offset(60)
            $0.centerX.equalTo(view.snp.centerX)
        }
    }
}

