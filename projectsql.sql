
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

CREATE DATABASE IF NOT EXISTS `project12` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `project12`;

CREATE TABLE `users`(
    `matricola` int(11),
    `password` varchar(255),
    `name` varchar(255),
    `lastname` varchar(255),
    `class` varchar(10),
    `pin`  varchar(10),
     PRIMARY KEY(`matricola`)
);

CREATE TABLE `Grades`(
  `id` int NOT NULL AUTO_INCREMENT,
  `matricolaStudente`int(11),
  `nomeProfessore` varchar(255),
  `matricolaProfessore` int(11),
  `materia` varchar(255),
  `voto` int(11),
  `tipo` varchar(255),
  `data` date,
   PRIMARY KEY(`id`)
);

CREATE TABLE `Professor` (
  `matricola` int(11),
  `password` varchar(255),
  `name` varchar(255),
  `lastname` varchar(255),
   PRIMARY KEY(`matricola`)

);

CREATE TABLE `Assenza`(
  `id` int NOT NULL AUTO_INCREMENT,
  `matricolaStudente` int(11),
  `data` date,
  `tipo` varchar(255),
  `checkbit` int,
   PRIMARY KEY(`id`)
);

CREATE TABLE `classi`(
  `id` int NOT NULL AUTO_INCREMENT,
  `matricolaProfessore` int(11),
  `name` varchar(10),
  PRIMARY KEY(`id`)
);
CREATE TABLE `materia`(
  `id` int NOT NULL AUTO_INCREMENT,
  `matricolaProfessore` int(11),
  `name` varchar(10),
  PRIMARY KEY(`id`)
);

CREATE TABLE `arguments`(
  `id` int NOT NULL AUTO_INCREMENT,
  `matricolaProfessore` int(11),
  `descrizione` varchar(255),
  `class` varchar(10),
  `materia` varchar(255),
  `count` int(11),
  PRIMARY KEY(`id`)
);

CREATE TABLE `Homework`(
  `id` int NOT NULL AUTO_INCREMENT,
  `matricolaProfessore` int(11),
  `class` varchar(10),
  `materia` varchar(255),
  `descrizione` varchar(255),
  `data` date,
  PRIMARY KEY(`id`)
);

CREATE TABLE `scheduleinfo`(
  `id` int NOT NULL AUTO_INCREMENT,
  `matricolaProfessore` int(11),
  `class` varchar(10),
  `materia` varchar(255),
  `day` int(11),
  `hours` int(11),
  PRIMARY KEY(`id`)
);


INSERT INTO `scheduleinfo` (`materia`,`matricolaProfessore`,`class`,`day`,`hours`) VALUES

("Fisica", 9999,"4B",1,11),
("Fisica", 9999,"4B",1,12),
("Fisica", 9999,"4B",3,12),
("Fisica", 9999,"4B",3,13),
("Filosofia", 9997,"4B",1,9),
("Filosofia", 9997,"4B",1,10),
("Filosofia", 9997,"4B",2,12),
("Filosofia", 9997,"4B",2,13),
("Geografia", 9999,"3B",5,9),
("Geografia", 9999,"3B",5,10),
("Matematica", 9997,"3B",2,9),
("Matematica", 9997,"3B",2,10),
("Matematica", 9997,"3B",4,9),
("Geografia", 9999,"3B",1,9),
("Geografia", 9999,"3B",1,10),
("Fisica", 9999,"3B",0,11),
("Fisica", 9999,"3B",0,12),
("Fisica", 9999,"3B",5,12),
("Fisica", 9999,"3B",5,13),
("Filosofia", 9997,"3B",1,9),
("Filosofia", 9997,"3B",1,10),
("Filosofia", 9997,"3B",3,12),
("Filosofia", 9997,"3B",3,13),
("Matematica", 9997,"3B",4,10);


INSERT INTO `users` (`matricola`,`password`,`name`,`lastname`,`class`,`pin`) VALUES
(1234,"password","Alberto","Amicomio","3B","0000"),
(1235,"password","Sara","Costruttore","3B","0000"),
(1236,"password","Vanessa","Opportuna","3B","0000"),
(1237,"password","Michela","Articuno","3B","0000"),
(1238,"password","Giuseppe","Barbiere","3B","0000"),
(1239,"password","Daniele","Zapdos","3B","0000"),
(1240,"password","Lucia","Portamivia","3B","0000"),
(1241,"password","Paoletto","Fisico","3B","0000"),
(1242,"password","Paoletto","Capellone","3B","0000"),
(1243,"password","Salvatore","Ruspberry","3B","0000"),
(1244,"password","Silvano","Medio","3B","0000"),
(1245,"password","Luca","Zammariello","3B","0000"),
(1246,"password","Alberto","Micio","4B","0000"),
(1247,"password","Riccardo","Carpinella","4B","0000"),
(1248,"password","Andrea","De Paolis","4B","0000"),
(1249,"password","Alberto","Menichelli","4B","0000"),
(1250,"password","Giapo","Colagrossi","4B","0000"),
(1251,"password","Fabrizio","Cola","4B","0000"),
(1252,"password","Stefan","Huma","4B","0000"),
(1253,"password","Federico","Pescatore","4B","0000"),
(1254,"password","Riccardo","Alberti","4B","0000"),
(1255,"password","Silvestro","Rosso","4B","0000");


INSERT INTO `Professor` (`matricola`,`password`,`name`,`lastname`) VALUES
(9999,"pass","Albertone","Macchina"),
(9998,"pass","Lucone","Albergo"),
(9997,"pass","Poseidone","Nuotatore");

INSERT INTO `classi` (`name`,`matricolaProfessore`) VALUES
("3B", 9999),
("4B", 9997),
("3B", 9998),
("4B", 9999),
("3B", 9997),
("4B", 9998);

INSERT INTO `materia` (`name`,`matricolaProfessore`) VALUES
("Geografia", 9999),
("Matematica", 9997),
("Storia", 9998),
("Fisica", 9999),
("Filosofia", 9997),
("Fisica", 9998);

INSERT INTO `Grades` (`matricolaStudente`,`matricolaProfessore`,`nomeProfessore`,`materia`,`voto`,`tipo`,`data`) VALUES
(1234, 9999, "Macchina","Geografia","8","scritto","2020-1-9"),
(1234, 9999, "Macchina","Geografia","7","orale","2020-1-3"),
(1234, 9999, "Macchina","Storia","5","orale","2020-1-5"),
(1241, 9999, "Macchina","Storia","5","orale","2020-1-5"),
(1250,9997,"Poseidone","Matematica","10","scritto","2020-1-9");

INSERT INTO `Assenza` (`matricolaStudente`,`data`,`tipo`,`checkbit`) VALUES
(1234,"2020-1-11","assenza",1),
(1237,"2020-1-10","assenza",1),
(1235,"2020-1-10","assenza",1),
(1238,"2020-1-10","assenza",1),
(1234,"2020-1-12","assenza",1),
(1239,"2020-1-10","assenza",1),
(1234,"2020-1-10","assenza",1),
(1234,"2020-1-14","assenza",1);
