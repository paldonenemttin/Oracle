-- scuser로 접속

DROP TABLE tbl_dept;
CREATE TABLE tbl_dept(
  dp_code CHAR(3) PRIMARY KEY,
  dp_name NVARCHAR2(20) NOT NULL,
  dp_prof NVARCHAR2(20) NOT NULL
);


INSERT INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES('001','컴퓨터공학','토발즈');
INSERT INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES('002','전자공학','이철기');
INSERT INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES('003','법학','킹스필드');
INSERT INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES('004','관광학','이한우');
INSERT INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES('005','국어국문','백석기');
INSERT INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES('006','영어영문','권오순');
INSERT INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES('007','무역학','심하균');
INSERT INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES('008','미술학','필리스');
INSERT INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES('009','고전음악학','파파로티');
INSERT INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES('010','정보통신공학','최양록');

commit;

INSERT ALL
 INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES('001','컴퓨터공학','토발즈')
 INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES('002','전자공학','이철기')
 INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES('003','법학','킹스필드')
 INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES('004','관광학','이한우')
 INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES('005','국어국문','백석기')
 INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES('006','영어영문','권오순')
 INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES('007','무역학','심하균')
 INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES('008','미술학','필리스')
 INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES('009','고전음악학','파파로티')
 INTO tbl_dept(dp_code, dp_name, dp_prof)
VALUES('010','정보통신공학','최양록')
SELECT * FROM DUAL;

COMMIT;

SELECT * FROM tbl_dept;

SELECT dp_code AS 학과코드, dp_name AS 학과명, dp_prof AS 담당교수
FROM tbl_dept;

DROP TABLE tbl_student;
CREATE TABLE tbl_student(
    st_num	CHAR(5) PRIMARY KEY,	
    st_name	NVARCHAR2(20) NOT NULL,
    st_dcode CHAR(3) NOT NULL,
    st_grade CHAR(1) NOT NULL,
    st_tel	VARCHAR2(20) NOT NULL,
    st_addr	NVARCHAR2(125)	
);

SELECT COUNT(*) FROM tbl_student;

SELECT
    *
FROM tbl_student;

-- 학생테이블과 학과테이블을
-- 학생의 st_dcode 칼럼과 학과의 dp_code 칼럼을 연관지어
-- JOIN을 수행하라
-- 학생테이블의 모든데이터를 나열하고
-- 학과 테이블에서 일치하는 데이터를 가져와서 연관하여 보여라
SELECT ST.st_num 학번,
        ST.st_name 학생이름,
        ST.st_dcode 학과코드,
        DP.dp_name 학과명,
        DP.dp_prof 담당교수,
        ST.st_grade 학년,
        ST.st_tel 전화번호,
        ST.st_addr 주소
FROM tbl_student ST
LEFT JOIN tbl_dept DP
ON ST.st_dcode = do_code
ORDER BY ST.st_num;

CREATE VIEW view_학생정보(
       ST.st_num 학번,
       ST.st_name 학생이름,
        ST.st_dcode 학과코드,
        DP.dp_name 학과명,
        DP.dp_prof 담당교수,
        ST.st_grade 학년,
        ST.st_tel 전화번호,
        ST.st_addr 주소
FROM tbl_student ST
LEFT JOIN tbl_dept DP
ON ST.st_dcode = do_code
);
ORDER BY ST.st_num;


