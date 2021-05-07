-- NHUSER로 접속
DROP TABLE tbl_iolist;
CREATE TABLE tbl_iolist(
    io_seq	NUMBER		PRIMARY KEY,
    io_date	VARCHAR2(10)	NOT NULL,	
    io_time	VARCHAR2(10)	NOT NULL,	
    io_pname	NVARCHAR2(50)	NOT NULL	,
    io_dname	NVARCHAR2(50)	NOT NULL	,
    io_dceo	NVARCHAR2(20)	NOT NULL	,
    io_inout	VARCHAR2(1)	NOT NULL	,
    io_qty	NUMBER	NOT NULL	,
    io_price	NUMBER	NOT NULL	
);

select io_inout, count(*)
from tbl_iolist
group by io_inout;

-- io_inout 칼럼의 데이터가 1이면 매입을 표시
-- 아니면 매출을 표시하라
select decode(io_inout,'1','매입','매출') as 구분,
  count(*)
  from tbl_iolist
  group by decode(io_inout,'1','매입','매출');

-- if io_inout == 1 THEN '매입'
-- else if io_inout == 2 THEN '매출'
  select decode(io_inout,'1','매입','2','매출') as 구분,
  count(*)
  from tbl_iolist
  group by decode(io_inout,'1','매입','2','매출');

/*
매입매출 데이터를 db import 한 후 
데이블에서 상품정보와 거래처 정보를 분리하여
제3 정규화를 수행하기

현재 매입매출 데이블에 상품이름과 거래처명(대표포함)이
저장되어 있다
현재 데이블에서 만약 상품이름이나 거래처명이 변경되어야 하는
일이 발생한다면
다수의 데이터(레코드)에 변경(update0가 되는 상황이 만들어진다
다수의 데이터를 변경하는 명령은
데이터 무결성을 해치는 원인 중 하나이다

상품테이블을 별도로 분리하고
상품코드, 상품명, 형시긍로 저장한 후
매입매출 테이블에는 상품명 대신 상품코드를 포함하고
이후에 join을 통해 데이터를 조회하는 것이 좋다

*/

-- 1. 매입매출 테이블에서 상품 정보를 중복없이 추출하기
SELECT io_pname
FROM tbl_iolist
GROUP BY IO_PNAME
ORDER BY IO_PNAME;
-- 2. 매입매출 테이블에서 상품정보와 매입단가 매출단가도 같이 추출하기
-- 전체 데이터에 상품별로 가장 높은 가격을 가져와서 매입매출 단가로 사용하자

SELECT IO_PNAME, 
   MAX(DECODE(IO_INOUT,'1',IO_PRICE,0)) AS 매입단가,
   MAX(DECODE(IO_INOUT,'2',IO_PRICE,0)) AS 매출단가
 FROM tbl_iolist
 group by io_pname
 order by io_pname;
 
 /*
 상품 리스틔를 추출했는데 매입단가가 0, 또는 매출단가가 0인 경우
 매입단가와 매출단가를 계산하기
 
 매입단가가 0인 경우
 매출단가에서 마진(20%)을 빼고, 다시 부가세(10)뺀 가격으로 계산
 매입 단가 = (매출단가 * 1.2)/1.1
 
 매출단가는 매입단가에 10% 마친추가, 부가세 10% 추가
 매출 단가 = (매입단가 * 1.2)*1.1
 
 10원단위 절사
 매출단가 = INT(매출단가 /10) * 10
 
 */
 
 -- 추출된 상품정보를 저장할 테이블 생성
 create table tbl_product(
 p_code	char(6)		PRIMARY KEY,
p_name	nVARCHAR2(50)	NOT NULL	,
p_iprice	NUMBER	NOT NULL	,
p_oprice	NUMBER	NOT NULL	,
p_vat	VARCHAR2(1)		DEFAULT 'Y'
 );
 
 -- 매입매출 데이터에서 상품정보를 생성했다
 -- 생성된 상품 정보가 맞게 되었는지 검증하기
 -- 두 테이블을 JOIN하여 혹시 NULL 값이 있는 확인하기
 
 
 

 