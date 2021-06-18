-- 여기는 testUser 접속

create table tbl_books(
    bk_isbn char(13) primary key,
    bk_ccode char(5) not null,
    bk_title nvarchar2(125) not null,
    bk_acode char(5) not null,
    bk_date varchar2(10),
    bk_pages number,
    bk_price number
);

drop table tbl_comp;
create table tbl_comp(
   cp_code	CHAR(5)		PRIMARY KEY,
cp_name	NVARCHAR2(125)	NOT NULL	,
cp_ceo	NVARCHAR2(30)	NOT NULL	,
cp_tel	varchar2(20)	NOT NULL	,
cp_addr	NVARCHAR2(125)		

);

create table tbl_author(
    au_code	char(5)		primary key,
    au_name	nvarchar2(125)	not null,	
    au_tel	varchar2(20)		,
    au_addr	nvarchar2(125)		
);

select count(*) from tbl_books;
select count(*) from tbl_comp;
select count(*) from tbl_author;

-- tbl_books 테이블에서
-- 각 몇권의 도서를 출판했는지 조회
select bk_ccode, count(*)
from tbl_books
group by bk_ccode;

select b.bk_ccode as 코드, 
c.cp_name as 출판사, 
count(*) as 권수
from tbl_books b 
  left join tbl_comp c
   on b.bk_ccode = c.cp_code
group by b.bk_ccode, c.cp_name;

-- tbl_books 테이블에서
-- 1. 도서 가겨이 2만원 이상인 도서들의 리스트
-- 2. 도서 가격이 2만원 이상읜 도서들의 전체 합계 금액
select * from tbl_books
where bk_price >= 20000;

select SUM(bk_price)
from tbl_books
where bk_price >=20000;

-- tbl_books, tbl_comp, tbl_author 세개의 table을 join하여
-- isbn, 도서명, 출판사명, 출판사대표, 저자, 저자 연락처
-- 출력되도록 작성
select
 b.bk_isbn as ISBN, b.bk_title as 도서명, c.cp_name as 출판사명, 
    c.cp_ceo as 대표, a.au_name as 저자, a.au_tel as 저자연락처
from tbl_books b
  left join tbl_comp c
    on b.bk_ccode = c.cp_code
  left join tbl_author a
   on bk_acode = a.au_code;

-- tbl_books, tbl_comp, tbl_author 세개의 table을 join하여
-- isbn, 도서명, 출판사명, 출판사대표, 저자, 저자 연락처, 출판일
-- 출력되도록 작성
-- 출판일이 2018년 데이터만
select
    b.bk_isbn as ISBN, b.bk_title as 도서명, c.cp_name as 출판사,
    c.cp_name as 대표, a.au_name as 저자, a.au_tel as 저자연락처,
    b.bk_date as 발행일
from tbl_books b
  left join tbl_comp c
   on b.bk_ccode = cp_code
  left join tbl_author a
   on b.bk_acode = au_code
WHERE b.bk_date between '2018-01-01' and '2018-12-31';

select
    b.bk_isbn as ISBN, b.bk_title as 도서명, c.cp_name as 출판사,
    c.cp_name as 대표, a.au_name as 저자, a.au_tel as 저자연락처,
    b.bk_date as 발행일
from tbl_books b
  left join tbl_comp c
   on b.bk_ccode = cp_code
  left join tbl_author a
   on b.bk_acode = au_code
WHERE substr(b.bk_date,0,4) = '2018';
/*
 SUBSTR(문자열 칼럼, 시작위치, 갯수)
 MYSQL: LEFT(문자열 칼럼, 시작위치, 갯수)
*/
CREATE VIEW view_도서정보 as(
select
 b.bk_isbn as ISBN, b.bk_title as 도서명, c.cp_name as 출판사명, 
    c.cp_ceo as 대표, a.au_name as 저자, a.au_tel as 저자연락처
from tbl_books b
  left join tbl_comp c
    on b.bk_ccode = c.cp_code
  left join tbl_author a
   on bk_acode = a.au_code
);

/*
자주 사용할 것같은 select sql은 view로 등록하면 언제든지 사용이 가능하다

그런데 자주 사용할 것 같지 않은 경우
view 생성하면 아무래도 저장공간ㅇ르 차지하게 된다

이럴때 한개의 sql(select)를 마치 가상의 table처럼
from절에 붙여서 사용할 수 있다
*/
select * from
(
select
 b.bk_isbn as ISBN, b.bk_title as 도서명, c.cp_name as 출판사명, 
    c.cp_ceo as 대표, a.au_name as 저자, a.au_tel as 저자연락처,
    b.bk_date as 발행일
from tbl_books b
  left join tbl_comp c
    on b.bk_ccode = c.cp_code
  left join tbl_author a
   on bk_acode = a.au_code
)
WHERE substr(발행일,0,4) = '2018';

-- tebl_books와 tbl_comp, tbl_books와 tbl_author fk 설정
-- bk_ccode와 cp_code       bk_acode와 au_code
ALTER table tbl_books
add constraint fk_company
foreign key(bk_ccode)
references tbl_comp(cp_code);

ALTER table tbl_books
add constraint fk_author
foreign key(bk_acode)
references tbl_author(au_code);

-- pk
-- 개체무결성을 보장하기 위한 조건
-- 내가 어떤 데이터를 수정, 삭제할때
-- 수정하거나 삭제하면 안되는 데이터를 유지하면서
-- 반드시 수정하거나 삭제하는 데이터는 수정, 삭제가 된다
-- 수정이상, 삭제 이상을 방지하는 방법
-- 또한 중복된 데이터를 절대 추가 할 수 없다 : 삽입이상을 방지하는 방법

-- FK
-- 두개 이상의 table을 연결하여 view(조회)를 할때
-- 어떤 데이터가 NULL 값으로 보이는것을 방지하기 위한 조치

-- Child(tbl_books):bk_ccode    Parent(tbl_comp):cp_code
-- 있을 수 있고 추가 가능     <<   있는 코드
-- 있어서는 안되며 추가 불가  <<   없는 코드
-- 있는 코드                 >>  삭제 불가능
-- 있는 코드                 >>  반드시 존재

-- 리처드 쇼튼의 연락처를 010-6676-6428에서
-- 010-9898-6428로 변경하기
update tbl_author set
au_tel = '010-9898-6428'
where au_code = 'A0006';

-- 정보를 수정, 삭제하는 절차
-- 내가 수정, 삭제하고자 하는 데이터가 어떤상태인지 조회
SELECT
    *
FROM tbl_author
where au_name = '리처드 쇼튼';

-- 수정하고자 하는 리처드 쇼튼의 pk를 확인했다
-- 수정, 삭제하고자 할땐 머넞 대상 데이터의 pk를 확인하고
-- pk를 where절에 포함하여 update, delete를 수행
update tbl_author set
au_tel = '010-9898-6428'
where au_code = 'A0006';

-- 실무에서 update, delete를 2개 이상 레코드에
-- 동시에 적용하는 것은 매우 위험한 코드이다
-- 꼭 필요한 경우가 아니면
-- update delete는 pk를 기준으로 한개씩 수행하는 것이 좋다