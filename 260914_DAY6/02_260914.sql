# DB => Table > RDBMS = 관계형 데이터베이스 관리 시스템
# MySQL 프로그램의 SQL 문법
# 관계 Relationship이 중요 포인트!

# 서브쿼리 : 1개의 SELECT FROM 조회 구문 안에 또 다른 SELECT FROM 조회 구문을 사용해서 값을 조회
# 서브쿼리 구문은 1개의 쿼리문 안에서 횟수 제약 없이 사용이 가능!
# 서브쿼리가 많아질수록 구문을 이해하는데 있어서 가독성이 매우 안 좋아짐! 코드에 대한 효율성 떨어짐!
# 해당 문제점을 해결하기 위해 JOIN이라는 개념 출현!

# JOIN
# INNER JOIN : 서로 다른 Table 간 공통 요소만 살려두는 문법
# OUTER JOIN : 먼저 사용 및 선택된 Table 요소를 중심으로 살려두는 문법
	# LEFT OUTER JOIN
    # RIGHT OUTER JOIN

SHOW TABLES;

SELECT * FROM film_category LIMIT 10;
# film_category TABLE : film_id, category_id, last_update 세 개의 열로 구성되어 있음

SELECT * FROM category;
# category TABLE : category_id, name, last_update 세 개의 열로 구성되어 있음

# 서로 다른 두 TABLE 관계를 맺애서 값을 조회해올 수 있다! -> 관계형데이터베이스시스템의 큰 특징

# << 첫 번째 예제! >>
SELECT 
	category_id, 
	COUNT(*) 
FROM film_category
GROUP BY category_id;

SELECT 
	category_id, 
	COUNT(*) 
FROM film_category
WHERE film_category.category_id > (
				SELECT category.category_id 
                FROM category
                WHERE category.name = "Comedy"
		)
GROUP BY film_category.category_id;

# 현업 개발자 : 서브쿼리를 더 선호
# 현업 데이터 사이언티스트 : JOIN을 더 선호

# << 두 번째 예제! >>
SELECT * FROM customer LIMIT 10;
# customer TABLE : customer_id, store_id, first_name, last_name, email, address_id, active, create_date, last_update

SELECT * FROM payment LIMIT 10;
# payment TABLE : payment_id, customer_id, staff_id, rental_id, amount, payment_date, last_update
# customer_id 고객 별 평균 얼마를 지불했는가
# customer payment -> 관계를 맺어서 알 수 있다!

SELECT 
	first_name,
    last_name
FROM customer
WHERE customer_id IN (
		SELECT 
			customer_id
        FROM payment
        WHERE amount > (
				SELECT 
					AVG(amount)
                FROM payment
        )
	);
# 전체 지불 평균보다 높은 지출을 한 고객 성, 이름 조회
# IN 전치사 뒤에 붙은 서브쿼리문의 조건에 하나만 걸리면 됨!

# JOIN으로 바꾸기
SELECT
	DISTINCT C.first_name, # 중복적으로 볼 필요 없이 한 사람만 확인하면 되는 거니까! 
    C.last_name
FROM customer C
JOIN payment P ON C.customer_id = P.customer_id
JOIN (
		SELECT 
			AVG(amount) avg_amount
		FROM payment
) A ON P.amount > A.avg_amount;

# << 세 번째 예제!! >>
# Sakila DB > 가장 많은 결제 (횟수 = 집계)를 한 고객 찾기!

# 혼자 해보기 = 은지언니가 도와줬음!

SELECT
	first_name, 
    last_name
FROM customer C
WHERE C.customer_id IN ( # = 이것도 가능!
			SELECT 
				customer_id
              FROM (
							SELECT
								customer_id, 
								COUNT(*) as customer_count
							FROM payment
							GROUP BY customer_id
							ORDER BY customer_count DESC LIMIT 1
						) as  A
		);

# 1- 출력하고자 하는 값 : fullname (성, 이름) -> TABLE : customer
# customer TABLE 안에는 결제 상세 정보가 없다
# 2- 출력하고자 하는 값 : 결제가 일어났을 때의 정보 -> TABLE : payment

# 선생님과 함께 써보기!

SHOW TABLES;

SELECT * FROM payment LIMIT 10;

SELECT 
	first_name,
    last_name
FROM customer
WHERE customer_id = (
		SELECT 
			customer_id
		FROM (
				SELECT 
					customer_id,
					COUNT(*) payment_count
				FROM payment
				GROUP BY customer_id
		)  AS payment_counts
		ORDER BY payment_count DESC 
        LIMIT 1
);

# 상위 10명 추출하고 싶을 때

SELECT 
	first_name,
    last_name
FROM customer
WHERE customer_id IN (
		SELECT 
			customer_id
		FROM (
				SELECT 
					customer_id,
					COUNT(*) payment_count
				FROM payment
				GROUP BY customer_id
				ORDER BY payment_count DESC LIMIT 10
		)  AS payment_counts
);

# 출력 및 조회하고자 하는 요소에 조건을 걸어서, 조건에 충족되어지는 값을 조건문 안에 또 다른 쿼리문, 
# 서브의 역할을 하는 쿼리문과 대조 및 비교하여 값을 조회

# << 네 번째 예제 >>

SELECT 
	P.customer_id, 
    P.amount, 
    P.payment_date
FROM payment P
WHERE P.amount > (
		SELECT 
			AVG(amount)
        FROM payment
        WHERE customer_id = P.customer_id
);
# SELECT FROM 안에 > SELECT FROM -> (상관 서브쿼리)
# 서브쿼리가 메인쿼리를 참조하고 있다!
# 서브쿼리가 자체적으로 값을 도출하지 못하고, 밖에 있는 컬럼을 참조해서 도출하는 경우
# 상위 관계에 있는 메인 쿼리문으로부터 값을 찾아와서, 참조해서 값을 조회할 때! -> 이렇게 이해하는 것이 좀 더 취지에 맞을지도!

# << 다섯 번째 예제 >>
# film Table 에서 평균 영화 길이보다 긴 영화 들의 제목을 조회!
SELECT
	title
FROM film
WHERE length > (
		SELECT
			AVG(length)
        FROM film
);

# << 여섯 번째 예제 >>
# Sakila DB에서, 각 고객들이 자신이 대여한 영화들이 존재
# 그동안 대여했었던 영화들의 평균 길이보다 긴 영화들의 제목만 취합해서 출력!

# 혼자 해보기

# first_name, last_name, film_title
# customer -> first_name, last_name, customer_id
# film -> film_id, length, title
# rental -> rental_id, customer_id, inventory_id
# payment -> customer_id, rental_id, payment_id
# inventory -> inventory_id, film_id

SELECT * FROM customer;

# customer_id -> rental / inventory_id -> inventory / film_id -> film / length

SELECT 
	C.first_name,
    C.last_name,
    F.title
FROM customer C
JOIN rental R ON C.customer_id = R.customer_id
JOIN inventory I ON R.inventory_id = I.inventory_id
JOIN film F ON I.film_id = F.film_id
WHERE F.length > (
		SELECT
			AVG(length)
		FROM film
);

# 선생님과 함께 써보기!
# first_name, last_name, film_title

SHOW TABLES;
# 후보군 : payment, rental, inventory

SELECT * FROM customer LIMIT 10;
# customer_id, first_name, last_name
SELECT * FROM film LIMIT 10;
# film_id, titlem length
SELECT * FROM rental LIMIT 10;
# customer_id, inventory_id
SELECT * FROM inventory LIMIT 10;
# inventory_id, film_id

# customer rental inventory film

SELECT 
	C.first_name, C.last_name, F.title
FROM customer C
JOIN rental R ON C.customer_id = R.customer_id
JOIN inventory I ON R.inventory_id = I.inventory_id
JOIN film F ON I.film_id = F.film_id
WHERE F.length > (
		SELECT
			AVG(FIL.length)
        FROM film FIL
        JOIN inventory INV ON FIL.film_id = INV.film_id
        JOIN rental REN ON INV.inventory_id = REN.inventory_id
        WHERE REN.customer_id = C.customer_id
);

# replacement_cost : $20 이상인 영화를 대여한 고객의 이름 조회
# 출력값 고객 이름

SELECT
	DISTINCT CONCAT(C.first_name, "_", C.last_name) fullname
FROM customer C
JOIN rental R ON C.customer_id = R.customer_id
JOIN inventory I ON R.inventory_id = I.inventory_id
JOIN film F ON I.film_id = F.film_id
WHERE F.replacement_cost >= 20;

# film 테이블에서 rating이 "PG-13" 등급인 영화들이 있음
# 전체 영화들은 각각 description 영화 설명이 존재
# 전체 영화들의 개별적인 description의 길이가 rating이 "PG-13" 등급에 한한
# 영화들의 평균  description의 길이보다 긴 영화들의 제목만 조회, 출력
# 각각 영화들은 영화 설명을 표기한 컬럼이 존재 / 영화 설명에 대한 문자의 길이 등급이 PG-13에 한한 영화들의 평균 문자 길이도 있을 것 아녀
# 그것보다 긴 설명 문자보다 긴 영화들의 제목만 조회하기
# LENGTH() : 특정 컬럼 안에 입력되어 있는 문자열의 길이를 조회 추출하는 함수

SELECT * FROM film_text LIMIT 10;
# film_id, title, description
SELECT * FROM film LIMIT 10;
# film_id, title, description, rating

SELECT
	title, 
    LENGTH(description)
FROM film
WHERE rating = "PG-13";

 