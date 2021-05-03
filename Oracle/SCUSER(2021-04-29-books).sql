-- scuser로 접속

DROP TABLE tbl_books;

DROP TABLE tbl_books;
CREATE TABLE tbl_books(
    bk_isbn	CHAR(13) PRIMARY KEY,
    bk_title NVARCHAR2(125)	NOT NULL,	
    bk_ccode CHAR(5) NOT NULL,
    bk_acode CHAR(5) NOT NULL,	
    bk_date	CHAR(10),	
    bk_pages NUMBER	,
    bk_price NUMBER	
);

DROP TABLE tbl_company;

CREATE TABLE tbl_company(
    cp_code	CHAR(5) PRIMARY KEY,
    cp_title NVARCHAR2(125)	NOT NULL,	
    cp_ceo NVARCHAR2(20),
    cp_tel VARCHAR2(20),	
    cp_addr	NVARCHAR2(125),		
    cp_genre NVARCHAR2(30)
);

INSERT INTO tbl_company(cp_code,CP_TITLE , CP_CEO , CP_TEL , CP_ADDR ,CP_GENRE)
VALUES('S0001','가온누리','이루리','010-4598-1234','경북 가천로 125번길 16','라이트노벨');

SELECT * FROM tbl_company;

CREATE TABLE tbl_auther(
au_code	CHAR(5)		PRIMARY KEY,
au_name	NVARCHAR2(50)	NOT NULL,	
au_tel	VARCHAR2(20),
au_addr	NVARCHAR2(125),		
au_genre	NVARCHAR2(30)
);




