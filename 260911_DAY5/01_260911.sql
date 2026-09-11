# SQL 기초 문법
# 실제 데이터를 활용한 응용 & 활용 문법
# sakila 데이터베이스 활용 기초 문법 + 중, 고급 문법

USE sakila; # 데이터 베이스 선택

SELECT * FROM film LIMIT 10; # 조회할 행의 수

SELECT COUNT(*) FROM film; # 데이터 행의 수

SELECT  DISTINCT rating FROM film; # 중복되는 값을 한 번만 조회

SELECT DISTINCT release_year FROM film;

SELECT * FROM rental WHERE inventory_id = 367; # 조건부로 조회

SELECT * FROM payment LIMIT 10;

SELECT COUNT(*) FROM payment; # 16,044개 집계함수

SELECT 
	SUM(amount), 
    AVG(amount), 
    MAX(amount), 
    MIN(amount)
FROM payment;
 # 연산처리 및 조회 함수
 
SELECT * FROM rental
WHERE inventory_id = 367 AND staff_id = 1; # 논리연산 + 조건식
 
SELECT rating FROM film
GROUP BY rating;
 
# DISTINCT : 중복 요소를 아예 제거하고 조회
# GROUP BY : 중복 요소를 하나의 대표 값으로 그룹핑 / 폴딩되어 있는 상태 = 접힌 상태
# GROUPING의 대상이 된 요소들은 집계 함수와 사용이 가능!

 SELECT 
	rating, 
    COUNT(*) AS rating_count # AS = Alias = 별칭 (생략 가능)
FROM film
GROUP BY rating; 