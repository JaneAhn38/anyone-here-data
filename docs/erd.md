# Anyone Here - Text ERD

본 문서는 Anyone Here 서비스의 데이터 구조를 정의한 텍스트 기반 ERD 문서입니다.
DB 구현 이전 설계 기준으로 사용됩니다.

---

## 1. users
서비스 사용자 기본 정보

- user_id (PK)
- email
- created_at

---

## 2. location_logs
사용자의 위치 로그 원본 데이터 (집계 전 raw 데이터)

- log_id (PK)
- user_id (FK → users.user_id)
- latitude
- longitude
- logged_at

---

## 3. spots
드라이브 스팟 정보

- spot_id (PK)
- name
- latitude
- longitude
- radius_m

---

## 4. spot_presence
특정 스팟에 현재 존재하는 사용자 수에 대한 집계 결과

- spot_id (FK → spots.spot_id)
- active_user_count
- calculated_at

※ spot_presence는 location_logs를 기반으로  
일정 시간/거리 기준에 따라 계산되는 집계 테이블이며,  
기준은 서비스 정책에 따라 변경될 수 있다.


---



## 5. 관계 요약

- users 1 : N location_logs
- spots 1 : N spot_presence
- location_logs는 spots와 직접 FK 관계를 갖지 않으며,
  거리 계산을 통해 집계 시점에 매핑된다.

---


## 테이블 관계 요약

- users 1:N location_logs
- spots 1:N spot_presence
- users N:M spots (location_logs 기반으로 계산)

  
