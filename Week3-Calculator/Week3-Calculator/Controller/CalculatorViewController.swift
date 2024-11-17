// iOS App Project file for Week3-Calculator - Controller/CalculatorViewController
// 작성일: 2024.11.14 (목요일)
//
// 작성자: Jamong
// 이 파일은 계산기 앱의 메인 뷰를 담당한다.

import UIKit
import SnapKit


/// 계산기 최상단 화면 (RootView)
class CalculatorViewController: UIViewController {
    
    private let resultLabel = LabelComponents(title: "0")
    private var buttonTappedAction: ButtonTappedAction?
    private var calculatorModel = CalculatorModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // buttonTappedAction 초기화
        buttonTappedAction = ButtonTappedAction(calculatorModel: calculatorModel, resultLabel: resultLabel)
        
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
        
        // 버튼 액션 연결
        for stackView in horizontalStackViews {
            for button in stackView.arrangedSubviews {
                if let button = button as? UIButton {
                    button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                }
            }
        }
    }
    
    /// 버튼 동작하는 기능 구현
    /// - Parameter sender: UIButton
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let title = sender.title(for: .normal) else { return }
        
        if let num = Int(title) {
            // 숫자 버튼인지 확인 후 기능
            buttonTappedAction?.numberButtonTapped(number: title)
        } else if title == "AC"{
            // "AC" 버튼 초기화 기능
            buttonTappedAction?.clearAll()
        } else if title == "=" {
            buttonTappedAction?.calculateResult()
        } else {
            buttonTappedAction?.operatorButtonTapped(sendOperator: title)
        }
    }
}

#Preview("ViewController") {
    CalculatorViewController()
}
