drop tablespace myLibs;
create tablespace myLibs;

create database myLibs;

use myLibs;

drop table tbl_books;
create table tbl_books(
	title	varchar(255),
	link	varchar(255),
	image	varchar(255),
	author	varchar(50),
	price	int,
	discount	int,
	publisher	varchar(50),
	isbn	char(13),
	description	varchar(2000),
	pubdate	varchar(20)
);