//
//  CalculatorView.swift
//  Calculate
//
//  Created by mun on 11/21/24.
//

import UIKit

import SnapKit

class CalculatorView: UIView {

  var label = UILabel()
  var verticalStackView = UIStackView()

  let buttonDatas = [["7", "8", "9", "+"],
                     ["4", "5", "6", "-"],
                     ["1", "2", "3", "*"],
                     ["AC", "0", "=", "/"]]

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
    configureLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // UI 설정
  private func configureUI() {
    self.backgroundColor = .black
    [label, verticalStackView].forEach() {
      self.addSubview($0)
    }

    configureLabel()
    configureVerticalStackView()
  }

  // label 스타일 설정
  private func configureLabel() {
    label.text = "0"
    label.textColor = .white
    label.textAlignment = .right
    label.font = .boldSystemFont(ofSize: 60)
  }

  // VerticalStackView 스타일 설정
  private func configureVerticalStackView() {
    for i in 0..<4 {
      let view = makeHorizontalStackView(i)
      verticalStackView.addArrangedSubview(view)
    }

    verticalStackView.axis = .vertical
    verticalStackView.backgroundColor = .black
    verticalStackView.spacing = 10
    verticalStackView.distribution = .fillEqually
  }

  // horizontalStackView 생성
  private func makeHorizontalStackView(_ verIndex: Int) -> UIStackView {
    let horizontalStackView = UIStackView()

    horizontalStackView.axis = .horizontal
    horizontalStackView.backgroundColor = .black
    horizontalStackView.spacing = 10
    horizontalStackView.distribution = .fillEqually

    for horIndex in 0..<4 {
      let button = makeButton(verIndex: verIndex, horIndex: horIndex)
      horizontalStackView.addArrangedSubview(button)
    }

    return horizontalStackView
  }

  // button 생성
  private func makeButton(verIndex: Int, horIndex: Int) -> UIButton {
    let button = UIButton()
    let title = buttonDatas[verIndex][horIndex]
    let color = Int(title) == nil ? .orange : UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)

    button.setTitle(title, for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 30)
    button.backgroundColor = color
    button.layer.cornerRadius = 80 / 2

    button.snp.makeConstraints() {
      $0.width.height.equalTo(80)
    }

    return button
  }

  // button 텍스트 변경
  func setLabelText(_ text: String) {
    label.text = text
  }

  // 오토 레이아웃 설정
  private func configureLayout() {
    label.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(30)
      $0.top.equalToSuperview().inset(200)
      $0.height.equalTo(100)
    }

    verticalStackView.snp.makeConstraints {
      $0.top.equalTo(label.snp.bottom).offset(60)
      $0.centerX.equalToSuperview()
    }
  }
}
