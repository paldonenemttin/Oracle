create database score;

use score;

drop table tbl_score;
create table tbl_score(
	sc_seq BIGINT	AUTO_INCREMENT	PRIMARY KEY,
    sc_stcode char(8) not null unique,
	sc_kor int not null,/*A02C5*/
    sc_eng int not null,/*A86G7*/
    sc_math int not null,/*A00B5*/
    sc_ethi int,/*B83E9*/
    sc_geo int,/*B43N0*/
    sc_acc int,/*B65Y1*/
    sc_hygi int,/*B29V7*/
    sc_info int,/*B71H3*/
    sc_all int not null,
    sc_float float,
    sc_count int
);

drop table tbl_student;
create table tbl_student(
	st_code char(8) primary key,
    st_spec varchar(20) not null,
    st_name varchar(20) not null,
    st_grade char(1) not null,
    st_tel varchar(13),
    st_addr varchar(100)
);

create table tbl_subject(
	sb_code char(5) primary key,
    sb_name varchar(20) not null,
    sb_prof varchar(20) not null
);

drop table tbl_allscore;
create table tbl_allscore(
	as_seq BIGINT	AUTO_INCREMENT	PRIMARY KEY,
    as_stcode char(4)not null,
    as_kor int not null,/*A02C5*/
    as_eng int not null,/*A86G7*/
    as_math int not null,/*A00B5*/
    as_ethi int,/*B83E9*/
    as_geo int,/*B43N0*/
    as_acc int,/*B65Y1*/
    as_hygi int,/*B29V7*/
    as_info int,/*B71H3*/
    as_all int not null,
    as_float float,
    as_count int
);

alter table tbl_allscore
add constraint fk_student
foreign key(as_stcode)
references tbl_student(st_code);

use score;

alter table tbl_allscore drop foreign key fk_student;

select
as_seq, as_all, as_info, as_float
from tbl_allscore;