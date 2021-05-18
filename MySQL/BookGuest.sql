-- 여기는 GBUSER
drop database GusetBook;
show databases;
use GuestBook;
drop table tbl_guest_book;
create table tbl_guest_book(
gb_seq	BIGINT	AUTO_INCREMENT	PRIMARY KEY,
gb_date	VARCHAR(10)	NOT NULL	,
gb_time	VARCHAR(10)	NOT NULL	,
gb_writer	VARCHAR(30)	NOT NULL,	
gb_email	VARCHAR(33)	NOT NULL,	
gb_password	VARCHAR(125)	NOT NULL	,
gb_content	VARCHAR(2000)	NOT NULL	
);

insert into tbl_guest_book(gb_date,gb_time,gb_writer,gb_email,gb_password,gb_content)
values('2021-05-18','10:2(:00','aipro','aipro@naver.com','12345','내일은 수요일');

select * from tbl_guest_book;

select count(*) from tbl_guest_book;

select * from tbl_guest_book
where gb_date = '2021-05-18';

select * from tbl_guest_book
order by gb_seq desc;

-- 날짜와 시간기준으로 최신글이 가장 먼저 보이도록
select * from tbl_guest_book
order by gb_date desc, gb_time desc;


-- update, delete 를 수행할때는
-- 두개 이상의 레코드에 영향이 미치는 명령은 매우 신중하게 실행해야 한다
-- 가자 ㅇ좋은 바업ㅂ은 변경, 삭제하고자는 데이터 여러개 있더라도
-- 가급적
update tbl_guest_book
set gb_time = '10:36:00'
where gb_seq = '2';

update tbl_guest_book
set gb_time = '10:29:00'
where gb_seq = '1';

select * from tbl_guest_book;

delete from tbl_guest_book
where gb_seq = '1';

select * from tbl_guest_book;
rollback;

select 30 * 40;

-- MYSQL 고유함수로 문자열을 연결할때
select concat('대한','민국','만세');

select * from tbl_guest_book
where gb_content like '%내일은%';

select * from tbl_guest_book
where gb_content like concat('%','내일은','%');

-- oracle의 decode()와 유사한 형태의 조건연사
-- gb_seq의 값이 짝수이면 짝수로 표시 아니면 홀수로 표시
select if(mod(gb_seq, 2) = 0,'짝수','홀수')
from tbl_guest_book;

select floor(rand() * 100);
select if(mod(floor(rand() * 100),2) = 0, '짝수', '홀수');

select count(*) from tbl_guest_book;

select * from tbl_guest_book
order by gb_date desc, gb_time desc;

select * from tbl_guest_book
where gb_content
like '%국가%'
order by gb_date desc, gb_time desc;

create view view_방명록 as
(
select gb_seq as '일련번호', gb_date as '등록일자', 
gb_writer as '등록자이름', gb_email as '등록 email',
 gb_password as '비밀번호', gb_content as '내용'
from tbl_guest_book
);

select * from view_방명록;