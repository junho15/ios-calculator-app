## iOS 커리어 스타터 캠프

### 1. 제목: 계산기

### 2. 소개
* 숫자패드와 기호를 이용해 사용자가 연산을 입력하면 연산 결과를 보여주는 앱.

### 3. 팀원
* 준호

### 4. 타임라인: 시간 순으로 프로젝트의 주요 진행 척도를 표시
| 날짜 | 주요 진행 내용
|---|---|
|9/20| STEP 1 구현 ( Test Target 추가 및 CalculatorItemQueue, CalculateItem 구현 )
|9/21| STEP 1 수정 ( 더블 스택 방식으로 Queue 수정, 테스트 케이스 추가 등 )
|9/23| STEP 2 구현 ( Operator, Formula, ExpressionParser 구현)
|9/27| STEP 2 수정 ( 가독성을 위해 코드 리팩토링 )
|9/30| STEP 3 구현 ( ViewController 기능 구현 )

### 5. 시각화된 프로젝트 구조(다이어그램 등)
![스크린샷 2022-09-23 오후 5 49 56](https://user-images.githubusercontent.com/48776496/191929145-0bf0b965-9de8-4181-8dbe-0bcd00e8c587.png)

### 6. 실행 화면(기능 설명)

### 7. 트러블 슈팅
- LinkedList & Double Stack
    * Array의 append 메서드는 O(1)의 복잡도이지만, removeFirst 메서드는 O(n)의 복잡도임. LinkedList를 사용하면 삽입, 삭제에 O(1)이 소요됨.
    * 위와 같은 이유로 queue에는 LinkedList가 적합하다 생각하여 LinkedList를 사용하여 Queue 구현함.
    ~~~swift
        class CalculatorItemQueue<T: CalculateItem> {
            class LinkedList<T> {
                class Node<T> {
                    var value: T
                    var next: Node?

                    init(value: T, next: Node? = nil) {
                        self.value = value
                        self.next = next
                    }
                }

                private var head: Node<T>?
                private var tail: Node<T>?
                private var isEmpty {
                    return tail == nil
                }

                func addLast(_ element: T) {
                    let newNode = Node(value: element)
                    if isEmpty {
                        tail = newNode
                        head = tail
                    } else {
                        last.next = newNode
                        tail = newNode
                }

                func removeFirst() -> T? {
                    if let first = head is nil {
                        head = first.next
                        return first
                    } else {
                        return nil
                    }
                }
            }

            private var queue: LinkedList<T> = LinkedList()

            func enqueue(_ element: T) {
                queue.addLast(element)
            }

            func dequeue() -> T? {
                return queue.removeFirst()
            }
        }
    ~~~
    * array를 사용하고 O(1)의 복잡도를 가진 메서드를 추가하는 방법이 있다고 리뷰어에게 코멘트를 받음.
    * LinkedList 대신 더블 스택을 사용해서 Queue를 다시 구현함.
    * LinkedList와 비교하여 코드 길이가 많이 줄어듬.
    * dequeue() 에서 사용한 reversed(), popLast() 모두 O(1)의 복잡도이기 때문에 성능에서도 큰 차이가 없음.
    ~~~swift
        class CalculatorItemQueue<T: CalculateItem> {
            private var enqueueStack: Array<T> = []
            private var dequeueStack: Array<T> = []
            
            func enqueue(_ element: T) {
                enqueueStack.append(element)
            }

            func dequeue() -> T? {
                if dequeueStack.isEmpty {
                    dequeueStack = enqueueStack.reversed()
                    enqueueStack.removeAll()
                }
                return dequeueStack.popLast()
            }
        }
    ~~~

- 가독성
    * if 문의 조건으로 Bool 타입의 상수를 사용하면, 상수의 이름으로 어떤 조건인지 이해하기 쉬움.
   ~~~swift
       // 수정 전
       var inputRemovedNegativeSignal: String = input
       if input.hasPrefix("-") {
           inputRemovedNegativeSignal.removeFirst()
       }

       // 수정 후 ( 조건에 상수 사용 )
       var inputRemovedFirstNegative: String = input
       let isFirstLetterNegative: Bool = inputRemovedFirstNegative.hasPrefix("-")
       if isFirstLetterNegative {
           inputRemovedFirstNegative.removeFirst()
       }
   ~~~

    * 함수 내부의 특정 기능을 분리하여 새로운 함수를 만들고, 그 함수를 호출해서 사용하면 어떤 기능을 하고 있는 지를 이해하기 쉬움.
   ~~~swift
       // 수정 전
       Operator.allCases.forEach {
           inputRemovedNegativeSignal = inputRemovedNegativeSignal.replacingOccurrences(of: "\($0.rawValue)-", with: "\($0.rawValue)")
       }

       // 수정 후 ( 기능 분리 )
       let inputRemovedNegative: String = removeNegative(from: inputRemovedFirstNegative)

       // 수정 후 ( 기능 분리 )
       private static func removeNegative(from input: String) -> String {
           var inputRemovedNegative: String = input
           Operator.allCases.forEach {
               inputRemovedNegative = inputRemovedNegative.replacingOccurrences(of: "\($0.rawValue)-", with: "\($0.rawValue)")
           }
           return inputRemovedNegative
       }

   ~~~

8. 참고 링크
* [Array append](https://developer.apple.com/documentation/swift/array/append(_:)-1ytnt)
* [Array removefirst](https://developer.apple.com/documentation/swift/array/removefirst())
* [Array reversed](https://developer.apple.com/documentation/swift/array/reversed())
* [Array popLast](https://developer.apple.com/documentation/swift/array/poplast())
