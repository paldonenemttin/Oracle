create database statea;
drop database statea;
use statea;

drop table test;
create table test(
	test_board varchar(10) primary key
);

drop table test2;
create table test2(
	test_notice varchar(10) primary key
    );
    
drop table test3;
create table test3(
	test_custom varchar(10) primary key
);
create table test_like(
	test_code varchar(10), 
	test_likes int
);

alter table test_like
add constraint fk_like
foreign key (test_code)
references test(test_board);

alter table test_like
add constraint fk_likes
foreign key (test_code)
references test3(test_custom);

select * from information_schema.table_constraints where table_name = 'test_like';

-- 여기까지가 테스트 --
drop table tbl_like;
create table tbl_like(
like_seq bigint auto_increment primary key,
like_hit	bigint default 0	,
like_cncode	char(5)	not null	,
like_user char(5) 
);

drop table tbl_image;
create table tbl_image(
	img_code	bigint auto_increment		primary key,
	img_cncode	char(5)	not null			,
    img_origin	varchar(300)	not null	,
    img_upname  varchar(300)	not null	
	
);

drop table tbl_board;
create table tbl_board(
	bd_code	CHAR(5)		PRIMARY KEY,
bd_title	VARCHAR(50)	NOT NULL	,
bd_content	VARCHAR(1000)	NOT NULL,	
bd_user	VARCHAR(10)	NOT NULL	,
bd_time	varchar(20)	NOT NULL	,
bd_vcount bigint default 0
);
drop table tbl_notice;
create table tbl_notice(
	nt_code	CHAR(5)		PRIMARY KEY,
nt_title	VARCHAR(50)	NOT NULL	,
nt_content	VARCHAR(1000)	NOT NULL,	
nt_user	VARCHAR(10)	NOT NULL	,	
nt_time	varCHAR(20)	NOT NULL	
);

use statea;

select * from tbl_image;
select * from tbl_board;
select * from tbl_like;

delete from tbl_board
where bd_code = 'bd001';