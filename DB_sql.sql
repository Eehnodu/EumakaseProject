CREATE SCHEMA FINAL;

USE FINAL;

CREATE TABLE TB_MEMBER(
    memId VARCHAR(50) PRIMARY KEY,
    memPw VARCHAR(100),
    memName VARCHAR(50),
    createdAt TIMESTAMP
);

insert into tb_member(memId, memPw, memName, createdAt) values ('id', 'pw', '회원', now()); 