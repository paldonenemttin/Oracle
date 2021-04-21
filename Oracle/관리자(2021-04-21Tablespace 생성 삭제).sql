-- 관리자 권한 접속

--TABEL SPACE 생성하기
CREATE TABLESPACE iolistDB
DATAFILE 'C:/oraclexe/data/iolist.dbf'
size 1m AUTOEXTEND on next 1k;

-- TABLESPACE 삭제할때는 반드시 옵션을 같이 작성 하자
-- EX)DROP TABLESPACE IOLISTDB -반드시
--    INCULDING CONTENTS AND DATAFILES - 옵션
--    CASCADE CONSTRRAINTS; - 옵션

--새로운 사용자 등록
CREATE USER iouser IDENTIFIED BY iouser
DEFAULT TABLESPACE iolistdb;

-- 사용자에게 권한 부여
GRANT DBA TO IOUSER;

-- 사용자 삭제
DROP USER iouser CASCADE;