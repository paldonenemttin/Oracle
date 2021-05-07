-- iouser로 접속

CREATE TABLE tbl_iolist(
    io_seq	NUMBER PRIMARY KEY,
    io_pdate VARCHAR2(10)	NOT NULL ,
    io_pname nVARCHAR2(50)	NOT NULL ,
    io_dname nVARCHAR2(50)	NOT NULL ,
    io_dceo	nVARCHAR2(20)	NOT NULL ,
    io_inout nVARCHAR2(5)	NOT NULL ,	
    io_qty	NUMBER	NOT NULL ,
    io_price NUMBER	NOT NULL ,	
    io_total NUMBER		
);

DROP TABLE tbl_iolist;

SELECT COUNT(*) FROM tbl_iolist
WHERE io_inout = '매입';
SELECT COUNT(*) FROM tbl_iolist
WHERE io_inout = '매출';

SELECT io_inout, COUNT(*)
FROM tbl_iolist
GROUP BY io_inout;

-- 매입괴 매출금액 총합
SELECT io_inout, SUM(io_total)
FROM tbl_iolist
GROUP BY io_inout;

SELECT io_inout,
    SUM(DECODE(io_inout,'매입',io_total)) as 매입합계,
    SUM(DECODE(io_inout,'매출',io_total)) as 매출합계
FROM tbl_iolist
GROUP BY io_inout;

SELECT
    SUM(DECODE(io_inout,'매입',io_total)) as 매입합계,
    SUM(DECODE(io_inout,'매출',io_total)) as 매출합계
FROM tbl_iolist;

-- 일년동안 매입과 매출금액을 계산하고 단순 이익금 계산해보기

SELECT 
    SUM(DECODE(io_inout,'매입',io_total)) as 매입합계,
    SUM(DECODE(io_inout,'매출',io_total)) as 매출합계,
    SUM(DECODE(io_inout,'매출',io_total)) -
    SUM(DECODE(io_inout,'매입',io_total)) as 이익금
FROM tbl_iolist;

-- 매입매출관련하여
-- 소매점에서 상품을 매입하여 소비자한테 판매할때
-- 매입할때 매입부가세 발생
-- 판매할떄 매출부가세 발생
-- 매출부가세 - 매입부가세를 계산하여 일년에 2~4회에 부가가치세를 납부한다

-- 농사를 지어서 쌀 20KG을 생산하여 판매를 하면
-- 약 5만원정도로 판매하게 된다
-- 쌀을 공장에서 가공하여 생산품(공산품)으로 만드렉 되면
-- 실제 쌀 20KG를 직판하는 것보다 더 비싼 가격에 판매하게 된다
-- 이때 실제 쌀보다 더 많은 이익이 발생하게 되므로
-- 가치가 부가되었다라고 표현한다
-- 가치가 부가된 만큼 세금을 납부하도록한다
-- 이것을 부가가치세라고 한다(Value Add Taxx, VAT)
-- 매입을 할ㄸ"ㅒ는 매입금의 10%를 세금으로 포함해 매입하고
-- 매출을 할때는 매출금액의 10%를 세금으로 ㅠ 포함해 판매한다

-- 매입매출 데이터에서 보면
-- 매입금액은 부가세 10%를 제외한 금액으로 입력하고
-- 매출금액은 부사게 10%가 포함된 금액으로 입력한다
-- 샘플데이터의 매입금액은 VAT 제외금액이고
--    ""       매출금액은 VAT 포함된 금액이다
-- 매입과 매출데이터로 지난 1년간 납부한 VAT 금액을 계산해보자