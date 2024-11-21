//
//  FatalErrorTerminate.swift
//  CalculatorApp
//
//  Created by 장상경 on 11/17/24.
//

import UIKit

protocol FatalErrorTerminate: AnyObject {
    func compulsoryTermination(second: Double)
    
    func showAlert()
}

extension FatalErrorTerminate {
    /// 치명적인 에러가 발생할 경우 앱을 우아하게 종료시키는 메소드
    /// - Parameter second: 몇 초 후에 종료시킬 것인지 정하는 파라미터
    func compulsoryTermination(second: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + second) {
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                exit(1)
            }
        }
    }
    
    /// 경고창(Alert)를 띄우는 메소드
    ///
    /// - 5초 후 앱을 종료한다는 경고를 알림
    /// - 버튼을 클릭시 앱을 즉시 종료s
    ///
    /// ``compulsoryTermination(second:)``
    func showAlert() {
        let title = "🚨Fatal Error🚨"
        let message = "This app will shut down in 5 seconds..."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let terminateAction = UIAlertAction(title: "Shut Down", style: .destructive) { _ in
            self.compulsoryTermination(second: 0)
        }
        
        alert.addAction(terminateAction)
        
        if let view = self as? ViewController {
            view.present(alert, animated: true) {
                self.compulsoryTermination(second: 5.0)
            }
        }
    }
}
