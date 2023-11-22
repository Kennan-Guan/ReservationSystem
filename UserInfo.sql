CREATE DATABASE IF NOT EXISTS `UserInfo`;
USE `UserInfo`;

CREATE TABLE IF NOT EXISTS users(
`username` varchar(30) 	NOT NULL,
`password` varchar(30) 	NOT NULL,
primary key(`username`));

INSERT IGNORE INTO users VALUES ('testabc', 'test123');

select * from users;



