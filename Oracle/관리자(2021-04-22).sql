-- 여기는 관리자 권한으로 접속

CREATE TABLESPACE schoolDB
DATAFILE 'C:/oraclexe/data/school.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;
-- schema : table, index, view 등등 데이터의 전체적인 모음집
-- 객체들의 정보를 담는 곳
-- 데이터들의 모음체
-- 표준SQL : CREATE SCHEMA
CREATE USER scuser IDENTIFIED BY scuser
DEFAULT TABLESPACE schoolDB;

-- 권한 부여, 실습을 위해서 DBA 권한을 부여하자
-- DBA권한을 남발하면
-- DB 보안적인 측면에서 무결성을 해칠수 있는 여지가 많아진다
-- DB와 관련된 보안 용어
-- 보안 침해 : 허가받지 않은 사용자가 접속하여 문제를 일으키는 경우
-- 무결성 침해(파괴) : 허가받은 사용자가 권한을 남용하여 문제를 일으킨 경우
--                    CUD(추가,수정,삭제)등을 잘못해 데이터에 문제가 생긴 경우
GRANT DBA TO scuser;
