# RxPhoto

## Environment
```
//  Secrets.swift

enum Secrets {
    static let accessKey = "API_KEY"
}
```
- API_KEY 부분에 Unsplash Access Key 입력하면 애플리케이션 동작 

## Scene
- PhotoMain   : 인기 사진 10개 로드
- PhotoDetail : 단일 사진 1개 로드(이전 화면에서 id 값으로 접근)
- PhotoSearch : 사진 검색 10개씩 로드
