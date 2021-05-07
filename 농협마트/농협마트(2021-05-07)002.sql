-- nhuser

/*
iolist테이블과 Prod테이블간에 상품으로 join을 하여
null값이 없는 것이 확인되었다

1. iolist 테블에 상품코드 칼럼을 추가하고
2, prod 테이블에서 상품코들 락져와 iolist테이블에 저장
3, iolist 테이블과 prod테이블간에 상품코드를 
      기준으로 join을 할 수 있도록
      테이블 변경을 시작한다
*/

-- tbl_iolist에 상품 코드를 저장할 칼럼을 추가
ALTER TABLE tbl_iolist
ADD io_pcode CHAR(6);
DESC tbl_iolist;

-- 생성된 io_pcode 칼럼에 io_pname 칼럼의 상품 이름에 해당하는
-- 코드 데이터를 tbl_product에서 가져와서
-- 저장을 해야한다

-- 테이블의 데이터를 변경하는 위한 dml
-- tbl_iolist 전체를 반복하면서
-- io_pcode 칼럼에 값을 갱신하라
-- 이때 tbl_iolist의 상품으로 tbl_product 데이터를 조회하여
-- 일치하는 데이터가 있으면
-- 그중에 상품코드 칼럼의 값을 가져와서
--  io_pcode 칼럼에 저장하라
UPDATE tbl_iolist IO
SET io_pname = (
    SELECT p_code FROM tbl_product P
    WHERE io.io_pname = P.p_name
);

update tbl_iolist IO
SET io_pcode = 'A'; 

/*
iolist 전체 데이터를 보여달라
iolist 데이터의 상품 이름을 product 테이블에서 조회하여
일치하는 상품이 있으면 리스트를 보일떄 같이 보여달라
라는 Sub Query
*/
SELECT IO.IO_PNAME,(
    SELECT P.p_name FROM tbl_prodect P
    WHERE io.io_pname = P.p_name
    )as 상품이름,
    (
    SELECT P.p_name FROM tbl_prodect P
    WHERE io.io_pname = P.p_name
    )as 상품코드
FROM TBL_IOLIST IO;

-- tbl_iolist의 상품코드 칼럼에 저장된 값과
-- tbl_product의 상품코드를ㄹ join하여 데이터 조회
SELECT io.io_pcode,io.io_pname,
       P.P_CODE,P.P_NAME,P.P_IPRICE, P.P_OPRICE
FROM tbl_iolist IO
LEFT JOIN tbl_product P
ON IO.IO_PCODE = P.P_cODE;

/*
매입매출 데이터에서 거래처 정보를 추출하고
거래처 정보 데이터를 생성한 후
거래처 코드를 만들고
tbl_dept Table을 작성한 한 다음 데이터를 import하고

iolist에 io_dcode 칼럼을 추가하고
데이터를 update 수행
*/

-- 1, iolist로 부터 거래처명, 대표자명 칼럼을 기준으로
--    중복되지 않은 데이터를 조회
--    거래처명, 대표자명 순으로 정렬
-- projection : 기ㅏ준이 되는 칼럼을 select 표현
--   필요한 칼럼만 나타나며 전체 데이터가 출력
-- 중복되지 않게(같은 데이터를 1번만 출력)
--   칼럼을 group by 묶기
select io_dname, io_dceo
from tbl_iolist
GROUP by io_dname, io_dceo
order by io_dname, io_dceo;

drop table tbl_dept;
CREATE TABLE tbl_dept(
  d_code	CHAR(5)		PRIMARY KEY,
d_name	nVARCHAR2(50)	NOT NULL	,
d_ceo	nVARCHAR2(20)	NOT NULL	,
d_tel	VARCHAR2(20)		,
d_addr	NVARCHAR2(125)		,
d_product	NVARCHAR2(20)		
);

-- IMPORT 된 저래처 정보와 매입매출 정보를 join하여
-- null 값이 있는지 확인

-- tbl_iolist에 io_dcode 칼럼추가, char(5)

-- 거래처정보 테이블에서 거래처 코드를 조회하여
-- tbl_iolist의 io_dxode칼럼에 update

select *
from tbl_iolsit 
    left join tbl_dept 
    on io_dname = d_name and io_dceo = d_ceo;
    
select from 

