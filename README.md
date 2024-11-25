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

## Level 3 - 버튼 컴포넌트, 스태뷰 컴포넌트 구현 및 연결
1. View/StackViewComponents 파일에 VerticalStackView의 UI 컴포넌트 클래스를 만듬
2. 버튼들을 추가적으로 만들고 HorizontalstackView들을 추가적으로 만들어 VerticalStackView에 넣어줌.
3. ViewController에 연결해 줌으로 써 Level 3의 요구조건을 만족함.

**StackViewComponents.swift**
``` swift
import UIKit
import SnapKit

/// 4개의 버튼을 담는 HorizontalstackView
class HorizontalStackViewComponents: UIStackView {
    ...
}

/// 버튼들이 담긴 4개의 HorizontalStackView를 담는 VerticalStackView
class VerticalStackViewComponents: UIStackView {
    
    /// VerticalStackView 커스텀 UI 컴포넌트 초기화
    /// - Parameter addStackView: 버튼 모음 HorizontalStackView (왼쪽 부터 들어감)
    init(addStackView: [UIStackView]) {
        super.init(frame: .zero)
        self.axis = .vertical
        self.spacing = 10
        self.distribution = .fillEqually
        self.snp.makeConstraints {
            $0.width.equalTo(350)
        }
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
```

**CalculatorViewController.swift**
```swift
/// 계산기 최상단 화면 (RootView)
class CalculatorViewController: UIViewController {
    
    private let resultLabel = LabelComponents(title: "0")
    private let button7 = ButtonComponents(title: "7", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let button8 = ButtonComponents(title: "8", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let button9 = ButtonComponents(title: "9", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let plusButton = ButtonComponents(title: "+", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let button4 = ButtonComponents(title: "4", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let button5 = ButtonComponents(title: "5", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let button6 = ButtonComponents(title: "6", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let minusButton = ButtonComponents(title: "-", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let button1 = ButtonComponents(title: "1", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let button2 = ButtonComponents(title: "2", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let button3 = ButtonComponents(title: "3", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let timesButton = ButtonComponents(title: "*", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let acButton = ButtonComponents(title: "AC", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let button0 = ButtonComponents(title: "0", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let equalButton = ButtonComponents(title: "=", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let divisionButton = ButtonComponents(title: "/", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    /// UI 연결 및 조건 설정
    private func setupUI() {
        view.backgroundColor = .black
        
        let plusHorizontalStackView = HorizontalStackViewComponents(addButtton: [button7, button8, button9, plusButton])
        let minusHorizontalStackView = HorizontalStackViewComponents(addButtton: [button4, button5, button6, minusButton])
        let timesHorizontalStackView = HorizontalStackViewComponents(addButtton: [button1, button2, button3, timesButton])
        let divisionHorizontalStackView = HorizontalStackViewComponents(addButtton: [acButton, button0, equalButton, divisionButton])
        let verticalStackView = VerticalStackViewComponents(addStackView: [plusHorizontalStackView, minusHorizontalStackView, timesHorizontalStackView, divisionHorizontalStackView])
        
        [plusHorizontalStackView, minusHorizontalStackView, timesHorizontalStackView, divisionHorizontalStackView]
            .forEach { verticalStackView.addSubview($0) }
        
        [resultLabel, verticalStackView]
            .forEach { view.addSubview($0) }
        
        // SnapKit을 사용하여 제약 조건 설정
        resultLabel.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.leading.equalTo(view.snp.leading).inset(30)
            $0.trailing.equalTo(view.snp.trailing).inset(30)
            $0.top.equalTo(view.snp.top).inset(200)
        }

        verticalStackView.snp.makeConstraints {
            $0.bottom.equalTo(view.snp.bottom).offset(10)
            $0.centerX.equalTo(view.snp.centerX)
        }
    }
}
```

### 트러블 슈팅
버튼들이 보이지 않은 현상이 발생하여 디버그 Hierarchy를 확인해 본 결과 VerticalStackView에서 Height가 0으로 확인됨 따라서 제약조건에서 Height가 없는 것을 확인 하여 `topAnchor` 또는 `Height`를 주려고 함.

| 화면                     | View Hierarchy                                    | Size Inspector                                |
|--------------------------|--------------------------------------------------|-----------------------------------------------|
| ![화면](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FeAQMmN%2FbtsKKxy1fDP%2FDWlSdaOdflEIiKZafvxIi0%2Fimg.png) | ![View Hierarchy](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FsOIHp%2FbtsKKaYppTO%2F3dTcCcwf8ksiWhdRKbmvOk%2Fimg.png) | ![Size Inspector](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FclzAMQ%2FbtsKLrx1EH4%2FX9rE6JSQoCFI4KOEQx6XXk%2Fimg.png) |

또한 HorizontalStackView끼리의 충돌도 예상되어 제약조건을 주었다.

**제약 조건 변경 - CalculatorViewController.swift**
```swift
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

plusHorizontalStackView.snp.makeConstraints {
    $0.top.equalTo(verticalStackView.snp.top).offset(10)
    $0.leading.equalTo(verticalStackView.snp.leading)
    $0.trailing.equalTo(verticalStackView.snp.trailing)
}
minusHorizontalStackView.snp.makeConstraints {
    $0.top.equalTo(plusHorizontalStackView.snp.bottom).offset(10)
    $0.leading.equalTo(verticalStackView.snp.leading)
    $0.trailing.equalTo(verticalStackView.snp.trailing)
}
timesHorizontalStackView.snp.makeConstraints {
    $0.top.equalTo(minusHorizontalStackView.snp.bottom).offset(10)
    $0.leading.equalTo(verticalStackView.snp.leading)
    $0.trailing.equalTo(verticalStackView.snp.trailing)
}
divisionHorizontalStackView.snp.makeConstraints {
    $0.top.equalTo(timesHorizontalStackView.snp.bottom).offset(10)
    $0.leading.equalTo(verticalStackView.snp.leading)
    $0.trailing.equalTo(verticalStackView.snp.trailing)
}
```

## 고민할 부분
많은 UIButton인 인스턴스들이 지저분하여 구조 개선을 하려고 한다.
1. title을 가지는 배열로 가져 반복하여 선언하는 방식
2. 배열안에 title과 backgroundcolor를 가지는 딕셔너리 방식
해당 방식으로 했을 때 Action 함수는 tilte을 비교하여 Action함수를 주는 방법으로 변경하고자 한다.

Level 4 - 연산 버튼 색상 변경 및 Button 구조 개선
먼저 연산 버튼 색상을 담아줄 Utilities/Constants.swift 파일을 만들어 주고 UIColor 값을 구조체로 저장한다. 그리고 버튼 인스턴스를 리스트로 생성해 주려고 한다. 

**Constants.swift**
```swift
import UIKit

/// 색상을 담는 구조체
struct ColorList {
    static let darkGray = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
    static let orange = UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 1.0)
}
```

**CalculatorViewController.swift 변경전**
```swift
class CalculatorViewController: UIViewController {
    
    private let resultLabel = LabelComponents(title: "0")
    private let button7 = ButtonComponents(title: "7", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let button8 = ButtonComponents(title: "8", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let button9 = ButtonComponents(title: "9", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let plusButton = ButtonComponents(title: "+", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let button4 = ButtonComponents(title: "4", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let button5 = ButtonComponents(title: "5", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let button6 = ButtonComponents(title: "6", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let minusButton = ButtonComponents(title: "-", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let button1 = ButtonComponents(title: "1", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let button2 = ButtonComponents(title: "2", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let button3 = ButtonComponents(title: "3", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let timesButton = ButtonComponents(title: "*", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let acButton = ButtonComponents(title: "AC", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let button0 = ButtonComponents(title: "0", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let equalButton = ButtonComponents(title: "=", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))
    private let divisionButton = ButtonComponents(title: "/", backgroundColor: UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0))

    ...
}
```

**CalculatorViewController.swift 변경후**
```swift
class CalculatorViewController: UIViewController {
    
    private let resultLabel = LabelComponents(title: "0")
    
    ...

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
    }
}
```

**ButtonData.swfit** 
버튼 데이터를 저장할 파일을 하나 생성하여 버튼의 데이터를 이중 배열과 튜플을 이용하여 저장하였다. (이유: Button에 들어가는 데이터가 title과 BackgroundColor로 2개여서 튜플을 이용했고 버튼 4개에 하나의 HorizontalStackView를 가지기 때문이다.)
```swift
import UIKit

/// 계산기 버튼 데이터
struct ButtonData {
    static let buttonData: [[(title: String, color: UIColor)]] = [
        [("7", ColorList.darkGray), ("8", ColorList.darkGray), ("9", ColorList.darkGray), ("+", ColorList.darkGray)],
        [("4", ColorList.darkGray), ("5", ColorList.darkGray), ("6", ColorList.darkGray), ("-", ColorList.darkGray)],
        [("1", ColorList.darkGray), ("2", ColorList.darkGray), ("3", ColorList.darkGray), ("*", ColorList.darkGray)],
        [("AC", ColorList.orange), ("0", ColorList.darkGray), ("=", ColorList.darkGray), ("/", ColorList.darkGray)]
    ]
}
```

**StackViewComponents.swift** 함수 추가 생성
버튼 데이터를 받아 버튼 컴포넌트를 만들고 만든 버튼을 HorizontalStackView를 만들어줘야하기에
createHorizontalStackView를 만들어 주었다.

```swift
import UIKit
import SnapKit

/// 4개의 버튼을 담는 HorizontalstackView
public class HorizontalStackViewComponents: UIStackView {
    ...
}


/// 버튼들이 담긴 4개의 HorizontalStackView를 담는 VerticalStackView
public class VerticalStackViewComponents: UIStackView {
    ...
}

/// HorizontalStackView 생성 및 버튼 구성 함수
/// - Parameter buttonData: ButtonData를 받음(이중배열-튜플)
/// - Returns: 버튼이 들어간 HorizontalStackView를 반환
func createHorizontalStackView(form buttonData: [[(title: String, color: UIColor)]]) -> [HorizontalStackViewComponents] {
    var horizontalStackView: [HorizontalStackViewComponents] = []
    
    for data in buttonData {
        // 버튼 배열 생성
        var buttons: [ButtonComponents] = []
        
        for (title, color) in data {
            let button = ButtonComponents(title: title, backgroundColor: color)
            buttons.append(button)
        }
        
        let stackView = HorizontalStackViewComponents(addButtton: buttons)
        horizontalStackView.append(stackView)
    }
    
    return horizontalStackView
}
```

### 트러블 슈팅
버튼들이 보이지 않은 현상이 발생하여 디버그 Hierarchy를 확인해 본 결과 VerticalStackView에 HorizontalStackView가 없다는 것을 확인했다. 해당 트러블은 VerticalStackView에 넣어주는 로직이 빠져있다고 추측하여 addSubview가 확인했고, 없는 것을 확인하여 넣어주었다.

| 화면                                                           | View Hierarchy                                               | Size Inspector                                               |
|--------------------------------------------------------------|--------------------------------------------------------------|--------------------------------------------------------------|
| ![화면](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FeAQMmN%2FbtsKKxy1fDP%2FDWlSdaOdflEIiKZafvxIi0%2Fimg.png) | ![R1280x0](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FcPFG9B%2FbtsKMjGQAtB%2FM1yl9ljueCdGaKK5SIgb7K%2Fimg.png) | ![R1280x0](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FRgBr3%2FbtsKMmJ6QTa%2FXWpqzkek5KXcopukTQ4iA0%2Fimg.png) |

## Level 5 - 버튼 원형 설정
Level 5의 요구사항대로 버튼 컴포넌트에서 conerRadius = 40을 주어 원형이 될 수 있도록 설정했다.
**View/ButtonComponents.swift**
```swift
import UIKit
import SnapKit

/// 게산기 버튼 커스텀 UI 컴포넌트
public class ButtonComponents: UIButton {
    
    /// 계산기 버튼 컴포넌트 초기화
    /// - Parameters:
    ///   - title: 버튼의 숫자 및 연산자
    ///   - backgroundColor: 버튼 색상
    init(title: String, backgroundColor: UIColor) {
        ...
        self.layer.cornerRadius = 40
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
```

## Level 6 -  버튼 클릭 시 라벨에 표시 설정
Level 6부터는 숫자 버튼이 입력되었을때 라벨에 표시되어야하는 요구사항이였다.
따라서 해당하는 버튼은 `title`을 확인하여 String값을 붙여주는 로직을 짜주었다.

먼저 들어가는 프로퍼티를 모델로 정의해주었고 ButtonTapped의 파일을 만들어서 눌렸을때의 기능을 하는 함수를 모아두고자 만들고 작성하였다.

**Model/CalculatorModel.swift**
```swift
import Foundation

// 계산기 상태를 관리하는 구조체
struct CalculatorModel {
    var currentInput: String = "0"  // 현재 입력 중인 값
    var previousValue: Int?         // 이전 계산 값
    var currentOperator: String?    // 현재 연산자
}
```

**Controller/ButtonTappedAction.swift**
```swift
import UIKit

/// 버튼 액션 관리 클래스
class ButtonTappedAction {
    
    private var calculatorModel: CalculatorModel
    private let resultLabel: LabelComponents
    
    init(calculatorModel: CalculatorModel, resultLabel: LabelComponents) {
        self.calculatorModel = calculatorModel
        self.resultLabel = resultLabel
    }

    /// 숫자 버튼이 눌렀을 때 호출
    func numberButtonTapped(number: String) {
        if calculatorModel.currentInput == "0" {
            calculatorModel.currentInput = number
        } else {
            calculatorModel.currentInput += number
        }
        
        // 모델 업데이트 후 라벨 변경
        resultLabel.text = calculatorModel.currentInput
    }
}

```

함수의 로직은 현재 라벨의 값이 0이면 입력받은 값을 띄워주고 아니면 현재 라벨의 값에 붙여줘서 띄워준다.

**Controller/CalculatorViewController.swift** 연결하기
```swift
/// 계산기 최상단 화면 (RootView)
class CalculatorViewController: UIViewController {
    
    ...
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
        ...
        // 버튼 액션 연결
        for stackView in horizontalStackViews {
            for button in stackView.arrangedSubviews {
                if let button = button as? UIButton {
                    button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                }
            }
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let title = sender.title(for: .normal) else { return }
        
        if let num = Int(title) {
            // 숫자 버튼인지 확인 후 기능
            buttonTappedAction?.numberButtonTapped(number: title)
        } else {
            // 연산자 버튼 구현
            print("연산자")
        }
    }
}
```

Model과 ButtonTappedAction을 연결시켜주고 해당하는 버튼이 들어갔을때 addTarget되게 하였다.

## Level 7 버튼 구현 중

**Model/CalculatorModel.swift** 
```swift
import Foundation

// 계산기 상태를 관리하는 구조체
struct CalculatorModel {
    var currentInput: String = "0"  // 현재 입력 중인 값
    var previousValue: Int?         // 이전 계산 값
    var currentOperator: String?    // 현재 연산자
    
    mutating func clear() {
        currentInput = "0"
        previousValue = nil
        currentOperator = nil
    }
}
```

**Controller/ButtonTappedAction.swift**
해당 기능 후 라벨 변경하는 코드가 똑같기 때문에 결과값의 라벨을 업데이트 하는 함수를 따로 빼서 연결했다.
```swift
import UIKit

/// 버튼 액션 관리 클래스
class ButtonTappedAction {
    
    private var calculatorModel: CalculatorModel
    private let resultLabel: LabelComponents
    
    init(calculatorModel: CalculatorModel, resultLabel: LabelComponents) {
        self.calculatorModel = calculatorModel
        self.resultLabel = resultLabel
    }

    /// 숫자 버튼 입력 기능
    func numberButtonTapped(number: String) {
        if calculatorModel.currentInput == "0" {
            calculatorModel.currentInput = number
        } else {
            calculatorModel.currentInput += number
        }
        updateLabel()
    }
    
    /// 초기화 기능
    func clearAll() {
        calculatorModel.clear()
        updateLabel()
    }
    
    /// 라벨 업데이트
    func updateLabel() {
        resultLabel.text = calculatorModel.currentInput
    }
}
```

**Controller/CalculatorViewController.swift** - buttonTapped 수
```swift
import UIKit
import SnapKit


/// 계산기 최상단 화면 (RootView)
class CalculatorViewController: UIViewController {
    ...
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
        } else {
            print("연산자")
        }
    }
}
```

## Level 8 - "=" 버튼 클릭 시 계산 수행
사칙연산자가 눌렸을 때는 라벨에 추가되고 “=“가 눌렸을 때 결과값을 출력하는 기능을 구현해야한다.

따라서 아래과 같이 기능을 구현하려고 한다. (Model에 정의)
1. 연산자가 눌렸을 때 해당 값을 저장하는 (previousValue) 프로퍼티를 만들어준다.
2. 연산자가 눌렸을때 현재 연산자 프로퍼티에 저장을하고 다음 연산자가 눌렸을 때 계산한 값이 이전 값(previousValue) 프로퍼티에 넣어준다.
3. 이 과정이 반복되고 “=“ 버튼이 눌렸을 때 결과값을 나타낸다.

**Model/CalculatorModel.swift**
```swift
/// 계산기 상태를 관리하는 구조체
struct CalculatorModel {
    var currentInput: String = "0"  // 현재 입력 중인 값
    var previousValue: Int?         // 이전 계산 값
    var currentOperator: String?    // 현재 연산자
    
    /// AC버튼으로 초기화
    mutating func clear() {
        ...
    }
    
    /// 결과값 계산
    mutating func calculateResult() -> String? {
        // 옵셔널 해제 과정
        guard let currnetValuse = Int(currentInput),
              let previousValue = previousValue,
              let operation = currentOperator else {
            print("이전 값, 입력값, 현재 연산자 중 없는게 있음")
            return nil
        }
        
        let result: Int
        
        switch operation {
        case "+":
            result = previousValue + currnetValuse
        case "-":
            result = previousValue - currnetValuse
        case "*":
            result = previousValue * currnetValuse
        case "/":
            result = previousValue / currnetValuse
        default:
            return nil
        }
        
        self.previousValue = result
        self.currentOperator = nil
        self.currentInput = "\(result)"
        return "\(result)"
    }
    
    /// 연산자 처리
    mutating func handleOperator(_ sendOperator: String) {
        if let currentValue = Int(currentInput) {
            if previousValue == nil {
                // 이전 값이 없으면 현재 값을 이전 값으로 저장
                previousValue = currentValue
            } else if let operation = currentOperator {
                // 이전 연산자 계산 수행
                let result = calculateResult()
            }
        }
        
        // 연산자 저장 및 입력 초기화
        currentOperator = sendOperator
        currentInput = "0"
    }
}
```

**func calculateResult()** 함수는 
1. guard문으로 현재 값, 이전 계산 값,  현재 연산자가 없으면 nil을 반환하여 계산하지 않고 만족하면 계산한다.
2. 계산할때 연산자에 맞게 연산한다.
3. 연산 된 후 이전값에 결과 값을 저장하고, 연산자는 nil, 현재 입력값에도 결과값을 주어 화면에 결과값이 나오는 함수를 만들었습니다.

**func handleOperator()** 함수는
1. 이전 값이 없으면 현재 값을 이전 값으로 저장한다.
2. 이전 연산자 계산을 수행한다.
3. 새로 받은 연산자를 이전 연산자 변수에 저장한다.
4. 현재 입력받은 값은 없앤다.

**CalculatorViewController.swift** 수정
```swift
import UIKit
import SnapKit


/// 계산기 최상단 화면 (RootView)
class CalculatorViewController: UIViewController {
        ...
    }
    
    
    /// UI 연결 및 조건 설정
    private func setupUI() {
        ...
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
```

## 예외 상황 시나리오 설정하기
1. 0 으로 나누었을 때 crashed

**Model/CalculatorModel.swift** 수정
```swift
import Foundation

/// 계산기 상태를 관리하는 구조체
struct CalculatorModel {
    ...
        let result: Int
        
        switch operation {
        case "+":
            result = previousValue + currnetValuse
        case "-":
            result = previousValue - currnetValuse
        case "*":
            result = previousValue * currnetValuse
        case "/":
            // 예외처리 : 나누는 값이 0이면 0
            result = currnetValuse == 0 ? 0 : previousValue / currnetValuse
        default:
            return nil
        }
        
        self.previousValue = result
        self.currentOperator = nil
        self.currentInput = "\(result)"
        return "\(result)"
    }
}
```
