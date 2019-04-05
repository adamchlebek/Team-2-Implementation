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
  primary key (username)
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

--Add Constraints Here
ALTER TABLE users ADD CONSTRAINT UC1 CHECK (language IN ('EN', 'FR', 'DE', 'ES', 'IT', 'RU'));
ALTER TABLE location ADD CONSTRAINT UC2 CHECK (ltype in ('City', 'Castle', 'Market', 'Cave', 'Forest'));
ALTER TABLE race ADD CONSTRAINT RC1 CHECK (strength > armor);
--End of Adding Constraings

--
SET FEEDBACK OFF
--< The INSERT statements that populate the tables>

--User Inserts
INSERT INTO users VALUES ('adamchlebek', 'Gandalf', 'password123', 0, 'EN');
INSERT INTO users VALUES ('philippicard', 'Big Phil', 'philpass', 1, 'EN');
INSERT INTO users VALUES ('gabegunnink', 'Gabster', 'passgabe12', 0, 'EN');
INSERT INTO users VALUES ('pablous', 'Mega Pablo', 'pablopass', 1, 'ES');
INSERT INTO users VALUES ('leyons', 'Leo The Great', 'wordPass', 0, 'FR');

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
INSERT INTO characters VALUES ('adamchlebek', 'Gandalf', 'Wizard', 'King City', 100, '10.123, -18.294');
INSERT INTO characters VALUES ('philippicard', 'Big Phil', 'Elf', 'Castle of Doom', 75, '110.123, 32.294');
INSERT INTO characters VALUES ('gabegunnink', 'Gabster', 'Wizard', 'Castle of Doom', 52, '103, 36.4');
INSERT INTO characters VALUES ('pablous', 'Mega Pablo', 'Human', 'The Goods Market', 100, '37.3, 10.24');
INSERT INTO characters VALUES ('leyons', 'Leo The Great', 'Goblin', 'Goblin Caves', 87, '-56, 32');
 
--Item Inserts
INSERT INTO item VALUES ('adamchlebek', 'Gandalf', 'Red Sharp', 'Sword', 4);
INSERT INTO item VALUES ('adamchlebek', 'Gandalf', 'Ninja Star', 'Knife', 3);
INSERT INTO item VALUES ('adamchlebek', 'Gandalf', 'Wooden Sniper', 'Bow', 5);
INSERT INTO item VALUES ('philippicaard', 'Big Phil', 'Gauze', 'Health Pack', 1);
INSERT INTO item VALUES ('philippicard', 'Big Phil', 'Beef', 'Food', 3);
INSERT INTO item VALUES ('philippicard', 'Big Phil', 'Bread', 'Food', 1);
--Gabes Items
INSERT INTO item VALUES ('pablous', 'Mega Pablo', 'Sprinters', 'Shoes', 3);
INSERT INTO item VALUES ('pablous', 'Mega Pablo', 'Red Bull', 'Drink', 1);
INSERT INTO item VALUES ('pablous', 'Mega Pablo', 'Marker', 'Writing', 3);
INSERT INTO item VALUES ('leyons', 'Leo The Great', 'Bloodhound', 'Animal', 4);
INSERT INTO item VALUES ('leyons', 'Leo The Great', 'Red Bull', 'Drink', 1);
INSERT INTO item VALUES ('leyons', 'Leo The Great', 'Marker', 'Writing', 3);
--INSERT ALL UR ITEMS PLZ--

--Location Inserts
INSERT INTO location VALUES ('King City', '10.6, -16', 'City');
INSERT INTO location VALUES ('Castle of Doom', '100.45, 36.8', 'Castle');
INSERT INTO location VALUES ('The Weapons Market', '43.9, 11.6', 'Market');
INSERT INTO location VALUES ('The Goods Market', '38.4, 10.8', 'Market');
INSERT INTO location VALUES ('Goblin Caves', '-56.4, 32.9', 'Cave');
INSERT INTO location VALUES ('The Haunted Forest', '-43, 38', 'Forest');

--Race Inserts
INSERT INTO race VALUES ('Wizard', 10, 4, 2);
INSERT INTO race VALUES ('Elf', 5, 10, 3);
INSERT INTO race VALUES ('Goblin', 3, 3, 2);
INSERT INTO race VALUES ('Human', 4, 5, 3);

--isDoing Inserts
--INSERT ISDOING PLZ--

--Quest Inserts--
INSERT INTO quest VALUES (1, 'Goblin Hunt', 'Hunt', 'An army of goblins are attacking the city! Hunt them!');
INSERT INTO quest VALUES (2, 'Resuce the Princess', 'Resuce', 'The dragon has kidnapped the princess. Please rescue her!');
INSERT INTO quest VALUES (3, 'Slay the Dragon', 'Hunt', 'An evil dragon is attacking the castle. Please save the castle!');
INSERT INTO quest VALUES ()

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
