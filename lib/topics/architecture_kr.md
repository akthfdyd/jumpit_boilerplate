# Presentation layer

## View

Flutter 앱은 위젯들만으로 구성됩니다. 위젯은 화면에 노출되는 형태에 따라 분류될 수 있습니다.

1. Screen : 위젯 중에서 화면단위가 되며 주로 네비게이터로 호출되는 위젯을 말합니다.
2. Overlay : 화면 상단에 쌓이는 위젯으로, 잠시 동안 화면의 전부 또는 일부를 덮었다가 필요한 기능을 수행한 후 사라지는 단위입니다. 주로 OverlayEntry 또는
   showDialog 또는 showModalBottomSheet에 의해 호출됩니다.
3. Component : 화면이나 오버레이를 구성하는 화면 내 일부를 차지하는 위젯입니다.

## ViewModel

Flutter 앱에서 ViewModel은 비즈니스 로직을 뷰와 분리시키는 역할입니다.  
위젯의 상태관리에 이용되며,  
UseCase를 호출하고 그에 대한 응답 이벤트를 View가 받을 수 있도록 합니다.

## Helper

helper는 서비스 기능에 한정된 재사용 가능 코드를 의미합니다.  
도메인 바깥에서도 보편적으로 사용할 수 있다면 Util 패키지여야 합니다.

# Domain layer

도메인 레이어는 비즈니스를 구성하는 주요 규칙이며,  
매우 작고 단순한 코드들로 구성되어 있습니다.  
그러나 그 중요성은 다른 계층보다 적지 않습니다.

서버에서 앱을 작동하는 데 필요한 이상의 데이터 규격을 보내도,  
또는 비즈니스 규칙에 비해 UI가 매우 복잡해 보이는 경우에도,  
도메인 레이어의 코드에는 영향을 주지 않습니다.

## Entity

Business를 구성하기 위한 최소 자원.  
DTO로서 사용되는 VO와는 다릅니다.

## Usecase

Business를 구성하기 위한 최소 기능.

## Repository

Repository 인터페이스는 Data Layer로부터 Entity를 리턴 받도록 정의됩니다.

# Data layer

도메인 계층은 외부 인터페이스에 대해 아무것도 몰라야 합니다.  

따라서 Repository가 수행한 기능의 결과가 UseCase로 반환되기 전에  
Repository의 구현체는 API를 통해 응답받은 VO 형태의 데이터를  
Entity 형태의 데이터로 가공하여 리턴해야 합니다.

## RepositoryImpl

Repository의 구현체로,  
Data layer에 존재하며 VO의 규격을 알고 있습니다.  
Entity를 리턴합니다.

## DataSource

데이터 저장공간(내/외부)으로부터 데이터를 받는 기능의 규약이 되는 인터페이스.

## Model

API를 사용한 데이터 전송 규격.  
이 코드에서는 ResponseVO만 설명합니다.  
Request 전송 규격이 Map to Query 혹은 Map to JSON 으로 제약되어 있기 때문입니다.  

- https://javiercbk.github.io/json_to_dart/

# Util

Util은 프로젝트 이외의 영역에서도 재사용할 수 있는 코드이며,  
플랫폼/서비스 종속성이 없는 범용 코드를 의미합니다.