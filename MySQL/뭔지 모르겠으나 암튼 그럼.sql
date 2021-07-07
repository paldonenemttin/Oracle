select * from tbl_company;

create database mybook;

use mybook;

create table tbl_books(
bk_isbn	CHAR(13)		PRIMARY KEY,
bk_title	VARCHAR(125)	NOT NULL,	
bk_ccode	CHAR(5)	NOT NULL	,
bk_acode	CHAR(5)	NOT NULL	,
bk_date	VARCHAR(10)		,
bk_price	INT		,
bk_pages	INT		
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

drop table tbl_buyer;
create table tbl_user(
bu_code	CHAR(5)		PRIMARY KEY,
bu_name	VARCHAR(50)	NOT NULL	,
bu_birth	INT	NOT NULL	,
bu_tel	VARCHAR(20)		,
bu_addr	VARCHAR(125)		
);

create table tbl_book_rent(
br_seq	BIGINT		PRIMARY KEY	,
br_sdate	VARCHAR(10)	NOT NULL,		
br_isbn	CHAR(13)	NOT NULL	,	
br_bcode	CHAR(5)	NOT NULL	,	
br_edate	VARCHAR(10)			,
br_price	INT			
);

select * from tbl_company;

select * from tbl_author ;

use mybook;

desc tbl_books;