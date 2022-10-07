## Calculator II

### 0.목차
1. [소개](#1-소개)
2. [팀원](#2-팀원)
3. [타임라인](#3-타임라인)
4. [시각화된 프로젝트 구조](#4-시각화된-프로젝트-구조)
5. [실행 화면](#5-실행-화면)
6. [트러블 슈팅](#6-트러블-슈팅)
7. [핵심 경험](#7-핵심-경험)

### 1. 소개
#### 계산기 프로젝트
각자의 계산기 프로젝트를 서로에게 코드 설명을 해준 뒤, 의논 후 더 타당한 코드로 병합


### 2. 팀원
| baem | 준호 |
| -------- | -------- |
| <img width="160px" src="https://cdn.discordapp.com/attachments/1007898491630145587/1010091194807750716/11.png">| <img width="180px" src="https://cdn.discordapp.com/attachments/1007898491630145587/1010092756057735169/unknown.png">|

### 3. 타임라인
#### 변경 사항(코드 병합)
- Operator
    - 열거형의 원시 값이 StoryBoard의 글자랑 같은 준호 코드를 사용했습니다.
- CalculatorItemQueue
    - 제너릭 사용과 더블스택이 더 효율적이라 생각해서 준호 코드를 사용했습니다.
- ExpressionParser
    - 연산자와 피연산자를 나누는 기능의 parse 메서드가 좀 더 가독성 있는 baem 코드를 사용했습니다.
- String+split
    - ExpressionParser 코드에 맞게 baem 코드를 사용했습니다.
- Formula
    - 제네릭 타입을 활용한 CalculatorItemQueue를 사용하기 위해 준호 코드를 사용했습니다.
- ViewController(Calculator)
    - ViewController 구현은 둘의 코드가 크게 달랐습니다. 앞의 코드와의 연계성을 위해 준호코드를 사용했습니다.

#### 리펙토링
- 병합에 따른 타입등 여러가지 오류 리펙토링
#### 버그 수정
- 시뮬레이터로 여러가지 케이스들을 확인하면서 버그 수정

### 4. 시각화된 프로젝트 구조

#### 4 Tree

```
├── Calculator
│   ├── Extension
│   │   ├── String+split
│   │   ├── Double+CalculateItem
│   ├── Model
│   │   ├── CalculatorItemQueue.swift
│   │   ├── CalculatorItem.swift
│   │   ├── Operator.swift
│   │   ├── Formula.swift
│   │   ├── Converter.swift
│   │   ├── ExpressionParser.swift
│   │   ├── Calculator.swift
│   │   └── CalculatorError.swift
└── CalculatorTests
    ├── ExpressionParserTests.swift
    ├── CalculatorItemQueueTests.swift
    ├── OperatorTests.swift
    ├── StringTests.swift
    ├── FormulaTests.swift
    └── CalculatorTests.swift
```

### 5. 실행 화면

| ![](https://i.imgur.com/A3EGhYJ.gif) | ![](https://i.imgur.com/Jj6LMTO.gif) | ![](https://i.imgur.com/q8xf1Ly.gif) |
| - | - | - |

### 6. 트러블 슈팅
* static 상수 대신 인스턴스 상수 사용
    * Calculator 구조체 내부에서 사용할 상수를 static 프로퍼티로 선언해서 사용함. 인스턴스 프로퍼티의 기본 값으로 같은 인스턴스 프로퍼티를 사용할 수 없었기 때문에 타입 프로퍼티를 사용함. Calculator 외부에서는 필요하지 않기 때문에 네임스페이스를 사용하지 않음.
    * 이니셜라이저에서 인스턴스 프로퍼티의 기본 값을 할당해주는 방법을 사용하면 타입 프로퍼티 대신 인스턴스 프로퍼티를 사용할 수 있다는 걸 확인하고 static 상수 대신 인스턴스 상수를 사용하도록 수정함.
    ~~~swift
        struct Calculator {
            // 수정 전
            static let defaultOperand: String = "0"
            static let defaultOperator: String = ""
            static let negativeSymbol: String = "-"
            private(set) var currentOperand: String = defaultOperand
            private(set) var currentOperator: String = defaultOperator
            
            // 수정 후
            private let defaultOperand: String = "0"
            private let defaultOperator: String = ""
            private let negativeSymbol: String = "-"
            private(set) var currentOperand: String
            private(set) var currentOperator: String

            init() {
                currentOperand = defaultOperand
                currentOperator = defaultOperator
            }
    ~~~
* extension 대신 객체의 메서드 사용
    * extension으로 메서드를 추가하면 전역에서 사용할 수 있어서 편리하지만, 필요한  인스턴스를 만들어 메서드를 사용하는 게 더 좋은 구조라고 생각해서 구조체를 만들어서 기능을 구현함.
    ~~~swift
        // 수정 전
        extension Double {
            static func convertStringContainingCommaToDouble(_ input: String) -> Double? {

        // 수정 후
        struct Converter {
            func convertStringContainingCommaToDouble(_ input: String) -> Double? {
    ~~~

### 7. 핵심 경험
- UML을 기반으로 한 코드병합
- 협업 중 스토리보드 병합
- 기존 코드의 리팩터링
- 단위 테스트를 통해 리팩터링 과정의 코드 오류를 최소화
- 제네릭을 활용하여 범용적인 타입 구현
