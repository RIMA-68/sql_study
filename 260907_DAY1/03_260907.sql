# bit, bytes
# bit = 컴퓨터 취급 최소한의 연산 처리 단위 = 0, 1
# byte = bit 8개 = 1 byte = 2^8 = 256

CREATE TABLE mytable(
	id INT UNSIGNED # 부호를 사용하지 X, 음의 정수 영역 사용 X -> 양의 정수만 사용
);

CREATE DATABASE IF NOT EXISTS customer_db;
SHOW DATABASES;
USE customer_db;

# NULL = 결측값
# 0, not, none => 값이 결여되어있는 상태! (언제라도 값이 들어올 수 있다는 전제 조건을 깔고 있음)
CREATE TABLE IF NOT EXISTS customer(
	no INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    age INT NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(30) NOT NULL,
    address VARCHAR(50)
);

# 기존 생성 테이블 안의 스키마 변경 수정!
# Table 내 컬럼 속성 변경
ALTER TABLE customer MODIFY COLUMN 
name VARCHAR(30) NOT NULL;

# Table 내 컬럼명 변경 + 속성 변경
ALTER TABLE customer CHANGE COLUMN 
name user_name VARCHAR(20) NOT NULL;

# 동시에 여러 구문을 같이 실행하고자 할 때,
# 구문의 가독성을 위해서 들여쓰기를 적절하게 해주면 좋다!
ALTER TABLE customer
	CHANGE COLUMN age user_age INT,
	CHANGE COLUMN phone user_phone VARCHAR(30) NOT NULL;

DESC customer;