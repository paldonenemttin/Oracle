create database db_school;

use db_school;

drop table tbl_student;
create table tbl_student(
	st_num char(8) primary key,
    st_name varchar(20) not null,
    st_dept varchar(20) not null,
    st_grade int not null,
    st_tel varchar(20) not null,
    st_addr varchar(200) 
);

insert into tbl_student(st_num, st_dept, st_grade, st_tel)
values('홍길동', '컴퓨터공학과', 3 , '010-1234-5678');
commit;
insert into tbl_student(st_num, st_name, st_dept, st_grade, st_tel)
values('A7810024','홍길동', '컴퓨터공학과', 3 , '010-1234-5678');

drop table tbl_score;
create table tbl_score(
	sc_seq bigint auto_increment primary key,
    sc_stnum char(8) not null,
    sc_sbcode varchar(4) not null,
    sc_score int not null
);

insert into tbl_score(sc_stnum, sc_sbcode, sc_score)
values('20210001','S001',67);
insert into tbl_score(sc_stnum, sc_sbcode, sc_score)
values('20210002','S002',87);
insert into tbl_score(sc_stnum, sc_sbcode, sc_score)
values('20210001','S003',100);


create table tbl_subject(
	sb_code char(4) primary key,
    sb_name varchar(20) not null,
    sb_prof varchar(20)
);

drop table tbl_subject;
insert into tbl_subject(sb_code, sb_name, sb_prof)
values('S001','국어','이세종');

use db_school;

commit;