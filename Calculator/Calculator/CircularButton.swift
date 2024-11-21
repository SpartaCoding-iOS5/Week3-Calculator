//
//  CircularButton.swift
//  Calculator
//
//  Created by 권승용 on 11/21/24.
//

import UIKit

final class CircularButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius: CGFloat = self.bounds.size.width / 2.0
        self.layer.cornerRadius = radius
    }
}
