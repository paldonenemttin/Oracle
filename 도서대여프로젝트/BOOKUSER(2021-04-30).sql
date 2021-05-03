CREATE TABLE tbl_books(
    bk_isbn	CHAR(13) PRIMARY KEY,
    bk_title NVARCHAR2(125)	NOT NULL,	
    bk_ccode CHAR(5) NOT NULL,	
    bk_acode CHAR(5) NOT NULL,	
    bk_date	VARCHAR2(10),
    bk_price NUMBER ,
    bk_pages NUMBER		
);

CREATE TABLE tbl_author(
    au_code	CHAR(5)	PRIMARY KEY,
    au_name	NVARCHAR2(50) NOT NULL,	
    au_tel	VARCHAR2(20) ,
    au_addr	NVARCHAR2(125),
    au_genre	NVARCHAR2(30)		
);

CREATE TABLE tbl_company(
    cp_code	CHAR(5)	PRIMARY KEY,
    cp_title NVARCHAR2(125)	NOT NULL,
    cp_ceo	NVARCHAR2(20),
    cp_tel	VARCHAR2(20),
    cp_addr	NVARCHAR2(125),
    cp_genre	NVARCHAR2(30)		
);

SELECT
    count(*)
FROM tbl_books;

SELECT
    count(*)
FROM tbl_company;

SELECT
    count(*)
FROM tbl_author;

-- 3개의 테이블을 join
drop view view_도서정보;
CREATE VIEW view_도서정보 AS
(SELECT B.bk_isbn AS ISBN,
       b.bk_title AS 도서명,
       c.cp_title AS 출판사명,
       c.cp_ceo AS 대표명,
       a.au_name AS 저자명,
       a.au_tel AS 저자연락처,
       b.bk_date AS 출판일,
       b.bk_price AS 가격,
       b.bk_pages AS 페이지
FROM tbl_books B
  LEFT JOIN tbl_company C
    ON b.bk_ccode = c.cp_code
    LEFT join tbl_author A
     on b.bk_acode = a.au_code
);

-- 단독 테이블로 생성된 view는 insert, update, delete 실행이 가능
-- table join으로 생성된 view는 읽기 전용
--      그러므로 insert, update, delete 실행 불가

SELECT * FROM "VIEW_도서정보";

DELETE tbl_books;

SELECT
    *
FROM tbl_books;

DELETE tbl_author;
