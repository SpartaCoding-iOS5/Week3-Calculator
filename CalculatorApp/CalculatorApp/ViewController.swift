//
//  ViewController.swift
//  CalculatorApp
//
//  Created by 장상경 on 11/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    private let answer: UILabel = UILabel()
    
    private let stackView = ButtonStackView(axix: .horizontal, spacing: 10)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setAnswer()
        setStackView(stackView, in: setButtonRow(firstRow), equal: answer, constant: 50)
    }

    ///  숫자 및 수식 입력, answer의 기본 세팅
    private func setAnswer() {
        answer.text = "12345"
        answer.textColor = UIColor.white
        answer.textAlignment = .right
        answer.font = UIFont.systemFont(ofSize: 60, weight: .bold)
        answer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(answer)
                
        NSLayoutConstraint.activate([
            answer.heightAnchor.constraint(equalToConstant: 100),
            answer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            answer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            answer.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        ])
    }
    
    /// 스택뷰의 기본 세팅을 해주는 메소드
    /// - Parameters:
    ///   - stackView: 세팅을 진행할 스택뷰
    ///   - item: 스택뷰에 넣을 아이템
    ///   - superView: 스택뷰의 오토레이아웃의 기준이 될 뷰
    ///   - constant: 기준 뷰와 떨어질 값
    ///
    ///   ``setButtonRow(_:)``
    private func setStackView(_ stackView: UIStackView, in item: [UIView], equal superView: UIView, constant: CGFloat) {
        stackView.addArrangedSubviews(item)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 80),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: superView.bottomAnchor, constant: constant)
        ])
    }
}
