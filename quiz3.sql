--PART I

--1. Create a tablespace with name 'quiz' and three datafiles. Each datafile of 15Mb.

CREATE TABLESPACE quiz
DATAFILE 'quiz1.DBF' SIZE 15M,
 'quiz2.DBF' SIZE 15M,
 'quiz3.DBF' SIZE 15M;
 
--2. Create a profile with idle time of 20 minutes, the name of the profile should be 'student'

CREATE PROFILE student LIMIT IDLE_TIME 20;

--3. Create an user named "usuario_1" with password "usuario_1". 

CREATE USER usuario_1 IDENTIFIED BY usuario_1;

--	- The user should be able to connect

GRANT CONNECT TO usuario_1;

--	- The user should has the profile "student"

ALTER USER usuario_1 PROFILE student;

--	- The user should be associated to the tablespace "quiz"

ALTER USER usuario_1 DEFAULT TABLESPACE quiz;

--	- The user should be able to create tables WITHOUT USING THE DBA ROLE. 

ALTER USER usuario_1 QUOTA 5M ON quiz;
GRANT CREATE TABLE TO usuario_1;

--4. Create an user named "usuario_2" with password "usuario_2"

CREATE USER usuario_2 IDENTIFIED BY usuario_2;

--	- The user should be able to connect

GRANT CONNECT TO usuario_2;

--	- The user should has the profile "student"

ALTER USER usuario_2 PROFILE student;

--	- The user should be associated to the tablespace "quiz"

ALTER USER usuario_2 DEFAULT TABLESPACE quiz;

--	- The user shouldn't be able to create tables.

REVOKE CREATE TABLE FROM usuario_2;

--PART II

--1. With the usuario_1 create the next table (DON'T CHANGE THE NAME OF THE TABLE NOR COLUMNS:

--create table attacks (
--	id INT,
--	url VARCHAR(2048),
--	ip_address VARCHAR(20),
--	number_of_attacks INT,
--	time_of_last_attack TIMESTAMP
--);

-- se creo con el usuario_1
create table attacks (
	id INT,
	url VARCHAR(2048),
	ip_address VARCHAR(20),
	number_of_attacks INT,
	time_of_last_attack TIMESTAMP
);

--2. Import this data (The format of the date is "YYYY-MM-DD HH24:MI:SS"): https://gist.github.com/amartinezg/6c2c27ae630102dbfb499ed22b338dd8
--3. Give permission to view table "attacks" of the usuario_2 (Do selects)

GRANT SELECT ON USUARIO_1.ATTACKS TO usuario_2;


-- con el usuario_2

--Queries: 

-- 1. Count the urls which have been attacked and have the protocol 'https'

select count(*) from USUARIO_1.attacks
where url like 'https%';
-- 2. List the records where the URL attacked matches with google (it does not matter if it is google.co.jp, google.es, google.pt, etc) order by number of attacks ascendent
select * from USUARIO_1.attacks
where url like '%google%';
-- 3. List the ip addresses and the time of the last attack if the attack has been produced the last year (2017) (Hint: https://stackoverflow.com/a/30071091)
-- 4. Show the first IP Adress which has been registered with the minimum number of attacks 
-- 5. Show the ip address and the number of attacks if instagram has been attack using https protocol