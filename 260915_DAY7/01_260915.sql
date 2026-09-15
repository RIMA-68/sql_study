# 2005년 8월에 대여된 모든 "R" 등급 영화의 제목과 해당 영화를 대여한 고객의 이메일을 조회
# 날짜 관련된 컬럼 -> 특정 연도 및 특정 월을 추출하고자 할 때 사용하는 함수 -> YEAR(customer.rental_date) / MONTH()

# 혼자 풀어보기

SELECT * FROM customer LIMIT 10;
# customer_id / email
SELECT * FROM rental LIMIT 10;
# rental_id / rental_date / customer_id / inventory_id
SELECT * FROM film LIMIT 10;
# film_id / title / rating
SELECT * FROM inventory LIMIT 10;
# inventory_id / film_id

# email customer_id -> TABLE rental inventory_id -> TABLE inventory film_id -> TABLE title rating

SELECT 
	F.title,
    C.email
FROM film F
JOIN inventory I ON F.film_id = I.film_id
JOIN rental R ON R.inventory_id = I.inventory_id
JOIN customer C ON C.customer_id = R.customer_id
WHERE F.rating = "R" AND YEAR(R.rental_date) = 2005 AND MONTH(R.rental_date) = 08;

# 선생님과 함께 풀어보기
# 렌탈이라는 대여 비즈니스 : 고객 대어 > 재고 > 영화

SELECT 
	F.title, 
    C.email
FROM film F
JOIN inventory I ON I.film_id = F.film_id
JOIN rental R ON R.inventory_id = I.inventory_id
JOIN customer C ON C.customer_id = R.customer_id
WHERE 
	MONTH(R.rental_date) = 8 AND 
    YEAR(R.rental_date) = 2005 AND
    F.rating = "R";

# USING 활용
SELECT 
	F.title, 
    C.email
FROM film F
JOIN inventory I USING(film_id) # 공동된 컬럼 확인하고 있다면 사용해라
JOIN rental R USING(inventory_id)
JOIN customer C USING(customer_id)
WHERE 
	MONTH(R.rental_date) = 8 AND 
    YEAR(R.rental_date) = 2005 AND
    F.rating = "R";

# 고객들의 대여 결제 정보 존재! 
# 각 고객 별 마지막 결제 시점, 해당 시점으로부터 30일 이전 기간 동안 결제 내역을 찾아서 
# 해당 결제 내역들의 전체 결제 내역의 합계, 평균 결제 금액 조회
# 출력 시, 소수점 첫 번째 자리까지 반올림해서 출력

SELECT * FROM payment LIMIT 10;

SELECT
	customer_id,
    ROUND(SUM(amount), 1) customer_sum,
    ROUND(AVG(amount), 1) customer_avg
FROM payment
WHERE payment_date >= DATE_SUB(
	(SELECT MAX(payment_date) FROM payment), INTERVAL 30 DAY
)
GROUP BY customer_id;

# 영화는 모두 카테고리를 가지고 있다! 
# 카테고리가 공상과학인 영화들에 출연한 배우의 이름을 찾아서 조회!
# 배우의 이름은 성, 이름 -> 하나로 연결해서 출력 CONCAT()
# 배우의 이름 출력 시, 대문자로 출력 UPPER()

# 혼자 풀어보기

SELECT * FROM actor LIMIT 10;
# actor_id / first_name / last_name
SELECT * FROM category;
# category_id / name (카테고리 이름)
SELECT * FROM film_category LIMIT 10;
# film_id / category_id
SELECT * FROM film_actor LIMIT 10;
# film_id / actor_id

# ACTOR first_name last_name : actor_id -> FILM_ACTOR film_id -> FILM_CATEGORY category_id -> CATEGORY name

SELECT
	UPPER(CONCAT(A.first_name, "_",  A.last_name)) AS fullname
FROM actor A
JOIN film_actor FA ON FA.actor_id = A.actor_id
JOIN film_category FC ON FC.film_id = FA.film_id
JOIN category C ON C.category_id = FC.category_id
WHERE C.name = "Sci-Fi";

# 선생님이랑 같이 풀기

SELECT
	UPPER(CONCAT(A.first_name, "_",  A.last_name)) AS fullname
FROM actor A
JOIN film_actor FA USING(actor_id)
JOIN film_category FC USING(film_id)
JOIN category C USING(category_id)
WHERE C.name = "Sci-Fi";
