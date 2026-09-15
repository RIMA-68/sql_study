# VIEW  : DB에 저장이 됨! / 여러 쿼리에서 계속 사용이 가능! / CREATE VIEW 로 시작 / 재사용에 포커스가 맞춰져 있음!
# WITH = CTE = Common Table Expression
# 미리 사전에 SELECT 구문 만들고 쓰는 것은 VIEW 와 큰 틀적으로 봤을 때는 같아!
# 하지만 큰 차이 > 저장 X / WITH절을 사용한 그 순간의 쿼리에서만 한시적 사용이 가능! / WITH 로 시작 / "가독성"에 포커스가 맞춰져 있음!

# JOIN이나 서브쿼리보다 가볍다! 
WITH FilmInventory AS (
	SELECT
		DISTINCT film_id
    FROM inventory
)

SELECT
	F.film_id, F.title
FROM film F
JOIN FilmInventory FI USING(film_id);

# CASE WHEN
SELECT * FROM film LIMIT 10; # rental_rate

SELECT 
	title,
    CASE
		WHEN rental_rate < 1 THEN "Cheap"
        WHEN rental_rate BETWEEN 1 AND 3 THEN "Moderate"
        ELSE "Expensive"
	END AS price_category
FROM film;

# 특정 선택 구간, 요소가 발생되었을 때 정의할 수 있다

# Sakila > 각 고객 별 총 결제 금액을 계산
# 총 결제 금액 구간에 따라서 고객을 다음 항목으로 분류 후 출력
# 총 결제 금액 0 ~ 50 : Low / 51 ~ 100 : Medium / 100 초과 : High
# 단, 고객 별 총 결제 금액은 WITH절로 작성 후 위 쿼리 구문 조회, 출력하시오

SELECT * FROM payment;
SELECT * FROM customer;


WITH CustomerPayments AS (
	SELECT
		customer_id,
        SUM(amount) total_payment
    FROM payment
    GROUP BY customer_id
)

SELECT
	customer_id,
    CASE
		WHEN total_payment BETWEEN 0 AND 50 THEN "Low"
        WHEN total_payment BETWEEN 51 AND 100 THEN "Medium"
        ELSE "High"
	END PatmentStatus
FROM CustomerPayments;