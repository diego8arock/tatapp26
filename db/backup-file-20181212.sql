-- MySQL dump 10.13  Distrib 5.7.24, for Linux (x86_64)
--
-- Host: localhost    Database: tatapp26_development
-- ------------------------------------------------------
-- Server version	5.7.24-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ar_internal_metadata`
--

DROP TABLE IF EXISTS `ar_internal_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ar_internal_metadata` (
  `key` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ar_internal_metadata`
--

LOCK TABLES `ar_internal_metadata` WRITE;
/*!40000 ALTER TABLE `ar_internal_metadata` DISABLE KEYS */;
INSERT INTO `ar_internal_metadata` VALUES ('environment','development','2018-12-11 17:33:12','2018-12-11 17:33:12');
/*!40000 ALTER TABLE `ar_internal_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assignments`
--

DROP TABLE IF EXISTS `assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assignments` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) NOT NULL,
  `employee_id` bigint(20) NOT NULL,
  `seat_id` bigint(20) NOT NULL,
  `assignment_date` date NOT NULL,
  `status` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_rails_1eb99de2cc` (`seat_id`),
  KEY `fk_rails_d0980e430f` (`employee_id`),
  KEY `fk_rails_4d3d2c839c` (`project_id`),
  CONSTRAINT `fk_rails_1eb99de2cc` FOREIGN KEY (`seat_id`) REFERENCES `seats` (`id`),
  CONSTRAINT `fk_rails_4d3d2c839c` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`),
  CONSTRAINT `fk_rails_d0980e430f` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignments`
--

LOCK TABLES `assignments` WRITE;
/*!40000 ALTER TABLE `assignments` DISABLE KEYS */;
INSERT INTO `assignments` VALUES (1,1,101,1,'2018-12-11',1,'2018-12-11 17:49:17','2018-12-11 17:49:17'),(2,1,98,34,'2018-12-12',2,'2018-12-12 15:17:50','2018-12-12 15:18:22');
/*!40000 ALTER TABLE `assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `number` varchar(30) NOT NULL,
  `admission_date` date NOT NULL,
  `birth_date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `assignment_type` int(11) NOT NULL DEFAULT '1',
  `seat_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_employees_on_number` (`number`),
  KEY `fk_rails_f3055ce412` (`project_id`),
  KEY `fk_rails_c961385dd5` (`seat_id`),
  CONSTRAINT `fk_rails_c961385dd5` FOREIGN KEY (`seat_id`) REFERENCES `seats` (`id`),
  CONSTRAINT `fk_rails_f3055ce412` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Julio Pinzon','1111111','2017-05-22','1984-10-06',2,1,NULL,1,'2018-12-11 17:33:19','2018-12-11 17:33:19'),(2,'Diego Ochoa','2222222','2017-05-22','1989-12-11',2,1,NULL,1,'2018-12-11 17:33:19','2018-12-11 17:33:19'),(3,'Paola Bernal','3333333','2017-05-22','1989-12-11',2,1,NULL,2,'2018-12-11 17:33:19','2018-12-11 17:33:19'),(4,'Paola Cardenas','4444444','2017-05-22','1989-12-11',2,1,NULL,2,'2018-12-11 17:33:19','2018-12-11 17:33:19'),(90,'Cesar Augusto Gomez','823773','2000-01-01','2000-01-02',1,2,9,2,'2018-12-11 17:46:40','2018-12-11 17:47:20'),(91,'Luz Karime Valderrama  Santibanez','891541','2000-01-01','2000-01-02',1,2,10,2,'2018-12-11 17:46:40','2018-12-11 17:47:20'),(92,'Juan Gabriel Rodriguez Fernandez','1220234','2000-01-01','2000-01-02',1,2,11,2,'2018-12-11 17:46:40','2018-12-11 17:47:20'),(93,'Luis Parody','1563056','2000-01-01','2000-01-02',1,2,12,2,'2018-12-11 17:46:40','2018-12-11 17:47:21'),(94,'Oscar Javier Angel Balcazar','1537117','2000-01-01','2000-01-02',1,2,13,2,'2018-12-11 17:46:40','2018-12-11 17:47:21'),(95,'Mr. Yeison Alberto Lopez Pascuas','1048222','2000-01-01','2000-01-02',1,1,NULL,1,'2018-12-11 17:47:21','2018-12-11 17:47:21'),(96,'Ms. Marisol   Higuera','1304238','2000-01-01','2000-01-02',1,1,NULL,1,'2018-12-11 17:47:21','2018-12-11 17:47:21'),(97,'Mr. Julian Ricardo Jimenez Hinestroza','1384198','2000-01-01','2000-01-02',1,1,NULL,1,'2018-12-11 17:47:21','2018-12-11 17:47:21'),(98,'Mr. Tanmay   .','741605','2000-01-01','2000-01-02',1,1,NULL,1,'2018-12-11 17:47:21','2018-12-11 17:47:21'),(99,'Ms. Nini Johanna Gutierrez Rojas','1571452','2000-01-01','2000-01-02',1,1,NULL,1,'2018-12-11 17:47:21','2018-12-11 17:47:21'),(100,'Ms. Jennifer   Bermudez Tunjano - Pasante','1560763','2000-01-01','2000-01-02',1,1,NULL,1,'2018-12-11 17:47:21','2018-12-11 17:47:21'),(101,'Ms. Daniela Lopez Lopez Carol - Pasante','1562211','2000-01-01','2000-01-02',1,1,NULL,1,'2018-12-11 17:47:22','2018-12-11 17:47:22'),(102,'Ms. Yulieth Alexandra Talero - Pasante','1419749','2000-01-01','2000-01-02',1,1,NULL,1,'2018-12-11 17:47:22','2018-12-11 17:47:22'),(103,'Mr. Elvis Ariel Mora Gamez','858973','2000-01-01','2000-01-02',1,1,NULL,1,'2018-12-11 17:47:22','2018-12-11 17:47:22'),(104,'Ms. Lina Andrea Guarnizo Espinosa','1454083','2000-01-01','2000-01-02',1,1,NULL,1,'2018-12-11 17:47:22','2018-12-11 17:47:22'),(105,'Mr. Fredy Alexander Munoz Bermudez','1455711','2000-01-01','2000-01-02',1,1,NULL,1,'2018-12-11 17:47:22','2018-12-11 17:47:22'),(106,'Ms. Leidy Viviana Gomez Espitia - Pasante','1460041','2000-01-01','2000-01-02',1,1,NULL,1,'2018-12-11 17:47:22','2018-12-11 17:47:22'),(107,'Jorge Garcia - Pasante','1560764','2000-01-01','2000-01-02',1,1,NULL,1,'2018-12-11 17:47:23','2018-12-11 17:47:23'),(108,'Gysella Andrea Pineda Quintero','1450706','2000-01-01','2000-01-02',1,1,NULL,1,'2018-12-11 17:47:23','2018-12-11 17:47:23'),(109,'Jeniffer lasso','1436448','2000-01-01','2000-01-02',1,1,NULL,1,'2018-12-11 17:47:23','2018-12-11 17:47:23');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maps`
--

DROP TABLE IF EXISTS `maps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maps` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `seats` text,
  `height` int(11) NOT NULL,
  `width` int(11) NOT NULL,
  `seats_total` int(11) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_rails_a90d6cd6e2` (`project_id`),
  CONSTRAINT `fk_rails_a90d6cd6e2` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maps`
--

LOCK TABLES `maps` WRITE;
/*!40000 ALTER TABLE `maps` DISABLE KEYS */;
INSERT INTO `maps` VALUES (1,'Mapa12','1_2,2_2,3_2,4_2,5_2,5_4,4_4,3_4,2_4,1_4',5,5,10,1,'2018-12-11 17:35:09','2018-12-11 17:35:09'),(2,'Mapa18','1_1,1_2,1_3,1_4,1_5,3_1,3_2,3_3,3_4,3_5,5_1,5_2,5_3,5_4,5_5',5,5,15,2,'2018-12-11 17:36:11','2018-12-11 17:36:11'),(4,'Mapa100','5_1,4_1,3_1,2_1,1_1,1_2,1_3,1_4,1_5,2_5,3_5,4_5,5_5,5_4,5_3,5_2',5,5,16,10,'2018-12-11 19:51:29','2018-12-11 19:51:29'),(5,'MapaGrupoSoporte','1_6,1_5,1_4,1_3,2_3,2_4,2_6,2_5,4_4,4_3,4_2,4_1,5_1,5_2,5_3',6,6,15,1,'2018-12-11 19:51:37','2018-12-11 19:51:37'),(6,'Mapa8','1_1,2_1,2_2,1_2',10,10,4,1,'2018-12-11 20:00:47','2018-12-11 20:00:47'),(7,'MapaTigo','5_1,4_1,4_2,5_2,1_10,1_9,1_7,1_6,3_10,3_9,3_8,3_7,3_6,3_5,3_4,4_4,4_5,4_9,4_10',5,10,19,11,'2018-12-11 20:36:19','2018-12-11 20:36:19'),(8,'MapaAvianca','7_1,6_1,5_1,4_1,3_1,2_1,1_3,1_4,1_5,1_8,1_9,2_9,2_8,2_5,2_3,2_4,4_3,4_4,4_5,4_6,4_7,4_8,4_9,5_9,5_8,5_7,5_6,5_5,5_4,5_3',7,9,30,5,'2018-12-11 20:43:09','2018-12-11 20:43:09'),(9,'MapaABINBEV','1_1,1_2,1_4,1_5,1_7,1_8,3_2,3_3,3_5,3_6,3_8,3_9,4_5,4_6,5_5,5_6,6_5,6_6,4_8,4_9,5_8,5_9,6_8,6_9,7_8,7_9,8_8,8_9,10_8,10_9,11_9,11_8,11_11,10_11,9_11,8_11,7_11,6_11',11,11,38,4,'2018-12-11 20:47:49','2018-12-11 20:47:49'),(10,'MapaTELCOS','18_50,17_50,14_50,13_50,13_49,14_49,17_49,18_49,18_47,17_47,16_47,15_47,14_47,13_47,13_46,14_46,15_46,16_46,17_46,18_46,13_44,14_44,15_44,16_44,16_43,15_43,14_43,13_43,13_41,14_41,15_41,16_41,16_40,15_40,14_40,13_40,13_38,13_37,14_37,14_38,17_38,17_37,18_37,18_38,13_35,14_35,15_35,16_35,17_35,17_34,16_34,15_34,14_34,13_34,13_32,14_32,14_31,13_31,17_31,17_32,13_29,14_29,15_29,16_29,16_28,15_28,14_28,13_28,13_26,14_26,15_26,16_26,17_26,17_25,16_25,15_25,14_25,13_25,13_23,14_23,15_23,16_23,16_22,15_22,14_22,13_22,13_20,13_19,16_19,16_20,17_20,17_19,17_17,16_17,16_16,15_16,15_17,14_17,14_16,13_16,13_17,13_14,14_14,15_14,16_14,17_14,17_13,16_13,15_13,14_13,13_13,13_10,13_11,14_11,14_10,17_10,17_11,13_7,13_8,14_8,14_7,15_7,15_8,16_8,16_7,17_7,17_8,13_4,13_5,14_5,14_4,15_4,15_5,16_5,16_4,17_4,13_2,13_1,16_2,17_2,17_1,16_1,11_31,11_32,11_34,11_35,10_31,9_31,8_31,7_31,6_31,5_31,4_31,10_32,9_32,8_32,7_32,6_32,5_32,4_32,10_34,9_34,8_34,7_34,7_35,8_35,9_35,10_35,4_34,4_35,3_35,3_34,1_33,1_34',18,50,174,2,'2018-12-11 21:34:58','2018-12-11 21:34:58'),(11,'Mapa72','1_1,2_2,3_3,4_4,5_5,5_1,4_2,2_4,1_5',5,5,9,1,'2018-12-12 14:05:20','2018-12-12 14:05:20');
/*!40000 ALTER TABLE `maps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `tag` varchar(3) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,'Grupo Soporte',1,'GS','2018-12-11 17:33:18','2018-12-11 17:33:18'),(2,'Claro/Telmex',1,'CL','2018-12-11 17:33:18','2018-12-11 17:33:18'),(3,'Davivienda',1,'DA','2018-12-11 17:33:18','2018-12-11 17:33:18'),(4,'ABINBEV',1,'AB','2018-12-11 17:33:18','2018-12-11 17:33:18'),(5,'AVIANCA',1,'AV','2018-12-11 17:33:18','2018-12-11 17:33:18'),(6,'Retail SWON',1,'RE','2018-12-11 17:33:18','2018-12-11 17:33:18'),(7,'BFSI SWON',1,'BF','2018-12-11 17:33:18','2018-12-11 17:33:18'),(8,'ENTSOL',1,'EN','2018-12-11 17:33:18','2018-12-11 17:33:18'),(9,'SWON CMI',1,'SW','2018-12-11 17:33:18','2018-12-11 17:33:18'),(10,'Compliance SWON',1,'CO','2018-12-11 17:33:18','2018-12-11 17:33:18'),(11,'TIGO',1,'TI','2018-12-11 17:33:18','2018-12-11 17:33:18');
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `resource_type` varchar(255) DEFAULT NULL,
  `resource_id` bigint(20) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_roles_on_resource_type_and_resource_id` (`resource_type`,`resource_id`),
  KEY `index_roles_on_name` (`name`),
  KEY `index_roles_on_name_and_resource_type_and_resource_id` (`name`,`resource_type`,`resource_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin',NULL,NULL,'2018-12-11 17:33:18','2018-12-11 17:33:18'),(2,'employee',NULL,NULL,'2018-12-11 17:33:18','2018-12-11 17:33:18');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20181125150022'),('20181205030857'),('20181205035634'),('20181206235806'),('20181207001245'),('20181207005912'),('20181207010426'),('20181207010454');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seats`
--

DROP TABLE IF EXISTS `seats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seats` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) NOT NULL,
  `code` varchar(10) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `assignment_date` date DEFAULT NULL,
  `map_id` bigint(20) NOT NULL,
  `html_id` varchar(255) NOT NULL,
  `fixed` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_rails_93e3b7506d` (`project_id`),
  KEY `fk_rails_f35d21dd46` (`map_id`),
  CONSTRAINT `fk_rails_93e3b7506d` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`),
  CONSTRAINT `fk_rails_f35d21dd46` FOREIGN KEY (`map_id`) REFERENCES `maps` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seats`
--

LOCK TABLES `seats` WRITE;
/*!40000 ALTER TABLE `seats` DISABLE KEYS */;
INSERT INTO `seats` VALUES (1,1,'GS1',1,'2018-12-11',1,'2_3',0,'2018-12-11 17:36:28','2018-12-11 17:49:17'),(2,1,'GS2',1,NULL,1,'3_3',0,'2018-12-11 17:36:31','2018-12-11 17:36:31'),(3,1,'GS3',1,NULL,1,'4_3',0,'2018-12-11 17:36:36','2018-12-11 17:36:36'),(4,1,'GS4',1,NULL,1,'5_3',0,'2018-12-11 17:36:40','2018-12-11 17:36:40'),(5,1,'GS5',1,NULL,1,'2_5',0,'2018-12-11 17:36:58','2018-12-11 17:36:58'),(6,1,'GS6',1,NULL,1,'3_5',0,'2018-12-11 17:37:01','2018-12-11 17:37:01'),(7,1,'GS7',1,NULL,1,'4_5',0,'2018-12-11 17:37:05','2018-12-11 17:37:05'),(8,1,'GS8',1,NULL,1,'5_5',0,'2018-12-11 17:37:09','2018-12-11 17:37:09'),(9,2,'CL1',3,'2018-12-11',1,'2_2',0,'2018-12-11 17:37:37','2018-12-11 17:47:20'),(10,2,'CL2',3,'2018-12-11',1,'2_3',0,'2018-12-11 17:37:40','2018-12-11 17:47:20'),(11,2,'CL3',3,'2018-12-11',1,'2_4',0,'2018-12-11 17:37:44','2018-12-11 17:47:21'),(12,2,'CL4',3,'2018-12-11',1,'2_5',0,'2018-12-11 17:37:49','2018-12-11 17:47:21'),(13,2,'CL5',3,'2018-12-11',1,'4_2',0,'2018-12-11 17:37:54','2018-12-11 17:47:21'),(14,2,'CL6',1,NULL,1,'4_3',0,'2018-12-11 17:38:00','2018-12-11 17:38:00'),(15,2,'CL7',1,NULL,1,'4_4',0,'2018-12-11 17:38:04','2018-12-11 17:38:04'),(16,2,'CL8',1,NULL,1,'4_5',0,'2018-12-11 17:38:08','2018-12-11 17:38:08'),(17,1,'GS1',1,NULL,5,'2_4',0,'2018-12-11 19:54:35','2018-12-11 19:54:35'),(18,1,'GS2',1,NULL,5,'2_5',0,'2018-12-11 19:54:38','2018-12-11 19:54:38'),(19,1,'GS3',1,NULL,5,'2_6',0,'2018-12-11 19:54:40','2018-12-11 19:54:43'),(20,1,'GS4',1,NULL,5,'2_7',0,'2018-12-11 19:54:46','2018-12-11 19:54:46'),(21,1,'GS5',1,NULL,5,'3_4',0,'2018-12-11 19:54:50','2018-12-11 19:54:50'),(22,1,'GS6',1,NULL,5,'3_5',0,'2018-12-11 19:54:52','2018-12-11 19:54:52'),(23,1,'GS7',1,NULL,5,'3_6',0,'2018-12-11 19:54:55','2018-12-11 19:54:55'),(24,1,'GS8',1,NULL,5,'3_7',0,'2018-12-11 19:54:57','2018-12-11 19:54:57'),(25,1,'GS9',1,NULL,5,'5_2',0,'2018-12-11 19:55:01','2018-12-11 19:55:01'),(26,1,'GS10',1,NULL,5,'5_3',0,'2018-12-11 19:55:04','2018-12-11 19:55:04'),(27,1,'GS11',1,NULL,5,'5_4',0,'2018-12-11 19:55:06','2018-12-11 19:55:06'),(28,1,'GS12',1,NULL,5,'5_5',0,'2018-12-11 19:55:08','2018-12-11 19:55:08'),(29,1,'GS13',1,NULL,5,'6_2',0,'2018-12-11 19:55:51','2018-12-11 19:55:51'),(30,1,'GS14',1,NULL,5,'6_3',0,'2018-12-11 19:55:54','2018-12-11 19:55:54'),(31,1,'GS15',1,NULL,5,'6_4',0,'2018-12-11 19:55:57','2018-12-11 19:55:57'),(32,1,'GS1',1,NULL,11,'1_1',0,'2018-12-12 14:05:42','2018-12-12 14:05:42'),(33,1,'GS2',1,NULL,11,'2_2',0,'2018-12-12 14:05:47','2018-12-12 14:05:47'),(34,1,'GS3',1,NULL,11,'3_3',0,'2018-12-12 14:05:52','2018-12-12 15:18:22'),(35,1,'GS4',1,NULL,11,'1_5',0,'2018-12-12 14:06:02','2018-12-12 14:06:02'),(36,1,'GS5',1,NULL,11,'2_4',0,'2018-12-12 14:06:07','2018-12-12 14:06:07'),(37,1,'GS6',1,NULL,11,'4_2',0,'2018-12-12 14:06:11','2018-12-12 14:06:11'),(38,1,'GS7',1,NULL,11,'5_1',0,'2018-12-12 14:06:15','2018-12-12 14:06:15'),(39,1,'GS8',1,NULL,11,'4_4',0,'2018-12-12 14:06:19','2018-12-12 14:06:19'),(40,1,'GS9',1,NULL,11,'5_5',0,'2018-12-12 14:06:26','2018-12-12 14:06:26');
/*!40000 ALTER TABLE `seats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `employee_number` varchar(255) DEFAULT NULL,
  `password_digest` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `username` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_username` (`username`),
  UNIQUE KEY `index_users_on_employee_number` (`employee_number`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,NULL,NULL,'2018-12-11 17:33:19','2018-12-11 17:33:19','admin','$2a$11$JnoR9UwD8N3EHvOSLeWNJOMcKbl4BS595fUaroAhxX7oEJPLSXjey',NULL,NULL,NULL),(2,NULL,NULL,'2018-12-11 17:33:19','2018-12-12 20:15:28','1111111','$2a$11$rs2ZVetG4KRjTuM8iIOrNO7dZ0Ltra3Pf9j9VLn3x3N65zf0pii5a',NULL,NULL,NULL),(3,NULL,NULL,'2018-12-11 17:33:19','2018-12-11 17:33:19','2222222','$2a$11$mIu3nH1TCabwCwtPb.8D8.4oAM1tXFYkaoIliNsNNCgA2HUJBCoWC',NULL,NULL,NULL),(4,NULL,NULL,'2018-12-11 17:33:19','2018-12-11 17:33:19','3333333','$2a$11$GFNVcZUvRn8HMJcTf3veWOgKFeO0FLehQRFUDotKLnqL5fTRKwdSa',NULL,NULL,NULL),(5,NULL,NULL,'2018-12-11 17:33:19','2018-12-11 17:33:19','4444444','$2a$11$q7ksckRtPrnxnqX0.TEwI.x2uMbAqEjFtgyDHlcii6p.8YsQyDfSW',NULL,NULL,NULL),(91,NULL,NULL,'2018-12-11 17:46:40','2018-12-11 17:46:40','823773','$2a$11$zZoxx.RvmqOJBxDRo8EifO7LL108yKl0nEs.Ej8ZU8nRziVHfy8q.',NULL,NULL,NULL),(92,NULL,NULL,'2018-12-11 17:46:40','2018-12-11 17:48:37','891541','$2a$11$3wNRXeX/km25HaDkx1RLFeiPeessfQSxmiH4DYcIux4XFLpd0JY0G',NULL,NULL,NULL),(93,NULL,NULL,'2018-12-11 17:46:40','2018-12-11 17:46:40','1220234','$2a$11$EV3G9Vm3lHMNd4x1wEsVEu1.LzfV.MbeYxqN9gDV/nYXVmOHEPOou',NULL,NULL,NULL),(94,NULL,NULL,'2018-12-11 17:46:40','2018-12-11 17:46:40','1563056','$2a$11$KrtnEP4hqgJ7JHaUrPyC4O0/LNx/J4WYDymRAy9ejM7bDmbgUFMuC',NULL,NULL,NULL),(95,NULL,NULL,'2018-12-11 17:46:40','2018-12-11 17:46:40','1537117','$2a$11$aHdxAeMyYyH7UDMiLiiCK.g.pd0Vtsgo7f/Ae.sx.ijQUgzQ15xfq',NULL,NULL,NULL),(96,NULL,NULL,'2018-12-11 17:47:21','2018-12-11 17:47:21','1048222','$2a$11$kxmbl47Sy3jSRVSg4nVCu.iSw3DCdyWQ8mNakiwyT3hWKkWjIpM.G',NULL,NULL,NULL),(97,NULL,NULL,'2018-12-11 17:47:21','2018-12-11 17:47:21','1304238','$2a$11$Atwc9wkVL7m/8aG1kl5EyOitPhukko//zEWPSB02RSnsGrVAUGf06',NULL,NULL,NULL),(98,NULL,NULL,'2018-12-11 17:47:21','2018-12-11 17:47:21','1384198','$2a$11$f4P9GXw2Wb.FQSYnK9PAJO9pEgdZ2U3U4uBd7IpDR0BWFTKSEe9Lq',NULL,NULL,NULL),(99,NULL,NULL,'2018-12-11 17:47:21','2018-12-12 15:18:18','741605','$2a$11$iCojc1SI4jMhqA/Goyf87uvV3AR2uV5SRrkiXsEyiW30VJneu/YZy',NULL,NULL,NULL),(100,NULL,NULL,'2018-12-11 17:47:21','2018-12-11 17:47:21','1571452','$2a$11$n0HQqghRvTteR70s6NVk4.VOYIcBHFe7OlhvAbNnXmPQgGHhvJ9OW',NULL,NULL,NULL),(101,NULL,NULL,'2018-12-11 17:47:21','2018-12-11 17:47:21','1560763','$2a$11$rE2lQubolskjeAV7LI0qPeKOJFc1aFKOcNFrt9A..do3ngCx4zI9O',NULL,NULL,NULL),(102,NULL,NULL,'2018-12-11 17:47:22','2018-12-11 17:49:31','1562211','$2a$11$IHfQ45ed/qJOAKGfAE6S6eG2Dbk7FjLTkcuGiBuHr8p9i3G.Ncybe',NULL,NULL,NULL),(103,NULL,NULL,'2018-12-11 17:47:22','2018-12-11 17:47:22','1419749','$2a$11$M5zUrcZiTHHKIxXHm2BUPukpy6KwDUt0t1vfF6HqS2Wgu1Hqs0a7O',NULL,NULL,NULL),(104,NULL,NULL,'2018-12-11 17:47:22','2018-12-11 17:50:13','858973','$2a$11$BT/8U9fYvuWwaAozuM0lz.ZbB/2jCm/TGfiT7qy.CEW5.Bfq6CJHy',NULL,NULL,NULL),(105,NULL,NULL,'2018-12-11 17:47:22','2018-12-11 17:47:22','1454083','$2a$11$fYO4xdZZNNGcukqAdDXY1uc8G6CVm.aAgZGaUNUbGuIyjpQlEYRai',NULL,NULL,NULL),(106,NULL,NULL,'2018-12-11 17:47:22','2018-12-11 17:47:22','1455711','$2a$11$8sznKoNWRvb56IJr4zgXYObKf56i7z5jc5p8SGFEt8E9U//7uTN/K',NULL,NULL,NULL),(107,NULL,NULL,'2018-12-11 17:47:22','2018-12-12 14:21:11','1460041','$2a$11$nXG03saLDQKaTw.8vbKiZ.gDQ/MWQGe2Z4a1kdgtaM3TWVoeriOpy',NULL,NULL,NULL),(108,NULL,NULL,'2018-12-11 17:47:23','2018-12-11 17:47:23','1560764','$2a$11$47UGjXC.hk6tU0z4U2GbDeKnq3zC9oXxN0gHfe8/fWglpgQjrUXa6',NULL,NULL,NULL),(109,NULL,NULL,'2018-12-11 17:47:23','2018-12-11 17:47:23','1450706','$2a$11$qX4wekAwzFJ0uJ1QG7pz/OJnTfn.KJkGID.oYeL.6/3qpnPdGOgPO',NULL,NULL,NULL),(110,NULL,NULL,'2018-12-11 17:47:23','2018-12-11 17:47:23','1436448','$2a$11$rghEwcnD4FMHLdUhgA/8Pu4Fp216mZujPbvVZ.LUJofjiIiuFtxp.',NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_roles`
--

DROP TABLE IF EXISTS `users_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_roles` (
  `user_id` bigint(20) DEFAULT NULL,
  `role_id` bigint(20) DEFAULT NULL,
  KEY `index_users_roles_on_user_id` (`user_id`),
  KEY `index_users_roles_on_role_id` (`role_id`),
  KEY `index_users_roles_on_user_id_and_role_id` (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_roles`
--

LOCK TABLES `users_roles` WRITE;
/*!40000 ALTER TABLE `users_roles` DISABLE KEYS */;
INSERT INTO `users_roles` VALUES (1,1),(2,2),(3,2),(4,2),(5,2),(91,2),(92,2),(93,2),(94,2),(95,2),(96,2),(97,2),(98,2),(99,2),(100,2),(101,2),(102,2),(103,2),(104,2),(105,2),(106,2),(107,2),(108,2),(109,2),(110,2);
/*!40000 ALTER TABLE `users_roles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-12-12 15:27:35
