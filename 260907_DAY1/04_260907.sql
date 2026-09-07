# DB 생성 -> 생성된 DB 안에 테이블 -> 테이블 안에 있는 값을 정의하기 위해 Schema -> Modify / Change -> INSERT -> UPDATE
# Data X

CREATE DATABASE student_db;
USE student_db;

CREATE TABLE students (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30),
    age INT UNSIGNED,
    grade VARCHAR(10)
);

INSERT INTO students VALUES(1, "RIMA", 17, "1학년");

INSERT INTO students (name, age, grade)
VALUES("REO", 19, "3학년");

INSERT INTO students (name, age, grade)
VALUES
	("JUN", 18, "2학년"),
    ("REI", 20, "3학년"),
    ("NIKI", 19, "3학년");

SELECT * FROM students;

UPDATE students
SET grade = "2학년", age = 18
WHERE id = 1;

# MySQL 프로그램 설치 > 구글 포털 > 베타 버전에서는 전부 바뀌어 버림 / 지금은 아래 구문이 오류 나는 게 당연해!
UPDATE students
SET grade = "3학년", age = 19;

# SAFE UPDATE 모드 끄겠다! = 하지만 이건 위험하니까, 함부로 껐다 켰다 하지 마시오~
SET SQL_SAFE_UPDATES = 0;

UPDATE students
SET grade = "1학년", age = 17
WHERE grade = "2학년" AND age = 18;
# 왜 안될까? PK가 아니기 때문에 조건의 대상이 될 수 없음! UPDATE 진행할 시, KEY로 설정되어진 컬럼이 조건값이 들어가야 됨!
# SET SQL_SAFE_UPDATES = 0; 하면 됨 / 하고 난 다음에 SET SQL_SAFE_UPDATES = 1; 하면 다시 켜짐 / 켜놓고 작업하는 걸 추천!

# DB 생성 -> 생성된 DB 안에 테이블 -> 테이블 안에 있는 값을 정의하기 위해 Schema -> Modify / Change -> INSERT -> UPDATE -> SELECT
# 조회하기!

SELECT * FROM students; # * = all

SELECT * FROM students WHERE age >= 19; # WHERE = 조건절
SELECT * FROM students WHERE age <> 19;
# 조건절 : 비교연산자 & 논리연산자
# 비교연산자 : = >= <= > < != <>

SELECT * FROM students WHERE NOT age = 18;
# NOT -> 연산자 아님! 예악어 안에 > 논리 부정 키워드!
# 단순 부정 연산을 위한 목적보다, NULL의 연산처리를 위한 목적이 더 크다!
# IS NOT NULL : 관례상 이렇게 쓰임 NULL 잡기에 NOT이 유리해서!

SELECT * FROM students WHERE age IS NOT NULL;
# 아래거는 값이 안 나와!
SELECT * FROM students WHERE age <> NULL;

SELECT * FROM students
WHERE (age > 18 AND grade = "3학년") OR grade = "1학년";
# AND : 좌항 AND 우항 -> 좌항도 True / 우항도 True

SELECT * FROM students
WHERE name LIKE "R%"; # % => 0개 혹은 그 이상의 존재 정의 # R로만 시작하면 된다! 이름이 R인 경우도 찾아 옴

SELECT * FROM students
WHERE name LIKE "%R%"; # 이름에 R만 들어가면 됨! 