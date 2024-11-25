create database meter;
use meter;
create table balance (
    id tinyint primary key auto_increment,
    value smallint,
    balancetime_ts timestamp
    );