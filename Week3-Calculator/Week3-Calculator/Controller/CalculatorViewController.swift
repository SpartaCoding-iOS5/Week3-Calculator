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
    private let button7 = ButtonComponents(title: "7", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let button8 = ButtonComponents(title: "8", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let button9 = ButtonComponents(title: "9", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let plusButton = ButtonComponents(title: "+", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    /// UI 연결 및 조건 설정
    private func setupUI() {
        view.backgroundColor = .black
        
        let horizontalStackView = HorizontalStackViewComponents(addButtton: [button7, button8, button9, plusButton])
        
        [resultLabel, horizontalStackView]
            .forEach { view.addSubview($0) }
        
        // SnapKit을 사용하여 제약 조건 설정
        resultLabel.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.leading.equalTo(view.snp.leading).inset(30)
            $0.trailing.equalTo(view.snp.trailing).inset(30)
            $0.top.equalTo(view.snp.top).inset(200)
        }
        
        horizontalStackView.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(resultLabel.snp.bottom).offset(30)
            $0.leading.equalTo(view.snp.leading).offset(10)
            $0.trailing.equalTo(view.snp.trailing).inset(10)
        }
    }
}

