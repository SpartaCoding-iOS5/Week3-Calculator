// iOS App Project file for Week3-Calculator - Data/ButtonData.swift
// 작성일: 2024.11.14 (목요일)
//
// 작성자: Jamong
// 이 파일은 계산기 버튼 데이터를 저장한다.

import UIKit

/// 계산기 버튼 데이터
struct ButtonData {
    static let buttonData: [[(title: String, color: UIColor)]] = [
        [("7", ColorList.darkGray), ("8", ColorList.darkGray), ("9", ColorList.darkGray), ("+", ColorList.orange)],
        [("4", ColorList.darkGray), ("5", ColorList.darkGray), ("6", ColorList.darkGray), ("-", ColorList.orange)],
        [("1", ColorList.darkGray), ("2", ColorList.darkGray), ("3", ColorList.darkGray), ("*", ColorList.orange)],
        [("AC", ColorList.orange), ("0", ColorList.darkGray), ("=", ColorList.orange), ("/", ColorList.orange)]
    ]
}
