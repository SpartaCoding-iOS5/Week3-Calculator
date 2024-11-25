# 계산기 만들기 과제 (Week 3-4)

Swift와 Xcode를 활용해 간단한 계산기 앱을 개발합니다. 이 과제는 Swift 문법을 바탕으로 Playground에서 구현한 로직을 UI와 통합해 실제 앱으로 구현하는 경험을 목표로 합니다.

## 📝 협업 규칙

### Pull Request 작성 규칙
1. **형식**: `[레벨] 작업 내용 - 팀원 이름`  
   - 예: `[Lv_1] 라벨 UI 구현 - 홍길동`
2. **작업 세부 사항**: 구현한 주요 기능과 로직에 대한 요약을 작성합니다.

### 레포지토리 설정 및 브랜치 관리
1. **Fork로 가져오기**: 각 팀원은 레포지토리를 Fork하여 자신의 개인 레포지토리로 가져옵니다.
2. **브랜치 생성**: Fork한 개인 레포지토리에서 각자의 이름을 딴 브랜치를 생성합니다.
3. **Pull Request**: 각자의 브랜치에서 Pull Request를 생성해 코드 리뷰를 요청합니다. 모든 팀원이 Pull Request에 코멘트를 추가하여 피드백을 제공합니다.
4. **수정 및 Merge**: 피드백을 반영하여 수정한 후, 팀원들의 동의를 얻어 merge를 진행합니다.

-> 풀 리퀘스트를 한 후 Merge하지 않은채 커밋-푸시를 하면 기존 풀 리퀘스트에 들어가기 때문에 그럴 경우 새로운 브랜치를 만듭니다. (ex. Jamong-Lv1, Jamong-Lv2 ...)

## 📂 코드 파일 구조

- **CalculatorApp**: 프로젝트의 메인 진입점이며, SwiftUI로 구현된 인터페이스를 통해 계산기 앱이 실행됩니다.
  - **Main.storyboard**: 앱의 기본 UI 구성과 레이아웃을 설정하는 스토리보드 파일입니다.
  - **CalculatorViewController.swift**: 계산기의 주요 기능을 구현한 뷰 컨트롤러 파일입니다.
  - **Extensions**: UIView와 UIButton에 필요한 공통 설정 및 기능 확장을 모아둔 파일입니다.
  - **Utilities**: 계산 로직을 처리하는 헬퍼 메서드를 포함한 파일로, Swift의 `NSExpression`을 활용한 수식 계산 메서드가 구현되어 있습니다.

## 🌟 필수 구현 기능 (Levels 1-5)

- **Level 1**: `UILabel`을 사용해 수식을 표시하는 UI를 구현합니다.  
- **Level 2**: `UIStackView`를 이용하여 숫자 및 연산 버튼을 구성하는 가로 스택 뷰를 생성합니다.
- **Level 3**: 세로 스택 뷰로 전체 버튼을 배열하여 계산기의 전반적인 UI를 완성합니다.
- **Level 4**: 연산 버튼의 색상을 오렌지로 설정해 차별화합니다.
- **Level 5**: 버튼을 원형으로 만들기 위해 `cornerRadius` 속성을 조정합니다.

## 💪 도전 구현 기능 (Levels 6-8)

- **Level 6**: 버튼 클릭 시 라벨에 숫자와 연산 기호가 차례로 표시되도록 구현합니다.
- **Level 7**: `AC` 버튼 클릭 시 초기화되어 기본 값 `0`이 표시되도록 구현합니다.
- **Level 8**: `=` 버튼을 클릭하면 수식이 계산되어 결과가 라벨에 표시되도록 구현합니다.

## 📜 구현 가이드

- **CalculatorViewController.swift**  
  각 레벨에 따라 구현된 기능을 `CalculatorViewController.swift` 파일에 추가하여 기본 UI와 로직을 통합합니다.

```swift
func calculate(expression: String) -> Int? {
    let expression = NSExpression(format: expression)
    if let result = expression.expressionValue(with: nil, context: nil) as? Int {
        return result
    } else {
        return nil
    }
}
```

- **버튼 및 라벨 설정**  
  - 버튼의 색상, 크기, 모양을 설정하고 라벨에 표시될 수식을 업데이트합니다.

---

## 🎯 목표

- **기한**: 11월 22일 (금) 낮 12시까지 제출
- **제출물**: 개인 과제 결과물을 GitHub에 올리고 링크를 제출합니다.

## 🔗 참고 링크
- [Swift 기초 및 iOS 개발 환경 설정](https://developer.apple.com/swift/)
- [Auto Layout 사용 가이드](https://developer.apple.com/documentation/uikit/auto_layout/)

---

이번 과제를 통해 UI와 로직의 통합 구현을 연습하고, 협업을 통한 코드 리뷰와 피드백을 통해 더 나은 코드 품질을 만들어 봅시다.
