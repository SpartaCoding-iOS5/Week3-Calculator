//
//  ViewController.swift
//  CalculatorApp
//
//  Created by 장상경 on 11/11/24.
//

import UIKit

final class ViewController: UIViewController, ButtonManagerDelegate, FatalErrorTerminate {
    
    private let displayLabel: UILabel = UILabel()
    
    private let scrollView = UIScrollView()
    
    private let buttons = ButtonManager()
    
    private var calculator = Calculator()
    
    private let firstRowStack = CustomStackView()
    private let secondRowStack = CustomStackView()
    private let thirdRowStack = CustomStackView()
    private let fourthRowStack = CustomStackView()
    
    private let numberButtonsStack = CustomStackView(axix: .vertical)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        // 델리게이트 프로퍼티 초기화
        buttons.delegate = self
        
        // fatalError
        calculator.terminate = self
        
        setupScrollView()
        setupDisplayLabel()
        setupVStack()
    }
    
    /// 스크롤뷰 기본세팅 메소드
    private func setupScrollView() {
        scrollView.backgroundColor = .black
        scrollView.contentAlignmentPoint.x = 1
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.heightAnchor.constraint(equalToConstant: 100),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        ])
    }
    
    ///  숫자 및 수식 입력, displayLabel의 기본 세팅
    private func setupDisplayLabel() {
        displayLabel.text = "0"
        displayLabel.textColor = UIColor.white
        displayLabel.textAlignment = .right
        displayLabel.numberOfLines = 1
        displayLabel.sizeToFit()
        displayLabel.font = UIFont.systemFont(ofSize: 60, weight: .bold)
        displayLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(displayLabel)
        
        NSLayoutConstraint.activate([
            displayLabel.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            displayLabel.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            displayLabel.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        ])
    }
    
    /// 다수의 스택뷰에 아이템을 추가하는 메소드
    /// - Parameter stackViews: 아이템을 추가할 스택뷰 배열
    ///
    /// ``setButtonRow(_:)``
    private func setupHStack(_ stackViews: [UIStackView]) {
        for (index, stackView) in stackViews.enumerated() {
            let item = buttons.setButtonRow(buttons.buttonRowList)
            stackView.addArrangedSubviews(item[index])
        }
    }
    
    /// vertical 스택뷰를 세팅하는 메소드
    ///
    /// ``setupHStack(_:)``
    private func setupVStack() {
        setupHStack([firstRowStack,
                     secondRowStack,
                     thirdRowStack,
                     fourthRowStack])
        
        numberButtonsStack.addArrangedSubviews([firstRowStack,
                                                secondRowStack,
                                                thirdRowStack,
                                                fourthRowStack])
        
        numberButtonsStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(numberButtonsStack)
        
        NSLayoutConstraint.activate([
            numberButtonsStack.widthAnchor.constraint(equalToConstant: 350),
            numberButtonsStack.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 60),
            numberButtonsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    /// 델리게이트를 통해 레이블의 값을 변경하는 메소드
    /// - Parameter text: 버튼액션으로 넘어오는 버튼의 타이틀 값(String)
    ///
    /// **조건 1.** 파라미터 값이 AC일 경우 - 레이블 값을 0으로 초기화
    ///
    /// **조건 2.** 파라미터 값이 AC가 아닐 경우 - 레이블 값을 변경 혹은 추가
    ///
    /// ``passDataToDelegate(_:)``
    func didTapButton(with status: InputStatus) {
        switch status {
        case .AC:
            self.displayLabel.text = "0"
            
            // AC를 누르면 스크롤뷰의 위치가 초기화되도록 설정
            resetContentViewOffset()
            
        case .calculate where (self.displayLabel.text != "0" && self.displayLabel.text?.count ?? 0 > 0):
            // 현재 레이블의 값이 0이 아니고 값이 존재하는지 확인
            // 아닐 경우 계산을 진행하지 않음
            let resultCalculate = self.calculator.calculate()
            self.displayLabel.text = resultCalculate == nil ? "Error" : String(resultCalculate!)
            
        case let .input(currentInput) where ["+","-","*","/"].contains(currentInput):
            // 연산자 중복을 방지
            // 만약 현재 레이블의 마지막 값이 연산자라면, 새로운 연산자로 변경
            changeOperator(currentInput)
            
        case let .input(currentInput) where (self.displayLabel.text != "Error"):
            // 입력이 정수이고 현재 레이블 값이 Error가 아닐 경우
            // 현재 레이블값에 입력된 값을 추가 혹은 변경
            let currenDisplayLabelCheck = (self.displayLabel.text == "0")
            self.displayLabel.text = currenDisplayLabelCheck ? currentInput : (self.displayLabel.text! + currentInput)
            
        default:
            break
        }
        
        // 버튼을 눌러 레이블 값이 변경되면 스크롤뷰에 업데이트 사항을 추가
        updateContentViewOffset()
        
        // 버튼을 누르면 현재 레이블의 값을 계산기에 추가
        self.calculator.currentInput = self.displayLabel.text
    }
}


private extension ViewController {
    /// 현재 스크롤뷰의 컨텐츠 위치를 업데이트 시키는 메소드
    ///
    /// 버튼을 누르면 컨텐츠뷰의 사이즈를 계산하여 자동으로 offset 값 변경
    func updateContentViewOffset() {
        if scrollView.contentSize.width >= scrollView.bounds.width {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                let newOffsetX = max(0, self.scrollView.contentSize.width - self.scrollView.bounds.width)
                self.scrollView.setContentOffset(CGPoint(x: newOffsetX, y: 0), animated: true)
            }
        }
    }
    
    /// 스크롤뷰의 위치를 초기화 시키는 메소드
    ///
    /// 컨텐츠뷰의 크기를 스크롤뷰보다 작게하여 값을 초기화
    ///
    /// ``updateContentViewOffset()``
    func resetContentViewOffset() {
        scrollView.contentSize = self.displayLabel.intrinsicContentSize
    }
    
    /// 연산자가 중복 사용된 경우 연산자를 바꾸는 메소드
    /// - Parameter input: 입력된 값(버튼) 확인
    func changeOperator(_ input: String) {
        let operators = ["+","-","*","/"]
        let lastText = self.displayLabel.text?.last
        
        guard operators.contains(String(lastText!)) else {
            self.displayLabel.text! += input
            return
        }
        
        self.displayLabel.text?.removeLast()
        self.displayLabel.text? += input
    }
}

