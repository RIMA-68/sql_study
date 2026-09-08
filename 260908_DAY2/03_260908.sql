# MySQL 프로그램 설치 > 가입 > 로그인
# CMD > Workbench가 없어도 쿼리문을 작성, 조회, 사용 가능!
# 변수 > 시스템환경변수 > 고급탭 선택

# CMD > MySQL Shell > DCL 문법을 사용할 수 있는 권한이 있다

# 로컬(내 컴퓨터)에서만 접속 가능한 사용자
CREATE USER 'nagisa'@'localhost' IDENTIFIED BY 'jakah6829';

# 로컬 컴퓨터의 hostname, port 아닌 경우에도 접속할 수 있는 사용자
CREATE USER 'nagisaGlobal'@'%' IDENTIFIED BY 'jakah6829';

# 클라우드 컴퓨팅
# 과거 > 어떤 사이트 접속하려면 : 반드시 '서버' 라는 개념이 필요했다! / 서버실이 존재했다!
# 서버 > 취급하는 데이터 접속량에 비례해서 > 서버에 대한 사이즈가 커짐! 공간에 대한 부담이 커진다!
# 화재, 재난 > 서버가 물리적인 공격을 받을 수 있음
--
# 가상공간 > DB > 데이터 적재하자!
# 서버가 가진 단점이 있으니, 이를 가상 공간에 두는 건 어떨까? 물리적 환경을 할애할 필요가 없어지겠지!
# 물리적 공격 피할 수 있음! 물론 사이버 공격은 좀 더 취약해졌겠지만.
# DB도 가상공간으로 간다 > 이 가상공간을 클라우드 라고 해!
# MySQL > 클라우드로 갈 수 있다! AWS : EC2 // Azure // Firebase (클라우딩 컴퓨팅 지원 클라우드 서버 관리 운영 생성하는 저장소)

USE student_db;

# 내 MySQL 접근 권한 갖고 있는 user 조회
SELECT host, user FROM mysql.user;

SET PASSWORD FOR 'nagisa'@'localhost' = 'nagikami';

DROP USER 'nagisa'@'localhost';

SHOW GRANTS FOR 'nagisaGlobal'@'%';

# 'GRANT USAGE ON *.* TO `nagisaGlobal`@`%`' -> 모든 권한을 nagisaGlobal에게

GRANT SELECT ON student_db.students TO 'nagisaGlobal'@'%';
# 특정 권한만 허용하고자 할 때 사용!
# GRANT INSERT, SELECT, UPDATE ON DB이름.테이블이름 TO 'userid'@'host';

# GRANT ALL ON DB이름.* TO 'userid'@'host';
# 특정 DB 안에 있는 모든 테이블에 대해 권한을 주겠다!

# *.* : 모든 DB 안에 있는 모든 Table
# 이런 방식으로도 구문을 쓸 수 있다는 예시를 들기 위해 해봅시다!
GRANT ALL ON *.* TO 'nagisaGlobal'@'%';
# 'GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, SHUTDOWN, PROCESS, FILE, REFERENCES, INDEX, ALTER, SHOW DATABASES, SUPER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE TABLESPACE, CREATE ROLE, DROP ROLE ON *.* TO `nagisaGlobal`@`%`'

REVOKE SELECT ON student_db.students
FROM 'nagisaGlobal'@'%';

# 계정 유지는 할 것인데, 이 사용자에게 주었던 모든 권한을 회수 
# GRANT OPTION 사용자가 모든 권한 받은 상황이었기에 다른 사용자에게 권한을 주었을 수도 있다. 그것조차 다 회수
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'nagisaGlobal'@'%';

# SQL 기본 개념 / 기본 문법
# Sakila DB 활용 실습 해볼 것!
# 다양한 문법 다뤄볼 예정!
# 그 전에, 실제 사이트에서 데이터 수집 + 수집한 것 MySQL에 저장