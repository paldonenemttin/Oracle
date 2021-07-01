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

use db_school;
drop table tbl_score;
/*
table에 insert into on duplicate key update를
실행하기 위해서는 pk 설정을 변경해야 한다
tbl_score는 두개의 칼럼을 기준으로 update나 delete를 수행하는 문제가 발생한다
가장 좋은 설계는 update delete를 수행할때 한개의 칼럼으로 구성된 pk를 기준으로 수행하는 것이다

pk는 그대로 살려두고alter두개의 칼럼을 묶어 unique로 설정
두개의 칼럼의 값이 동시에 같은 경우는 추가하지 말라는 제약 조건 설정
*/
create table tbl_score(
	sc_seq bigint auto_increment primary key,
    sc_stnum char(8) not null,
    sc_sbcode varchar(4) not null,
    sc_score int not null,
    unique(sc_stnum, sc_sbcode)
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

/*
과목 테이블과 성적테이블을 가지고
각 학생의 성적 리스트를 출력해보기
과목 리스트를 출력하고 각 과목의 성적이 입력된 학생의 리스트를 확인하기
학번을 조건으로 하여 한 학생의 성적 입력 여부를 확인하기

학생의 점수가 입력된 과목과 입력되지 않은 과목을 확인하고 싶다
*/
select SB.sb_code, SB.sb_name, SB.sb_prof, sc_stnum, sc_score
from tbl_subject SB
	left join tbl_score (select * from tbl_score where sc_stnum = '2021001')
		on sc_sbcode = SB.sb_code;

/*

*/
select SB.sb_code, SB.sb_name, SB.sb_prof, sc_stnum, sc_score
from tbl_subject SB
	left join tbl_score
		on sc_stnum = SB.sb_code
        and sc_stnum = '20210001' limit 5;
        
select count(*) from tbl_score
where sc_stnum = '20211001';

delete from tbl_student
where st_num = '20210103';

delete from tbl_student
where st_num = '20210104';
delete from tbl_student
where st_num = '20210102';
delete from tbl_student
where st_num = '20210105';

/*
한번의 insert로 다수의 데이터를 insert하기
이를 bulk insert라 함
*/
insert into tbl_score(sc_stnum, sc_sbcode, sc_score)
values
('20210002','S001',40),
('20210002','S002',50),
('20210002','S003',77),
('20210002','S004',64),
('20210002','S005',100);

select * from tbl_score;