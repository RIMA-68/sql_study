USE sakila;

SELECT 
	rating, 
    COUNT(*) rating_count,
    AVG(rental_rate) avg_rental_rate
FROM film 
GROUP BY rating
ORDER BY avg_rental_rate DESC; # default ASC 오름차순 / DESC 내림차순

SELECT 
	rating, 
    COUNT(*) rating_count,
    AVG(rental_rate) avg_rental_rate
FROM film
WHERE release_year = 2006 OR release_year = 2007
GROUP BY rating
ORDER BY avg_rental_rate DESC;
# GROUP화를 하고자 하는 대상이 존재 : 해당 GROUP화 대상의 조건이 직접적이지 않으면, WHERE 사용
# 이미 그룹화되어진 대상을 가지고 조건을 걸어야 되는 경우, HAVING

# HAVING : 그룹화 되어 있는 대상의 조건을 설정하고자 할 때!
SELECT 
	rating, 
    COUNT(*) rating_count,
    AVG(rental_rate) avg_rental_rate
FROM film
WHERE release_year = 2006 OR release_year = 2007
GROUP BY rating
HAVING rating_count >= 200
ORDER BY avg_rental_rate DESC;
# 그룹화가 되어진 요소와 함께 출력해야 되는 직접적인 대상들은 반드시 HAVING이라는 요소로 조건을 걸어준다!

# 표기 순서 : S -> F -> W -> G -> H -> O
# 실행 순서 : F -> W -> G -> H -> S -> O