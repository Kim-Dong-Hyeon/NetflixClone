# Netflix 클론 코딩 프로젝트 명세

## 프로젝트 개요

---

### 프로젝트 이름
**Netflix 클론 코딩**

### 프로젝트 설명
이 프로젝트는 Netflix 앱을 클론 코딩하는 것을 목표로 합니다. 이를 통해 iOS 개발에 필요한 다양한 개념을 복습하고, 실제 앱 개발에 적용하는 경험을 제공합니다. 주요 학습 내용으로는 `UICollectionView`를 이용한 복잡한 레이아웃 구성, `비동기 프로그래밍`, `MVVM 아키텍처`, `RxSwift`를 활용한 효율적인 비동기 프로그래밍 및 데이터 바인딩, `AVFoundation`을 활용한 동영상 재생 등이 포함됩니다.

## 기술 스택 및 주요 기능

---

### 기술 스택
- **UIKit**: iOS 앱의 사용자 인터페이스 구성
- **RxSwift**: 비동기 프로그래밍 및 MVVM 패턴 구현
- **AVFoundation**: 동영상 재생 기능 구현
- **SnapKit**: 코드 기반의 오토레이아웃 설정
- **YouTubeiOSPlayerHelper**: YouTube 동영상 재생 지원

### 주요 기능
1. **영화 및 TV 쇼 목록 표시**: TMDB API를 활용하여 인기 영화, 평점 높은 영화, 인기 TV 쇼 목록을 가져와서 표시
2. **동영상 재생**: 선택한 영화 또는 TV 쇼의 예고편을 AVPlayer 및 YouTubePlayer를 통해 재생
3. **MVVM 아키텍처**: 데이터와 UI 로직의 분리를 통해 코드의 유지보수성 및 확장성 향상

## 상세 구현 가이드

---

### 1. UICollectionView 구현
- **구성 요소**
  - `UICollectionViewCell`: 영화 포스터를 표시하는 셀
  - `Supplementary View`: 각 섹션의 헤더를 표시하는 보충 뷰
  - `Section`: 데이터를 그룹화하여 영화 및 TV 쇼를 섹션별로 나누어 표시

- **필요한 프로토콜**
  - `UICollectionViewDataSource`: 데이터 관리
  - `UICollectionViewDelegate`: 셀 선택 및 상호작용 관리
  - `UICollectionViewLayout`: 레이아웃 구성

### 2. AVFoundation 활용
- **기능**: 외부 동영상 URL을 통해 동영상을 재생
- **사용 클래스**: `AVPlayer`, `AVPlayerViewController`
- **동작 원리**: AVPlayer를 통해 동영상을 로드하고, AVPlayerViewController로 재생

### 3. TMDB Open API 사용
- **영화 정보 가져오기**: TMDB의 Open API를 이용하여 인기 영화, 평점 높은 영화, 인기 TV 쇼 목록을 가져옴
- **API 문서**
  - 인기 영화: `https://api.themoviedb.org/3/movie/popular?api_key=API_KEY`
  - 평점 높은 영화: `https://api.themoviedb.org/3/movie/top_rated?api_key=API_KEY`
  - 인기 TV 쇼: `https://api.themoviedb.org/3/tv/popular?api_key=API_KEY`
  - 포스터 이미지: `https://image.tmdb.org/t/p/w500/POSTER_PATH.jpg`

### 4. MVVM 패턴 구현
- **Model**: 데이터 구조 정의 (`Movie`, `Video` 구조체)
- **ViewModel**: TMDB API와의 네트워크 통신 및 데이터 가공 로직 구현
- **View**: UI 구성 요소 및 데이터 바인딩 구현

### 5. 동영상 재생 구현
- **AVFoundation**: 외부 동영상 URL을 통한 동영상 재생 구현
- **YouTubeiOSPlayerHelper**: YouTube 동영상 재생 구현

## 구현 단계

---

### STEP 1: 영화 및 TV 쇼 목록 표시
- TMDB API를 사용하여 영화 및 TV 쇼 데이터를 가져오고, 이를 `UICollectionView`에 표시합니다.

### STEP 2: MVVM 패턴으로 구조화
- 데이터를 View와 분리하여 ViewModel에 위치시키고, `RxSwift`를 사용하여 데이터를 바인딩합니다.

### STEP 3: 동영상 재생 기능 구현
- AVFoundation을 활용하여 외부 동영상 재생을 구현하고, YouTubeiOSPlayerHelper를 통해 YouTube 예고편을 재생합니다.

## 참고 자료

---

- [TMDB API 문서](https://developer.themoviedb.org/docs/getting-started)
- [UICollectionView | Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uicollectionview)
- [AVFoundation | Apple Developer Documentation](https://developer.apple.com/documentation/avfoundation/)
- [YouTube iOS Player Helper](https://github.com/youtube/youtube-ios-player-helper)
