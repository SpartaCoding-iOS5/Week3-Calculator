# 1. 프로젝트 소개
앱 개발 입문 주차 과제로 기본적인 계산기 기능을 구현하여, iOS 앱 개발에 필요한 기초 개념과 UI 개발 방법을 실습한다. `Swift`와 `SnapKit`을 사용하고 `UIKit Codebase`로 개발을 진행하려고 한다.

---
# 2. 프로젝트 개요
- 프로젝트 이름: Calculator
- 설명: 간단한 정수형 계산기 앱으로 덧셈, 뺄셈, 곱셈, 나눗셈과 같은 사칙연산을 지원함.
- 개발 환경: Xcode 16.1, iOS 18.1
- 사용한 라이브러리: SnapKit(레이아웃 제약 조건 설정)

---
# 3. 주요 기능
- 숫자 입력: 숫자 버튼을 눌러 정수를 입력할 수 있다.
- 사칙연산: 덧셈, 뺄셈, 곱셈, 나눗셈 기능을 제공한다.
- 초기화: `AC`버튼을 눌러 계산을 초기화 한다.
- 결과 표시: `=` 버튼을 눌렀을 때 수식이 계산되고 결과가 화면에 표시된다.
- 에러 처리: 잘못된 수식 입력 시 앱이 예외적으로 종료되지 않도록 기본적인 에러 처리 추가

---
# 4. 구현 상세 
## Level 1 - Label로 수식 표시
* UILabel을 사용하여 입력된 수식을 표시한다.
* BackgroundColor = .black
* TextColor = .white
* Title = 12345
* TextAlignment = .trailing
* Font = SystemBold, Size = 60
* AutoLayout:
  * leading, trailing = superView와 간격 30
  * top = superView와 간격 200
  * height = 100

---

## Level 2 - 가로 StackView로 버튼 구성
* UIStackView를 사용하여 4개의 버튼을 가로로 배치한다.
* UIButton 속성:
  * Font = .boldSystemFont(ofSize: 30)
  * BackgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
  * frame.size.height = 80
  * frame.size.width = 80
  * layer.cornerRadius = 40
* horizontalStackView 속성:
  * axis = .horizontal
  * backgroundColor = .black
  * spacing = 10
  * distribution = .fillEqually
* horizontalStackView AutoLayout:
  * height = 80

---

## Level 3 - 세로 StackView로 전체 구성
* UIStackView를 사용하여 가로 스택 뷰들을 세로로 배치한다.
* verticalStackView 속성:
  * axis = .vertical
  * backgroundColor = .black
  * spacing = 10
  * distribution = .fillEqually
* verticalStackView AutoLayout:
  * width = 350
  * top = label의 bottom에서 60 떨어지도록 설정
  * centerX = superView와 같도록 설정

---

## Level 4 - 연산 버튼 색상 지정
* 연산 버튼들(+, -, *, /, AC, =)의 색상을 오렌지색으로 설정한다.
* UIButton 속성:
  * BackgroundColor = .orange
* 개발 팁:
  * `func makeButton(titleValue: String, action: Selector, backgroundColor: UIColor) -> UIButton` 메서드를 정의하여 버튼을 효율적으로 생성할 수 있다.

---

## Level 5 - 버튼 원형 설정
* 모든 버튼을 원형으로 만듭니다.
  * HorizontalStackView의 높이 = 80
  * VerticalStackView의 가로 = 350
  * VerticalStackView의 Spacing = 10
  * VerticalStackView 내 각 버튼의 가로 길이 = (350 - 10 * 3) / 4 = 80
  * UIButton의 layer.cornerRadius = 40으로 설정하여 원형을 만듭니다.

---

## Level 6 - 버튼 클릭 시 라벨에 표시
* 기본 텍스트를 "12345"에서 "0"으로 초기화합니다.
* 버튼을 클릭하면 해당 버튼의 값이 라벨에 추가되도록 설정합니다.
  * 예) 기본값 `0` → `1` 클릭 시 "01" → `2` 클릭 시 "02" → `+` 클릭 시 "02+" → `3` 클릭 시 "02+3"
* 맨 앞자리가 `0`인 경우 `0`을 제거하도록 설정
  * 예) "012" → "12"

---

## Level 7 - 초기화 버튼 (AC)
* AC 버튼을 클릭하면 모든 값이 초기화되고 라벨에 "0"이 표시되도록 구현합니다.

---

## Level 8 - "=" 버튼 클릭 시 계산 수행
* `=` 버튼을 클릭하면 수식이 계산되고 결과가 표시되도록 설정합니다.
  * 예) "1+2+3" 입력 후 "=" 클릭 시 결과 "6" 출력, "123*456" 입력 후 "=" 클릭 시 결과 "56088" 출력
* 계산을 위한 메서드 사용 예시:
  ```swift
  func calculate(expression: String) -> Int? {
      let expression = NSExpression(format: expression)
      if let result = expression.expressionValue(with: nil, context: nil) as? Int {
          return result
      } else {
          return nil
      }
  }

---
# 5. 구조 설계
하나의 화면에 공통된 버튼들 그리고 해당하는 버튼의 로직과 에러 처리 MVC 패턴으로 폴더링하면 다음과 같이 구조 설계를 할 수 있겠다.

## Model
- 역활: 모델 클래스, 구조체, 데이터 관리 객체등 앱의 데이터와 비즈니스 로직을 관리하는 모델 파일을 저장
- CalculatorModel:
  - 계산기 상태를 관리하는 구조체
  - 입력을 초기화하는 메서드
- CalculatorError:
  - 에러 처리 
  
## View
- 역활: 사용자 인터페이스(UI) 관련 파일을 관리한다.
- ButtonComponents:
  - 버튼의 커스텀 UI 컴포넌트를 관리
- LabelComponents:
  - 메인화면 라벨의 컴포넌트를 관리

## Controller
- 역활: 뷰와 모델 사이의 데이터를 중계하고 사용자 입력을 처리하는 로직을 포함한다.
- ClaculatorViewController:
  - 메인 화면을 관리
- ButtonTappedAction:
  - 버튼에 대한 기능을 관리

## Resources
- 역활: 앱에서 사용하는 리소스 파일들을 저장한다.
- Assets.xcassets
- Info.plist
- LaunchScreen.stroyboard

## Utilities
- 역활: 확장 기능을 추가하는 폴더로 사용자 정의, 상수 등이 포함된다.
- Constants:
  - 매직 넘버를 관리하는 파일
  
---
# 6. 구현 시작
구조를 설계했으니 다음으로는 레벨 별로 구현을 시작하려고 한다.

## Level 1 - 기본적인 틀 잡기 및 라벨 컴포넌트 생성
각 폴더를 만들어주고 Controller에는 CalculatorViewController
View에는 LabelComponents를 구현하여 연결하였다.

**LabelComponents.swift**
```swift
import UIKit
import SnapKit

/// Label 커스텀 UI 컴퍼넌트
class LabelComponents: UILabel {
    
    /// Label 커스텀 UI 컴퍼넌트 초기화
    /// - Parameter title: 화면 숫자 값
    init(title: String) {
        super.init(frame: .zero)
        self.text = "12345"
        self.textColor = .white
        self.textAlignment = .right
        self.font = .systemFont(ofSize: 60, weight: .bold)
    }
    
    required init?(coder: NSCoder) {
        print("이 초기화 메서드는 구현되지 않았습니다.")
        return nil
    }
}
```

**CalculatorViewController.swift**
```
import UIKit
import SnapKit

class CalculatorViewController: UIViewController {
    
    private let resultLabel = LabelComponents(title: "0")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        view.addSubview(resultLabel)
        
        // SnapKit을 사용하여 제약 조건 설정
        resultLabel.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.leading.equalTo(view.snp.leading).inset(30)
            $0.trailing.equalTo(view.snp.trailing).inset(30)
            $0.top.equalTo(view.snp.top).inset(200)
        }
    }
}
```
## Level 2 - 버튼 컴포넌트, 스태뷰 컴포넌트 구현 및 연결
1. View/ButtonComponents, StackViewComponents 파일을 만들고 Button, HorizontalStackView의 UI 컴포넌트 클래스를 만듬
2. 컴포넌트를 View 컨트롤러에 연결해 줌으로 써 Level 2의 요구조건을 만족함.

**ButtonComponents.swift**
```swift
import UIKit
import SnapKit


/// 게산기 버튼 커스텀 UI 컴포넌트
class ButtonComponents: UIButton {
    
    /// 계산기 버튼 컴포넌트 초기화
    /// - Parameters:
    ///   - title: 버튼의 숫자 및 연산자
    ///   - backgroundColor: 버튼 색상
    init(title: String, backgroundColor: UIColor) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        self.frame.size.width = 80
        self.frame.size.height = 80
        // self.layer.cornerRadius = 40
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
```

**StackViewComponents.swift**
```swift
import UIKit
import SnapKit

/// 4개의 버튼을 담는 HorizontalstackView
class HorizontalStackViewComponents: UIStackView {
    
    /// HorizontalStackView 커스텀 UI 컴퍼넌트 초기화
    /// - Parameter addButtton: HorizontalStackView에 넣을 버튼 (왼쪽 부터 들어감)
    init(addButtton: [UIButton]) {
        super.init(frame: .zero)
        self.axis = .horizontal
        self.spacing = 10
        self.distribution = .fillEqually
        
        addButtton.forEach{addArrangedSubview($0)}
        
        self.snp.makeConstraints {
            $0.height.equalTo(80)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("이 초기화 메서드는 구현되지 않았습니다.")
    }
}
```

**CalculatorViewController.swift**
```swift
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
```
