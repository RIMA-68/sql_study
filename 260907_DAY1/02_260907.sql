# DB : 데이터를 관리할 수 있는 가장 큰 카테고리
# 소문자로 해도 되던데, 왜 굳이 대문자로 하나요?
# 현업 -> 대문자 사용
# 영어 베이스 기반 SQL 쿼리문 : 예약어 | 명령어 / 업데이트 : 모르면 명령어 인지, 커스터마이징한 문자열인지 알 수 없음!
# Oracle에서는 색상 표기도 없어!
# 실행 : ctrl + enter : 현재 작성한 쿼리문 실행
# 서로 다른 테이블 간 어떤 연결 및 관계를 맺도록 할 것인가!

CREATE DATABASE dbname;

SHOW DATABASES;

USE dbname;

# 하나의 테이블 안에 복수의 데이터 서로 관계를 갖고 있음! 테이블 갯수 제한 없이 생성해서 넣을 수 있음!
# 스페이스보다 Tab키 추천! = 스페이스 4번과 동일
# 추가할 열과 해당 열의 특성 설정
CREATE TABLE mytable (
	id INT, 
    name VARCHAR(50),
    PRIMARY KEY(id)
);

# 현업 스타일 (반복해서 값을 넣는 것 비효율적, 행이 많아지는 것 별로)
# AUTO_INCREMENT 값이 들어올 때마다 값 하나씩 증가 / 각각의 행을 식별하는 주요한 역할을 하게끔 하겠다
CREATE TABLE mytable (
	id INT PRIMARY KEY AUTO_INCREMENT, 
    name VARCHAR(50)
);

# 현재 생성된 테이블이 어떤 규칙으로 정의되어 있는가를 보려고 할 때
DESC mytable;

# 현재 생성된 테이블 안에서 값 조회
SELECT * FROM mytable;

# 데이터베이스 삭제
DROP DATABASE dbname;