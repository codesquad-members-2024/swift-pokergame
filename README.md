# swift-pokergame
KAI - 두번째 iOS 프로젝트 

<details>
<summary>게임보드 만들기</summary>

## 🎯주요 작업

- [x]  코드로 화면 크기에 따라 뷰를 균등하게 분리해서 생성
- [x]  이미지 뷰에 content mode 학습하고 원하는 비율로 표시하기 → 1:1.27 비율 균등하게 7등분
- [x]  이미지를 배경에 패턴으로 추가하기

## 📚학습 키워드

### **StackView**
<img width="727" alt="스크린샷 2024-03-11 오전 10 18 13" src="https://github.com/codesquad-members-2024/swift-photoframe/assets/104732020/2073ccc0-fe4d-401e-99ef-bedb1ecd90b8">

2015년 iOS 9에서 처음으로 등장했다.

Stack View는 그 자체로 내용을 가지진 않고
UI 요소를 가로 혹은 세로로 묶어주는 역할을 한다.

### **StatusBar : 상태창**

색상변경 방법

1. Project → General → Deployment Info 들어가기
2. Status Bar Style에서 고르기
    1. Dark Content : 검은색 표시
    2. Light Content : 흰색 표시
        
<img width="760" alt="스크린샷 2024-03-11 오전 10 23 29" src="https://github.com/codesquad-members-2024/swift-photoframe/assets/104732020/a78f817b-ee21-4e5d-8dfe-a5b0c32997ba">
        
3. Info.plist에서 `View controller-based status bar appearance` 를 추가하고 Value No로 설정하기
    1. 하는 이유? 앱 전체에서 하나의 상태 표시줄 모양을 사용하게 된다.
        
<img width="715" alt="스크린샷 2024-03-11 오전 10 26 16" src="https://github.com/codesquad-members-2024/swift-photoframe/assets/104732020/2a9ac14a-2133-4ea2-be58-5ae463f297a1">
        

### UIImageView

이미지를 화면에 표시하는 뷰. 

이 뷰는 내부적으로 하나의 `UIImage`를 관리

이미지 뷰 속성들…

- Scale To Fill
- Aspect Fit
- Aspect Fill
- Top, Bottom, Left, Right…
1. **Scale**은 가로x세로 비율을 유지하지 않는다
2. **Aspect**는 비율을 유지한다.
3. Fill은 단어 뜻 그대로여백을 남기지 않고 모두 "채운다".
4. . **Fit**은 영역안에 이미지를 "맞춘다".

## 💻고민과 해결

### 코드로 7개 화면크기를 구하고 균등하게 7등분하여 이미지를 어떻게 표시할 것인가??

1. 현재 뷰의 너비에서 좌우여백, 카드사이 여백을 뺀 길이를 구한다.
2. 이용할 수 있는 가로길이에서 7등분한다
3. 높이는 1.27 곱한다
4. 반복문을 통해서 각 카드의 x좌표를 구하고 ImageView를 생성한다.

## 🤔결과

![Simulator Screenshot - iPhone 15 Pro - 2024-03-11 at 12 03 20](https://github.com/codesquad-members-2024/swift-photoframe/assets/104732020/aa3de693-6338-49cb-85c6-4ccac7a59a70)

## 📚추가학습

### 앱 기본 설정(Info.plist)을 변경하는 방식에 대해 학습하고 앱 표시 이름을 변경하는 방법?

Info.plist : 앱이나 플러그인에 필요한 여러가지 설정들을 제공하는 XML 파일

<img width="107" alt="스크린샷 2024-03-11 오후 12 14 30" src="https://github.com/codesquad-members-2024/swift-photoframe/assets/104732020/56c7df2d-cd0f-4ff2-85ec-9b8b40540cf8">

<img width="411" alt="스크린샷 2024-03-11 오후 12 11 24" src="https://github.com/codesquad-members-2024/swift-photoframe/assets/104732020/86241fe3-ae70-4a4f-85f1-51c28351c66b">

<img width="1034" alt="스크린샷 2024-03-11 오후 12 17 40" src="https://github.com/codesquad-members-2024/swift-photoframe/assets/104732020/8fe76eb5-34f4-4c1b-a4b8-69c790b5b47a">

</div>
</details>

<details>
<summary>카드 클래스 구현하기</summary>

## 🎯주요 작업

- [x]  객체지향 프로그래밍 방식으로 필요한 역할을 담당하는 객체를 설계
- [x]  객체 내부 데이터 타입과 사용할 데이터를 구분하기
- [x]  유니코드를 활용하기

## 📚학습 키워드

<details>
<summary>Memory Model</summary>

앱을 실행했을 때 iOS가 프로세스가 처리하는 메모리 모델은  다른 메모리 모델과 동일하다.
코드가 올라가는 TEXT 영역

전역변수를 다루는 BSS(Block Started by Symbol), GVAR(Global Variables)

swift로 작성하더라도, 스위프트 컴파일되서 나오는 결과들은 C와 호환되는 프로세스 모델을 만드는 것이 목표이기 때문에 위 3가지 구조는 크게 다르지 않다.

새로운 함수를 호출하는 경우에 sp가 내려오게 된다. 매개변수와 리턴주소가 스택에 차지하게 된다. 그런 다음에,

지역 변수를 선언하면 스택영역을 차지하게 된다.

이러한 구조는 컴파일 구조 등등 여러 규격에 따라 다르지만, **개념상으로는 위의 구조를 그대로 사용한다.**

### Stack Frame

sp: 스택 포인터

사용중인 스택주소의 마지막 sp에서 직전에 사용중이였던 sp를 이어서 함수를 호출하거나, 새로 할당하는 경우에 계속 쌓이게되는 구조를 지닌다.

### iOS 프로세스 메모리

Text영역에서 코드가 올라가게 된다.

클래스는 Heap에 로딩된다.

함수가 호출하는 경우 !

호출하는 순간 스택에 매개변수 값이 쌓이게 된다.

local variable이 스택에 쌓인다.

‼️문자열은 기존 Objective-C에 의하면 스택에 들어가는게 아니라, 컴파일 하는 순간에 문자열을 텍스트영역에 복사해놓고, 그것을 참조하는 형식으로 만들어졌다.

위 과정은 Swift에서는 달라진다!!!!!!!!!!!

그리고 함수안에 클래스를 선언한 경우에는 클래스의 인스턴스가 Heap에 생기게 되고, 속성값은 인스턴스로 할당하게 된다.

그리고 return하는 순간에, 

1. 스택이 다 비워지고
2. ARC에 의해 Heap은 해제된다.

### Heap Allocation

만약에 힙에 오브젝트들을 생성한다면…

작은 오브젝트, 큰 오브젝트가 있을 수 있다.

만들 때는 괜찮지만, 쓰고 지우고 만들고 하다보면,

이가 빠진 것 처럼 중간에 있는게 듬성듬성 비워지는데 힙이 효율적이지 못하게 된다.

그래서 극복하기 위해 최신 iOS는 크기에 따라서 영역이 나뉘어 졌다. 

→ 이러한 관리하는 것을 “Virtual Memory 관리한다” 표현

힙 영역이 Virtual Memory와 같이 관리가 된다.

물리 메모리를 관리하는 VM 오브젝트들이 커널 내부에서 관리를 하는데 크기에 따른 힙의 영역이 VM들과 매칭이 되어 있다.

### 그래서..

iOS, MacOS 구분과 그 OS들이 얼마만큼의 Page와 연결이 되는지에 따라서 힙 영역에 있는 크기가 정해진다.

1. 작은 클래스를 선언한다고 하면 힙의 TINY영역에 만들어지고
2. String을 로딩하는 Data처럼 선언을 하더라도 1️⃣TINY영역에 buffer를 차지하는 포인터에 대한 영역만 잡히고, 2️⃣실제로 큰 데이터는 힙의 Large영역에 만들어진다.
3. 특이하게 Image는 워낙 크기때문에 이미지를 할당하고, 관리하는 영역이 VM에 따로 있다. 그리고 이미지 객체를 잘못 쓰게 되면 VM이 가득차서 **오버플로우**가 발생할 수 있다.

### NSString 문자열 객체 최적화

NSString: Foundation에 만들어져있는 문자열을 다루는 객체

NSString이 최적화하기 위해서 인스턴스가 만들어지더라도, 내부의 클래스가 텍스트영역에 있는 문자열을 참조해서 쓰는 구조로 만들어져 있다. → 메모리를 효율적으로 쓰기위해서 Objective-C시절에 했던 최적화 방법

### 스위프트 문자열 메모리 할당 분석 ‼️‼️‼️

스위프트 문자열은 메모리 레이아웃이 18바이트로 차지한다.

그래서 이를 기준으로 했을 때, 12바이트보다 작은 값이냐, 큰값이냐에 따라서 나뉨

1. 12바이트보다 작은 값일 때
    1. 스택에 문자열이 할당
2. 12바이트보다 큰 값일 때
    1. 힙에 할당, 스택의 공간에는 힙에 만들어진 주소가 들어가게 된다.

스위프트 문자열은 길이에 따라서 다르게 동작된다!!!!!!!!!

value타입이라고 무조건 스택에 생기지 않는다!! 중요!!!!!!!!!

그래서 대표적인 타입이 String인데 길이에 따라서 다르게 할당된다. why? 최적화를 위해서!!!!!

### 추상화 기법의 선택

- Struct: 엔티티 (저장되고, 관리되어야 하는 데이터의 집합)
- Class: Identity가 필요한 부분, 상속등의 OOP(***Object-Oriented*** Programming)
- Generics: 정적 다형성으로 가능한 경우
- Protocol: 동적 다형성으로 필요한 경우

### Struct에 클래스 타입의 Property가 많으면..

- enum, struct 등 Value type으로 대체
- Reference Counting 줄임

### Protocol Type을 쓸 때 대상이 큰 struct면..

- Indirect storage로 struct 구조 변경
- Mutable 해야하면 Copy-on-Write 구현

</div>
</details>

<details>
<summary>Object-oriented Design</summary>

프로그램을 독립적인 단위인 객체들로 나누고 이 객체들의 상호작용을 통해 프로그램을 설계하고 구현하는 패러다임,

객체지향 프로그래밍 특성 추캡상다

- 추상화
    - 객체의 공통적인 속성과 기능을 추출하여 정의하는 것
    - 토끼, 강아지, 사자의 공통적인 특징 포유류로 추상화한다
- 캡슐화
    - 객체 수행 목적에 따라 데이터 구조 및 처리방법을 결합시켜 묶는다. 외부에 내부 기능 구현 내용을 감추고 이용방법만 알 수 있다.
    - 캡슐화는 왜 외부에서 객체의 직접 접근을 막는가?  은닉화 장점을 갖기 때문에
    - 변경을 못하게 하여, 유지보수나 확장시 오류의 범위를 최소화한다.
    - 조작법은 바뀌어도 사용방법 자체는 바뀌지 않아서 오류의 범위를 최소화
    - 데이터가 변경되어도, 다른 객체에 영향을 주지 않는 독립성을 갖는다.
- 상속
    - 상위개념의 특징을 하위 개념이 물려받아 사용하는 것
    - 재사용을 하여 코드의 길이를 줄이고, 가독성을 높인다.
    - 상속은 기능확장의 개념으로 생각해야 한다.
- 다형성
    - 상속과 연관있는 개념으로, 자식 클래스가 여러형태로 존재하는 것
    - 오버로드와 오버라이딩 대표적인 예시이다.
    - 오버라이딩 : 서브클래스는 슈퍼클래스에서 상속할 메서드, 프로퍼티, 서브스크립트를 재정의하는 것을 말한다.
    - 오버로드: 함수의 이름은 같으나, 매개변수, 리턴타입 등으로 다르게 설정하여 함수를 중복으로 선언하는 것을 말한다.

### 장점 재생자유

1. 재사용성
2. 생산성 향상
3. 자연스러운 모델링
4. 유지보수 

### 단점

1. 많은 오버헤드가 발생한다

### 객체지향 프로그램 및 설계의 기본 원칙 다섯가지

### SPR(Single Responsibility Principle)

단일 책임 원칙

클래스는 하나의 책임을 가져야 한다.

SPR을 위반한 사례 → Messive View

이를 해결하기 위해서? 클래스를 작게 만들도록 노력

### OCP (Open-Closed Principle)

개방 폐쇄 원칙

모듈 확장에는 열려있고, 변경에는 닫혀있어야 한다.

→ 분기문을 적절히 쓰면서 줄이도록 노력하기 

if/ switch 대신에

1. protocol 사용하기
2. dictionary 사용하기

### LSP (Liskov Substitution Principle)

리스코프 치환 원칙

자식클래스가 부모클래스의 동작을 방해하면 안된다.

### ISP (Interface Segregation Principle)

인터페이스 분리 원칙

클래스가 사용하지 않는 메소드에 의존관계를 맺으면 안되고, 사용하는 기능만 제공하도록 인터페이스를 분리해야한다.

### DIP (Dependency Inversion Principle)

의존 역전 원칙

상위클래스, 인터페이스, 추상클래스일수록 변하지 않을 가능성이 높기 때문에 의존하라는 것

</div>
</details>

### **유니코드**

전 세계 사람들이 사용할 수 있는 부호 체계

Swift에서 문자열을 저장할 때는 문자열에 포함된 각각의 문자를 유니코드값or스탈라값(UTF-32)으로 저장한다

스탈라값(UTF-32)으로 저장된 문자는 언제든지 UTF-8, UTF-16으로 쉽게 변환할 수 있다.


## 💻고민과 해결

### `stackView.translatesAutoresizingMaskIntoConstraints = false` 무엇인가?

시스템이 자동으로 제약 조건을 생성하지 않도록 하는 것,

개발자가 직접 모든 제약 조건을 정의해야 하는 것을 의미한다.

<img width="156" alt="스크린샷 2024-03-11 오후 2 15 58" src="https://github.com/codesquad-members-2024/swift-pokergame/assets/104732020/8cc3b044-705a-4ecd-b111-507745ccc187">

해결방법 : 스택 뷰의 높이를 그 너비의 약 1/7에 해당하는 1.27배로 설정해야 함


```swift
// stackView.heightAnchor.constraint(equalTo: stackView.widthAnchor , multiplier: 1.27)
stackView.heightAnchor.constraint(equalTo: stackView.widthAnchor , multiplier: 1.27 / CGFloat(7))
```




### if let 과 guard let 문법 차이

### if let

옵셔널 값이 nil이 아닐 때 코드 블록을 실행한다.

값이 없을 경우,  다른 코드의 실행을 할 수 있도록 진행시킨다.

```swift
if let value = optionalValue {
    // optionalValue가 nil이 아닐 때 실행되는 블록
} else {
    // optionalValue가 nil일 때 실행되는 블록
}

```

### guard let

nil인 경우에 현재 코드의 실행 흐름을 빠져나가도록 강제시킨다.

```swift
guard let value = optionalValue else {
    // optionalValue가 nil일 때 실행되고 함수에서 빠져나감
    return
}
// value를 그대로 사용한다.

```

## 🤔결과

<img width="627" alt="스크린샷 2024-03-12 오후 2 18 16" src="https://github.com/codesquad-members-2024/swift-pokergame/assets/104732020/9ccd66a1-30ff-41da-b6e9-5aa4bbfb74d7">

</div>
</details>


&nbsp;

<details>
<summary>카드덱 구현하고 테스트하기</summary>

## 🎯주요 작업

- [x]  구조체와 클래스 차이점을 학습, 속성변화 확인하기
- [x]  참조 접근자 학습
- [x]  클래스 메모리 관리방식을 학습, reset()할때 이전에 만든 객체 설명
- [x]  메모리 분석도구 학습
- [x]  카드 객체 인스턴스를 포함하는 카드덱 구조체 구현

## 📚학습 키워드

### struct

1. 값 타입, 구조체의 인스턴스를 다른 변수에 할당하거나 함수에 전달할 때 인스턴스의 복사본이 생성되고 전달된다.
2. 다른 구조체나 클래스로부터 상속될 수 없다
3. 타입 캐스팅 지원 안함
4. 소멸자 없음
5. Stack에 만들어짐 (heap에 만들어지는예외 있음)

### class

1. 참조 타입, 클래스의 인스턴스를 다른 변수에 할당하거나 함수에 전달할 때 인스턴스에 대한 참조, 포인터가 전달된다.
2. 상속 가능 → 오버라이딩, 다형성
3. 인스턴스는 런타임에 타입을 검사하고 해석하기 위해 타입캐스팅 사용가능
4. deinit 사용가능
5. heap에 만들어짐

### 속성 변화할 때 차이

- 구조체의 인스턴스가 let으로 선언된 경우

→ 인스턴스의 속성을 수정할 수 없다.

속성을 수정할려면 var로 선언해야 됨

- 클래스 인스턴스가 let으로 선언된 경우

해당 인스턴스의 참조된 속성이 var로 선언되어 있으면 수정이 가능하다

→ 변수가 인스턴스 자체를 직접 가지고 있는 것이 아닌, 인스턴스를 가리키는 참조를 가지고 있기 때문이다.

### 참조 접근자를 통해 정보를 감추고, 메서드 접근

```swift
class BankAccount {
    private var balance: Double = 0.0 // 은닉화된 잔액 정보

    // 잔액에 대한 참조 접근자 메소드
    func getBalance() -> Double {
        return balance
    }

    // 잔액을 증가시키는 메소드
    func deposit(amount: Double) {
        if amount > 0 {
            balance += amount
        }
    }

    // 잔액을 감소시키는 메소드
    func withdraw(amount: Double) -> Bool {
        if amount <= balance && amount > 0 {
            balance -= amount
            return true
        } else {
            return false
        }
    }
}
```

### 클래스 메모리 관리 방식 = ARC

Automatic Reference Counting

메모리 누수 방지, 메모리 관리를 위해

객체의 참조 횟수를 자동으로 계산하고, 객체가 더 이상 필요하지 않게 되면 메모리에서 자동으로 해제하는 시스템

### ARC 과정

1. 인스턴스 생성: 객체의 인스턴스가 생성 될 때, ARC는 해당 인스턴스에 대한 RC를 1추가함
2. 참조 추가: 다른 변수, 상수가 생성된 인스턴스를 참조할 때마다 RC 1씩 증가함
3. 참조 해제: RC 1씩 감소
4. 메모리 해제: 인스턴스의 RC가 0이 되면, ARC는 인스턴스가 더이상 필요하지 않다고 판단 후, 메모리에서 해제 함

### Instruments

iOS 프로젝트할 때, 디바이스에 올려 테스트하여 크래쉬가 없이 잘 작동하는 것에 만족하는 것이 아니라 프로파일링까지 마무리 해야 실유저에게 크래쉬안나는 보장을 할 수 있게 됨

## 💻고민과 해결

count = 배열의 count 

shuffle, removeOne, reset 기능은 배열을 이용해서 구현하도록 한다.

## 🤔결과

<img width="627" alt="스크린샷 2024-03-13 오전 12 48 10" src="https://gist.github.com/assets/104732020/e92336ac-9277-4140-9d08-24e2f5e61009">

</div>
</details>
