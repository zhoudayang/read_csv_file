-- MySQL dump 10.13  Distrib 5.7.13, for osx10.11 (x86_64)
--
-- Host: localhost    Database: ezlife
-- ------------------------------------------------------
-- Server version	5.7.13

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
-- Table structure for table `auth_group`
--
DROP DATABASE IF EXISTS `ezlife`;
create database `ezlife`;
use `ezlife`;
DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permissi_content_type_id_2f476e4b_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_perm_permission_id_1fbb5f2c_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_user_user_perm_permission_id_1fbb5f2c_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `distinguish`
--

DROP TABLE IF EXISTS `distinguish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `distinguish` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_id` int(11) NOT NULL,
  `sop_id` int(11) NOT NULL,
  `sample_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `best_cutoff_begin` double NOT NULL,
  `best_cutoff_end` double NOT NULL,
  `ev` double NOT NULL,
  `auc_value` double NOT NULL,
  `concordance` double NOT NULL,
  `tpr` double NOT NULL,
  `tnr` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=880 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `efirms`
--

DROP TABLE IF EXISTS `efirms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `efirms` (
  `_id` int(11) NOT NULL,
  `sn_code` varchar(255) DEFAULT NULL,
  `organization_id` int(11) NOT NULL,
  `create_at` datetime DEFAULT NULL,
  `efirms_sn` varchar(255) DEFAULT NULL,
  `efirms_name` varchar(255) DEFAULT NULL,
  `tech_name` varchar(100) NOT NULL,
  `electro_type` varchar(255) DEFAULT NULL,
  `holder_type` varchar(255) DEFAULT NULL,
  `assemble_date` datetime DEFAULT NULL,
  `firmware_version` varchar(255) DEFAULT NULL,
  `software_version` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE KEY `efirms_sn` (`efirms_sn`),
  UNIQUE KEY `sn_code` (`sn_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eplate_types`
--

DROP TABLE IF EXISTS `eplate_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eplate_types` (
  `_id` int(11) NOT NULL,
  `layout` longtext NOT NULL,
  `type` varchar(150) NOT NULL,
  `create_at` datetime NOT NULL,
  PRIMARY KEY (`_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eplates`
--

DROP TABLE IF EXISTS `eplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eplates` (
  `_id` int(11) NOT NULL,
  `bar_code` varchar(60) DEFAULT '',
  `eplate_type_id` int(11) DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `eplate_description` varchar(255) DEFAULT '',
  `batch_date` datetime DEFAULT NULL,
  `purchaser` varchar(50) DEFAULT '',
  `batch_number` varchar(60) DEFAULT NULL,
  `organization_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `organization`
--

DROP TABLE IF EXISTS `organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organization` (
  `_id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `country` varchar(60) NOT NULL,
  `city` varchar(60) NOT NULL,
  `Address` varchar(250) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `create_at` datetime NOT NULL,
  `longitude` varchar(60) NOT NULL,
  `latitude` varchar(60) NOT NULL,
  PRIMARY KEY (`_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `_id` int(11) NOT NULL AUTO_INCREMENT,
  `catalogA` varchar(255) DEFAULT NULL,
  `catalogB` varchar(255) DEFAULT NULL,
  `catalogC` varchar(255) DEFAULT NULL,
  `attributes` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `Mongodb_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reagent`
--

DROP TABLE IF EXISTS `reagent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reagent` (
  `_id` int(11) NOT NULL AUTO_INCREMENT,
  `id` int(11) DEFAULT NULL,
  `reagent_id` int(11) DEFAULT NULL,
  `batch_id` int(11) DEFAULT NULL,
  `private_num` varchar(255) DEFAULT NULL,
  `storage` double DEFAULT NULL,
  `code_number` varchar(255) DEFAULT NULL,
  `specification` varchar(255) DEFAULT NULL,
  `batch_number` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `attributes` varchar(255) DEFAULT NULL,
  `supplier` varchar(255) DEFAULT NULL,
  `purchaser` varchar(255) DEFAULT NULL,
  `creator` varchar(255) DEFAULT NULL,
  `purchase_date` datetime DEFAULT NULL,
  `arrival_date` datetime DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `organization_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1346 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sample`
--

DROP TABLE IF EXISTS `sample`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sample` (
  `_id` int(11) NOT NULL AUTO_INCREMENT,
  `id` int(11) NOT NULL,
  `sample_id` int(11) DEFAULT NULL,
  `batch_id` int(11) DEFAULT NULL,
  `private_num` varchar(255) DEFAULT NULL,
  `od_or_amount` varchar(255) DEFAULT NULL,
  `stock_concentration` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `sequence` longtext,
  `purification` varchar(255) DEFAULT NULL,
  `mod_5` varchar(255) DEFAULT NULL,
  `mod_3` varchar(255) DEFAULT NULL,
  `attributes` varchar(255) DEFAULT NULL,
  `designer` varchar(255) DEFAULT NULL,
  `supplier` varchar(255) DEFAULT NULL,
  `creator` varchar(255) DEFAULT NULL,
  `purchase_date` datetime DEFAULT NULL,
  `arrival_date` datetime DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `purchaser` varchar(255) DEFAULT NULL,
  `organization_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1033 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sop`
--

DROP TABLE IF EXISTS `sop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sop` (
  `_id` int(11) NOT NULL AUTO_INCREMENT,
  `sop_id` int(11) NOT NULL,
  `sop_name` varchar(255) NOT NULL,
  `step1_type_id_1` int(11) DEFAULT NULL,
  `step1_reagent_id_1` int(11) DEFAULT NULL,
  `step1_volumn_1` varchar(255) DEFAULT NULL,
  `step1_type_id_2` int(11) DEFAULT NULL,
  `step1_reagent_id_2` int(11) DEFAULT NULL,
  `step1_volumn_2` varchar(255) DEFAULT NULL,
  `step1_type_id_3` int(11) DEFAULT NULL,
  `step1_reagent_id_3` int(11) DEFAULT NULL,
  `step1_volumn_3` varchar(255) DEFAULT NULL,
  `step1_type_id_4` int(11) DEFAULT NULL,
  `step1_reagent_id_4` int(11) DEFAULT NULL,
  `step1_volumn_4` varchar(255) DEFAULT NULL,
  `step1_type_id_5` int(11) DEFAULT NULL,
  `step1_reagent_id_5` int(11) DEFAULT NULL,
  `step1_volumn_5` varchar(255) DEFAULT NULL,
  `step1_type_id_6` int(11) DEFAULT NULL,
  `step1_reagent_id_6` int(11) DEFAULT NULL,
  `step1_volumn_6` varchar(255) DEFAULT NULL,
  `step1_type_id_7` int(11) DEFAULT NULL,
  `step1_reagent_id_7` int(11) DEFAULT NULL,
  `step1_volumn_7` varchar(255) DEFAULT NULL,
  `step1_type_id_8` int(11) DEFAULT NULL,
  `step1_reagent_id_8` int(11) DEFAULT NULL,
  `step1_volumn_8` varchar(255) DEFAULT NULL,
  `step1_type_id_9` int(11) DEFAULT NULL,
  `step1_reagent_id_9` int(11) DEFAULT NULL,
  `step1_volumn_9` varchar(255) DEFAULT NULL,
  `step1_type_id_10` int(11) DEFAULT NULL,
  `step1_reagent_id_10` int(11) DEFAULT NULL,
  `step1_volumn_10` varchar(255) DEFAULT NULL,
  `step1_type_id_11` int(11) DEFAULT NULL,
  `step1_reagent_id_11` int(11) DEFAULT NULL,
  `step1_volumn_11` varchar(255) DEFAULT NULL,
  `step1_type_id_12` int(11) DEFAULT NULL,
  `step1_reagent_id_12` int(11) DEFAULT NULL,
  `step1_volumn_12` varchar(255) DEFAULT NULL,
  `step1_type_id_13` int(11) DEFAULT NULL,
  `step1_reagent_id_13` int(11) DEFAULT NULL,
  `step1_volumn_13` varchar(255) DEFAULT NULL,
  `step1_type_id_14` int(11) DEFAULT NULL,
  `step1_reagent_id_14` int(11) DEFAULT NULL,
  `step1_volumn_14` varchar(255) DEFAULT NULL,
  `step1_type_id_15` int(11) DEFAULT NULL,
  `step1_reagent_id_15` int(11) DEFAULT NULL,
  `step1_volumn_15` varchar(255) DEFAULT NULL,
  `step1_pipette_volumn` double DEFAULT NULL,
  `step1_efield_vol1_voltage` double DEFAULT NULL,
  `step1_efield_vol1_duration` double DEFAULT NULL,
  `step1_efield_vol2_voltage` double DEFAULT NULL,
  `step1_efield_vol2_duration` double DEFAULT NULL,
  `step1_efield_cycles` int(11) DEFAULT NULL,
  `step1_incubation_duration` double DEFAULT NULL,
  `step1_wash` longtext NOT NULL,
  `step2_type_id_1` int(11) DEFAULT NULL,
  `step2_reagent_id_1` int(11) DEFAULT NULL,
  `step2_volumn_1` varchar(255) DEFAULT NULL,
  `step2_type_id_2` int(11) DEFAULT NULL,
  `step2_reagent_id_2` int(11) DEFAULT NULL,
  `step2_volumn_2` varchar(255) DEFAULT NULL,
  `step2_type_id_3` int(11) DEFAULT NULL,
  `step2_reagent_id_3` int(11) DEFAULT NULL,
  `step2_volumn_3` varchar(255) DEFAULT NULL,
  `step2_type_id_4` int(11) DEFAULT NULL,
  `step2_reagent_id_4` int(11) DEFAULT NULL,
  `step2_volumn_4` varchar(255) DEFAULT NULL,
  `step2_type_id_5` int(11) DEFAULT NULL,
  `step2_reagent_id_5` int(11) DEFAULT NULL,
  `step2_volumn_5` varchar(255) DEFAULT NULL,
  `step2_type_id_6` int(11) DEFAULT NULL,
  `step2_reagent_id_6` int(11) DEFAULT NULL,
  `step2_volumn_6` varchar(255) DEFAULT NULL,
  `step2_type_id_7` int(11) DEFAULT NULL,
  `step2_reagent_id_7` int(11) DEFAULT NULL,
  `step2_volumn_7` varchar(255) DEFAULT NULL,
  `step2_type_id_8` int(11) DEFAULT NULL,
  `step2_reagent_id_8` int(11) DEFAULT NULL,
  `step2_volumn_8` varchar(255) DEFAULT NULL,
  `step2_type_id_9` int(11) DEFAULT NULL,
  `step2_reagent_id_9` int(11) DEFAULT NULL,
  `step2_volumn_9` varchar(255) DEFAULT NULL,
  `step2_type_id_10` int(11) DEFAULT NULL,
  `step2_reagent_id_10` int(11) DEFAULT NULL,
  `step2_volumn_10` varchar(255) DEFAULT NULL,
  `step2_pipette_volumn` double DEFAULT NULL,
  `step2_efield_vol1_voltage` double DEFAULT NULL,
  `step2_efield_vol1_duration` double DEFAULT NULL,
  `step2_efield_vol2_voltage` double DEFAULT NULL,
  `step2_efield_vol2_duration` double DEFAULT NULL,
  `step2_efield_cycles` int(11) DEFAULT NULL,
  `step2_incubation_duration` double DEFAULT NULL,
  `step2_wash` longtext NOT NULL,
  `step3_type_id_1` int(11) DEFAULT NULL,
  `step3_reagent_id_1` int(11) DEFAULT NULL,
  `step3_volumn_1` varchar(255) DEFAULT NULL,
  `step3_type_id_2` int(11) DEFAULT NULL,
  `step3_reagent_id_2` int(11) DEFAULT NULL,
  `step3_volumn_2` varchar(255) DEFAULT NULL,
  `step3_type_id_3` int(11) DEFAULT NULL,
  `step3_reagent_id_3` int(11) DEFAULT NULL,
  `step3_volumn_3` varchar(255) DEFAULT NULL,
  `step3_type_id_4` int(11) DEFAULT NULL,
  `step3_reagent_id_4` int(11) DEFAULT NULL,
  `step3_volumn_4` varchar(255) DEFAULT NULL,
  `step3_type_id_5` int(11) DEFAULT NULL,
  `step3_reagent_id_5` int(11) DEFAULT NULL,
  `step3_volumn_5` varchar(255) DEFAULT NULL,
  `step3_type_id_6` int(11) DEFAULT NULL,
  `step3_reagent_id_6` int(11) DEFAULT NULL,
  `step3_volumn_6` varchar(255) DEFAULT NULL,
  `step3_type_id_7` int(11) DEFAULT NULL,
  `step3_reagent_id_7` int(11) DEFAULT NULL,
  `step3_volumn_7` varchar(255) DEFAULT NULL,
  `step3_type_id_8` int(11) DEFAULT NULL,
  `step3_reagent_id_8` int(11) DEFAULT NULL,
  `step3_volumn_8` varchar(255) DEFAULT NULL,
  `step3_type_id_9` int(11) DEFAULT NULL,
  `step3_reagent_id_9` int(11) DEFAULT NULL,
  `step3_volumn_9` varchar(255) DEFAULT NULL,
  `step3_type_id_10` int(11) DEFAULT NULL,
  `step3_reagent_id_10` int(11) DEFAULT NULL,
  `step3_volumn_10` varchar(255) DEFAULT NULL,
  `step3_pipette_volumn` double DEFAULT NULL,
  `step3_efield_vol1_voltage` double DEFAULT NULL,
  `step3_efield_vol1_duration` double DEFAULT NULL,
  `step3_efield_vol2_voltage` double DEFAULT NULL,
  `step3_efield_vol2_duration` double DEFAULT NULL,
  `step3_efield_cycles` int(11) DEFAULT NULL,
  `step3_incubation_duration` double DEFAULT NULL,
  `step3_wash` longtext NOT NULL,
  `step4_type_id_1` int(11) DEFAULT NULL,
  `step4_reagent_id_1` int(11) DEFAULT NULL,
  `step4_volumn_1` varchar(255) DEFAULT NULL,
  `step4_type_id_2` int(11) DEFAULT NULL,
  `step4_reagent_id_2` int(11) DEFAULT NULL,
  `step4_volumn_2` varchar(255) DEFAULT NULL,
  `step4_type_id_3` int(11) DEFAULT NULL,
  `step4_reagent_id_3` int(11) DEFAULT NULL,
  `step4_volumn_3` varchar(255) DEFAULT NULL,
  `step4_pipette_volumn` double DEFAULT NULL,
  `step4_efield_vol1_voltage` double DEFAULT NULL,
  `step4_efield_vol1_duration` double DEFAULT NULL,
  `step4_efield_vol2_voltage` double DEFAULT NULL,
  `step4_efield_vol2_duration` double DEFAULT NULL,
  `step4_efield_cycles` int(11) DEFAULT NULL,
  `step4_incubation_duration` double DEFAULT NULL,
  `step4_wash` longtext NOT NULL,
  `step5_type_id_1` int(11) DEFAULT NULL,
  `step5_reagent_id_1` int(11) DEFAULT NULL,
  `step5_volumn_1` varchar(255) DEFAULT NULL,
  `step5_type_id_2` int(11) DEFAULT NULL,
  `step5_reagent_id_2` int(11) DEFAULT NULL,
  `step5_volumn_2` varchar(255) DEFAULT NULL,
  `step5_pipette_volumn` double DEFAULT NULL,
  `step5_efield_vol1_voltage` double DEFAULT NULL,
  `step5_efield_vol1_duration` double DEFAULT NULL,
  `step5_efield_vol2_voltage` double DEFAULT NULL,
  `step5_efield_vol2_duration` double DEFAULT NULL,
  `step5_efield_cycles` int(11) DEFAULT NULL,
  `step5_incubation_duration` double DEFAULT NULL,
  `step5_wash` longtext NOT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE KEY `sop_id` (`sop_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1132 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `table_type`
--

DROP TABLE IF EXISTS `table_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `table_type` (
  `_id` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `table_type` varchar(255) DEFAULT NULL,
  `table_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `test_result`
--

DROP TABLE IF EXISTS `test_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_result` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `machine_id` int(11) NOT NULL,
  `eplate_id` varchar(255) DEFAULT NULL,
  `temperature` double DEFAULT NULL,
  `pressure` double DEFAULT NULL,
  `humidity` double DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `test_id` int(11) DEFAULT NULL,
  `sop_id` int(11) DEFAULT NULL,
  `current_amp` double DEFAULT NULL,
  `std_well` double DEFAULT NULL,
  `cv_well` double DEFAULT NULL,
  `location` varchar(50) DEFAULT '',
  `time_zone` varchar(50) DEFAULT '',
  `date` datetime DEFAULT NULL,
  `sample_type_id_1` int(11) DEFAULT NULL,
  `sample_reagent_id_1` int(11) DEFAULT NULL,
  `sample_concentration_1` varchar(255) DEFAULT NULL,
  `sample_type_id_2` int(11) DEFAULT NULL,
  `sample_reagent_id_2` int(11) DEFAULT NULL,
  `sample_concentration_2` varchar(255) DEFAULT NULL,
  `sample_type_id_3` int(11) DEFAULT NULL,
  `sample_reagent_id_3` int(11) DEFAULT NULL,
  `sample_concentration_3` varchar(255) DEFAULT NULL,
  `sample_type_id_4` int(11) DEFAULT NULL,
  `sample_reagent_id_4` int(11) DEFAULT NULL,
  `sample_concentration_4` varchar(255) DEFAULT NULL,
  `sample_type_id_5` int(11) DEFAULT NULL,
  `sample_reagent_id_5` int(11) DEFAULT NULL,
  `sample_concentration_5` varchar(255) DEFAULT NULL,
  `sample_type_id_6` int(11) DEFAULT NULL,
  `sample_reagent_id_6` int(11) DEFAULT NULL,
  `sample_concentration_6` varchar(255) DEFAULT NULL,
  `sample_type_id_7` int(11) DEFAULT NULL,
  `sample_reagent_id_7` int(11) DEFAULT NULL,
  `sample_concentration_7` varchar(255) DEFAULT NULL,
  `sample_type_id_8` int(11) DEFAULT NULL,
  `sample_reagent_id_8` int(11) DEFAULT NULL,
  `sample_concentration_8` varchar(255) DEFAULT NULL,
  `sample_type_id_9` int(11) DEFAULT NULL,
  `sample_reagent_id_9` int(11) DEFAULT NULL,
  `sample_concentration_9` varchar(255) DEFAULT NULL,
  `sample_type_id_10` int(11) DEFAULT NULL,
  `sample_reagent_id_10` int(11) DEFAULT NULL,
  `sample_concentration_10` varchar(255) DEFAULT NULL,
  `pre_treat` varchar(255) DEFAULT NULL,
  `well` varchar(150) DEFAULT '',
  `algorithm` varchar(150) DEFAULT '',
  `is_positive` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46046 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `is_admin` tinyint(1) DEFAULT '0',
  `api_token` varchar(255) DEFAULT NULL,
  `last_login_time` datetime DEFAULT NULL,
  `organization_id` int(11) DEFAULT NULL,
  `efirms` int(11) DEFAULT NULL,
  `efirm_access` int(11) DEFAULT NULL,
  `access` int(11) DEFAULT NULL,
  `roles` varchar(255) DEFAULT NULL,
  `privileges` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-09-13 20:58:30
