DROP TABLE tbl_buyer;
CREATE TABLE tbl_buyer(
    bu_code	CHAR(5)	PRIMARY KEY,
    bu_name	NVARCHAR2(50) NOT NULL,	
    bu_brith NUMBER NOT NULL ,
    bu_tel	VARCHAR2(20) ,
    bu_addr	NVARCHAR2(125)		
);

INSERT INTO tbl_buyer(bu_code, bu_name, bu_brith, bu_tel, bu_addr)
VALUES('H0001','니똥꼬','20210503','010-5754-4907','트롤리시 가분로 248');

SELECT * FROM tbl_buyer;

DELETE FROM tbl_buyer;

DROP TABLE tbl_book_rent;

CREATE TABLE tbl_book_rent(
    br_seq	NUMBER PRIMARY KEY,
    br_sdate VARCHAR2(10) NOT NULL,
    br_isbn	CHAR(13) NOT NULL,
    br_bcode CHAR(5) NOT NULL,	
    br_edate VARCHAR2(10),	
    br_price NUMBER		
);

-- 세개의 테이블을 참조 무결성 설정
-- 대상 Table은 다중관계의 Table
-- tbl_buyer 데이터 1개 고객이
-- 다수의 tbl_book_rent table에 포함이 된다
-- tbl_buyer 1 : tbl_book_rent N = 1 : 다의 관계이다
-- N의 table에서 fk 설정을 하고 1의 table과 관계를 맺는다

ALTER TABLE tbl_book_rent -- N(다 多)의 테이블
ADD CONSTRAINT fk_isbn -- FK 이름
FOREIGN KEY(br_isbn) -- N table의 칼럼
REFERENCES tbl_books(bk_isbn); -- 1 table과 칼럼

ALTER TABLE tbl_book_rent
ADD CONSTRAINT fk_buyer
FOREIGN KEY(br_bcode)
REFERENCES tbl_buyer(bu_code);

/*
tbl_book_rent table에는 필수 사용하는 데이터 칼럼을
pk로 설정하는데 어려움이 있다
다른 table 의 칼럼을 참조를 하고는 있짐나
모든 칼럼이 중복 값을 가질수 있는 관꼐로
만일 칼럼으로 pk를 설정할 수 없다

pk를 설정하고 더불어 주문관련 리스틀르 보는데 사용할
br_seq 칼럼을 만들고 이 컬럼으로 pk를 설정했다

book_rent 테이블에 데이터를  INSERT 하려고 할때
항상 유일할 값으로 pk를 설정해야 하는 어려움이 있다
보통 이러한 칼럼은 일련 번호 순으로 만드는데
오라클을 이외의 다른 dbms에는 일련번호를 자동으로 만들어주는
Table 속성이 있다
오라클(11이하)에서는 그러한 속성이 없다
mySQL 의 경우 칼럼 속성에 AUTO_INCREMENT로 설정을 하면
그 칼럼은 insert 할때 별도 값을 지정하지 않아도
항상 유일한 일련번호 자동 생성이 된다

오라클에서는 이련번호를 생성하기 위한 별도의 객체가 존재

*/

-- 오라클에서 일련번호를 생성하는 SEQUENCE 객체
-- DDL 명ㄹ여을 사용하여 SEQ 객체 생성
-- 이름을 명령할때  SEQ_로 시작하고
-- 뒤에 적용할 대상 TABLE명을 붙여 생성한다
DROP SEQUENCE seq_book_rent;
CREATE SEQUENCE seq_book_rent -- SEQ이름
START WITH 1 -- 시작값
INCREMENT BY 1; -- 자동증가값

SELECT seq_book_rent.NEXTVAL FROM DUAL;

INSERT INTO tbl_book_rent(br_seq, br_sdate, br_isbn, br_bcode)
VALUES (SEQ_BOOK_RENT.nextval,'2021-05-03', '9791162540756','B0001');

select * from tbl_book_rent;

-- 이미 만들어져 있는 seq 삭제
DROP SEQUENCE seq_book_rent;

-- 가존에 사용하던 seq를 삭제하고 다시 생성할 경우
 -- 반드시 적용되는 table의 칼럼 값을 확인해야 ㅎ나다
 -- seq 칼럼의 최댓값을 확인하고
 select max(br_seq) from tbl_book_rent;
 
-- SEQ의 START 값을 적용하는 테이블의 SEQ 최댓값보다 크게 설정해야 함
CREATE SEQUENCE seq_book_rent
START WITH 3
INCREMENT BY 1;

INSERT INTO tbl_book_rent(br_seq,br_sdate,br_isbn,br_bcode)
VALUES(seq_book_rent.nextval,'2021-05-03','9791162540756','B0002');

select * from tbl_book_rent;

-- tbl_book_rent는 회원이 도서를 대여한 리스트가 있다
-- 여기엔 도서코드, 회원코드 만 있기 때문에
-- 구체적인 정보를 알수 없다
-- table join을 통해서 구체적인 정보를 확인하자
-- EQ JOIN
select * from tbl_book_rent BR, tbl_books BO, tbl_buyer BU
WHERE br.br_isbn = bo.bk_isbn AND br.br_bcode = bu.bu_code;

-- INNER JOIN
-- fk 관계가 설정된  table간에 사용하는 join
-- FK 관계가 설정되지 않은 TABLE간에선 조회되는 데이터가 실제와 다를 수 있다
SELECT br.br_sdate AS 대여일,
       br.br_bcode as  회원코드,
       bu.bu_name as 회원명,
       br.br_isbn as ISBN,
       BK.bk_title AS 도서명,
       br.br_edate AS 반납일,
       br.br_price AS 대여금
FROM tbl_book_rent br join tbl_books bO
on br.br_isbn = bO.bO_isbn join tbl_buyer on br.br_bcode = bu.bu_code;


-- left (outhr) join
--  테이블간에 fk가 설정되지 안혹
-- 참조하는 테이블의 데이터가 마련되지 않은 경우
 -- from 절에 표현된 table 데이터 위주로 조회하고자 할때
 -- fk설정되지 않아도 데이터 조회는 모두 할 수 있다
 -- 단 join 된 테이블에 데이터가 없으면 null로 표현된다
 
DROP VIEW view_도서정보;

CREATE VIEW view_도서대여정보 as
(SELECT br.br_sdate AS 대여일,
       br.br_bcode AS 회원코드,
       bu.bu_name AS 회원명,
       bu.bu_tel AS 회원연락처,
       br.br_isbn AS ISBN,
       bk.bk_title AS 도서명,
       br.br_edate AS 반납일,
       br.br_price AS 대여금
FROM tbl_book_rent BR LEFT JOIN tbl_books BK ON br.br_isbn = bk.bk_isbn 
LEFT JOIN tbl_buyer BU ON bR.bR_bcode = bU.bU_code);

SELECT OBJECT_TYPE FROM USER_OBJECTS WHERE OBJECT_NAME='view_도서정보';

select * from "VIEW_도서대여정보";

select * from view_도서대여정보
where 회원명 = '명윤일';

select * from "VIEW_도서대여정보"
WHERE 대여일 < '2021-04-30';

-- 4월 25일 이전에 대여했는데 이작 반납이 안된 사람
select * from view_도서대여정보
where 대여일 < '2021-04-25' and 반납일 is null;

SELECT 대여일,회원코드, 회원명, 반납일, BU.bu_tel
FROM view_도서대여정보 BR
    LEFT JOIN tbl_buyer BU
        ON BR.회원코드 = BU.bu_code
WHERE 대여일 < '2021-04-25' AND 반납일 IS NULL;        

-- 중복된 데이터가 있으면 그룹으로 묶어서
-- 단순하게 보여달라
SELECT 대여일,회원코드, 회원명, BU.bu_tel
FROM view_도서대여정보 BR
    LEFT JOIN tbl_buyer BU
        ON BR.회원코드 = BU.bu_code
WHERE 대여일 < '2021-04-25' AND 반납일 IS NULL
GROUP BY 대여일,회원코드, 회원명, BU.bu_tel;

/*
위의 코드는 전체 데이터중에서 대여일과 반납일에 조건을 부여한후
데이터를 간추리고, 간추려진 데이터를 GROUP으로 묶어 보여주기

아래 코드는 전체 데이터를 GROUP으로 묶고
묶인 데이터를 조건에 맞는 항목만 보여주기

이 두 코드는 결과는 같지만
실행하는 성능은 매우 많은 차이가 난다
데이터가 많을 수록 성능 차이는 매우 극명하게 나타난다
*/

SELECT 대여일,회원코드, 회원명, BU.bu_tel
FROM view_도서대여정보 BR
    LEFT JOIN tbl_buyer BU
        ON BR.회원코드 = BU.bu_code
GROUP BY 대여일,회원코드, 회원명, BU.bu_tel, 반납일
HAVING 대여일 < '2021-04-25' AND 반납일 IS NULL;

-- 예시)
/*
 학생이름  과목  점수
 ----------------------
 홍길동    국어  50
 홍길동    영어  50
 홍길동    수학  50
 홍길동    과학  50
 이몽룡    국어  90
 이몽룡    영어  80
 이몽룡    수학  70
 이몽룡    과학  70
 ----------------------
 홍길동    250
 이몽룡    310
 이 데이터에서 홍길동 학생의 4과목 총점을 계산하기 위한 코드
 */ 
SELECT 학생이름, SUM(점수)
FROM tbl_score
GROUP BY 학생이름
HAVING SUM(점수) > 250;


-- tbl_score에서 과학, 수학 2과목의 점수만 총점을 계산하고 싶다
SELECT 학생이름, SUM(점수)
FROM tbl_score
WHERE 과목 = '과학' OR 과목 = '수학'
GROUP BY 학생이름;

-- 직업별로 급여의 합계 계산하기
SELECT 직업, SUM(급어)
FROM tbl_급여
GROUP BY 직업;

-- 직업별로 급여를 합계 계산할때
-- 직업이 영업직 인 사람을 제외하고 싶다
SELECT 직업,SUM(급여)
FROM tbl_급여
WHERE 직업 != '영업직'
GROUP BY 직업;

SELECT 직업,SUM(급여)
FROM tbl_급여
GROUP BY 직업
HAVING 직업 != '영업직';

-- 급여테이블에서 영업직을 제외한 직업의 급여 총합계를 계산하고
-- 총 합계가 3000000 이상인 데이터만 보여라
SELECT 직업,SUM(급여)
FROM tbl_급여
WHERE 직업 != '영업직'
GROUP BY 직업
HAVING SUM(급여) >= 3000000;

-- 급여테이블에서 영업직을 제외하고
-- 실 급여가 1000000을 초과하는 데이터만 합산하여 보여라
SELECT 직업,SUM(급여)
FROM tbl_급여
WHERE 직업 != '영업직' AND 급여 > 1000000
GROUP BY 직업;

-- 대여일이 2021-04-25 이전이고 아직 미납된 데이터
SELECT *  FROM view_도서대여정보
WHERE 대여일 < '2021-04-25' AND 반납일 IS NULL;

SELECT 대여일, 회원코드, 회원명, 회원연락처, 도서명
FROM view_도서대여정보
WHERE 대여일 < '2021-04-25' AND 반납일 IS NULL
GROUP BY 대여일, 회원코드, 회원명, 회원연락처, 도서명;

INSERT INTO tbl_book_rent(br_seq,
            br_sdate, br_bcode, br_isbn)
VALUES ( seq_book_rent.NEXTVAL,
            '2021-04-01','B0011','9791188850266');

INSERT INTO tbl_book_rent(br_seq,
            br_sdate, br_bcode, br_isbn)
VALUES ( seq_book_rent.NEXTVAL,
            '2021-04-01','B0011','9791188850389');

-- 대여일이 2021-04-25일 이전이고 아직 미반납된
-- 대여정보를 보여라
-- 그리고 회원코드순으로 보여라
SELECT 대여일, 회원코드, 회원명, 회원연락처, 도서명
FROM view_도서대여정보
WHERE 대여일 < '2021-04-25' AND 반납일 IS NULL
GROUP BY 대여일, 회원코드, 회원명, 회원연락처, 도서명
ORDER BY 회원코드;

