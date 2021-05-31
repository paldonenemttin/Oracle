-- 하나마트
-- database 생성

create database nhDB;
show databases;

-- 사용할 데이터베이스에 연결하기
use nhDB;
drop table tbl_iolist;
-- table 생성
create table tbl_iolist(
	io_seq	BIGINT	auto_increment 	PRIMARY KEY,
	io_date	VARCHAR(10)	NOT NULL	,
    io_time	VARCHAR(10)	NOT NULL	,
	io_pname	VARCHAR(50)	NOT NULL,	
	io_dname	VARCHAR(50)	NOT NULL,	
	io_dceo	VARCHAR(20)	NOT NULL	,
	io_inout	VARCHAR(5)	NOT NULL,	
	io_qty	INT	NOT NULL	,
	io_price	INT	NOT NULL,	
	io_total	INT		
    );
	
desc tbl_iolist;

select count(*) from tbl_iolist;

-- 매입과 매출 합계 계산
-- io_inout 칼럼1이면 매입, 2이면 매출
-- 수량 * 단가 해서 계산
select (io_qty * io_price) 합계 
from tbl_iolist;

-- 매입합계, 매출합계
select SUM(io_qty * io_price) 합계 
from tbl_iolist
group by io_inout;

select io_inout, SUM(io_qty * io_price) 합계 
from tbl_iolist
group by io_inout;

-- oracle decode(조건, true, false)
select case when io_inout = '1' then '매입' 
			when io_inout = '2' then '매출'
		end as '구분',
        sum(io_qty * io_price) as '합계'
        from tbl_iolist
        group by io_inout;
        
-- if(조건, true, false) : mySQL 전용 함수
select if(io_inout = '1', '매입', '매출') as 구분,
sum(io_qty * io_price) as 합계
from tbl_iolist
group by io_inout;

-- 매입합계와 매출합계를 pivot 형식으로 조회
select if sum(if(io_inout = '1', io_qty, io_price, 0)) as 매입,
		  sum(if(io_inout = '2', io_qty, io_price, 0)) as 매출
from tbl_iolist;

select io_date as '일자',
       sum(if(io_inout = '1', io_qty * io_price, 0)) as 매입,
	   sum(if(io_inout = '2', io_qty * io_price, 0)) as 매출
from tbl_iolist
group by io_date
order by io_date;

-- 각 거래처 별로 매입매출 합계
-- pivot 방식으로 조회하기
select io_dname as '거래처',
		sum(if(io_inout = '1' , io_qty * io_price,0)) as 매입,
        sum(if(io_inout = '2' , io_qty * io_price,0))as 매출
from tbl_iolist
group by io_dname;

-- 표준 sql을 사용하여  거래처별로 매입 매출 합계
select io_dname as '거래처',
sum(case when io_inout = '1' then io_qty * io_price end) as '매입',
sum(case when io_inout = '2' then io_qty * io_price end) as '매출'
from tbl_iolist
group by io_dname;

-- 2020 4월 매입매출 리스트 조회
select *
from tbl_iolist
where io_date between '2020-04-01' and '2021-04-30';

-- 2020 4월 거래처별로 매입매출 합계
select io_dname as '거래처',
sum(case when io_inout = '1' then io_qty * io_price end) as '매입',
sum(case when io_inout = '2' then io_qty * io_price end) as '매출'
from tbl_iolist
where io_date between '2020-04-01' and '2021-04-30'
group by io_dname
order by io_dname;

-- left, mid, right
-- 문자열 칼럼의 데이터를 일부만 추출할때
-- left(칼럼, 갯수) : 왼쪽부터 문자열 추출
-- mid(칼럼, 위키, 갯수) : 중간문자열 추출
-- Oracle SUBSTR(칼럼, 위치, 갯수)
-- right(칼럼, 갯수) : 오른쪽부터 문자열 추출
select * from tbl_iolist
where left(io_date,7) = '2020-04';

select left('대한민국','2');
select left('Republic of',2);
-- mySQL은 언어와 관계없이 글자수로 인식
select left('대한민국',2),left('korea',2);
select mid('대한민국',2,2),mid('korea',2,2);
select right('대한민국',2),right('korea',2);