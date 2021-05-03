DROP TABLE tbl_student;
-- scuser로 접속   
-- 학생정보 table생성
DROP TABLE tbl_student;

CREATE TABLE tbl_student(
  st_num CHAR(5)PRIMARY KEY,
  st_name NVARCHAR2(20) NOT NULL,
  st_dept NVARCHAR2(20),
  st_grade VARCHAR2(10),
  st_addr NVARCHAR2(125)
);

CREATE TABLE tbl_student(
	st_num	CHAR(5) PRIMARY KEY,
    st_name	NVARCHAR2(20) NOT NULL,		
	st_deot	NVARCHAR2(10),		
	st_grade VARCHAR2(5),		
	st_tel	VARCHAR2(20),		
    st_addr	NVARCHAR2(125)		
)

DROP TABLE tbl_score;
CREATE TABLE tbl_score(
  sc_num	CHAR(5)		PRIMARY KEY,
  sc_kor	NUMBER	NOT NULL,	
  sc_eng	NUMBER	NOT NULL,	
  sc_math	NUMBER	NOT NULL	
);

DROP VIEW VIEW_1반학생;
DROP VIEW view_score;
DROP VIEW view_영어점수;

-- 임포트한 데이터 확인
SELECT * FROM tbl_student;

-- 임포트한 데이터의 갯수(데이터 레코드 수 ) 확인
-- COUNT(): SQL의 통계함수, 갯수를 계산
SELECT COUNT(*) FROM tbl_student;

DROP TABLE tbl_score;

SELECT SUM(sc_kor) AS 국어총점,
                   SUM(sc_eng) AS 영어총점,
                   SUM(sc_math) as 수학총점
                   FROM TBL_SCORE;

-- 숫자 칼럼의 연산을 하여 표시


-- 전체 학생 성적중에 국어 최고점, 최저점
SELECT MAX(sc_kor) 국어최고, MIN(sc_kor) 국어최저
FROM tbl_score;

-- 통계 함수
-- COUNT() SUM() AVG() MIN() MAX()
--  갯수 , 합산, 평균, 최소값, 최대값
-- 통계함수를 사용할때 통계에 포함하지 않는 칼럼을
-- 보고자 할때는 GROUP BY를 사용하여 묶어줘야 한다
-- 학번으로 묶어서, 동일한 학번의 국어점수의 합계할때
SELECT sc_num, SUM(sc_kor)
FROM tbl_score
GROUP BY sc_num;

SELECT
    *
FROM tbl_score;

SELECT
    *
FROM tbl_student
WHERE st_num = 'S0090';

-- 성적데이터를 보면서
-- 각 학생의 이름 등을 같이 보고 싶다
-- 2개의 테이블을 JOIN하여 함께 보자
-- tbl_score 테이블을 
-- tbl)score와 sc_num 칼럼의 값과 같은 데이터를 
-- tbl_student에서 찾아서 함께 나열하라
SELECT
    *
FROM tbl_score, tbl_student
WHERE sc_num = st_num;

SELECT st_num, st_name, st_deot, sc_kor, sc_eng, sc_math
FROM tbl_score, tbl_student
WHERE sc_num = st_num;


-- 2개 이상의 테이블을 join할때
-- 각각 테이블의 칼럼이름이 같은 경우
-- 문제가 발생 할 수 있다
-- 문제가 발생할 경우는 각 테이블 이름을 명시해 주어야 한다
SELECT tbl_score.sc_num,
       tbl_student.st_name,
       tbl_student.st_deot,
       tbl_score.sc_kor,
       tbl_score.sc_eng,
       tbl_score.sc_math
FROM tbl_score, tbl_student
WHERE sc_num = st_num;

-- 테이블에 Alias를 추가한 후
-- 각 칼럼 이름에  Alias를 사용할 수 있다
-- 테이블 Alias에도 AS
-- 오라클에서는 테이블 Alias에  AS키워드를 사용하면
-- (수정 추가 해야 함)

-- EQJOIN(참조 무결성이 보장된ㄴ 경우 사용하는 일반적인 JOIN)
SELECT SC.sc_num,
       ST.st_name,
       ST.st_deot,
       SC.sc_kor,
       SC.sc_eng,
       SC.sc_math
FROM tbl_score SC, tbl_student ST
WHERE sc_num = st_num;


-- 학생데이터에서 일부를삭제한 후 JOIN을 실행했더니
-- 성적 데이터가 79개 밖에 조회되지 않는다

-- 테스트를 위해 학생데이터 일부를 삭제
DELETE FROM tbl_student
WHERE st_num <= 'S0080';

-- 학생데이터에는 1~79번까지만 있고
-- 성적데이터에는 1~ 100Rkwl dlTek
-- 성적데이터의 80~100까지는
-- 실제 존재하는 학생인지 아닌지 증명할 방법이 없다
-- 성적데이터는 무결성이 깨진 상태가 된다
-- 학생테이블과 성적데이블간의 연관(관계) 참조가 무너진 상태가 된다
-- 이러한 현상을 참조 무결정이 오류가 발생했다라고 표현한다
-- 참조 무력ㄹ성에 문제가 생긴경우 JOIN했을때 데이터의 신회성을 보증할 수 없다
SELECT * FROM tbl_score;
SELECT * FROM tbl_student;

-- 참조 무결성 여부와 관계없이
-- 모든 데이터를 JOIN하여 보고 싶을때

-- 참조무결성에 문제가 있는 경우
-- LEFT JOIN(LEFT OUT JOIN)
--    tbl_score 테이블의 데이터는 모두 보여주고
--     학생테이블에서 학번이 일치하는 학생이 있으면
--      같이 보여달라
-- 보통 table의 참조무결성 보증을 설정한느경우가 있는데
-- 참조관계에 없느 ㄴ다수의 테이블의JOIN하여 보고 싶을때는
-- LEFT JOIN을 사용한다
-- 참조 무경성 보증이 된 경우도 LEFT JOIN을 수행하면
-- 모든 데이터의 참조 무결성이 잘되고 있는지 확인 할 수 있다
SELECT SC.sc_num,
       ST.st_name,
       ST.st_deot,
       SC.sc_kor,
       SC.sc_eng,
       SC.sc_math
FROM tbl_score SC LEFT JOIN tbl_student ST
ON sc_num = st_num;

-- EQ JOIN을 실행할때 조건을 부여하지 않으면
-- 테이블 곱하기 테이블 만큼의 데이터가 출력된다
-- 이렇게 인출된 데이터를 "카티션곱"이라고 한다
SELECT COUNT (*) FROM tbl_score, tbl_student;

-- 학생 데이터에 없는 학생의 성적이 추가되엉 씨는지 일부를 알고 싶을때
-- 참조 무결성에 오류가 있는지 알고 싶을때
SELECT COUNT(*)
FROM tbl_score LEFT JOIN tbl_student
ON sc_num = st_num;

-- 학생데이터를 모두 나열하고
-- 학생 데이터와 일치하는 성적데이터만 보여라
-- 학생 데이터와 성적 데이터간의 참조 무결서엥 오류가 있기때문에
-- 실제 학생 데이터에 존재하는 성적정보만 보고 싶을때
SELECT COUNT(*) FROM tbl_student
LEFT JOIN tbl_score
ON st_num = sc_num;

-- ROUND() DBMS 시스템 함수, 소수점이하 자릿수 제한
-- ROUND(값, 자릿수) : 자릿수 이하에서 반올림
-- ROUND(값, 0) :자릿수 이하값은 무조건 절사
-- TRUNK(값, 자릿수) : 자릿수 이하 값은 무조건 절사
CREATE VIEW view_성적정보 AS
(SELECT SC.sc_num AS 학번, ST.st_name AS 이름,
       ST.st_deop AS 학과, ST.st_grade AS 학년,
       ST.st_tel AS 전화번호, SC.sc_kor AS 국어,
       SC.sc_eng AS 영어, SC.sc_math AS 수학,
       (SC.sc_kor + SC.sc_eng + SC.sc_math) AS 총점,
       ROUND((SC.sc_kor + SC.sc_eng + SC.sc_math)/3,2) AS 평균,
       ROUND((SC.sc_kor + SC.sc_eng + SC.sc_math)/3,0) AS 평균1
       FROM tbl_score SC 
       LEFT JOIN tbl_student ST
ON sc_num = st_num
);

CREATE VIEW view_성적정보 AS
(SELECT SC.sc_num AS 학번, ST.st_name AS 이름,
       st.st_deot AS 학과, ST.st_grade AS 학년,
       ST.st_tel AS 전화번호, SC.sc_kor AS 국어,
       SC.sc_eng AS 영어, SC.sc_math AS 수학,
       (SC.sc_kor + SC.sc_eng + SC.sc_math) AS 총점,
       ROUND((SC.sc_kor + SC.sc_eng + SC.sc_math)/3,2) AS 평균,
       ROUND((SC.sc_kor + SC.sc_eng + SC.sc_math)/3,0) AS 평균1
       FROM tbl_score SC 
       LEFT JOIN tbl_student ST
ON sc_num = st_num
);