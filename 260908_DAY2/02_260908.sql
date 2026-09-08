DROP DATABASE student_db;

DELETE FROM students; # DB는 그대로 둔 상태에서 해당 테이블 안에 있는 값을 제거

DELETE FROM steudents WHERE name = "RIMA";
# Error Code: 1146. Table 'student_db.steudents' doesn't exist

DESC students;

TRUNCATE TABLE students;
# 기존 테이블의 구조는 유지하면서 값만 제거