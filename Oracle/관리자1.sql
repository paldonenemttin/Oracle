/*
오라클에서는 관리자(sys, system, sysdba)계정이 존재하고
 관리자 계정으로 접속을 하면
 오라클 시스템 자체를 컨트롤할수 있는 권한이 있다
 sysdba 권한이다 라고 한다.

보안사고 : 허가받지 않은 사용자가 네트워크를 통해서
불법적으로 시스템에 침투하여 데이터, 시스템을 파괴하는 행위
관리자 권한의 노출로 인하여 관리자 권한 탈취

데이터 무결성 파괴: 허가된 사용자에 권한이 잘못 부여되거나, 
과도하게 권한을 부여하여
명령을 잘못사용하여 데이터에 문제를 일으키는것

관리자 권한에서는 최소한으로
테이블 스페이스 생성 사용자 생성 사용자에게 
권한 부여는 정도만 사용하도록 권장한다
*/

create TABLESPACE testDB
DATAFILE 'C:/oraclexe/data/test.dbf'
size 1m AUTOEXTEND on next 1k;

/*
testUser라는 "사용자계정(User Account)"를 생성하고
비번을 testUser로 하고
기본 TableSpace testDb로 설정
*/
create user testUser IDENTIFIED by testUser
DEFAULT tablespace testDB;
/*
최초로 사용자계정을 생성한 후에는
아직 아무런 권한이 없기때문에
DB에 접속하는 것조차 할 수 없다
실습을 쉽게 하기 위해 생성한 사용자 계정에 DBA권한을 부여한다

DBA권한: 시스템 관련 DB에 접근 할 수 없으나 기타 테이블을 만드는 일 부터
        대부분의 DBMS 관련 명령을 사용해 DB를 핸들링 할 수 있는 권한
*/
Grant dba to testUser;