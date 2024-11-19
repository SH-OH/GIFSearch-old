# GIFSearch

## Overview

### Tech Stack
- Modularized using Tuist
- Adopted Microfeature Architecture with MVVM
- Managed DI with Swinject
- Reactive Programming with Rx
- Asynchronous Programming with Swift Concurrency
- Code-based UI with SnapKit
- Implemented Networking and GIFLoader

### Architecture
### Layer 구성
- Feature
    - 사용자의 액션을 처리하거나 데이터를 보여주는, 사용자와 직접 맞닿는 Presentation 레이어
    - ex) View, ViewModel 등
- Domain
    - 외부의 데이터를 처리하고, 도메인을 구분하여 해당 로직을 수행하는 레이어
    - ex) Data, UseCase 등
- Core
    - 비즈니스 로직을 포함하지 않고 순수 기능성 모듈이 위치한 레이어
    - ex) Networking, Database 등
- UserInterface
    - 공용 View, 디자인 시스템, 리소스 등 UI 요소 모듈이 위치한 레이어
    - ex) DesignSystem
- Shared
    - ThirdParty, extension 등 모든 레이어에서 공용으로 재사용될 모듈이 위치한 레이어
    - ex) UtilityModule, GlobalThirdParyLibrary

### MicroFeatures Architecture
- [Tuist의 Micro Features](https://docs.tuist.io/guide/scale/ufeatures-architecture) 구조를 기반으로 설계하였습니다. 
- **Why?**
    - 이 구조로 설계함으로써 각 모듈별로 더 쉽고 명확하게 테스트할 수 있고, 기존 Modular 아키텍처에서 Feature Layer가 Massive한 현상을 해소할 수 있습니다. 또한, Feature Layer에서 다양한 모듈을 복잡하게 참조하면서 발생하는 의존성 순환 참조 현상에 대해서도 쉽게 대처할 수 있습니다.


    <img src="https://user-images.githubusercontent.com/74440939/210211725-5ac7c9fe-bf25-4707-9775-4f46f1c0c522.png" width="200">
