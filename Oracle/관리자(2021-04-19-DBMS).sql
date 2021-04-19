--여기는 SQL 코드를 작성하고 테스트 할 수 있는 화면이다
-- SQL코드를 작성할때 -- 로 시작되는 문장은 주석이다
-- SQL 코드는 대소문자 구분이 없다
-- 단, 키워드는 대문자, 변수등은 소문자로 사용할 예정
-- 코드는 여러줄에 걸쳐 작성 가능
-- 코드는 끝에 반드시 ;이 있어야함
-- 코드에 ; 를 빼먹으면 명령문 문법 오류가 발생함

-- 1. 데이터 저장소를 생성하기
-- Oracle에서는 데이터 저장소를 파일 단위로 관리한다
-- oracle에서는 데이터 저장소를 " Table Space"라고 한다
-- oracle이외의 다른 DBMS 소프트웨어에서는 데이터저장소를
--   DataBase라고 한다.
-- 생성하기 : CREATE
-- 로컬디스트의 oraclexe/data 폴더에 mydb.dbf 라는 파일을 생성하고
--   mudb라는 이름으로 사용하겟다
-- 데이터가 있든 말든간에 기본 크기를 10mbyte로 설정해 달라
-- 만약 데이터가 추가되는 동안에 공간이 부족하면
-- 자동으로 10 kbyte 씩 증가해 준비해 달라
CREATE TABLESPACE MYDB
DATAFILE 'C:/oraclexe/data/mydb.dbf'
SIZE 10M AUTOEXTEND ON NEXT 10K;

-- SQL Dveloper에서 명령 실행하기
-- SQL 코드를 입력하고 명령줄 내에서 CTRL + ENTER를 입력
-- 가. SQL Devloper는 localhost:1521에서 기다리고 있는
--     Oracle DBMS서버에게 명령을 전닳나다
-- 나. Oracle DBMS 서버는 명령응ㄹ 수신한 후 문법 검사를 하고
--     명령을 실행 한 후 결과를 다시 SQL Developer에게 return
-- 다. SQL Develper는 Console에 결과를 보여준다

-- DROP : CREATE로 생성한 개체(OBJECT, 요소)를 제거하는 명령
DROP TABLESPACE mydb
INCLUDING CONTENTS AND DATAFILES
CASCADE CONSTRAINTS;

-- 사용자 생성하기
-- Oracle DBMS 에 접속하여 명령을 수행 할 수 있는 사용자 계정 추가
-- ID를 user1으로 하고 비밀번호를 1234로 하는 사용자 추가
CREATE USER user1 IDENTIFIED BY 1234;
DROP USER user1 CASCADE;

-- USER(사용자 계정)
-- 일반적인DBMS 소프트웨어의 사용자 계정은 DBMS 서버에 접속키 위한 역할만 수행
--  Oracle에서의 사용자 계정은 데이터 저장소와 연결하는
--   독특한 역할도 수행한다
-- A라는 사용자가 생성한, 연결된 TalbeSpace가 있다면
--    다른사용자는 TableSpace에 데이터를
--      추가 수정 삭제 조회하는데 제한을 둘 수 있다
-- 사용자를 등록할때 사용자만의 TableSpace를 지정하여 줄수 있다
--      사용자 만의 데이터를 별도로 관리 할 수 있다
-- 일반적인 DBMS는 데이터 저장공간을 DataBase라는 것 만으로 지정한다
-- 만약 데이터를 추가등을 하고자 할때
-- 어떤 DataBase에 데이터를 저장할 것인지
-- 지정하지 않으면 명령 수행에 문제가 발생할 수 잇다
-- 일반적인 DBMS는 데이터 저장공간을 DataBase라는 것 만으로 지정을 함
-- 오라클은 User와 TableSpace를 연결하여 사용자가 DataBase처럼 작동하게 할 수 있다
-- 특정 사용자로 접속만 하면 자동으로 지정된TableSpace가 사용가능 상태가 되어
-- 어떤 테이블스페이스에 데이터를 저장할 것인지 신경쓰지 않아도 된다
-- user1 사용자로 접속하여 데이터를추가하면
-- mydb tablespce에 저장하라
CREATE USER user1 IDENTIFIED BY 1234
DEFAULT TABLESPACE mydb;

-- 오라클에서는 새로운 사용자를 생성한 직후 아무런 권한도 부여되지 않는 상태다
-- 심지어 접속(로그인) 자체가 되지 않는다.