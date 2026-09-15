# SET = 집합 쿼리 구문

# UNION : 두 개 이상의 SELECT문의 결과 집합을 출력해주는 구문 (중복행 제거)
# 조회가 되어진 결과값을 집합으로 출력해준다!
# UNOIN ALL : UNION과 기능은 동일하나, 중복된 행을 포함

# INTERSECT : 집합으로 본다면, 교집합!
# EXCEPT : 집합으로 본다면, 차집합!

# UNION | UNION ALL | INTERSECT | EXCEPT
# 집합 쿼리 구문을 사용하려면, 반드시 각 SELECT 구문의 열이 같은 순서로 되어 있어야 된다!
# 데이터 유형도 동일해야 된다! (스키마 타입이 같아야 된다!)

SELECT film_id FROM film
UNION ALL
SELECT film_id FROM inventory;

# INTERSECT / EXCEPT -> MySQL에서 지원 안 됨!

# TRANSACTION 구문 : START TRANSACTION // COMMIT // ROLLBACK

SELECT * FROM customer LIMIT 10;

SET SQL_SAFE_UPDATES = 0;
START TRANSACTION;

UPDATE customer
SET first_name = "RIMA";

SELECT * FROM customer LIMIT 10;

ROLLBACK;

# MARY : customer_id 1번인 사람
START TRANSACTION;

UPDATE customer
SET first_name = "RIMA"
WHERE customer_id = 1;

SELECT * FROM customer LIMIT 10;

COMMIT;
# COMMIT 하면 ROLLBACK 안 됨!
ROLLBACK;