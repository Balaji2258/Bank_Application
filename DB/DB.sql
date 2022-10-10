create database Bank;

use Bank;

-- create table user(
-- acc_no int primary key,
-- user_name varchar(50) unique not null,
-- password varchar(20) not null,
-- re_pw varchar(50) not null,
-- acc_type varchar(20) not null,
-- balance double not null,
-- address varchar(50),
-- phone int(10) unique not null,
-- email varchar(50) unique);

-- drop table User;

CREATE TABLE `Bank`.`user` (
  `acc_no` INT NOT NULL,
  `full_name` VARCHAR(50),
  `user_name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NULL,
  `re_pw` VARCHAR(45) NULL,
  `acc_type` VARCHAR(45) NULL,
  `balance` DOUBLE NULL,
  `address` VARCHAR(45) NULL,
  `phone` BIGINT(10) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`acc_no`),
  UNIQUE INDEX `user_name_UNIQUE` (`user_name` ASC) VISIBLE,
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE);

create table transactions(
id int auto_increment primary key,
acc_no int,
trans_type varchar(20),
trans_amt double,
trans_date dateTime,
foreign key(acc_no) references user(acc_no)
on delete cascade);

create table admins(
admin_id varchar(50) primary key,
admin_pass varchar(20));

insert into admins values
('admin1', 'admin1@123'),
('admin2', 'admin2@123');

create table services(
serv_id int auto_increment primary key,
acc_no int,
user_name varchar(50),
apply_cheque boolean,
apply_date datetime,
approve_date datetime,
foreign key(acc_no) references user(acc_no)
on delete cascade);

drop table user;
drop table transactions;
drop table admins;
drop table services;

desc user;
desc transactions;
desc services;

select * from user;
select * from transactions;
select * from admins;
select * from services;

-- drop database Bank;