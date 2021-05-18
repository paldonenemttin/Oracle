-- DataBase Schema
-- 물리적 저장공간
-- Orable : TableSpace + User 생성하여
--    연동을 하면 user를 통해 모든 물리적 (  ) 접근이 된다

create database GuestBook;
-- gbuser 사용자를 등록하고
-- 접근권한을 localhost로 제한하겠다
create user gbUser@localhost;
-- 원격 또는 다른 서버 client에서 접속 가능하도록 설정
create user gbUser@ '%';

-- MYSQL DataBase는 MYSQL에서 매우 중요한 정보가 저장되는 곳
use MYSQL; -- db 정보 확인 위해 db사전에 접근
show tables;
desc user;
-- 사용자 정보가 등록된 table select
select host,user from user;
-- 등록된 사용자의 권한 확인
show grants for gbUser@localhost;
-- gbUser에게 모든 권한을 부여하라
-- localhost에서만 접근 가능
grant all privileges on *.* to
gbUser@localhost;

grant all privileges on *.* to
'gbUser'@'192.168.0.%';

-- 현재 공유기에 공토응로 연결된 pc에서 mysql server에 접근하라
create user gbUser@'192.168.0.%';
-- 현재 공유기에 공통으로 연결된 pc에서 접근할때 모든 권한을 부여하겠다
grant all privileges on *.* to
'gbUser'@'192.168.0.%';

-- 5.x mysql 버전에서 비번 변경
update user set password=password('1234')
where user='gbUser@localhost';

-- 8.x 버전 mysql에서 비번 변경
alter user 'gbUser'@'localhost'
identified with mysql_native_password by '1234';
flush privileges;