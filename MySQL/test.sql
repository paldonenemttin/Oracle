-- 현재 존재하는 DataBase를 보여달라
SHOW databases;
-- 지금부터 MYSQL DataBase를 사용하겠다
-- 사용자와 연관없이 기본적으로 사용할 DataBase를 지정해 사용할 준비
use MYSQL;
-- 현재 접속한 DataBase(musql)에 있는
-- 모든 table을 보여달라
SHOW tables;
-- myDB라는 DataBase(데이터 저장소) 생성
CREATE database myDB;
-- 생성된 저장소 확인
SHOW databases;

-- MYSQL에서는 사용할 DB를 OPEN하기
-- USE 명령을 사용해 DB OPEN
USE MYDB;
-- 현재 DB(MYDB)에 있는 ㅁ모든 TABLE을 보여달라
SHOW TABLES;

-- my sql에서는 일련번호와 관련된 칼럼에
-- auto_increment 옵션을 설정하면
-- insert할때 값을 지정하지 않아도
-- 자동으로 id, seq 값을생성하여
-- 칼럼에 추가하여 준다.
CREATE TABLE tbl_test(
	id bigint primary key 
           Auto_increment,
    NAME varchar(50) NOT NULL,
    TEL varchar(20),
    ADDR varchar(125)
);

SHOW TABLES;
DESC  TBL_TEST;

insert INTO tbl_test(name, tel, addr)
values('홍길동','010-1234-5678','서울시');

select * from tbl_test;

-- my sql은 명령을 끝내도 이후 
CREATE TABLE tbl_books(
	bk_isbn	CHAR(13)		PRIMARY KEY,
	bk_title	VARCHAR(125)	NOT NULL,	
	bk_comp	VARCHAR(50)	NOT NULL	,
	bk_author	VARCHAR(50)	NOT NULL	,
	bk_trans varchar(20),
    bk_date	VARCHAR(10)		,
	bk_price	INT		,
	bk_pages	INT		
);

SHOW TABLES;
DESC tbl_books;

select * from tbl_books;

select count(*) from tbl_books;

-- 도서 가격이 25000원 이상인 데이터
select * from tbl_books
where bk_pages >= 10000;

-- 도서가격이 마누언 이상 2만원 이하 
select * from tbl_books
where  bk_pages >= 10000 and bk_pages <=20000;

-- 도서 명에 '왕' 문자열이 있는 데이터
select * from tbl_books
where bk_title like '%왕%';
-- java 등 코딩에서 중간 문자열 검색
--  oracle : '%'||'왕'||'%'
--  mysql : concat('%','왕','%')
select * from tbl_books
where bk_title like concat('%','왕','%'); 

-- 날짜 칼럼의 앞에 4글자만 보여라
select left(bk_date,4)
from tbl_books;

-- 발행일이 2018년도인 도서들
select * from tbl_books
where left(bk_date,4) = 2018;

-- 전체 데이터를 날짜 순으로 보여라
select * from tbl_books
order by bk_date;

-- 도서명을 역수능로 정령하여 표기하라
select * from tbl_books
order by bk_title desc;

-- 처음 3개의 데이터만 보여라
select * from tbl_books
limit 3;

-- 0부터 시작하여 3번째 테이터부터 2개
-- 게시판 등 코딩에서 pagination을 구현할때
-- 사용하는 방법
select * from tbl_books
limit 3,2;

create database BookRent;

use BookRent;

CREATE TABLE tbl_books(
	bk_isbn	CHAR(13)		PRIMARY KEY,
	bk_title	VARCHAR(125)	NOT NULL,	
	bk_ccode	CHAR(5)	NOT NULL	,
	bk_acode	CHAR(5)	NOT NULL	,
	bk_date	VARCHAR(10)		,
	bk_price	int		,
	bk_pages	int		
);

create table tbl_company(
cp_code	CHAR(5)		PRIMARY KEY,
cp_title	VARCHAR(125)	NOT NULL	,
cp_ceo	VARCHAR(20)		,
cp_tel	VARCHAR(20)		,
cp_addr	VARCHAR(125)	,	
cp_genre	VARCHAR(10)		
);

create table tbl_author(
au_code	CHAR(5)		PRIMARY KEY,
au_name	VARCHAR(50)	NOT NULL	,
au_tel	VARCHAR(20)		,
au_addr	VARCHAR(125)	,	
au_genre	VARCHAR(30)		
);

create table tbl_buyer(
bu_code	CHAR(5)		PRIMARY KEY,
bu_name	VARCHAR(50)	NOT NULL	,
bu_brith	INT	NOT NULL	,
bu_tel	VARCHAR(20)		,
bu_addr	VARCHAR(125)		
);

create table tbl_bookrent(
	br_seq bigint primary key auto_increment,
    br_sdate varchar(10) not null,
    br_isbn char(13) not null,
    br_bcode char(13) not null,
    br_edate varchar(10) not null,
    br_price INT
);