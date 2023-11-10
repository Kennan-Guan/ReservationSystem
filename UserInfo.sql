CREATE DATABASE IF NOT EXISTS `UserInfo`;
USE `UserInfo`;

CREATE TABLE users(
`username` varchar(30) 	NOT NULL,
`password` varchar(30) 	NOT NULL,
primary key(`username`));


select * from users;



