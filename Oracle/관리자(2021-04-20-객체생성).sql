-- 관리자 접속
-- 실습을 위해 기존 객체 삭제
-- 사용자 SCUSER삭제
DROP USER scuser CASCADE;

DROP TABLESPACE schoolDB
INCLUDING CONTENTS AND DATAFILES
CASCADE CONSTRAINTS;

create TABLESPACE schoolDB
DATAFILE 'C:/oraclexe/data/schools.dbf'
size 1m AUTOEXTEND on next 1k;

CREATE USER scuser IDENTIFIED by scuser
DEFAULT TABLESPACE schoolDB;


