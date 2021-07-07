use myLibs;

drop table tbl_gallery;
create table tbl_gallery(
g_seq	bigint	auto_increment	primary key,
g_writer	varchar(20)	not null	,
g_date	varchar(10)	not null	,
g_time	varchar(10)	not null	,
t_subject	varchar(50)	not null,	 
g_content	varchar(1000)	not null	,
g_image	varchar(125)		
);

show tables;

drop table tbl_files;
create table tbl_files(
	file_seq	bigint	auto_increment	primary key,
	file_gseq	bigint	not null	,
	file_origin	varchar(125)	not null	,
	file_upname	varchar(125)	not null	
);

show tables;

select * from tbl_gallery;

insert into tbl_gallery(g_writer, g_date, g_time, g_subject,g_content)
values('aipro','2021-07-06','15:19:00','dust','realdust');

-- 현재 연결된 session에서 insert가 수행되고
-- 그 과정에서 auto_increment 칼럼이 변화가 있으면
-- 그 값을 알려주는 함수
select last_insert_id();

select * from tbl_files;

select * from tbl_gallery;

desc tbl_gallery;

insert into tbl_files(file_gseq,file_origin,file_update)
value(1,'title','uuid_title')(1,'title','uuid_title')(1,'title','uuid_title');

-- insert를 수행할때
-- auto_increment로 설정된 칼럼에
-- 0 도는 null, ''을 설정하면
-- auto_increment가 실행된다
insert into tbl_gallery(g_seq,g_writer,g_date,g_tile, g_subject,g_content)
value('','0','ddd','dkje',
use mylibs;

drop table tbl_gallery;
drop table tbl_files;

select * from tbl_files;
select * from tbl_gallery;

-- EQ Join
-- 카티션 곱
-- 두개의 table을 join하여 table 갯수 * table2 갯수만큼 list출력
select * from tbl_gallery G, tbl_files F
where G.g_seq = F.file_gseq
and G.g_seq = 1;

create view view_갤러리 as(
select  G.g_seq as g_seq, G.g_writer AS g_writer, G.g_date as g_date, 
G.g_time as g_time, G.g_subject as g_subject, G.g_content as g_content,G.g_image as g_image,
		F.file_seq as f_seq,F.file_origin as f_origin,F.file_upname as f_upname
from tbl_gallery G, tbl_files F
where G.g_seq = F.file_gseq
);

desc view_갤러리;

select * from view_갤러리;