-- ksuser로 접속

DROP TABLE tbl_stud;
CREATE TABLE tbl_student(
    st_num	CHAR(5)		PRIMARY KEY,
    st_name	NVARCHAR2(20)	NOT NULL	,
    st_tel	VARCHAR2(20)	NOT NULL	,
    st_addr	NVARCHAR2(125)		,
    st_grade	NUMBER	NOT NULL	,
    st_dpcode	CHAR(4)	NOT NULL	
	
);
DROP TABLE tbl_subj;
CREATE TABLE tbl_dept(
        dp_code	CHAR(4)		PRIMARY KEY,
    dp_name	NVARCHAR2(20)	NOT NULL,	
    dp_pro	NVARCHAR2(20)	NOT NULL,	
    dp_tel VARCHAR2(5)		

);

CREATE TABLE tbl_subject(
    sb_code	CHAR(5)		PRIMARY KEY,
    sb_name	NVARCHAR2(20)	NOT NULL,	
    sb_prof	NVARCHAR2(20)		
);

DROP TABLE tbl_score;
CREATE TABLE tbl_score(
    sc_seq	NUMBER		PRIMARY KEY,
    sc_stnum	CHAR(5)	NOT NULL	,
    sc_sbcode	CHAR(5)	NOT NULL	,
    sc_score	NUMBER		

);

SELECT COUNT(*) FROM tbl_dept;
SELECT * FROM tbl_score;
SELECT COUNT(*) FROM tbl_student;
SELECT * FROM tbl_subject;

-- left join을 하여 import된 두 테이블간의 데이터 유효성 검증
-- 학생 Table에 없는 학과 코드가 있는지 검증하기
-- 학생 Table과 학과 Table 간의 fk 설정을 하기 위한 검증
-- 결과 List에서 절대 (null)이 없어야 한다
SELECT st.st_num AS 학번, st.st_name AS 이름, st.st_tel as 연락처,
       st.st_dpcode as 학과코드, st.st_addr as 주소, dp.dp_name as 학과명,
       st.st_grade as 학년
       FROM tbl_student ST LEFT JOIN tbl_dept dP
     ON st.st_dpcode = dp.dp_code;

drop view view_성적정보;
CREATE VIEW view_성적정보 as
(
SELECT sc.sc_seq as 일련번호, sc.sc_sTNUM as 학번, st.st_name as 학생이름,
       st.st_tel as 전화번호, sc.sc_sbcode as 과목코드, sb.sb_name 과목명,
       sc.sc_score 점수 ,sb.sb_prof 담임교수
      FROM tbl_score sc
      LEFT JOIN tbl_student st
         on sc.sc_stnum = st.st_num
      LEFT JOIN tbl_subject sb
        on sc.sc_sbcode = sb.sb_code
);

SELECT * FROM "VIEW_성적정보";

-- 학생별 총점
-- 학번 과목 점수 형태로 저장된 제2 정규화 테이블
SELECT 학번, 학생이름, SUM(점수) as 총점, ROUND(avg(점수),1) as 평균
from VIEW_성적정보
GROUP by 학번, 학생이름
ORDER by 학번;

SELECT 학번, DECODE(과목명,'국어',점수) AS 국어점수
FROM "VIEW_성적정보"
ORDER BY 학번;

-- 위의 SQL을 학번으로 GROUPING하고
-- 각 점수를 합산(SUM())하면
-- DBMS의 SQL에서는 (NULL) +숫자 = 0+숫자 와 같다
--  SUM(
DROP VIEW view_성적보고서;
CREATE VIEW view_성적보고서 as
(
SELECT 학번, 
        SUM(DECODE(과목명,'국어',점수)) AS 국어점수,
          SUM(DECODE(과목명,'영어',점수)) AS 영어점수,
            SUM(DECODE(과목명,'수학',점수)) AS 수학점수,
            SUM(DECODE(과목명,'데이터베이스',점수)) AS DB점수,
            SUM(DECODE(과목명,'미술',점수)) AS 미술점수,
            SUM(DECODE(과목명,'음악',점수)) AS 음악점수,
            SUM(DECODE(과목명,'소프트웨어공학',점수)) AS SW점수,
            SUM(점수) AS 총점,
            ROUND(AVG(점수),1) AS 평균
FROM "VIEW_성적정보"
GROUP BY 학번);

SELECT * FROM VIEW_성적보고서
ORDER BY 학번;

select sc.학번, st.st_name as 학생이름, st.st_tel as 전화번호,
      sc.국어점수, sc.수학점수,sc.영어점수
from view_성적보고서 sc
       LEFT JOIN tbl_student st on sc.학번 = st.st_num;
