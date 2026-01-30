**Anyone Here**는 드라이브 스팟에 현재 사람들이 있는지를 실시간으로 보여주는 위치 기반 웹 서비스입니다.

본 레포지토리는 **Anyone Here** 서비스에서 사용되는 데이터 처리 및 집계 로직을 담당합니다.


## Data Model
- 데이터 구조 설계는 `docs/erd.md` 문서를 기준으로 합니다.


## Data Flow
1. 사용자의 위치 정보가 location_logs로 수집됩니다.
2. 위치 로그를 기준으로 드라이브 스팟별 현재 인원수를 계산합니다.
3. 계산된 결과는 spot_presence 형태로 집계되어 서비스에 제공됩니다.


## Aggregation Policy
spot_presence는 location_logs를 기반으로
일정 시간 및 거리 기준에 따라 계산되는 집계 데이터이며,
세부 기준은 서비스 정책에 따라 변경될 수 있습니다.


## Directory Structure
- docs/ : 데이터 모델 및 설계 문서
- sample-data/ : 개발 및 테스트용 샘플 데이터




