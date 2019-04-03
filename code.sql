SPOOL project.out
SET ECHO ON
/*
CIS 353 - Database Design Project
Adam Chlebek
Phillip Picard
Gabe Gunnink
*/

--DROP TABLES BEFORE STARTING

DROP TABLE users CASCADE CONSTRAINTS;
DROP TABLE loginTimes CASCADE CONSTRAINTS;
DROP TABLE characters CASCADE CONSTRAINTS;
DROP TABLE item CASCADE CONSTRAINTS;
DROP TABLE location CASCADE CONSTRAINTS;
DROP TABLE race CASCADE CONSTRAINTS;
DROP TABLE isDoing CASCADE CONSTRAINTS;
DROP TABLE quest CASCADE CONSTRAINTS;

--END DROP TABLES

CREATE TABLE users (
  username      varchar(30), 
  cName         varchar(30) NOT NULL,
  password      varchar(40) NOT NULL,
  isLoggedIn    integer NOT NULL,
  language      varchar(20),
  primary key (username),

  CONSTRAINT IC1 CHECK (language IN ('EN', 'FR', 'DE', 'ES', 'IT', 'RU'))
);

CREATE TABLE loginTimes (
  username      varchar(30), 
  loginTime     timestamp,
  primary key(username, loginTime)
);

CREATE TABLE characters (
  username      varchar(30), 
  cName         varchar(30),
  rName         varchar(40) NOT NULL,
  lName         varchar(30) NOT NULL,
  health        integer NOT NULL,
  position      varchar(30),
  primary key (username, cName)
);

CREATE TABLE item (
  username      varchar(30), 
  cName         varchar(30),
  iName         varchar(40),
  cType         varchar(30),
  iLevel        integer,
  primary key (username, cName, iName)
);

CREATE TABLE location (
  lNAme     varchar(30), 
  position  varchar(30),
  ltype     varchar(30),
  primary key (lName)
);

CREATE TABLE race (
  rName     varchar(30),
  strength  integer,
  speed     integer,
  armor     integer,
  primary key (rName)
);

CREATE TABLE isDoing (
  username        varchar(30), 
  cName           varchar(30),
  qID             varchar(40),
  percentProgress decimal(3,2),
  primary key (username, cName, qID)
);

CREATE TABLE quest (
  qID           varchar(40), 
  qName         varchar(30),
  task          varchar(40),
  description   varchar(200),
  primary key (qID)
);


--Add Foreign Keys Here
ALTER TABLE loginTimes
ADD FOREIGN KEY (username) references users(username)
Deferrable initially deferred;

--End of Adding Foreign Keys

--
SET FEEDBACK OFF
--< The INSERT statements that populate the tables>

--User Inserts
INSERT INTO users VALUES ('adamchlebek', 'Adam', 'password123', 0, 'EN');
INSERT INTO users VALUES ('philippicard', 'Philip', 'philpass', 1, 'EN');
INSERT INTO users VALUES ('gabegunnink', 'Gabe', 'passgabe12', 0, 'EN');
INSERT INTO users VALUES ('pablous', 'Pablo', 'pablopass', 1, 'ES');
INSERT INTO users VALUES ('leyons', 'Leo', 'wordPass', 0, 'FR');

--Login Times Inserts
INSERT INTO loginTimes VALUES ('adamchlebek', TO_DATE('2018-10-11 12:42:23', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO loginTimes VALUES ('adamchlebek', TO_DATE('2018-11-13 14:22:13', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO loginTimes VALUES ('philippicard', TO_DATE('2019-01-11 05:12:32', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO loginTimes VALUES ('philippicard', TO_DATE('2019-03-12 21:42:35', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO loginTimes VALUES ('gabegunnink', TO_DATE('2018-12-13 05:25:52', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO loginTimes VALUES ('pablous', TO_DATE('2018-10-19 02:52:26', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO loginTimes VALUES ('leyons', TO_DATE('2019-02-24 17:36:17', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO loginTimes VALUES ('leyons', TO_DATE('2019-03-14 18:18:40', 'yyyy/mm/dd hh24:mi:ss'));

--Characters Inserts
INSERT INTO characters VALUES ('adamchlebek', 'Adam', 'Wizard', 'City', 100, '40.123, -32.294'));
INSERT INTO characters VALUES ('philippicard', 'Philip', 'Wizard', 'City', 100, '40.123, -32.294'));
INSERT INTO characters VALUES ('gabegunnink', 'Gabe', 'Wizard', 'City', 100, '40.123, -32.294'));
INSERT INTO characters VALUES ('pablous', 'Pablo', 'Wizard', 'City', 100, '40.123, -32.294'));
INSERT INTO characters VALUES ('leyons', 'Leo', 'Wizard', 'City', 100, '40.123, -32.294'));
 
--Item Inserts


SET FEEDBACK ON
COMMIT;
--
--< One query (per table) of the form: SELECT * FROM table; in order to print out your database >
SELECT * FROM users;
SELECT * FROM loginTimes;
SELECT * FROM characters;
SELECT * FROM item;
SELECT * FROM location;
SELECT * FROM race;
SELECT * FROM isDoing;
SELECT * FROM quest;

--< The SQL queries>. Include the following for each query:
--1. A comment line stating the query number and the feature(s) it demonstrates (e.g. – Q25 – correlated subquery).
--2. A comment line stating the query in English.
--3. The SQL code for the query.
--
--< The insert/delete/update statements to test the enforcement of ICs >


--Include the following items for every IC that you test (Important: see the next section titled
--“Submit a final report” regarding which ICs to test).
--A comment line stating: Testing: < IC name>
--A SQL INSERT, DELETE, or UPDATE that will test the IC.
COMMIT;
--
SPOOL OFF