# Anyone Here – Data Processing & Aggregation

Anyone Here는 드라이브 스팟에 현재 사람들이 있는지를 실시간으로 보여주는 위치 기반 웹 서비스입니다.

본 레포지토리는 Anyone Here 서비스에서 사용되는 데이터 모델, 위치 로그 처리 및 집계 로직을 담당합니다.


## Data Model

데이터 구조 설계는 docs/erd.md 문서를 기준으로 합니다.

주요 테이블:
- users
- spots
- location_logs
- spot_presence


## Data Flow

1. 사용자의 위치 정보가 location_logs 테이블로 수집됩니다.
2. 위치 로그를 기준으로 드라이브 스팟별 현재 인원수를 계산합니다.
3. 계산된 결과는 spot_presence 형태로 집계되어 서비스에 제공됩니다.


## Aggregation Policy

spot_presence는 location_logs를 기반으로 계산되는 집계 데이터입니다.

- 일정 시간 기준 (예: 최근 N분)
- 스팟 중심 좌표 및 반경 기준
- 동일 사용자 중복 제거 (COUNT(DISTINCT user_id))

세부 기준은 서비스 정책에 따라 변경될 수 있으며,
자세한 내용은 docs/aggregation-policy.md를 참고합니다.


## Directory Structure

docs/          데이터 모델 및 설계 문서  
sql/           스키마 및 집계 SQL 스크립트  
sample-data/   개발 및 테스트용 샘플 데이터 (CSV)


## Database Setup

본 레포지토리의 SQL 스크립트는 MySQL 8.x 환경을 기준으로 작성되었습니다.


### 1. Schema 생성 (01_schema.sql)

sql/01_schema.sql은 anyoneheredb 데이터베이스와 테이블 구조를 생성하는 스크립트입니다.

실행 예시 (Windows):

cd "C:\Program Files\MySQL\MySQL Server 8.0\bin"
mysql -u root -p < "C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\AnyoneHere\sql\01_schema.sql"

MySQL 계정 및 파일 경로는 환경에 맞게 수정해야 합니다.


### 2. 샘플 데이터 적재 (02_seed_sample_data.sql)

sql/02_seed_sample_data.sql은 sample-data/ 디렉터리의 CSV 파일을 적재하는 스크립트입니다.

cd "C:\Program Files\MySQL\MySQL Server 8.0\bin"
mysql -u root -p < "C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\AnyoneHere\sql\02_seed_sample_data.sql"


### CSV 경로 주의사항

현재 스크립트는 다음 경로를 가정합니다.

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/AnyoneHere/sample-data/spots.csv'
INTO TABLE spots
...

운영체제, MySQL 설치 위치, 레포지토리 클론 위치,
secure_file_priv 설정에 따라 경로가 달라질 수 있습니다.
환경에 맞게 수정해야 합니다.


### MySQL 스크립트 실행 순서

이 프로젝트의 샘플 데이터베이스는 `/sql` 디렉터리의 스크립트로 초기화할 수 있습니다.

#### 1) 사전 준비

- MySQL 8.x 설치
- SQL/CSV 파일 경로 예시:
  - `C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\AnyoneHere\sql\`

#### 2) 스크립트 실행

터미널/CMD에서 MySQL bin 디렉터리로 이동한 뒤, 아래 순서대로 실행합니다.

```bash
cd "C:\Program Files\MySQL\MySQL Server 8.0\bin"

mysql -u root -p < "C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\AnyoneHere\sql\01_tables.sql"
mysql -u root -p < "C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\AnyoneHere\sql\02_load_sample_data.sql"
mysql -u root -p < "C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\AnyoneHere\sql\03_compute_spot_presence.sql"
mysql -u root -p < "C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\AnyoneHere\sql\04_view_spot_status.sql"



## Notes

- 본 레포지토리는 데이터 처리 및 집계 로직을 담당합니다.
- API 서버 및 프론트엔드 구현은 별도 레포지토리에서 관리될 수 있습니다.
- 집계 정책이나 데이터 구조 변경 시 docs/ 문서를 함께 업데이트해야 합니다.
