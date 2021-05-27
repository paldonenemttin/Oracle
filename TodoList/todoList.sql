use mydb;

create table tbl_todolist(
	td_seq bigint auto_increment primary key,
    td_sdate varchar(10) not null,
    td_stime varchar(10) not null,
    td_doit varchar(300) not null,
    td_edate varchar(10) default '', 
    td_etime varchar(10) default ''
);

DESC tbl_todolist;

select * from tbl_todolist;