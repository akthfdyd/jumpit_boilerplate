# Hot update (like code-push)

## flutter_eval 이용방법(mermaid diagram)

sequenceDiagram
participant D as 개발자
participant S as 코드 서버
participant A as 호스트 앱 (Flutter)
participant R as flutter_eval 런타임
participant H as 핫 업데이트 위젯

    %% 1. 개발 및 배포 과정 %%
    Note over D: 1. 코드 개발 및 컴파일
    D->>D: 핫스왑 대상 위젯을 HotSwap()으로 감싸기
    D->>D: 교체할 위젯 코드를 별도 패키지에 작성
    D->>D: `dart_eval compile` 명령어로 .evc 파일 생성
    D->>S: 컴파일된 .evc 파일을 서버에 업로드

    %% 2. 앱 실행 및 코드 로딩 %%
    Note over A: 2. 앱 실행 및 핫 업데이트 적용
    A->>S: 앱 실행 시 .evc 파일 요청
    S-->>A: .evc 파일 응답
    A->>R: .evc 바이트코드로 런타임 초기화
    A->>A: 위젯 트리 렌더링
    Note over A, R: HotSwap(id) 위젯 발견 시<br/>런타임이 해당 ID의 위젯을 요청
    R-->>A: .evc에 정의된 핫 업데이트 위젯 반환
    A->>H: 핫 업데이트 위젯 렌더링

    %% 3. 상호작용 (MethodChannel 예시) %%
    Note over H, A: 3. 상호 코드 호출 (MethodChannel)
    H->>R: MethodChannel.invokeMethod("메소드", 파라미터) 호출
    R->>A: 브릿지를 통해 메소드 호출 전달
    A->>A: 등록된 핸들러로 앱 네이티브 기능 수행
    A-->>R: 처리 결과 반환
    R-->>H: 최종 결과를 핫 업데이트 위젯으로 반환
    H->>H: 반환된 결과로 UI 업데이트