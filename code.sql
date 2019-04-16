SPOOL project.out
SET ECHO ON
/*
CIS 353 - Database Design Project
Adam Chlebek
Philip Picard
Gabe Gunnink
*/
--
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
--
--START CREATE TABLES
CREATE TABLE users (
  username      varchar(30), 
  cName         varchar(30) NOT NULL,
  password      varchar(40) NOT NULL,
  isLoggedIn    integer NOT NULL,
  language      varchar(20),
  primary key (username)
);
--
CREATE TABLE loginTimes (
  username      varchar(30), 
  loginTime     timestamp,
  primary key(username, loginTime)
);
--
CREATE TABLE characters (
  username      varchar(30), 
  cName         varchar(30),
  rName         varchar(40) NOT NULL,
  lName         varchar(30) NOT NULL,
  health        integer NOT NULL,
  position      varchar(30),
  primary key (username, cName),
  CHECK (health >= 0)
);
--
CREATE TABLE item (
  username      varchar(30), 
  cName         varchar(30),
  iName         varchar(40),
  iType         varchar(30),
  iLevel        integer,
  primary key (username, cName, iName),
  CHECK (iLevel >= 0)
);
--
CREATE TABLE location (
  lName     varchar(30), 
  position  varchar(30),
  ltype     varchar(30),
  primary key (lName)
);
--
CREATE TABLE race (
  rName     varchar(30),
  strength  integer,
  speed     integer,
  armor     integer,
  primary key (rName),
  CHECK (strength >= 0),
  CHECK (speed >= 0),
  CHECK (armor >= 0)
);
--
CREATE TABLE isDoing (
  username        varchar(30), 
  cName           varchar(30),
  qID             varchar(40),
  percentProgress integer,
  primary key (username, cName, qID),
  CHECK (percentProgress >= 0)
);
--
CREATE TABLE quest (
  qID           varchar(40), 
  qName         varchar(30),
  task          varchar(40),
  description   varchar(200),
  primary key (qID)
);
--END CREATE TABLES
--
--Add Foreign Keys Here
ALTER TABLE users
ADD CONSTRAINT fk1 FOREIGN KEY (username, cName) REFERENCES characters(username, cName)
	ON DELETE CASCADE
	DEFERRABLE INITIALLY DEFERRED;
--
ALTER TABLE loginTimes
ADD CONSTRAINT fk2 FOREIGN KEY (username) REFERENCES users(username)
	ON DELETE CASCADE
	DEFERRABLE INITIALLY DEFERRED;
--
ALTER TABLE characters
ADD CONSTRAINT fk3 FOREIGN KEY (username) REFERENCES users(username)
	ON DELETE CASCADE
	DEFERRABLE INITIALLY DEFERRED;
--
ALTER TABLE item
ADD CONSTRAINT fk4 FOREIGN KEY (username, cName) REFERENCES characters(username, cName)
	ON DELETE CASCADE
	DEFERRABLE INITIALLY DEFERRED;
--
ALTER TABLE isDoing
ADD CONSTRAINT fk5 FOREIGN KEY (username, cName) REFERENCES characters(username, cName)
	ON DELETE CASCADE
	DEFERRABLE INITIALLY DEFERRED;
--
ALTER TABLE isDoing
ADD CONSTRAINT fk6 FOREIGN KEY (qID) REFERENCES quest(qID)
	ON DELETE CASCADE
	DEFERRABLE INITIALLY DEFERRED;
--End of Adding Foreign Keys
--
--Add Constraints Here
ALTER TABLE users ADD CONSTRAINT UC1 CHECK (language IN ('EN', 'FR', 'DE', 'ES', 'IT', 'RU'));
ALTER TABLE location ADD CONSTRAINT UC2 CHECK (ltype in ('City', 'Castle', 'Market', 'Cave', 'Forest'));
ALTER TABLE quest ADD CONSTRAINT UC3 CHECK (task in ('Hunt', 'Rescue', 'Find'));
ALTER TABLE item ADD CONSTRAINT UC4 CHECK (NOT(iType = 'Sword' AND iLevel > 10));
ALTER TABLE race ADD CONSTRAINT UC5 CHECK (NOT(rName = 'Wizard' AND speed > 10) AND speed > 0);
ALTER TABLE race ADD CONSTRAINT UC6 CHECK (strength > armor);
ALTER TABLE users ADD CONSTRAINT UC7 CHECK (isLoggedIn IN (0, 1));
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
INSERT INTO users VALUES ('jake', 'Darth Vader', 'no-one-can-hack-my-password', 1, 'EN');
INSERT INTO users VALUES ('bob', 'Bob', '129aef', 0, 'FR');
--
--Login Times Inserts
INSERT INTO loginTimes VALUES ('adamchlebek', TO_DATE('2018-10-11 12:42:23', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO loginTimes VALUES ('adamchlebek', TO_DATE('2018-11-13 14:22:13', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO loginTimes VALUES ('philippicard', TO_DATE('2019-01-11 05:12:32', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO loginTimes VALUES ('philippicard', TO_DATE('2019-03-12 21:42:35', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO loginTimes VALUES ('gabegunnink', TO_DATE('2018-12-13 05:25:52', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO loginTimes VALUES ('pablous', TO_DATE('2017-10-19 02:52:26', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO loginTimes VALUES ('leyons', TO_DATE('2019-02-24 17:36:17', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO loginTimes VALUES ('leyons', TO_DATE('2019-03-14 18:18:40', 'yyyy/mm/dd hh24:mi:ss'));
--
--Characters Inserts
INSERT INTO characters VALUES ('adamchlebek', 'Gandalf', 'Wizard', 'King City', 100, '10.123, -18.294');
INSERT INTO characters VALUES ('philippicard', 'Big Phil', 'Elf', 'Castle of Doom', 75, '110.123, 32.294');
INSERT INTO characters VALUES ('gabegunnink', 'Gabster', 'Wizard', 'Castle of Doom', 52, '103, 36.4');
INSERT INTO characters VALUES ('pablous', 'Mega Pablo', 'Human', 'The Goods Market', 100, '37.3, 10.24');
INSERT INTO characters VALUES ('leyons', 'Leo The Great', 'Goblin', 'Goblin Caves', 87, '-56, 32');
INSERT INTO characters VALUES ('jake', 'Darth Vader', 'Goblin', 'The Goods Market', 50, '33.9, 11.56');
INSERT INTO characters VALUES ('bob', 'Bob', 'Human', 'King City', 87, '10.5, -20.7');
--
--Item Inserts
INSERT INTO item VALUES ('adamchlebek', 'Gandalf', 'Red Sharp', 'Sword', 4);
INSERT INTO item VALUES ('adamchlebek', 'Gandalf', 'Ninja Star', 'Knife', 3);
INSERT INTO item VALUES ('adamchlebek', 'Gandalf', 'Wooden Sniper', 'Bow', 5);
INSERT INTO item VALUES ('adamchlebek', 'Gandalf', 'Spell Book', 'Book', 3);
INSERT INTO item VALUES ('adamchlebek', 'Gandalf', 'Cake', 'Food', 4);
INSERT INTO item VALUES ('philippicard', 'Big Phil', 'Gauze', 'Health Pack', 1);
INSERT INTO item VALUES ('philippicard', 'Big Phil', 'Beef', 'Food', 3);
INSERT INTO item VALUES ('philippicard', 'Big Phil', 'Bread', 'Food', 1);
INSERT INTO item VALUES ('gabegunnink', 'Gabster','fire staff++','magic weapon', 4);
INSERT INTO item VALUES ('gabegunnink', 'Gabster','fire runes','ammo', 1);
INSERT INTO item VALUES ('gabegunnink', 'Gabster','robes of mordor','magic armor', 5);
INSERT INTO item VALUES ('pablous', 'Mega Pablo', 'Sprinters', 'Shoes', 3);
INSERT INTO item VALUES ('pablous', 'Mega Pablo', 'Marker', 'Writing', 3);
INSERT INTO item VALUES ('leyons', 'Leo The Great', 'Bloodhound', 'Animal', 4);
INSERT INTO item VALUES ('leyons', 'Leo The Great', 'Red Bull', 'Drink', 1);
--
--Location Inserts
INSERT INTO location VALUES ('King City', '10.6, -16', 'City');
INSERT INTO location VALUES ('Castle of Doom', '100.45, 36.8', 'Castle');
INSERT INTO location VALUES ('The Weapons Market', '43.9, 11.6', 'Market');
INSERT INTO location VALUES ('The Goods Market', '38.4, 10.8', 'Market');
INSERT INTO location VALUES ('Goblin Caves', '-56.4, 32.9', 'Cave');
INSERT INTO location VALUES ('The Haunted Forest', '-43, 38', 'Forest');
--
--Race Inserts
INSERT INTO race VALUES ('Wizard', 10, 4, 2);
INSERT INTO race VALUES ('Elf', 5, 10, 3);
INSERT INTO race VALUES ('Goblin', 3, 3, 2);
INSERT INTO race VALUES ('Human', 4, 5, 3);
--
--isDoing Inserts
INSERT INTO isDoing VALUES ('leyons', 'Leo The Great', 1, 50);
INSERT INTO isDoing VALUES ('leyons', 'Leo The Great', 3, 12);
INSERT INTO isDoing VALUES ('philippicard', 'Big Phil', 4, 92);
INSERT INTO isDoing VALUES ('gabegunnink', 'Gabster', 1, 51);
--
--Quest Inserts--
INSERT INTO quest VALUES (1, 'Goblin Hunt', 'Hunt', 'An army of goblins are attacking the city! Hunt them!');
INSERT INTO quest VALUES (2, 'Resuce the Princess', 'Rescue', 'The dragon has kidnapped the princess. Please rescue her!');
INSERT INTO quest VALUES (3, 'Slay the Dragon', 'Hunt', 'An evil dragon is attacking the castle. Please save the castle!');
INSERT INTO quest VALUES (4, 'Find the Gold', 'Find', 'The king has lost his gold! Please go and find it.');
--
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
--
-- Q1 - Join involving at least four relations.
-- This will find all characters that are wizards, have at least a level 2 item, are not in a forest, and is currently not logged in. Select
-- the name and location name they are currently at. Then order them by name.
SELECT DISTINCT c.cName, l.lName
FROM characters c, location l, item i, users u
WHERE (c.rName = 'Wizard' AND i.username = c.username AND i.cName = c.cName 
       AND i.iLevel >= 2 AND c.lName = l.lName AND l.ltype != 'Forest'
       AND u.username = c.username AND u.cName = c.cName AND u.isLoggedIn = 0)
ORDER BY c.cName;
--
-- Q2 - Self-join
-- Find pairs of quest names where both quests are hunt and don't show duplicates.
SELECT q1.qName, q2.qName
FROM quest q1, quest q2
WHERE q1.task = 'Hunt' AND q2.task = q1.task AND q1.qID < q2.qID;
--
-- Q3 - UNION
-- Find the name of every character that has an a in their name or is located in a cave.
SELECT c1.cName
FROM characters c1
WHERE c1.cName LIKE '%a%'
UNION
SELECT c2.cName
FROM characters c2, location l
WHERE c2.lName = l.lName AND l.ltype = 'Cave';
--
-- Q4 - AVG
-- Find the average health of all the characters that are a race with a strength more than or equal to 4.
SELECT AVG(c.health)
FROM characters c, race r
WHERE c.rName = r.rName AND r.strength >= 4;
--
-- Q5 - Group by, having, order by
-- Select the character name, race name, and the number of items in the inventory for every character
-- with more than or exactly having 3 items in their inventory. Than order the results by name.
SELECT c.cName, c.rName, COUNT(*)
FROM characters C, item I
WHERE I.username = C.username AND I.cName = C.cName
GROUP BY c.cName, c.rName
HAVING COUNT(*) >= 3
ORDER BY c.cName;
--
-- Q6 - Correlated subquery
-- Select the username and name of all characters with health above 20 and that have no items in their inventory.
SELECT C.username, C.cName
FROM characters C
WHERE C.health > 20 AND
      NOT EXISTS (SELECT *
                  FROM item I
                  WHERE I.username = C.username AND I.cName = C.cName);
--
-- Q7 - Non-correlated subquery
-- Select the username and name of all characters with health above 50 and that are not doing any quests.
SELECT C.username, C.cName
FROM characters C
WHERE C.health > 50 AND
      C.username NOT IN (SELECT D.username
                         FROM isDoing D);
--
-- Q8 - Relational division
-- Find the username and name of all characters that are doing every hunt quest.
SELECT C.username, C.cName
FROM characters C
WHERE NOT EXISTS (
  (SELECT Q.qID
   FROM quest Q
   WHERE Q.task = 'Hunt')
   MINUS
  (SELECT Q.qID
   FROM isDoing D, Quest Q
   WHERE D.qId = Q.qID AND D.username = C.username AND D.cName = C.cName AND Q.task = 'Hunt')
);
--
-- Q9 - Outer-join query
-- List all character's name and the username of the user and show what quests they are doing. For
-- the quests show the id of the quest and the progress.
SELECT C.username, C.cName, D.qId, D.percentProgress
FROM characters C LEFT OUTER JOIN isDoing D ON C.username = D.username AND C.cName = D.cName;
--
--< The SQL queries>. Include the following for each query:
--1. A comment line stating the query number and the feature(s) it demonstrates (e.g. – Q25 – correlated subquery).
--2. A comment line stating the query in English.
--3. The SQL code for the query.
--NOTE: we need. . . 
-- a join involving at least four relations
-- a self-join
-- UNION, INTESECT, and/or MINUS
-- SUM, AVG, MAX and/or MIN
-- GROUP BY, HAVING, and ORDER BY, all in same query
-- a correlated subquery
-- a non-correlated subquery
-- a relational DIVISION query
-- an outer join query
--
--< The insert/delete/update statements to test the enforcement of ICs >
-- Testing: <UC1>
INSERT INTO users VALUES ('test','testname','testpass',0,'XX');
INSERT INTO users VALUES ('test1','testname1','testpass1',0,'w');
INSERT INTO users VALUES ('test2','testname2','testpass2',0,'llama');
UPDATE users 
SET language = ''
WHERE isLoggedIn = 0;
--
-- Testing: <username>
INSERT INTO users VALUES (NULL, 'test', 'testpass', 0, 'en');
--
-- Testing: <rName>
INSERT INTO characters VALUES ('philippicard', 'john is the man', NULL, 'King City', 100, '10.123, -18.294');
--
-- Testing: <password>
INSERT INTO users VALUES ('myuser', 'myname', NULL, 0, 'en');
--
-- Testing: <UC2>
UPDATE location
SET ltype = 'classroom'
WHERE ltype = 'Market';
--
-- Testing: <UC3>
INSERT INTO quest VALUES ('test UC3', 'testboi', 'coding', 'test the Integrity Constraint 3 with a variety of different tactics.');
UPDATE quest
SET task = 'coding'
WHERE qID = 3;
--
-- Testing: <UC4>
UPDATE item 
SET iLevel = 11
WHERE iType = 'Sword';
UPDATE item 
SET iLevel = -69
WHERE iType = 'Sword';
--
-- Testing: <UC5>
UPDATE race
SET speed = 11
WHERE rName = 'Wizard';
UPDATE race
SET speed = -420
WHERE rName = 'Wizard';
--
-- Testing: <UC6>
UPDATE race
SET armor = 20
WHERE strength < 20;
--
-- Testing: <UC7>
UPDATE users
SET isLoggedIn = -7
WHERE isLoggedIn = 0 OR isLoggedIn = 1;
UPDATE users
SET isLoggedIn = 2
WHERE isLoggedIn = 0 OR isLoggedIn = 1;
--
--Include the following items for every IC that you test (Important: see the next section titled
--“Submit a final report” regarding which ICs to test).
--A comment line stating: Testing: < IC name>
--A SQL INSERT, DELETE, or UPDATE that will test the IC.
COMMIT;
--
SPOOL OFF
