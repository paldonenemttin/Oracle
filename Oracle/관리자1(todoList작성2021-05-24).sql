create TABLESPACE todoDB
DATAFILE 'C:/oraclexe/data/todoDB'
SIZE 1m AUTOEXTEND ON NEXT 1k;

create user tduser IDENTIFIED BY todo
DEFAuLT TABLESPACE todoDB;

grant DBA TO tduser;

