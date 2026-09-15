# VIEW = 가상 테이블 = Virtual Table
# SubQuery | JOIN 사용할 경우 -> 쿼리 구문 행수가 많아짐 -> 자연스럽게 코드 가독성 저하 시킴
# -> 사람이 코드를 보면서 쿼리 구문을 작성에 -> 실수가 많아질 수 있음
# 사전에 가상으로 값을 저장시켜 놓은 테이블 준비
# 해당 테이블을 필요에 따라서 가져다가 사용 -> 쿼리 구문 독립성을 유지 -> 실수 확률 낮아짐! (VIEW를 쓰는 목적)

# VIEW 구문 사용 -> 실제 데이터가 저장되는 것은 아님!! / SELECT 형식의 쿼리 구문만 저장!

# CREATE 라는 명령문과 항상 같이 움직인다!

CREATE VIEW ActorInfo AS 
SELECT first_name, last_name
FROM actor
WHERE actor_id < 100;

SELECT * FROM ActorInfo;

# VIEW 한 번 생성되면, 다른 프로젝트 구문에서도 사용이 가능!
# VIEW는 동일한 이름으로 이미 생성되어있다면, 같은 이름을 또 다시 사용할 수 없다!
# 같은 이름을 또 쓰고 싶다면 CREATE OR REPLACE VIEW ~ 이렇게 작성해서 덮어쓰기!

# 그래서 지울 수 있는 방법도 있다!
DROP VIEW ActorInfo;

SELECT * FROM customer; # MARY SMITH : customer_id가 1번인 사람

CREATE OR REPLACE VIEW myview AS
SELECT * FROM customer
WHERE customer_id = 1;

SELECT * FROM myview;

UPDATE customer
SET first_name = "REO"
WHERE customer_id = 1;

# VIEW 해당 데이터 어딘가에 저장이 됨! WITH는 이게 안 됨! 그 때만 잠깐! 
# VIEW는 실존하는 데이터이기 때문에 이 값이 바뀌어지면 그 값을 조회한 값도 변경되어진 값으로 가지고 온다!
# 그러니까 중복 사용도 안되는거겠지!

UPDATE customer
SET first_name = "MARY"
WHERE customer_id = 1;
# 다시 MARY로 돌려주기

DROP VIEW myview;