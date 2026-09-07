# 주석 : 문법 관련 내용, 마케팅 관 (어떤 의미를 갖고 있는지)
-- 단문 = 한 줄 주석
/*
복문주석
*/

# MySQL 프로그램 : RDBMS를 지원하기 위해서 만들어진 프로그램
# DB : Database = 여러 Data들이 모여 있는 그룹/집합 = 저장소
# Data : 관찰, 측정, 조사를 통해서 수집된 값, 사실, 기록
# 하나의 열 안에 들어가야 될 형태를 약속해두자! => Schema
# Schema : 약속 = 데이터 별 특정 요소들을 어떤 제약 조건 하에 기록, 저장할 것인가를 약속하는 것
# Table : 공통 주제에 속해 있는 데이터들을 별도로 관리하기 위해서 만들어 놓은 저장 단위
# MongoDB 프로그램 : NoSQL을 지원하기 위해서 만들어진 프로그램
# DBMS에 따라서 어떻게 관리할 것인지 > RDBMS (MySQL) > DB 안에 > Table이 존재하고 > Table 안에 Schema 기준으로 어떤 열에 어떤 값을 넣을지 약속해서 > 각각의 Data가 저장되어 있는 형태
# AI Agent & MCP : MySQL > AI가 해줄 것! / RCTCO : 프롬프트 작성 시, 관리가 되어지는 원리 시스템 알고 있는 상태에서 요청하는 것과 무지한 상태와는 결과값이 전혀 다를 것!

# SQL 문법 종류 4가지 분야
# DDL : Data Definition Language : CREATE, DROP, ALTER
# DML : Data Manipulation Language : SELECT, INSERT, UPDATE, DELETE
# DCL : Data Control Language : GRANT, REVOKE
# TCL : Transaction Control Language : COMMIT, ROLLBACK, SAVEPOINT

# Table : 실제 Data가 저장되어 있는 공간!
# 행, 열로 구성되어 있다!
# 1개의 행 = 레코드 (Record) = Row = 튜플 (Tuple)
# 1개의 열 = 속성 (Attribute) = Column > 하나의 컬럼 대표하는 어떠한 특성 의미 갖고 있는지에 대한 컬럼 정의하는 텍스트 Field Name (필드명)