USE sakila;
SHOW TABLES;

SELECT * FROM payment LIMIT 10;

SELECT 
	DATE_FORMAT(payment_date, "%Y-%m") AS payment_month, 
    SUM(amount) 
FROM payment
GROUP BY payment_month
ORDER BY payment_month;
# 2005년 05월에서 06월 성장 / 07월 엄청난 성장 / 08월 소폭 하락 / 02월 대폭 하락

SELECT 
	customer_id,
    COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id;