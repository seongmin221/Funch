# Funch: 즐거운 첫 만남 도우미

<img width="200" alt="IOS_screenshot_1248_2778_1" src="https://github.com/seongmin221/funch-portfolio/assets/72431640/0bf94bdd-6faa-4d4a-b6fe-a179eaaf5855">
<img width="200" alt="IOS_screenshot_1248_2778_2" src="https://github.com/seongmin221/funch-portfolio/assets/72431640/3a40e00e-75be-4fe4-8f0e-4300d89a8d2a">
<img width="200" alt="IOS_screenshot_1248_2778_3" src="https://github.com/seongmin221/funch-portfolio/assets/72431640/890c31c8-176b-4cae-8925-256eab575cca">
<img width="200" alt="IOS_screenshot_1248_2778_4" src="https://github.com/seongmin221/funch-portfolio/assets/72431640/c1ed3630-b314-410b-a1e5-d734463c4848">





## Overview
- 프로젝트 소개
  - v1.0.0
    - 처음 모임, 동아리에서 만나는 사람과 대화 주제를 찾기 위한 개인 프로필을 생성할 수 있습니다
    - 생성한 프로필을 토대로 다른 사람과 매칭을 하여 어느 정도의 일치율을 가졌는지 확인할 수 있습니다
    - 본인의 프로필을 확인할 수 있습니다
  - v1.1.0
    - 매칭한 사람들의 MBTI를 수집하여 도감을 채워나갈 수 있습니다

- 기간:
  - 1st Release: 2024.01 ~ 2024.02
  - 2nd Release: 2024.02 ~ 현재
- 역할:
  - iOS Developer
 
- [App Store Link](https://apps.apple.com/kr/app/%ED%99%A9%EA%B8%88%ED%8E%80%EC%B9%98/id6478166971)

<br>

<br>

## Main Contributions
### Layout Protocol을 따르는 커스텀 레이아웃 구현

<img width="300" alt="image" src="https://github.com/seongmin221/funch-portfolio/assets/72431640/99ff1639-d1eb-4821-b453-1a5675cf6b74">

- SwiftUI를 통해 좌측으로 정렬되는 레이아웃을 구현하기 위해, Layout Protocol을 따르는 커스텀 그리드를 구현했습니다.

```swift
extension DynamicHGrid: Layout {
    /// DynamicGrid의 사이즈를 계산하는 함수
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.replacingUnspecifiedDimensions().width
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        return calculateLayout(of: sizes, containerWidth: width).size
    }
    
    /// DynamicGrid 내부에 있는 subview들을 배치시키는 함수
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let offsets = calculateLayout(of: sizes, containerWidth: bounds.width).offsets
        for (offset, subview) in zip(offsets, subviews) {
            subview.place(at: .init(x: offset.x + bounds.minX, y: offset.y + bounds.minY), proposal: .unspecified)
        }
    }
}
```

```swift
extension DynamicHGrid {
    func calculateLayout(of subviewSizes: [CGSize], containerWidth: CGFloat) -> (offsets: [CGPoint], size: CGSize) {
        var offsets: [CGPoint] = []
        var containerSize: CGSize = .zero
        var currentPosition: CGPoint = .zero
        for size in subviewSizes {
            if currentPosition.x + size.width > containerWidth {
                currentPosition.x = 0
                currentPosition.y += size.height + lineSpacing
            }
            offsets.append(currentPosition)
            currentPosition.x += size.width + itemSpacing
            containerSize.width = max(containerSize.width, currentPosition.x)
            containerSize.height = max(containerSize.height, currentPosition.y + size.height)
        }
        
        return (offsets, containerSize)
    }
}
```

- 그리드 내부에 들어갈 뷰들의 너비가 전체 그리드의 너비를 넘기면, y 좌표를 다음 갱신하여 다음 줄로 넘어가게끔 조절하였습니다.
- 위 과정이 반복됨에 따라, 가장 알맞는 너비와 높이 값을 계산했습니다.
- 반복문을 통해 각 뷰들의 위치를 저장해두고, 가장 알맞는 사이즈와 함께 반환합니다.


<br>

<br>

### 디자인 시스템 구축

- 재사용성을 높이기 위해 Core 레이어에 디자인 시스템을 구축했습니다.
  - 디자인 시스템에는 색상, 이미지, 그라디언트, 폰트를 추가했습니다
  - 각 에셋을 열거형으로 관리하여 손쉽게 사용할 수 있도록 적용했습니다.

![normal](https://github.com/seongmin221/funch-portfolio/assets/72431640/27a4f820-6a56-4a18-a237-25d7a66853d0)

![max_length](https://github.com/seongmin221/funch-portfolio/assets/72431640/19b4adf2-279e-4ed6-843a-2f5fe6e8afe4)

![icon](https://github.com/seongmin221/funch-portfolio/assets/72431640/cdd3dd15-f7b5-4e4d-b6fa-df4a8fc19a1f)

![button](https://github.com/seongmin221/funch-portfolio/assets/72431640/7c657981-bee9-45e8-a140-aebb2f01c26a)

- 위 사진의 재사용되는 `TextField`를 단일 컴포넌트로 만들어 입력값을 토대로 의도한 UI를 그리도록 했습니다.


<br>

<br>


### 그 외

- 전반적인 GUI를 구현했습니다.
- 앱 타겟을 17.0 -> 16.0으로 낮추어, 변경사항에 대응했습니다


<br>

<br>

## 💡 Things I Learned

### 클린 아키텍쳐의 필요성

- 과거에 코드를 작성할 때에는, 설계와 구조의 중요성에 대해 이해하지 못했습니다. 하지만 잦은 기획 변경이 생기고, 앱 타겟을 수정하거나, 추가 피쳐를 개발해야 하는 등 변경이 많은 태스크가 생겼고, 클린 아키텍쳐가 적용된 프로젝트와, 그렇지 않은 프로젝트의 차이점을 알 수 있었습니다.
  
  - 클린 아키텍쳐를 적용한 프로젝트의 확장성과 유지보수성을 이해했습니다.
  - 프로젝트 설계의 중요성을 깨달았습니다.
  - 위 경험으로 더 나은 프로젝트 구조와 설계를 위해 <객체지향의 사실과 오해>와 <클린 아키텍쳐> 서적을 읽고 있습니다.

<br>

- Instruments를 통한 메모리 사용량의 분석 필요성과 방법에 대해 이해하였고, `repository` 등을 자체로 생성하는 경우 메모리의 낭비가 발생함을 확인했습니다.
  - 이런 문제를 해결하기 위해 객체의 생성을 최소화하고, 따로 주입하는지 그 이유를 알게 되었습니다.


<br>

<br>

## 🔩 Tech & Skills

<img src="https://img.shields.io/badge/SwiftUI-blue" height="30"> <img src="https://img.shields.io/badge/Combine-blue" height="30"> <img src="https://img.shields.io/badge/CleanArchitecture-blue" height="30"> 

<img src="https://img.shields.io/badge/Figma-orange" height="30">

<img src="https://img.shields.io/badge/Discord-yellow" height="30"> <img src="https://img.shields.io/badge/Notion-yellow" height="30">

<br>

<br>


## 🛠 Development Environment

<img src="https://img.shields.io/badge/iOS-16+-white" height="30"> <img src="https://img.shields.io/badge/Xcode-15.2-blue" height="30">



