# CalculatorApp
## Codebase
### Folder Organization
``` 
CalculatorApp-Codebase/
│
├── App/
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   ├── Info.plist
│   └── LaunchScreen.storyboard
│
├── Model/
│   └── CalculatorLogic.swift
│
├── View/
│   ├── CalculatorButton.swift
│   └── ExpressionLabel.swift
│
├── Controller/
│   └── ViewController.swift
│
└── Resources/
    └── Assets.xcassets
```

---

## Codebase.Ver.0.0.8
- CalculatorApp-Storyboard Ver.0.0.8 (Lv.8) 파일이 포함됨
- CalculatorApp-Codebase Ver.0.0.8 (Lv.8)

### CalculatorApp-Storyboard Ver.0.0.8 (Lv.8)
숫자와 연산자 버튼을 누를 때마다 `expression` 문자열에 추가하고, 이를 화면(expressionLabel)에 표시한다.
"=" 버튼을 누르면 수식을 계산하여 결과를 표시하며, "AC" 버튼으로 초기화한다. 
곱셈(`×`)과 나눗셈(`÷`)은 실제 계산을 위해 `*`, `/`로 변환된다.

![image](https://github.com/user-attachments/assets/4c6fba3c-4cf3-40c5-983f-ae5cfc953c04)

### CalculatorApp-Codebase Ver.0.0.8 (Lv.8)

#### �️ **열거형을 활용한 버튼 관리 (`CalculatorButton`)**
- `enum CalculatorButton`으로 버튼의 상태를 정의:
  - **숫자 버튼**과 **연산자 버튼**을 동일한 열거형으로 관리.
  - 각 버튼의 **타이틀, 배경색** 등을 프로퍼티로 제공.
  - **`button` 프로퍼티**를 통해 버튼 인스턴스를 생성하여 일관성 있는 설정 제공.
  - **객체 지향 원칙 활용**: 중복되는 버튼 설정(프레임, 색상, 텍스트 스타일)을 열거형 내부에서 한 번만 정의하여 중복 코드 최소화.

#### � **버튼 액션 처리의 통합적 구현**
- **모든 버튼의 액션을 `buttonAction` 메서드로 통합**:
  - `UIButton`의 **타이틀 기반으로 동작 결정** (`titleLabel?.text`).
  - **숫자와 연산자 구분 없이 동일한 메서드**에서 처리.
  - `switch` 문을 활용하여 각 버튼의 기능(숫자 추가, 연산자 추가, 초기화, 계산) 실행.
  - **선언형 접근법**: 버튼마다 개별 메서드를 만드는 대신, 액션 메서드를 하나로 통합하여 유지보수성 강화.

#### �️ **`didSet`를 활용한 표현식 업데이트**
- **`expression` 프로퍼티에 `didSet` 사용**:
  - **상태 변화 감지**: `expression`이 변경될 때마다 라벨에 자동으로 반영.
  - **숫자 입력 예외 처리**: `0`으로 시작하는 표현식을 자동 정리(두 번째 문자가 숫자일 경우 첫 번째 `0` 제거).

#### � **동적 레이아웃 설정 (`SnapKit`)**
- **Stack View**:
  - 수직 스택(superStack)을 상위 컨테이너로 두고, 내부에 4개의 **수평 스택**을 배치.
  - 각 수평 스택에 버튼 4개씩 배치하여 계산기의 숫자 및 연산자 버튼을 균일하게 정렬.
- **SnapKit의 제약 조건 사용**:
  - **수평 스택 간 간격** 및 각 버튼의 크기를 동적으로 조정.
  - 화면 크기에 따라 적절한 버튼 배치가 자동 조정되도록 설정.

#### � **`NSExpression`을 활용한 수식 평가**
- 수식 계산은 `NSExpression`을 활용하여 문자열 수식을 평가:
  - 입력된 수식을 단순히 텍스트가 아닌 **실제 수식으로 변환**하여 계산.
  - **커스텀 기호(`×`, `÷`)를 표준 수학 기호(`*`, `/`)로 변환**하는 전처리 함수(`changeMathSymbols`) 포함.
  - `NSExpression`의 내장 계산 기능을 사용하여 **간결하고 안전한 계산 로직** 구현.
