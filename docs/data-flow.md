## 1. Location Data Ingestion

- 사용자는 일정 주기로 위치 정보를 전송한다.
- 위치 정보는 location_logs 테이블에 raw 데이터로 저장된다.
- 이 데이터는 집계 전 원본 데이터로 사용된다.


## 2. Spot Presence Determination

- 사용자의 최근 위치 로그를 기준으로 스팟 반경 내 여부를 판단한다.
- 일정 시간 이내의 로그만을 유효 데이터로 간주한다.
- 해당 조건을 만족하는 사용자를 해당 스팟의 활성 사용자로 계산한다.


## 3. Aggregation Process

- location_logs를 기반으로 spot_presence 데이터를 주기적으로 계산한다.
- 각 스팟별 활성 사용자 수를 집계한다.
- 집계 결과는 조회 성능 향상을 위해 별도의 테이블로 관리된다.


