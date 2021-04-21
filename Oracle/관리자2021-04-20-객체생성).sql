-- 여기는 관리자 화면으로 접속
-- 오라클에서 DBMS 프로젝트를 수행할때
-- 제일먼저 할일 TABLESpace를 만들기
-- TableSpace == DataBase : 실제데이터가 저장되는 공간, 파일
-- DBL(Data Definition Lang. 명령, 데이터정의어)
--    DBA(DataBase Adminstrator)의 궎나을 갖는 사용자가 사용하는명령어
-- CREATE로 시작은 대부분의 명령어
-- Oracle에서는 SYSDBA권한 등급이 있으면
-- 일반적인 DBA보다 높은 권한을 갖고 있다
-- SYSDBA 권한은 TableSpace를 만들고, User를만드는 역할
-- SYS 사용자로 접속한 상태
CREATE TABLESPACE schoolDB
DATAFILE 'C:/oraclexe/data/school.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

-- SYSDBA는 시스템 모든 부분에 접근 할 수 있는 권한이 있어서
-- 자칫 명령을 잘못 입력하고 실행하면  Oracle DBMS 자체게 문제가 생긴다
-- 때문에 SYSDBA보다 등급이 낮은 생성자를생성하고
-- 생성된 자용자 계저응로 명령을 수행, 실습한다

-- 새로운 사용자계저응로 등록할때 TableSpace와 연결을 하여
-- 데이터를 추가할 수 있도록 설정
-- scuser 계정으로 데이터를 추가하면 자동으로 schoolDB tablespace
--   데이터가 모이게 된다
CREATE USER scuser IDENTIFIED BY scuser
DEFAULT TABLESPACE schoolDB;

-- DBMS에서 사용자계정
-- DBMS는 사용자에게 권한등급을 부여하여
-- 데이터생서으 조회, 삭제, 변경 등을 세부저긍로 지정할 수 있다
-- 세부적인 항목은 회사, 조직마다 별도로 정책을 만들어 쓰기 때문에
-- 규칙이 정해진 것은 없다
-- 보통 DBMS에서 새로운 사용자계정을 등록하면
-- 일반적인 명령을 수행 할 수 있도록 허용하는데
-- Oracle은 새로운 사용자계정을 생성하면
-- 아무것도 할 수 없는 상태이다
-- 관리자(SYSDBA)는 새로 생성된 계정이 무언가 명령을 수행 할 수 있도록
-- 권한을 부여한느 명령을 수행해 주어야 한다.
-- 오라클은 새로 생성된 사용자 계정은
-- DBMS에 접속 하는 것 조차 막아놓는다
-- 때문에 접속 Profile을 만들어도
-- 접속 test에서 오류가 발생한다

-- DCL(DATA controll Lang. 데이터 제어어)
-- 보안과 관련된 명령
-- scuser 사용자에게 CREATE SESSION 권한을 부여
-- CREATE SESSION :DBMS 서버에 접속(login)을 할 수 잇는 권한
-- GRANT ** TO user : user에게 ** 권한을 부여한다
GRANT CREATE SESSION TO scuser;
-- REVOKE ** FROM user : user에게서 ** 권한을 제거하기
REVOKE CREATE SESSION FROM scuser;
-- tbl_scool TABLE에 데이터를 추가하는 권한을 scuser에게 부여
GRANT INSERT ON tbl_school TO scuser;
-- tbl_school TABLE 데이터를 조회 할 수 있는 권한을 scuser에게 부여
GRANT SELECT ON tbl_school TO scuser;

-- 원칙은 사용자에게 건한을 일일 지정하여 세부적으로 관리 해야 한다
-- 하지만 학습(실습)하는 입장에서 일일이 세부적으로 지정하기는 불편함이 잇다
-- 사용등록 하고 DBA(DB관리자) 권한을 부여하여
-- 실습에 용이하도록 사용하겠다
GRANT DBA TO  scUSER;