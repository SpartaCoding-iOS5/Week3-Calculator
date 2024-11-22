# 📱 CalculatorApp

This is a project for a basic integer calculator capable of performing four fundamental arithmetic operations: addition, subtraction, multiplication, and division. <br>

The project consists of two versions:
  1. CalculatorApp-Storyboard: A Storyboard-based implementation for designing the calculator’s interface visually (Current Version: 0.0.8).
  2. CalculatorApp-Codebase: A code-based implementation using programmatic UI to build the calculator (Current Version: 0.2.0).


## 📅 Project Scope

| Developer   |  Links                          | Project Timeline      |  
| --------    | --------------------------------- | ---------------------- |  
| DoyleHWorks | [GitHub](https://github.com/DoyleHWorks) <br> [Velog](https://velog.io/@doylehworks/posts?tag=ProjectCalculatorApp)  | 2024-10-14 <br> ~ 2024-10-22 |  

## 📚 Tech Stacks

<div> 
  <img src="https://img.shields.io/badge/Xcode_16.1-147EFB?style=for-the-badge&logo=xcode&logoColor=white">
  <img src="https://img.shields.io/badge/Swift_5-F05138?style=for-the-badge&logo=swift&logoColor=white"> 
  <br>
  <img src="https://img.shields.io/badge/UIKit-2396F3?style=for-the-badge&logo=uikit&logoColor=white">
  <img src="https://img.shields.io/badge/SnapKit-00aeb9?style=for-the-badge&logoColor=white">
  <br>
  <img src="https://img.shields.io/badge/gitkraken-179287?style=for-the-badge&logo=gitkraken&logoColor=white">
  <img src="https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white">
  <br>
</div>

## 🧮 CalculatorApp-Storyboard 0.0.8 (Deprecated)

Implemented the basic UI and button actions using Storyboard.

![image](https://github.com/user-attachments/assets/4c6fba3c-4cf3-40c5-983f-ae5cfc953c04)

## 🛠️ CalculatorApp-Codebase 0.2.0 

### 📂 Folder Organization  
```
CalculatorApp-Codebase/
├── App/
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   ├── Info.plist
│   └── LaunchScreen.storyboard
├── Model/
│   ├── CalculatorLogic.swift
│   └── CalculatorLogicDelegate.swift
├── ViewController/
│   └── ViewController.swift
└── Resources/
    └── Assets.xcassets
```

### 🖼️ App Preview
|![Nov-22-2024 01-47-18](https://github.com/user-attachments/assets/2edc0bcd-15ad-4234-a3e6-61e7f544a915)|![image](https://github.com/user-attachments/assets/09007c81-30b3-427d-849e-81d5ee084491)|![image](https://github.com/user-attachments/assets/1cf328fb-fb97-44d3-b719-76c1ec66f35b)|
|---|---|---|

### 📐 Main Features & Considerations

#### 🎨 User Interface

- **Expression Label**: Displays the current input or result.
- **Buttons**: Includes digits (0-9), basic operators (+, -, ×, ÷), an all-clear (AC) button, and an equals (=) button.

#### 🧮 Calculation Logic

- **Input Handling**: Manages user inputs, ensuring valid sequences and preventing errors such as multiple consecutive operators or leading zeros.
- **Expression Evaluation**: Utilizes NSExpression to evaluate mathematical expressions, converting symbols as needed for accurate computation.

#### 🔍 Input Validation (Exception Handling)

- **Division by Zero**: Prevents invalid operations, such as dividing by zero, by implementing checks before updating the expression.
- **Operator Validation**: Removes redundant or consecutive operators from the expression dynamically, ensuring the calculation logic remains consistent.
- **Zero Handling**: Implements specific rules to handle leading zeros in expressions, such as “0123”, by automatically correcting the input.

#### 🏗️ Architecture: Model + ViewController
- This project imitates the Model-View-Controller (MVC) design pattern:
  - **Model**: The CalculatorLogic class encapsulates all business logic, ensuring the UI remains decoupled from the underlying calculation operations.
  - **ViewController**: Configures and updates UI components like buttons and labels.

#### 🧩 Delegate Pattern
- Implements the delegate pattern to communicate between the CalculatorLogic model and the ViewController:
  - **CalculatorLogicDelegate**: Notifies the controller (ViewController) of changes in the expression or result.

#### ✨ Additional Considerations
- **Efficient Layout Management**: Utilizes SnapKit for concise and readable Auto Layout constraints, simplifying the layout configuration process.
- **Dynamic Font Scaling**: Ensures the text fits within the label, dynamically adjusting the font size for longer expressions.
- **Button Animations**: Buttons feature a press animation that highlights the user’s interaction.
- **Portrait Mode Only**: The app is locked to portrait orientation, ensuring an optimized user experience and layout for calculator functionality.
- **Dark Content Status Bar**: Configured the status bar to use dark content for better visibility and consistency with the app’s design.
- **Left and Right Constraints**: Used left and right constraints instead of leading and trailing, as the calculator does not need to support right-to-left languages, keeping the layout simple and intuitive.

## 📦 How to Install  
1. Clone this repository:  
   ```bash  
   git clone https://github.com/DoyleHWorks/CalculatorApp.git  
   ```  
