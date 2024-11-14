//
//  ViewController.swift
//  Calculate
//
//  Created by mun on 11/14/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureLayout()
    }
    
    // UI 설정
    private func configureUI() {
        view.backgroundColor = .black
        configureLabel()
        
        [label].forEach{
            view.addSubview($0)
        }
    }
    
    // label 스타일 설정
    private func configureLabel() {
        label.text = "12345"
        label.textColor = .white
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 60)
    }
    
    // 레이아웃 설정
    private func configureLayout() {
        label.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalToSuperview().inset(200)
            $0.height.equalTo(100)
        }
    }
}

#Preview("ViewController") {
    ViewController()
}
