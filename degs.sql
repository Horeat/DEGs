-- MySQL dump 10.13  Distrib 8.0.13, for Win64 (x86_64)
--
-- Host: localhost    Database: degs
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `app_methods_methodsinfo`
--

DROP TABLE IF EXISTS `app_methods_methodsinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `app_methods_methodsinfo` (
  `method_id` int(11) NOT NULL,
  `method_name` varchar(50) NOT NULL,
  `method_type` varchar(20) NOT NULL,
  `method_detail` longtext NOT NULL,
  `author` varchar(20) DEFAULT NULL,
  `args` varchar(80) DEFAULT NULL,
  `use_number` int(11) NOT NULL,
  PRIMARY KEY (`method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_methods_methodsinfo`
--

LOCK TABLES `app_methods_methodsinfo` WRITE;
/*!40000 ALTER TABLE `app_methods_methodsinfo` DISABLE KEYS */;
INSERT INTO `app_methods_methodsinfo` VALUES (1001,'有筛选指标的数据 - p_value','With Select Tag','上传文件需为 .csv 格式，内容要求如图所示，其中首列为基因标识且必须存在p_value字段。','--','p_value < 0.05',42),(1002,'有筛选指标的数据 - logFC','With Select Tag','上传文件需为 .csv 格式，内容要求如图所示，其中首列为基因标识且必须存在 logFC 字段。','--','logFC > 2 & <-2   或 logFC > 1 & <-1',6),(1003,'有筛选指标的数据 - FDR','With Select Tag','上传文件需为 .csv 格式，内容要求如图所示，其中首列为基因标识且必须存在p_value字段。','--','FDR < 0.05',7),(1004,'有筛选指标的数据 - p_value + logFC','With Select Tag','上传文件需为 .csv 格式，内容要求如图所示，其中首列为基因标识且必须存在 p_value 和 logFC 字段。','--','logFC > 2 & <-2  或 logFC > 1 & <-1  且p_value < 0.05',3),(1005,'有筛选指标的数据 - p_value + FDR','With Select Tag','上传文件需为 .csv 格式，内容要求如图所示，其中首列为基因标识且必须存在p_value字段。','--','p_value < 0.05 且 FDR < 0.05',0),(1006,'有筛选指标的数据 - FDR + logFC','With Select Tag','上传文件需为 .csv 格式，内容要求如图所示，其中首列为基因标识且必须存在p_value 和 logFC 字段。','--','logFC > 2 & <-2  或 logFC > 1 & <-1  且FDR < 0.05',3),(1007,'有筛选指标的数据 - p_value + logFC + FDR','With Select Tag','上传文件需为 .csv 格式，内容要求如图所示，其中首列为基因标识且必须存在p_value 和 logFC 字段。','--','logFC > 2 & <-2  或 logFC > 1 & <-1  且 p_value < 0.05 且 FDR < 0.05',23),(2001,'t检验','No Select Tag','上传文件需为 .csv 格式，内容要求如图所示，其中首列为基因标识或探针标识，control组和case组的生物学重复次数至少为2（即每个分组里至少有两组数据且每个分组中的数据组数要相同）。我们会采用 t-test 的方法分析两组数据之间的统计学差异性，您同样可以设置相应的 p_value、logFC、FDR 进行差异表达基因的筛选。','--','logFC > 2 & <-2  或 logFC > 1 & <-1  且 p_value < 0.05 且 FDR < 0.05',68),(2002,'ks检验','No Select Tag','上传文件需为 .csv 格式，内容要求如图所示，其中首列为基因标识或探针标识，control组和case组的生物学重复次数至少为2（即每个分组里至少有两组数据且每个分组中的数据组数要相同）。我们会采用 ks-test 的方法分析两组数据之间的统计学差异性，您同样可以设置相应的 p_value、logFC、FDR 进行差异表达基因的筛选。','--','logFC > 2 & <-2  或 logFC > 1 & <-1  且 p_value < 0.05 且 FDR < 0.05',1);
/*!40000 ALTER TABLE `app_methods_methodsinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_operation_userhistory`
--

DROP TABLE IF EXISTS `app_operation_userhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `app_operation_userhistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `upload_file` varchar(100) NOT NULL,
  `args_choose` varchar(50) NOT NULL,
  `result_file` varchar(100) NOT NULL,
  `use_time` datetime(6) NOT NULL,
  `method_id` varchar(10) NOT NULL,
  `user_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_operation_userhi_user_id_id_edaecef1_fk_app_users` (`user_id_id`),
  CONSTRAINT `app_operation_userhi_user_id_id_edaecef1_fk_app_users` FOREIGN KEY (`user_id_id`) REFERENCES `app_users_userprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_operation_userhistory`
--

LOCK TABLES `app_operation_userhistory` WRITE;
/*!40000 ALTER TABLE `app_operation_userhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_operation_userhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_operation_usermessage`
--

DROP TABLE IF EXISTS `app_operation_usermessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `app_operation_usermessage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` int(11) NOT NULL,
  `message` varchar(500) NOT NULL,
  `has_read` tinyint(1) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_operation_usermessage`
--

LOCK TABLES `app_operation_usermessage` WRITE;
/*!40000 ALTER TABLE `app_operation_usermessage` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_operation_usermessage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_users_emailverifyrecord`
--

DROP TABLE IF EXISTS `app_users_emailverifyrecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `app_users_emailverifyrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `send_type` varchar(30) NOT NULL,
  `send_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_users_emailverifyrecord`
--

LOCK TABLES `app_users_emailverifyrecord` WRITE;
/*!40000 ALTER TABLE `app_users_emailverifyrecord` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_users_emailverifyrecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_users_userprofile`
--

DROP TABLE IF EXISTS `app_users_userprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `app_users_userprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `nick_name` varchar(50) NOT NULL,
  `birday` date DEFAULT NULL,
  `gender` varchar(10) NOT NULL,
  `address` varchar(100) NOT NULL,
  `mobile` varchar(11) DEFAULT NULL,
  `image` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_users_userprofile`
--

LOCK TABLES `app_users_userprofile` WRITE;
/*!40000 ALTER TABLE `app_users_userprofile` DISABLE KEYS */;
INSERT INTO `app_users_userprofile` VALUES (1,'pbkdf2_sha256$150000$S3FOBqgqwcH2$A/wAXUNHZr5j4BE5sgxM/ILQdXx3dMAkOTHLtZ8l/1I=','2020-05-23 11:51:14.902230',1,'Renshujie','','','952146111@qq.com',1,1,'2020-02-05 02:16:56.339353','我是管理员','2000-02-15','female','西安电子科技大学','1231293840','image/2020/02/img-2ab7f286d597a4fa9c62a1a4a6a01dba.jpg'),(8,'pbkdf2_sha256$150000$UU6CMklk3QGe$ylJ9bTSiUb8IuHQaWZA4IOVUEYB27LaA94xUAi7j1tM=','2020-02-21 09:06:52.195819',0,'hemeifa@126.com','','','hemeifa@126.com',0,1,'2020-02-20 12:52:41.472201','小哆啦','2014-02-11','male','北京','1425367400','image/2020/02/-4a5362ae671a6c91.jpg');
/*!40000 ALTER TABLE `app_users_userprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_users_userprofile_groups`
--

DROP TABLE IF EXISTS `app_users_userprofile_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `app_users_userprofile_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userprofile_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_users_userprofile_gr_userprofile_id_group_id_e39f515b_uniq` (`userprofile_id`,`group_id`),
  KEY `app_users_userprofile_groups_group_id_99dd7ff9_fk_auth_group_id` (`group_id`),
  CONSTRAINT `app_users_userprofil_userprofile_id_de511939_fk_app_users` FOREIGN KEY (`userprofile_id`) REFERENCES `app_users_userprofile` (`id`),
  CONSTRAINT `app_users_userprofile_groups_group_id_99dd7ff9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_users_userprofile_groups`
--

LOCK TABLES `app_users_userprofile_groups` WRITE;
/*!40000 ALTER TABLE `app_users_userprofile_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_users_userprofile_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_users_userprofile_user_permissions`
--

DROP TABLE IF EXISTS `app_users_userprofile_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `app_users_userprofile_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userprofile_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_users_userprofile_us_userprofile_id_permissio_4f41e0b1_uniq` (`userprofile_id`,`permission_id`),
  KEY `app_users_userprofil_permission_id_fc0981c8_fk_auth_perm` (`permission_id`),
  CONSTRAINT `app_users_userprofil_permission_id_fc0981c8_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `app_users_userprofil_userprofile_id_3a6a4818_fk_app_users` FOREIGN KEY (`userprofile_id`) REFERENCES `app_users_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_users_userprofile_user_permissions`
--

LOCK TABLES `app_users_userprofile_user_permissions` WRITE;
/*!40000 ALTER TABLE `app_users_userprofile_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_users_userprofile_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can view permission',1,'view_permission'),(5,'Can add group',2,'add_group'),(6,'Can change group',2,'change_group'),(7,'Can delete group',2,'delete_group'),(8,'Can view group',2,'view_group'),(9,'Can add content type',3,'add_contenttype'),(10,'Can change content type',3,'change_contenttype'),(11,'Can delete content type',3,'delete_contenttype'),(12,'Can view content type',3,'view_contenttype'),(13,'Can add 用户信息',4,'add_userprofile'),(14,'Can change 用户信息',4,'change_userprofile'),(15,'Can delete 用户信息',4,'delete_userprofile'),(16,'Can view 用户信息',4,'view_userprofile'),(17,'Can add log entry',5,'add_logentry'),(18,'Can change log entry',5,'change_logentry'),(19,'Can delete log entry',5,'delete_logentry'),(20,'Can view log entry',5,'view_logentry'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add 轮播图',7,'add_banner'),(26,'Can change 轮播图',7,'change_banner'),(27,'Can delete 轮播图',7,'delete_banner'),(28,'Can view 轮播图',7,'view_banner'),(29,'Can add 邮箱验证码',8,'add_emailverifyrecord'),(30,'Can change 邮箱验证码',8,'change_emailverifyrecord'),(31,'Can delete 邮箱验证码',8,'delete_emailverifyrecord'),(32,'Can view 邮箱验证码',8,'view_emailverifyrecord'),(33,'Can add 筛选方法',9,'add_methodsinfo'),(34,'Can change 筛选方法',9,'change_methodsinfo'),(35,'Can delete 筛选方法',9,'delete_methodsinfo'),(36,'Can view 筛选方法',9,'view_methodsinfo'),(37,'Can add 用户消息',10,'add_usermessage'),(38,'Can change 用户消息',10,'change_usermessage'),(39,'Can delete 用户消息',10,'delete_usermessage'),(40,'Can view 用户消息',10,'view_usermessage'),(41,'Can add 用户历史',11,'add_userhistory'),(42,'Can change 用户历史',11,'change_userhistory'),(43,'Can delete 用户历史',11,'delete_userhistory'),(44,'Can view 用户历史',11,'view_userhistory'),(45,'Can add Bookmark',12,'add_bookmark'),(46,'Can change Bookmark',12,'change_bookmark'),(47,'Can delete Bookmark',12,'delete_bookmark'),(48,'Can view Bookmark',12,'view_bookmark'),(49,'Can add User Setting',13,'add_usersettings'),(50,'Can change User Setting',13,'change_usersettings'),(51,'Can delete User Setting',13,'delete_usersettings'),(52,'Can view User Setting',13,'view_usersettings'),(53,'Can add User Widget',14,'add_userwidget'),(54,'Can change User Widget',14,'change_userwidget'),(55,'Can delete User Widget',14,'delete_userwidget'),(56,'Can view User Widget',14,'view_userwidget'),(57,'Can add log entry',15,'add_log'),(58,'Can change log entry',15,'change_log'),(59,'Can delete log entry',15,'delete_log'),(60,'Can view log entry',15,'view_log'),(61,'Can add captcha store',16,'add_captchastore'),(62,'Can change captcha store',16,'change_captchastore'),(63,'Can delete captcha store',16,'delete_captchastore'),(64,'Can view captcha store',16,'view_captchastore');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `captcha_captchastore`
--

DROP TABLE IF EXISTS `captcha_captchastore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `captcha_captchastore` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `challenge` varchar(32) NOT NULL,
  `response` varchar(32) NOT NULL,
  `hashkey` varchar(40) NOT NULL,
  `expiration` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hashkey` (`hashkey`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `captcha_captchastore`
--

LOCK TABLES `captcha_captchastore` WRITE;
/*!40000 ALTER TABLE `captcha_captchastore` DISABLE KEYS */;
INSERT INTO `captcha_captchastore` VALUES (55,'QPJP','qpjp','17b0b4fee5682c570a6d02ef63944a3f17699c0b','2020-03-24 11:26:02.884740'),(56,'TVYB','tvyb','3c013d3683c4a306b831c269e8a365bfd4ea15a0','2020-03-24 11:26:24.463640'),(57,'BXMZ','bxmz','497bdcddc74a68f6c91be1a44f66ce1638e3a13e','2020-03-24 11:26:25.747206'),(58,'QAOV','qaov','591b949c4fa6ed44e9c5d461344d9debf7b8e842','2020-03-24 11:26:32.740944'),(59,'LIQX','liqx','d8b20a86da301d608a4d0414b6270d67b650abaf','2020-03-24 11:28:08.513488'),(60,'EDXM','edxm','f8bb87e3142dea534a6d44d1842c8a0442c1e614','2020-03-24 11:28:18.869805'),(61,'ZJYE','zjye','952fc1f957f994d38ab8a0b07d8977bef90172df','2020-03-24 11:28:25.834979'),(62,'VAKL','vakl','9e0163920ada21a827888c1113534b9aa133f6d3','2020-03-24 11:28:36.379776'),(63,'IUWX','iuwx','410c8ec5759c078f0794df8a4ce4af2ea08b0826','2020-03-24 11:28:38.626765'),(64,'AFJB','afjb','1993b862a3366c120bef77f6b0dd4551db4397a7','2020-03-24 11:28:39.712861'),(65,'FRWQ','frwq','a3a1efa0d616ff6d8f577097b458fa676a48110e','2020-03-24 11:28:41.782439'),(66,'BBXT','bbxt','7c100b1cc39a453026ea3a32d011b431fe88d7b4','2020-03-24 11:28:43.501727'),(67,'TRPZ','trpz','1a06ebf6086f618e42808b488a51e4e7e1a371a0','2020-03-24 11:28:49.385956'),(68,'AKKR','akkr','7ba061f91e9b5f75f3ce55774dbd8192e161a420','2020-03-24 11:28:59.801130'),(70,'CLVO','clvo','c02b13dc478fc2d3e348767914b3047f5e5faa03','2020-04-29 16:08:00.947381'),(71,'NLLW','nllw','230bcd7fa98d7ee877723e04a87ba4a4ac0f01af','2020-04-29 16:09:28.726583'),(72,'AGSI','agsi','230619e12fce5d009071c93ffcd9a9501fc88fca','2020-05-03 17:30:49.584387'),(73,'ZWSP','zwsp','d94182290a508029230743d183ae064f46237f9f','2020-05-03 17:31:13.110106'),(74,'XYOK','xyok','e5e47b3c69aadf1908dde8eb7e6e6a69294ae0b4','2020-05-03 17:37:21.464324'),(75,'RIPC','ripc','c1cee02d7cccc7e2d5bac8b73e286ed13c37ac96','2020-05-03 17:40:40.787072'),(76,'IJQD','ijqd','069241c9d5063f9afd8feec4ed2a7fc8f22cdafe','2020-05-22 10:56:25.606367'),(77,'KBBY','kbby','60e7dfc575c38559fa8034e2abf6bef919988f17','2020-05-22 10:56:47.022254'),(78,'LKRN','lkrn','b1c2015e2265bdaf134079a60b549a13107160ff','2020-05-22 10:56:48.447052'),(79,'QEGR','qegr','30bc6640c157defdfd8d3c2a4a7a65c0d3f234e1','2020-05-22 10:57:24.414048'),(80,'AFXR','afxr','eb9cd48017548ea8787d1fc6ef880d665ce6c10d','2020-05-22 11:04:26.854635'),(81,'CUDE','cude','34c51b9cfd0f1c3f1da7f7183029f40f3c7ba572','2020-05-22 11:12:31.578925'),(82,'FCZS','fczs','ad9fef6bfbf1e3f68abde745698b6889e091f39f','2020-05-22 11:12:39.228244'),(83,'HEII','heii','82d6b9292bccc540d1c139325c2cfdf899df05ca','2020-05-22 11:12:40.217570'),(84,'MMRT','mmrt','4ed8a210a461edc18f02a622073def4eeec1e2ad','2020-05-22 11:12:50.260427'),(85,'APLD','apld','668123922326c2930cde292b92d2ad5537eed5f2','2020-05-22 11:12:56.257019'),(86,'VARR','varr','e6c6c20ee26b765c2a5555748e8b12d93aaaeab4','2020-05-22 11:12:57.093127'),(87,'AVAA','avaa','c1704ff88f4f6e576bc775bb8ef15e66bde5aff7','2020-05-22 11:25:59.989036'),(88,'RREF','rref','5e5a70457825fbfc51823d8c9187ed09d2e1f877','2020-05-22 11:26:08.200432'),(89,'HAOW','haow','351259dcdfab60d6e5d1b096e192b47211aeef88','2020-05-22 11:27:38.681560'),(90,'QYCP','qycp','c03b18f4f09566f40b87b8cb1e6f218bfd441728','2020-05-22 11:27:46.565716'),(91,'KAAF','kaaf','001f0c25288581a938a4eb282b7f02df6684a861','2020-05-22 11:27:47.425649'),(92,'DKQZ','dkqz','44066804dbc668d4e41d995842f68ee0b82fa8de','2020-05-23 11:54:44.831471'),(93,'AMVB','amvb','ca5652ea1122d2bb1be8813ebcb99356b1aaeb81','2020-05-23 11:55:52.133702'),(94,'TIJT','tijt','30f66ebee33ad8a8ebfed07d5f4eaf6f10d99fb5','2020-05-23 11:55:59.380246');
/*!40000 ALTER TABLE `captcha_captchastore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_app_users_userprofile_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_app_users_userprofile_id` FOREIGN KEY (`user_id`) REFERENCES `app_users_userprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2020-02-05 02:33:14.240639','2','LBB',1,'[{\"added\": {}}]',4,1),(2,'2020-02-05 14:59:14.264900','1','235488(2@2.com)',1,'[{\"added\": {}}]',8,1),(3,'2020-02-13 03:07:28.830657','3','小朋友',1,'[{\"added\": {}}]',4,1),(4,'2020-02-18 03:13:52.075352','1','Banner object (1)',1,'[{\"added\": {}}]',7,1),(5,'2020-02-18 03:14:16.771174','2','Banner object (2)',1,'[{\"added\": {}}]',7,1),(6,'2020-02-18 03:15:54.931354','3','Banner object (3)',1,'[{\"added\": {}}]',7,1),(7,'2020-02-18 03:44:29.736791','3','小朋友',3,'',4,1),(8,'2020-02-25 17:29:16.358733','1001','1001',1,'[{\"added\": {}}]',9,1),(9,'2020-02-25 17:32:40.622154','1002','1002',1,'[{\"added\": {}}]',9,1),(10,'2020-02-25 17:34:59.357694','1003','1003',1,'[{\"added\": {}}]',9,1),(11,'2020-02-26 00:38:11.350138','1001','1001',1,'[{\"added\": {}}]',9,1),(12,'2020-02-26 10:10:59.758142','1002','1002',1,'[{\"added\": {}}]',9,1),(13,'2020-02-26 10:11:29.540445','1003','1003',1,'[{\"added\": {}}]',9,1),(14,'2020-02-26 10:12:23.295128','1004','1004',1,'[{\"added\": {}}]',9,1),(15,'2020-02-26 10:13:23.615563','1005','1005',1,'[{\"added\": {}}]',9,1),(16,'2020-02-26 10:14:28.229702','1006','1006',1,'[{\"added\": {}}]',9,1),(17,'2020-02-26 10:15:29.326927','1007','1007',1,'[{\"added\": {}}]',9,1),(18,'2020-02-26 10:57:46.310943','2001','2001',1,'[{\"added\": {}}]',9,1),(19,'2020-02-26 10:59:01.650504','2002','2002',1,'[{\"added\": {}}]',9,1),(20,'2020-03-24 11:31:27.192680','2002','2002',2,'[{\"changed\": {\"fields\": [\"method_detail\", \"args\"]}}]',9,1),(21,'2020-03-24 11:32:56.651353','2002','2002',2,'[{\"changed\": {\"fields\": [\"method_detail\"]}}]',9,1),(22,'2020-03-24 11:33:22.059165','2001','2001',2,'[{\"changed\": {\"fields\": [\"method_detail\"]}}]',9,1),(23,'2020-03-24 11:33:40.277595','2002','2002',2,'[{\"changed\": {\"fields\": [\"args\"]}}]',9,1),(24,'2020-03-24 19:31:22.685697','2002','2002',2,'[{\"changed\": {\"fields\": [\"method_name\", \"method_type\"]}}]',9,1),(25,'2020-03-24 19:31:40.072373','2001','2001',2,'[{\"changed\": {\"fields\": [\"method_name\", \"method_type\"]}}]',9,1),(26,'2020-03-24 19:32:46.610968','1007','1007',2,'[{\"changed\": {\"fields\": [\"method_name\", \"method_type\"]}}]',9,1),(27,'2020-03-24 19:33:09.410535','1006','1006',2,'[{\"changed\": {\"fields\": [\"method_name\", \"method_type\"]}}]',9,1),(28,'2020-03-24 19:33:29.299311','1005','1005',2,'[{\"changed\": {\"fields\": [\"method_name\", \"method_type\"]}}]',9,1),(29,'2020-03-24 19:34:03.718859','1004','1004',2,'[{\"changed\": {\"fields\": [\"method_name\", \"method_type\"]}}]',9,1),(30,'2020-03-24 19:34:22.389924','1003','1003',2,'[{\"changed\": {\"fields\": [\"method_name\", \"method_type\"]}}]',9,1),(31,'2020-03-24 19:34:46.114855','1002','1002',2,'[{\"changed\": {\"fields\": [\"method_name\", \"method_type\"]}}]',9,1),(32,'2020-03-24 19:35:02.720281','1001','1001',2,'[{\"changed\": {\"fields\": [\"method_name\", \"method_type\"]}}]',9,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (5,'admin','logentry'),(9,'app_methods','methodsinfo'),(11,'app_operation','userhistory'),(10,'app_operation','usermessage'),(7,'app_users','banner'),(8,'app_users','emailverifyrecord'),(4,'app_users','userprofile'),(2,'auth','group'),(1,'auth','permission'),(16,'captcha','captchastore'),(3,'contenttypes','contenttype'),(6,'sessions','session'),(12,'xadmin','bookmark'),(15,'xadmin','log'),(13,'xadmin','usersettings'),(14,'xadmin','userwidget');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2020-02-04 03:19:21.147640'),(2,'contenttypes','0002_remove_content_type_name','2020-02-04 03:19:21.407567'),(3,'auth','0001_initial','2020-02-04 03:19:21.547701'),(4,'auth','0002_alter_permission_name_max_length','2020-02-04 03:19:21.998825'),(5,'auth','0003_alter_user_email_max_length','2020-02-04 03:19:22.010921'),(6,'auth','0004_alter_user_username_opts','2020-02-04 03:19:22.024757'),(7,'auth','0005_alter_user_last_login_null','2020-02-04 03:19:22.038140'),(8,'auth','0006_require_contenttypes_0002','2020-02-04 03:19:22.045131'),(9,'auth','0007_alter_validators_add_error_messages','2020-02-04 03:19:22.064955'),(10,'auth','0008_alter_user_username_max_length','2020-02-04 03:19:22.081073'),(11,'auth','0009_alter_user_last_name_max_length','2020-02-04 03:19:22.094032'),(12,'auth','0010_alter_group_name_max_length','2020-02-04 03:19:22.129647'),(13,'auth','0011_update_proxy_permissions','2020-02-04 03:19:22.143610'),(14,'app_users','0001_initial','2020-02-04 03:19:22.375072'),(15,'admin','0001_initial','2020-02-04 03:20:11.275120'),(16,'admin','0002_logentry_remove_auto_add','2020-02-04 03:20:11.524769'),(17,'admin','0003_logentry_add_action_flag_choices','2020-02-04 03:20:11.550697'),(18,'sessions','0001_initial','2020-02-04 03:20:11.602077'),(19,'app_users','0002_banner_emailverifyrecord','2020-02-04 03:45:09.395105'),(23,'app_users','0003_auto_20200205_1016','2020-02-05 02:16:06.726804'),(24,'xadmin','0001_initial','2020-02-05 09:00:27.158634'),(25,'xadmin','0002_log','2020-02-05 09:00:27.844078'),(26,'xadmin','0003_auto_20160715_0100','2020-02-05 09:00:28.293867'),(27,'captcha','0001_initial','2020-02-10 09:10:14.914290'),(28,'app_users','0004_auto_20200217_1515','2020-02-17 07:15:30.382874'),(29,'app_users','0005_auto_20200218_1112','2020-02-18 03:12:35.689243'),(30,'app_users','0006_delete_banner','2020-02-18 23:42:10.374046'),(33,'app_methods','0001_initial','2020-02-26 00:31:37.029457'),(34,'app_operation','0001_initial','2020-02-26 00:31:37.182239'),(35,'app_methods','0002_auto_20200324_1930','2020-03-24 19:30:17.979758'),(36,'app_operation','0002_auto_20200327_1024','2020-03-27 10:25:00.500895');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('brnkkiimfvwtypc7nvgez40511m39wha','ZjQyOWZiNmYwNjI2MzAxNTgyMDhlN2FhMTMwMDVhZGE3ZTIxOTU0ZDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0NDZlMjAyYTQ3ODc1ZjRhM2M5NGY1ZjJhYzM4NWI1Mzc1MzRjODc0In0=','2020-04-07 11:25:41.316657'),('exp79vi4xdd5lv064zzkz6l6gcfqn8o4','ZjQyOWZiNmYwNjI2MzAxNTgyMDhlN2FhMTMwMDVhZGE3ZTIxOTU0ZDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0NDZlMjAyYTQ3ODc1ZjRhM2M5NGY1ZjJhYzM4NWI1Mzc1MzRjODc0In0=','2020-06-06 11:51:14.923172');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-27 15:40:30
