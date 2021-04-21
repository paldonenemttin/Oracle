-- IOUSER 권한으로 접속
-- IOUSER는  DBA 권한을 갖고 있기 때문에
-- 일반적인 표준 DDL. DML, DCL 명령등을 사용할 수 있다
-- DDL(data definition Lang. 데이터 정의어)
--     객체생성 CREAT TABLE, VIEW, INDEX
--     객체 삭제 DROP, TABLE, VIEW, INDEX
--     객체 변경(수정) ALTER TABLE, INDEX
-- ORACLE 전용 DDL
--      객체 생성  CREATE SEQUENCE

-- 거래내역 저장할 TABLE
CREATE TABLE tbl_iolist(
  io_date VARCHAR2(10), -- 2021-04-21
  io_buyer NVARCHAR2(20),
  io_pname NVARCHAR2(20),
  io_qty NUMBER,
  io_price NUMBER,
  io_total NUMBER
  );
  
-- 생성된 table에 데이터 추가
INSERT INTO tbl_iolist(io_date, io_buyer, io_qty, io_price)
VALUES ('2021-01-01','홍길동',10,1000);

--데이터 전체 조회
SELECT io_date,io_buyer,io_pname,io_qty,io_price FROM tbl_iolist;

-- 위에서 생성한  tbl_iolist는 데이터를 추가하는데
-- 아무런 제약조건을 설정하지 않았다
-- 그랬더니 insert를 수행했을때 실수로 상품명을 입력하지 않았는데도
-- 데이터가 insert 되어버렸다
-- 나중에 확인을 해보니 상품이 없어서 데이터 활용가치가
-- 떨어지는 현상이 발생했다
-- 이런 상황을 "insert(추가, 삽입) 이상현상"이 발생했다
--  무결성이 훼손되었다
-- 기존의 Table을 제거하고 무결성을 유지하기 위한 
-- 제약조건을 설정하여 table을 다시 만들자

DROP TABLE tbl_iolist;
CREATE TABLE tbl_iolist(
  io_date VARCHAR2(10), -- 2021-04-21
  io_buyer NVARCHAR2(20),
  io_pname NVARCHAR2(20) not null,
  io_qty NUMBER,
  io_price NUMBER,
  io_total NUMBER
);

-- 다시 데이터insert 테스트(상품데이터를 입력하지 않은 상태로)
INSERT INTO tbl_iolist(io_date, io_buyer, io_qty, io_price)
VALUES ('2021-01-01','홍길동',10,1000);
-- 명령 수행에서 오류발생
-- io_pname 칼럼에 null을  insert할 수 없다
-- io_pname에 데이터가 setter 되지 않았다

INSERT INTO tbl_iolist(io_pname) VALUES('새우깡');
-- 조건 없이 모든 데이터를 조회하라(출력하라)
SELECT *FROM tbl_iolist;

-- 원한느칼럼을 배열하고 조건없이 모든 데이터를 조회하라
-- Projection 지정
SELECT io_pname,io_buyer FROM tbl_iolist;

-- 데이터를 insert하는데 필수적으로 setting되어야 할 칼럼에
-- 필수 제약조건을 설정하자
CREATE TABLE tbl_iolist(
  io_date VARCHAR2(10) not null, -- 2021-04-21
  io_buyer NVARCHAR2(20)not null,
  io_pname NVARCHAR2(20) not null,
  io_qty NUMBER not null,
  io_price NUMBER not null,
  io_total NUMBER
);

-- select 명령문의  as(alias) 원래 table의 칼럼명을 변경하여 표현하고 싶을때
-- 1. tbl_iolist로 부터 데이터를 가져오고
-- 2. project로 설정된 칼럼들 데이터만 추출하여
-- 3. 리스트를 출력한다
insert into tbl_iolist(io_date,io_buyer,io_pname,io_qty,io_price)
values ('2021-04-21','홍길동','새우깡',10,1000);
SELECT io_date AS 거래일자, io_buyer AS 고객명, io_pname AS 상품명,
       io_qty AS 수량, io_price AS 단가 , io_qty * io_price AS 합계
from tbl_iolist; --iolistDB.iouser.tbl_iolist에서 데이터를 가져와라

INSERT INTO tbl_iolist(io_date, io_buyer, io_pname, io_qty, io_price)
VALUES ('2021-01-01','이몽룡', '어묵탕' ,10,1000);
INSERT INTO tbl_iolist(io_date, io_buyer, io_pname,io_qty, io_price)
VALUES ('2021-01-01','성춘향','신라면',10,1000);
INSERT INTO tbl_iolist(io_date, io_buyer, io_pname,io_qty, io_price)
VALUES ('2021-01-01','임꺽정','빗자루',10,1000);
insert into tbl_iolist(io_date,io_buyer,io_pname,io_qty,io_price)
values ('2021-04-21','홍길동','매일우유',10,5000);

SELECt * FROM tbl_iolist;

-- 1. tbl_iolist로 부터 데이터를가져오기
-- 2. 가져온 데이터 중에서 io_buyer 칼럼에 저장된 값이
-- 홍길동인 데이터만 간추려서
-- 3. 보여달라
SELECT
    *
FROM tbl_iolist
WHERE io_buyer = '홍길동';

-- tbl_iolist에 저장되어 있는데이터 리스트 중에서
-- io_buyer 칼럼의 값이'홍길동'인 데이터만 간추려서
-- io_buyer, io_pname 칼럼만 보이고 나머지 칼럼은 숨겨서 보려달라
-- 보여지는 칼럼에는 별명을 붙여서 보여라
SELECT io_buyer as 고객명, io_pname as 구매상품
FROM tbl_iolist
WHERE io_buyer = '홍길동';
