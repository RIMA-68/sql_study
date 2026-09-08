USE student_db;
SHOW TABLES;
DESC students;
SELECT * FROM students;

SELECT * FROM students
WHERE name LIKE "_E_"; # 총 3개의 문자열로 구성이 되어있어야 됨! 반드시 두 번째에는 E가 있어야 된다

# % : 0번 | 1번 이상
# _ : 해당 개수만큼 있어야 된다

SELECT * FROM students
WHERE name LIKE "____"; # 반드시 문자열이 4개인 행 찾아오기

SELECT * FROM students
WHERE name NOT LIKE "____"; # 4 문자열이 아닌 행 찾아오기

# WHERE : 조건절 -> 비교 & 논리 연산자와의 사용 많이 한다
# <> !=
# NOT : 부정 연산자이긴하지만, NULL이라는 값 잡기 위해 나온 경우가 많다

SET SQL_SAFE_UPDATES = 0;

UPDATE students SET age = 17, grade = "1학년"
WHERE name = "RIMA"; # OR PK 속성이 적용된 컬럼을 조건으로 사용!

SET SQL_SAFE_UPDATES = 1;