# LiveScore

## 프로젝트 설명
- 날짜(yyyy-MM-dd, yyyy.MM.dd, yyyy/MM/dd) 검색하여 검색날짜 축구 경기 스케쥴 표시
- 홈 팀 빨간색 글씨로 표기, 경기 진행 상태 표시, 승리 팀 스코어 빨간색 글씨로 표기
- 메이저 리그 지원
- 한국어 지원 X
- 리그 별 TOP 10 득점순위 검색 (태그 헤더뷰 활용)(선수 상세정보)
- MVP 패턴 사용
- https://www.football-data.org API 사용

보완할 점..
1. 일부 국가 표기 오류(아예 안뜸)(해결 완료)  // 삭제 (리그 로고로 대체)
2. RefreshControl 추가 (해결 완료)
3. 경기 데이터가 많을 때 스크롤이 느림.. (해결 완료)
4. 팀 로고 추가하려는데 오류발생... (해결 완료)
5. 이미지 .svg 파일에 대한 불러오기 문제 해결해야함. (WKWebView로 해결)(해결 했지만 사이즈 수정필요.)
6. ...

해결한 점..
1. 해당 리그의 국기 이미지 없애고, 해당 리그 로고로 대체
2. 태그 헤더뷰랑 득점순위 컬렉션 뷰가 겹쳐서 하나만 나오길래 isHidden(isHidden: Bool) 함수 만들어서 태그 헤더뷰 클릭 시 테이블 뷰 가리고 득점순위 컬렉션 뷰 나타나게 함 (반대로 RefreshControl 사용시 득점순위 컬렉션 뷰 데이터 초기화 하고 가린 뒤 테그 헤더뷰 나타나게 함)
3. ...

더 하고 싶은 것..
1. 경기 전, 경기 중, 경기 후 표시 하고 싶음. (타임라인 추가 완료)
2. 리그 검색하여 득점순위 10위까지 보여주는 뷰 -> 해당 선수 세부정보 (완료)
3. 팀 상세 스텟 뷰 하나 더 만들고 싶음 (해당 팀의 스쿼드...)(추가 API 결제 해야함)
4. ...

### 화면 구성
![Simulator Screen Shot - iPhone 13 Pro Max - 2022-05-24 at 18 03 16](https://user-images.githubusercontent.com/96865411/169995344-3c81cb28-90ce-40e7-a57d-2355e466fe5d.png)![Simulator Screen Shot - iPhone 13 Pro Max - 2022-05-24 at 18 03 27](https://user-images.githubusercontent.com/96865411/169995384-3ad63f05-566f-48da-87fd-cda2385f7bc3.png)![Simulator Screen Shot - iPhone 13 Pro Max - 2022-05-24 at 18 03 30](https://user-images.githubusercontent.com/96865411/169995412-27b721c2-f75b-4a5e-bdaa-99b2fd8f81bf.png)
