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

&nbsp;
