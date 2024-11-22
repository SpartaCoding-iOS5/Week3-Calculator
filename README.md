# 🧮 계산기 앱 만들기

### 📑 개요

Swift와 Xcode를 활용해 간단한 계산기 앱을 개발합니다. 이 과제는 Swift 문법을 바탕으로 Playground에서 구현한 로직을 UI와 통합해 실제 앱으로 구현하는 경험을 목표로 합니다.

|개발 기간|인원|개발 언어|개발 환경|
|------|--|------|------|
|24.11.15 - 21|1인|Swift|OS: macOS 15.0.1, IDE: Xcode 16.1|

---

### 📂 코드 파일 구조

- **CalculatorViewController.swift**: 계산기의 주요 기능을 구현한 뷰 컨트롤러 파일입니다.
- **LayoutConstants**: View 및 Layout의 사이즈를 상수값으로 가지고 있습니다.
- **ExtendedColors**: UIColor를 확장하여 필요한 색상을 상수값으로 선언하였습니다.
- **ExtendedFonts**: UIFont를 확장하여 필요한 폰트의 size와 wight를 상수값으로 선언하였습니다.

---

<span style="color: gray">각 Level에 걸려있는 링크를 클릭하면 해당 레벨에서 진행한 PR 페이지로 이동합니다.</span>
### 🌟 필수 구현 기능 (Levels 1-5)

- [Level 1](https://github.com/SpartaCoding-iOS5/Week3-Calculator/pull/8) : `UILabel`을 사용해 수식을 표시하는 UI를 구현합니다.  
- [Level 2](https://github.com/SpartaCoding-iOS5/Week3-Calculator/pull/10) : `UIStackView`를 이용하여 숫자 및 연산 버튼을 구성하는 가로 스택 뷰를 생성합니다.
- [Level 3](https://github.com/SpartaCoding-iOS5/Week3-Calculator/pull/26) : 세로 스택 뷰로 전체 버튼을 배열하여 계산기의 전반적인 UI를 완성합니다.
- [Level 4](https://github.com/SpartaCoding-iOS5/Week3-Calculator/pull/27): 연산 버튼의 색상을 오렌지로 설정해 차별화합니다.
- [Level 5](https://github.com/SpartaCoding-iOS5/Week3-Calculator/pull/36) : 버튼을 원형으로 만들기 위해 `cornerRadius` 속성을 조정합니다.

### 💪 도전 구현 기능 (Levels 6-8)

- [Level 6](https://github.com/SpartaCoding-iOS5/Week3-Calculator/pull/37) : 버튼 클릭 시 라벨에 숫자와 연산 기호가 차례로 표시되도록 구현합니다.
- [Level 7](https://github.com/SpartaCoding-iOS5/Week3-Calculator/pull/38) : `AC` 버튼 클릭 시 초기화되어 기본 값 `0`이 표시되도록 구현합니다.
- [Level 8](https://github.com/SpartaCoding-iOS5/Week3-Calculator/pull/50) : `=` 버튼을 클릭하면 수식이 계산되어 결과가 라벨에 표시되도록 구현합니다.
- [추가 수정 내용](https://github.com/SpartaCoding-iOS5/Week3-Calculator/pull/55) : 구현 기능 외 파일 분리나 줄바꿈 등을 수정하였습니다.

---

### 🪲 트러블 슈팅
- [Xcode : "The project ‘project’ is damaged..."](https://chaehyunp.github.io/blog/?post=%5B20241120%5D_%5BTIL241120%5D_%5BTIL%5D_%5B%5D_%5BXcode+%22The+project+%E2%80%98project%E2%80%99+is+damaged%22%5D_%5B%5D.md)
