create database meter;
create table balance (
    id tinyint primary key auto_increment,
    value smallint,
    balancetime_ts timestamp
    );