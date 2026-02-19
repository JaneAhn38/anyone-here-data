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


본 레포지토리에서 사용되는 샘플 데이터는
`sample-data/` 디렉토리에 CSV 형태로 제공됩니다.
해당 데이터는 실제 사용자 정보가 아닌 테스트 및 설계 검증용 데이터입니다.


샘플 데이터는 `sample-data/` 디렉토리에 포함되어 있으며,
데이터 모델 구조 및 집계 로직 검증을 위한 테스트 용도로 제공됩니다.




##Database Setup
이 레포지토리의 SQL 스크립트는 로컬 MySQL 8.x 환경을 기준으로 합니다.
​

1. 스키마 생성 (01_schema.sql)
sql/01_schema.sql은 anyoneheredb 데이터베이스와 테이블 구조를 생성하는 스크립트입니다.

bash
# MySQL 설치 경로에 따라 bin 디렉터리로 이동 (예시)
cd "C:\Program Files\MySQL\MySQL Server 8.0\bin"

# 01_schema.sql 실행 (경로는 환경에 맞게 수정)
mysql -u root -p < "C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\AnyoneHere\01_schema.sql"
mysql -u root -p 부분은 사용하는 MySQL 계정에 맞게 변경할 수 있습니다.

01_schema.sql 파일의 위치가 다르면, 마지막 인자로 넘기는 파일 경로를 환경에 맞게 수정해야 합니다.

2. 샘플 데이터 적재 (02_seed_sample_data.sql)
sql/02_seed_sample_data.sql은 sample-data/ 디렉터리의 CSV를 anyoneheredb에 적재하는 스크립트입니다.

bash
# MySQL bin 디렉터리에서 실행 (경로는 예시)
cd "C:\Program Files\MySQL\MySQL Server 8.0\bin"

# 02_seed_sample_data.sql 실행 (경로는 환경에 맞게 수정)
mysql -u root -p < "C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\AnyoneHere\02_seed_sample_data.sql"
경로는 환경에 맞게 수정해야 합니다
현재 스크립트는 CSV가 다음 경로에 있다고 가정합니다.

sql
LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/AnyoneHere/sample-data/spots.csv'
INTO TABLE spots
...
운영체제, MySQL 설치 위치, 클론한 디렉터리 위치에 따라 다음이 달라질 수 있습니다.


