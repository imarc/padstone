-- MySQL dump 10.16  Distrib 10.3.5-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: padstone
-- ------------------------------------------------------
-- Server version	10.3.5-MariaDB-10.3.5+maria~jessie

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
-- Table structure for table `assetindexdata`
--

DROP TABLE IF EXISTS `assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT 0,
  `completed` tinyint(1) DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assetindexdata`
--

LOCK TABLES `assetindexdata` WRITE;
/*!40000 ALTER TABLE `assetindexdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `assetindexdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  KEY `assets_volumeId_keptFile_idx` (`volumeId`,`keptFile`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
INSERT INTO `assets` VALUES (51,2,4,'imarc_logo.jpg','image',2210,966,257528,NULL,NULL,NULL,'2019-04-25 18:09:18','2019-04-25 18:09:18','2019-04-25 18:09:18','cdd2a61d-f7c7-4fd1-b0f4-7cfbf6f4a00b');
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assettransformindex`
--

DROP TABLE IF EXISTS `assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT 0,
  `inProgress` tinyint(1) NOT NULL DEFAULT 0,
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assettransformindex`
--

LOCK TABLES `assettransformindex` WRITE;
/*!40000 ALTER TABLE `assettransformindex` DISABLE KEYS */;
/*!40000 ALTER TABLE `assettransformindex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assettransforms`
--

DROP TABLE IF EXISTS `assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assettransforms`
--

LOCK TABLES `assettransforms` WRITE;
/*!40000 ALTER TABLE `assettransforms` DISABLE KEYS */;
/*!40000 ALTER TABLE `assettransforms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  KEY `categories_parentId_fk` (`parentId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (5,1,NULL,NULL,'2018-01-31 19:53:20','2018-01-31 19:53:20','e88de118-68c7-41f7-90e0-7b77cea66ab1'),(6,1,NULL,NULL,'2018-01-31 19:53:25','2018-01-31 19:53:25','55252392-5c48-4a8b-8658-d79796ccafe1'),(7,1,NULL,NULL,'2018-01-31 19:53:36','2018-01-31 19:53:36','fd7e0db8-a773-4ab4-9f8e-be519ae3be3b'),(8,1,NULL,NULL,'2018-01-31 19:53:45','2018-01-31 19:53:45','f8099cb9-ffed-44ea-af67-1a43cff72445'),(9,1,NULL,NULL,'2018-01-31 19:53:51','2018-01-31 19:53:51','b7fbd468-90d6-46ab-85e9-5991fd597cbd'),(18,2,NULL,NULL,'2018-02-04 18:18:49','2018-02-04 18:18:49','41794692-8d95-4ace-99af-444840d58a08'),(19,2,NULL,NULL,'2018-02-04 18:18:57','2018-02-04 18:18:57','aab589df-23c9-4015-aae9-6ad55ea007d8'),(20,2,NULL,NULL,'2018-02-04 22:11:29','2018-02-04 22:11:29','a14eb3bf-0589-4f7e-9472-3014cc96da8c'),(21,2,NULL,NULL,'2018-02-04 22:11:36','2018-02-04 22:11:36','825c7f14-483a-47dd-8b2c-c316a9eaac85');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorygroups`
--

DROP TABLE IF EXISTS `categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `categorygroups_dateDeleted_idx` (`dateDeleted`),
  KEY `categorygroups_name_idx` (`name`),
  KEY `categorygroups_handle_idx` (`handle`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorygroups`
--

LOCK TABLES `categorygroups` WRITE;
/*!40000 ALTER TABLE `categorygroups` DISABLE KEYS */;
INSERT INTO `categorygroups` VALUES (1,2,6,'Resource Categories','resourceCategories','2018-01-31 19:53:07','2019-03-11 19:59:48',NULL,'d9b26dd3-8815-474a-b2d1-df10d1da9ea4'),(2,4,21,'Blog Categories','blogCategories','2018-02-02 22:17:15','2018-02-02 22:17:15',NULL,'380fab36-d288-4b53-9d1b-d5aad2afc914');
/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorygroups_sites`
--

DROP TABLE IF EXISTS `categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `uriFormat` text DEFAULT NULL,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorygroups_sites`
--

LOCK TABLES `categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `categorygroups_sites` DISABLE KEYS */;
INSERT INTO `categorygroups_sites` VALUES (1,1,1,1,'resource-categories/{slug}','resource-categories/_category','2018-01-31 19:53:07','2019-03-11 19:59:48','178a1f52-69b6-4200-b3c5-8575f724254b'),(2,2,1,1,'blog-categories/{slug}','blog-categories/_category','2018-02-02 22:17:15','2018-02-02 22:17:15','09320ff7-8439-45ee-9e41-8a7a6b474e73');
/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_resourceUrl` text DEFAULT NULL,
  `field_resourceCTA` text DEFAULT NULL,
  `field_resourceEmbed` text DEFAULT NULL,
  `field_resourceDate` datetime DEFAULT NULL,
  `field_htmlTitleOverride` text DEFAULT NULL,
  `field_metaDescription` text DEFAULT NULL,
  `field_openGraphTitle` text DEFAULT NULL,
  `field_openGraphDescription` text DEFAULT NULL,
  `field_headerCode` text DEFAULT NULL,
  `field_footerCode` text DEFAULT NULL,
  `field_personJobTitle` text DEFAULT NULL,
  `field_personAbstract` text DEFAULT NULL,
  `field_personBio` text DEFAULT NULL,
  `field_newsDate` datetime DEFAULT NULL,
  `field_blogDate` datetime DEFAULT NULL,
  `field_blogAbstract` text DEFAULT NULL,
  `field_eventStartDate` datetime DEFAULT NULL,
  `field_eventEndDate` datetime DEFAULT NULL,
  `field_newsAbstract` text DEFAULT NULL,
  `field_eventLocation` text DEFAULT NULL,
  `field_headline` text DEFAULT NULL,
  `field_subheadline` text DEFAULT NULL,
  `field_resourceDescription` text DEFAULT NULL,
  `field_altText` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
INSERT INTO `content` VALUES (1,1,1,NULL,'2017-11-29 20:51:54','2019-03-12 15:51:37','8a7441f7-d6f1-4e31-a1b7-12164bf985c6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,4,1,'Yypta63G-1','2018-01-17 16:36:22','2018-02-05 19:48:38','5c22d539-742a-467d-8562-5fba303b36ea',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,5,1,'White Papers','2018-01-31 19:53:20','2018-01-31 19:53:20','179970dc-e9fc-4d6c-a5d5-b1f75cce9e27',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,6,1,'Videos','2018-01-31 19:53:25','2018-01-31 19:53:25','6d8e1a8c-62d4-421c-b688-07dd2903cf62',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,7,1,'Case Studies','2018-01-31 19:53:36','2018-01-31 19:53:36','6baca749-278a-42a7-8b2f-852e206138bb',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,8,1,'Webinars','2018-01-31 19:53:45','2018-01-31 19:53:45','76badf17-d466-442d-af6f-de6dd4515e1c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,9,1,'Reports','2018-01-31 19:53:51','2018-01-31 19:53:51','056d522e-bffc-4c64-8c0e-67dd05bdafbf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(15,15,1,'Home','2018-02-02 05:31:09','2019-03-12 16:06:41','6ac247f1-3af3-4bba-8b3c-366d5a9bae99',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Welcome to your new site.','You\'ve successfully got a new site up and running using Padstone, a starter package built by Imarc.',NULL,NULL),(16,16,1,'Error','2018-02-02 05:34:35','2019-03-11 18:14:20','f248f374-04d1-4eea-a554-8b355583b1ee',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Something horrible has happened.',NULL,NULL,NULL),(17,17,1,'404 Page','2018-02-02 05:34:50','2019-03-11 18:15:49','b6a63da2-e3fb-4b59-bce8-6865714eb1e3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Page Not Found','We couldn\'t find what you\'re looking for.',NULL,NULL),(18,18,1,'Culture','2018-02-04 18:18:49','2018-02-04 18:18:49','49f1275c-531e-4534-9efc-ec072cb1ea2f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(19,19,1,'Hiring','2018-02-04 18:18:57','2018-02-04 18:18:57','27264a17-1fc2-4297-8601-2d842d594fea',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(20,20,1,'Announcement','2018-02-04 22:11:29','2018-02-04 22:11:29','457610de-324f-44c2-9329-e70ccfcd2171',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(21,21,1,'Press Release','2018-02-04 22:11:36','2018-02-04 22:11:36','1fad4b5e-c717-416f-be52-516bbe2c9de3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(22,22,1,'Contact','2018-02-04 22:14:34','2019-03-11 18:01:52','0a4602f9-c70b-46f7-b44a-7971458a8b7b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Contact Us','We want to hear from you.',NULL,NULL),(23,23,1,'About','2018-02-04 23:03:59','2019-10-22 14:53:49','b80ed219-99bb-4af9-bcd6-4e481e9a70d4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Get to know us.','We\'re here for you and can\'t wait to help.',NULL,NULL),(24,24,1,'Privacy','2018-02-04 23:08:53','2019-03-11 18:13:11','ae7bb5ef-39a1-4352-bebf-40dfdb31d977',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Legal & Privacy',NULL,NULL,NULL),(25,25,1,'News & Events','2018-02-05 06:20:14','2019-10-21 19:16:03','e8e7d573-73fd-4d84-8926-ec7a8b444720',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'News & Events','Here\'s what\'s happening.',NULL,NULL),(26,26,1,'Resources','2018-02-05 06:20:40','2019-10-21 19:16:11','d98e0b30-38ba-4775-88de-802e6b2175eb',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Resources','We\'ve got you covered.',NULL,NULL),(27,27,1,'Blog','2018-02-05 06:21:29','2019-10-21 18:08:53','a190b8ca-8dae-447a-98f8-9f0a7558a63e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Our Blog',NULL,NULL,NULL),(29,29,1,'Yypta63G 1','2018-02-05 19:49:24','2018-02-05 19:49:24','88e813ec-d523-47d3-b2d6-d505da954fa9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(32,36,1,'Welcome to the Blog','2019-03-11 18:17:26','2019-03-11 19:42:02','e14aba32-a602-464f-8cfa-fa841e1e38ca',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,'2019-03-11 07:00:00','<p>You\'ve successfully found the blog section within Padstone. Feel free to delete this entry and add your own articles.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(33,38,1,'New Website Successfully Created','2019-03-11 18:18:29','2019-03-11 21:07:48','984915d7-a938-4da6-a346-2fd9cb54589c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,'2019-03-12 07:00:00',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(34,40,1,'External Resource','2019-03-11 18:19:11','2019-03-11 20:00:25','157606d4-92f5-4afb-b1c3-a8d28e7943b6','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Craft 3 Documentation\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://docs.craftcms.com/v3/\"}','Download Now',NULL,'2019-03-10 08:00:00',NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Proin est libero, dignissim id ex sed, ultricies accumsan libero. Duis lobortis fermentum volutpat. Quisque at dignissim orci, a vehicula tellus. Donec vel urna eleifend, tincidunt purus at, varius augue.</p>',NULL),(35,42,1,'Imarc Website','2019-03-11 18:21:49','2019-03-11 20:00:25','606ab5c6-16f7-4fda-b632-713b9924ca65','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Imarc, A Digital Agency\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://www.imarc.com/\"}',NULL,NULL,'2019-03-11 07:00:00',NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Mauris justo ante, iaculis eget augue ac, consequat sagittis odio. Vivamus pretium, elit vitae commodo feugiat, diam tortor elementum velit, sit amet congue tortor ex vitae mi. Morbi bibendum tempus semper.</p>',NULL),(36,44,1,'ACME Resource','2019-03-11 20:01:52','2019-03-11 20:02:43','f5164b59-0e89-45c1-822a-e1d8b900a96e','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Go to Imarc.com Now\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://www.imarc.com\"}','Learn More',NULL,'2019-03-12 07:00:00',NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Pellentesque finibus sagittis placerat. Integer diam lorem, viverra tempus libero eget, sagittis faucibus mi. In sit amet quam eget nibh cursus malesuada. Fusce nibh ante, maximus fermentum arcu eu, ultricies hendrerit justo.</p>',NULL),(37,46,1,'First Lastername','2019-03-11 21:30:37','2019-03-11 22:01:52','5fb575ff-3538-4e76-817f-a48227efbc07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','','Example Employee','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>','<p>First Lastername ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(38,47,1,'Leadership','2019-03-11 21:31:27','2019-10-21 18:10:02','cdb56519-f6ac-4c15-b06d-0302b1ff60cd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Leadership','Leading us to a brighter future.',NULL,NULL),(39,48,1,'Example Shared Block','2019-03-12 16:06:37','2019-03-12 16:06:37','1818d7a0-3cf4-4b34-af76-a539760b3925',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(40,51,1,'Imarc_logo','2019-04-25 18:09:18','2019-04-25 18:09:18','e5f0234b-665c-4618-b0c4-72272831b807',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(41,52,1,'Service Unavailable Page','2019-10-25 18:39:21','2019-10-25 19:24:36','196122ff-87e0-495e-9811-54edc74bddcf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Site Unavailable','Our site is temporarily unavailable. Please try again later!',NULL,NULL),(42,53,1,'Service Unavailable Page','2019-12-20 16:17:51','2019-12-20 16:17:51','49e8e8de-7406-4d72-8ea2-e44eabae0e5c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Site Unavailable','Our site is temporarily unavailable. Please try again later!',NULL,NULL),(43,54,1,'Service Unavailable Page','2019-12-20 16:17:51','2019-12-20 16:17:52','de159e6c-d577-4b5c-a8e8-c32a2aaca3ad',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Site Unavailable','Our site is temporarily unavailable. Please try again later!',NULL,NULL),(44,55,1,'Blog','2019-12-20 16:17:52','2019-12-20 16:17:52','e9c2d4f0-2c6c-4c15-a104-f20d371c9753',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Our Blog',NULL,NULL,NULL),(45,56,1,'Home','2019-12-20 16:17:52','2019-12-20 16:17:55','97928aca-a983-440e-9e5a-7ff475e65fe4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Welcome to your new site.','You\'ve successfully got a new site up and running using Padstone, a starter package built by Imarc.',NULL,NULL),(46,62,1,'Example Shared Block','2019-12-20 16:17:56','2019-12-20 16:17:57','3172d033-af02-4dd7-adc8-d790b1f88eda',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(47,64,1,'Leadership','2019-12-20 16:17:57','2019-12-20 16:17:58','5b2ef129-5c5b-49f3-b0ec-862ada3b692e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Leadership','Leading us to a brighter future.',NULL,NULL),(48,65,1,'Leadership Page','2019-12-20 16:17:58','2019-12-20 16:17:58','071fbd72-14e1-4ad0-99f7-87313ef15c87',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Leadership','Leading us to a brighter future.',NULL,NULL),(49,66,1,'Leadership Page','2019-12-20 16:17:58','2019-12-20 16:17:58','4de75d9a-4ee9-4916-903b-fb1575a6ff1a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Leadership','Leading us to a brighter future.',NULL,NULL),(50,67,1,'First Lastername','2019-12-20 16:17:59','2019-12-20 16:18:00','c352f5b7-e7ef-440a-9566-ec273199ba71',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','','Example Employee','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>','<p>First Lastername ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(51,68,1,'ACME Resource','2019-12-20 16:18:02','2019-12-20 16:18:03','82186bbf-e9a4-4f24-a2f3-ee4a5b70e168','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Go to Imarc.com Now\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://www.imarc.com\"}','Learn More',NULL,'2019-03-12 07:00:00',NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Pellentesque finibus sagittis placerat. Integer diam lorem, viverra tempus libero eget, sagittis faucibus mi. In sit amet quam eget nibh cursus malesuada. Fusce nibh ante, maximus fermentum arcu eu, ultricies hendrerit justo.</p>',NULL),(52,70,1,'ACME Resource','2019-12-20 16:18:04','2019-12-20 16:18:05','69486da8-0fea-467d-8484-026f9c19cca5','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Go to Imarc.com Now\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://www.imarc.com\"}','Learn More',NULL,'2019-03-12 07:00:00',NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Pellentesque finibus sagittis placerat. Integer diam lorem, viverra tempus libero eget, sagittis faucibus mi. In sit amet quam eget nibh cursus malesuada. Fusce nibh ante, maximus fermentum arcu eu, ultricies hendrerit justo.</p>\n',NULL),(53,72,1,'External Resource','2019-12-20 16:18:06','2019-12-20 16:18:07','dc7e0f7c-605b-4742-8749-a1a6773ed391','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Craft 3 Documentation\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://docs.craftcms.com/v3/\"}',NULL,NULL,'2019-03-10 08:00:00',NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Proin est libero, dignissim id ex sed, ultricies accumsan libero. Duis lobortis fermentum volutpat. Quisque at dignissim orci, a vehicula tellus. Donec vel urna eleifend, tincidunt purus at, varius augue.</p>',NULL),(54,73,1,'Imarc Website','2019-12-20 16:18:08','2019-12-20 16:18:09','e1d2d46c-021e-4cdf-9575-e72a14629d4b','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Imarc, A Digital Agency\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://www.imarc.com/\"}',NULL,NULL,'2019-03-11 07:00:00',NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Mauris justo ante, iaculis eget augue ac, consequat sagittis odio. Vivamus pretium, elit vitae commodo feugiat, diam tortor elementum velit, sit amet congue tortor ex vitae mi. Morbi bibendum tempus semper.</p>',NULL),(55,74,1,'Welcome to the Blog','2019-12-20 16:18:10','2019-12-20 16:18:12','c7e1f6b6-d7ae-42d3-a7a5-bfe37d28bc25',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,'2019-03-11 07:00:00','<p>You\'ve successfully found the blog section within Padstone. Feel free to delete this entry and add your own articles.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(56,77,1,'External Resource','2019-12-20 16:18:13','2019-12-20 16:18:14','8720af10-309a-40c5-8948-e0ecbd4372bf','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Craft 3 Documentation\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://docs.craftcms.com/v3/\"}',NULL,NULL,'2019-03-10 08:00:00',NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Proin est libero, dignissim id ex sed, ultricies accumsan libero. Duis lobortis fermentum volutpat. Quisque at dignissim orci, a vehicula tellus. Donec vel urna eleifend, tincidunt purus at, varius augue.</p>',NULL),(57,78,1,'Imarc Website','2019-12-20 16:18:15','2019-12-20 16:18:16','e490efe9-4c56-4333-84b8-69438a5a86e6','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Imarc, A Digital Agency\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://www.imarc.com/\"}',NULL,NULL,'2019-03-11 07:00:00',NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Mauris justo ante, iaculis eget augue ac, consequat sagittis odio. Vivamus pretium, elit vitae commodo feugiat, diam tortor elementum velit, sit amet congue tortor ex vitae mi. Morbi bibendum tempus semper.</p>',NULL),(58,79,1,'External Resource','2019-12-20 16:18:17','2019-12-20 16:18:18','7dc45566-1e5b-4b19-b25a-fcc59647fec8','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Craft 3 Documentation\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://docs.craftcms.com/v3/\"}',NULL,NULL,'2019-03-11 07:00:00',NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Proin est libero, dignissim id ex sed, ultricies accumsan libero. Duis lobortis fermentum volutpat. Quisque at dignissim orci, a vehicula tellus. Donec vel urna eleifend, tincidunt purus at, varius augue.</p>',NULL),(59,80,1,'Important Resource','2019-12-20 16:18:18','2019-12-20 16:18:19','7cb0d755-cc37-481b-8a39-a3dc26b7f2dd','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Craft 3 Documentation\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://docs.craftcms.com/v3/\"}',NULL,NULL,'2019-03-11 07:00:00',NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Proin est libero, dignissim id ex sed, ultricies accumsan libero. Duis lobortis fermentum volutpat. Quisque at dignissim orci, a vehicula tellus. Donec vel urna eleifend, tincidunt purus at, varius augue.</p>',NULL),(60,81,1,'Import Resource','2019-12-20 16:18:19','2019-12-20 16:18:20','4eb172ea-f3a5-4277-a4cf-1550c16d00f9','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Craft 3 Documentation\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://docs.craftcms.com/v3/\"}',NULL,NULL,'2019-03-11 07:00:00',NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Proin est libero, dignissim id ex sed, ultricies accumsan libero. Duis lobortis fermentum volutpat. Quisque at dignissim orci, a vehicula tellus. Donec vel urna eleifend, tincidunt purus at, varius augue.</p>',NULL),(61,82,1,'New Website Successfully Created','2019-12-20 16:18:20','2019-12-20 16:18:21','84bb30ef-2100-4b51-9d33-dc2b8d5f78ec',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,'2019-03-12 07:00:00',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(62,84,1,'Welcome to the Blog','2019-12-20 16:18:22','2019-12-20 16:18:23','d110697b-532b-40dc-a65d-fb2068b85c5d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,'2019-03-11 07:00:00','<p>You\'ve successfully found the blog section within Padstone. Feel free to delete this entry and add your own articles.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(63,87,1,'404 Page','2019-12-20 16:18:23','2019-12-20 16:18:24','52831701-6ac6-4eac-9436-1a56119c6a53',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Page Not Found','We couldn\'t find what you\'re looking for.',NULL,NULL),(64,88,1,'Blog','2019-12-20 16:18:24','2019-12-20 16:18:24','2142dec8-452d-49e0-a756-e23674feb9e5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Our Blog',NULL,NULL,NULL),(65,89,1,'News & Events','2019-12-20 16:18:24','2019-12-20 16:18:25','4b154974-1dd0-4ef9-9a9f-b417da9d1f72',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'News & Events','Here\'s what\'s happening.',NULL,NULL),(66,90,1,'Resources','2019-12-20 16:18:25','2019-12-20 16:18:25','ee902feb-0a6e-4914-b4be-964c43a252a5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Resources','We\'ve got you covered.',NULL,NULL),(67,91,1,'About','2019-12-20 16:18:25','2019-12-20 16:18:26','c79bb01e-44a4-4d2b-a3ff-6fda8482d46a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Get to know us.','We\'re here for you and can\'t wait to help.',NULL,NULL),(68,92,1,'About','2019-12-20 16:18:26','2019-12-20 16:18:26','5b0e3ff2-2639-4673-b212-692feb884c36',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Get to know us.','We\'',NULL,NULL),(69,93,1,'Contact','2019-12-20 16:18:27','2019-12-20 16:18:27','387925ba-902b-4d5d-8850-9dedaf85e0b0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Contact Us','We want to hear from you.',NULL,NULL),(70,94,1,'Privacy','2019-12-20 16:18:28','2019-12-20 16:18:28','f1c50b6f-a4a9-48fe-9244-5794ed1294e0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Legal & Privacy',NULL,NULL,NULL),(71,95,1,'Error','2019-12-20 16:18:28','2019-12-20 16:18:29','6050b925-4658-4467-b40d-d53c619c69c9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Something horrible has happened.',NULL,NULL,NULL),(72,96,1,'Page Not Found','2019-12-20 16:18:29','2019-12-20 16:18:29','efc345ac-a513-44ea-a254-d07e66c3b195',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Page Not Found','We couldn\'t find what you\'re looking for.',NULL,NULL),(73,97,1,'Page Not Found','2019-12-20 16:18:29','2019-12-20 16:18:29','2211bbf4-297d-424b-8924-e41eb56bcfb6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'The Blog','We couldn\'t find what you\'re looking for.',NULL,NULL),(74,98,1,'Page Not Found','2019-12-20 16:18:29','2019-12-20 16:18:30','df537e6f-759d-4392-a58a-2a4a3972c742',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Page Not Found','We couldn\'t find what you\'re looking for.',NULL,NULL),(75,99,1,'Home','2019-12-20 16:18:31','2019-12-20 16:18:32','5269766d-382b-432d-95de-a466b3e3bcc9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Welcome to your new site.','You\'ve successfully got a new site up and running using Padstone, a starter package built by Imarc.',NULL,NULL),(76,105,1,'Error','2019-12-20 16:18:34','2019-12-20 16:18:34','597541b0-e8a2-4768-91a0-c346678f043c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Something horrible has happened.',NULL,NULL,NULL),(77,106,1,'Error Page','2019-12-20 16:18:34','2019-12-20 16:18:35','3ef73d60-ca59-48ed-85ae-af164d3b83de',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Something horrible has happened.',NULL,NULL,NULL),(78,107,1,'Privacy','2019-12-20 16:18:35','2019-12-20 16:18:35','8491cf5d-32e6-4181-be6c-d81d4bd51ff6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Legal & Privacy',NULL,NULL,NULL),(79,108,1,'Privacy Page','2019-12-20 16:18:36','2019-12-20 16:18:36','d9dd7312-03ac-42ff-b864-774cfaeec1af',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Legal & Privacy',NULL,NULL,NULL),(80,109,1,'Contact','2019-12-20 16:18:36','2019-12-20 16:18:37','78e440c1-cb35-4dcc-bbea-09947d339d45',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Contact Us','We want to hear from you.',NULL,NULL),(81,110,1,'Contact Page','2019-12-20 16:18:38','2019-12-20 16:18:38','7e00c841-c550-4872-8d2d-7047d4d6bd50',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Contact Us','We want to hear from you.',NULL,NULL),(82,111,1,'About','2019-12-20 16:18:38','2019-12-20 16:18:38','74d562da-ec6f-4699-ba74-bd113b80bbb2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Get to know us.','We\'re here for you and can\'t wait to help.',NULL,NULL),(83,112,1,'Resources','2019-12-20 16:18:39','2019-12-20 16:18:39','83a0f2cd-756e-48e4-9867-285938af5465',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Resources','We\'ve got you covered.',NULL,NULL),(84,113,1,'Resources Page','2019-12-20 16:18:39','2019-12-20 16:18:39','316da15c-22c2-4da0-9480-7e9fa3d047b9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Resources','We\'ve got you covered.',NULL,NULL),(85,114,1,'News & Events','2019-12-20 16:18:39','2019-12-20 16:18:40','b1a72f4a-85e2-4f85-aa42-24417565c32b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'News & Events','Here\'s what\'s happening.',NULL,NULL),(86,115,1,'News & Events Page','2019-12-20 16:18:40','2019-12-20 16:18:40','085b011d-42a9-4e9a-869f-12ff3dbdfdfc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'News & Events','Here\'s what\'s happening.',NULL,NULL),(87,116,1,'Blog','2019-12-20 16:18:40','2019-12-20 16:18:40','27114f70-e27a-4e2e-a916-fd50aa9b1074',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Our Blog',NULL,NULL,NULL),(88,117,1,'Blog Page','2019-12-20 16:18:40','2019-12-20 16:18:41','ccabd9ac-50f7-44f9-91d4-8445333ebcc3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Our Blog',NULL,NULL,NULL),(89,118,1,'Home','2019-12-20 16:18:41','2019-12-20 16:18:43','5b7fdba6-3a7a-4e5f-a98b-4073fccec254',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Welcome to your new site.','You\'ve successfully got a new site up and running using Padstone, a starter package built by Imarc.',NULL,NULL),(90,124,1,'Homepage','2019-12-20 16:18:44','2019-12-20 16:18:46','2fcfaebb-5c78-47ef-b666-d785cf295227',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Welcome to your new site.','You\'ve successfully got a new site up and running using Padstone, a starter package built by Imarc.',NULL,NULL),(91,130,1,'About Page','2019-12-20 16:18:48','2019-12-20 16:18:48','bb8e26f5-dc49-4fcd-bf59-651f8f653e46',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Get to know us.','We\'re here for you and can\'t wait to help.',NULL,NULL),(92,131,1,'About Page','2019-12-20 16:18:48','2019-12-20 16:18:48','303031ca-d3e3-49d1-8d9b-5f0d9e4ae33c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Get to know us.','We\'re here for you and can\'t wait to help.',NULL,NULL),(93,132,1,'Homepage','2019-12-20 16:18:49','2019-12-20 16:18:51','c76b9f6e-0332-4927-8faf-caad7359e442',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Welcome to your new site.','You\'ve successfully got a new site up and running using Padstone, a starter package built by Imarc.',NULL,NULL),(94,138,1,'Homepage','2019-12-20 16:18:51','2019-12-20 16:18:53','f5975dcc-b772-4368-b0a8-1a5d47d6a9d0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Welcome to your new site.','You\'ve successfully got a new site up and running using Padstone, a starter package built by Imarc.',NULL,NULL);
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craftidtokens`
--

DROP TABLE IF EXISTS `craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craftidtokens`
--

LOCK TABLES `craftidtokens` WRITE;
/*!40000 ALTER TABLE `craftidtokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deprecationerrors`
--

DROP TABLE IF EXISTS `deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `traces` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB AUTO_INCREMENT=252 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deprecationerrors`
--

LOCK TABLES `deprecationerrors` WRITE;
/*!40000 ALTER TABLE `deprecationerrors` DISABLE KEYS */;
INSERT INTO `deprecationerrors` VALUES (243,'ElementQuery::getIterator()','/var/www/html/padstone3/templates/_macros.twig:4','2019-03-12 18:15:08','/var/www/html/padstone3/templates/_macros.twig',4,'Looping through element queries directly has been deprecated. Use the all() function to fetch the query results before looping over them.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/var/www/html/padstone3/vendor/craftcms/cms/src/elements/db/ElementQuery.php\",\"line\":464,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"ElementQuery::getIterator()\\\", \\\"Looping through element queries directly has been deprecated. Us...\\\"\"},{\"objectClass\":\"craft\\\\elements\\\\db\\\\EntryQuery\",\"file\":\"/var/www/html/padstone3/storage/runtime/compiled_templates/d2/d21018067abc82ceab6a9351d8279eaba7af162347bd86832e74063ae5fd33db.php\",\"line\":64,\"class\":\"craft\\\\elements\\\\db\\\\ElementQuery\",\"method\":\"getIterator\",\"args\":null},{\"objectClass\":\"__TwigTemplate_a3db16200bd50a1a17564449363e63f1093e7f2e148509f7f0f692def5592f4b\",\"file\":\"/var/www/html/padstone3/storage/runtime/compiled_templates/d2/d21018067abc82ceab6a9351d8279eaba7af162347bd86832e74063ae5fd33db.php\",\"line\":137,\"class\":\"__TwigTemplate_a3db16200bd50a1a17564449363e63f1093e7f2e148509f7f0f692def5592f4b\",\"method\":\"macro_renderBlock\",\"args\":\"craft\\\\elements\\\\MatrixBlock, [\\\"parent\\\" => [\\\"field\\\" => craft\\\\elements\\\\db\\\\MatrixBlockQuery, \\\"varargs\\\" => [true], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], \\\"index0\\\" => 4, \\\"index\\\" => 5, \\\"first\\\" => false, ...]\"},{\"objectClass\":\"__TwigTemplate_a3db16200bd50a1a17564449363e63f1093e7f2e148509f7f0f692def5592f4b\",\"file\":\"/var/www/html/padstone3/storage/runtime/compiled_templates/46/46d2ebf1ab24057b70047e3c3512a27d4c53cfcb4cd113ab82d2942dd7188ea6.php\",\"line\":56,\"class\":\"__TwigTemplate_a3db16200bd50a1a17564449363e63f1093e7f2e148509f7f0f692def5592f4b\",\"method\":\"macro_renderAllBlocks\",\"args\":\"craft\\\\elements\\\\db\\\\MatrixBlockQuery, true\"},{\"objectClass\":\"__TwigTemplate_0a41589a0652ebec4aa22746af92b9cf9b09282ed0cb00371505310b8f038372\",\"file\":\"/var/www/html/padstone3/vendor/twig/twig/lib/Twig/Template.php\",\"line\":189,\"class\":\"__TwigTemplate_0a41589a0652ebec4aa22746af92b9cf9b09282ed0cb00371505310b8f038372\",\"method\":\"block_content\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"content\\\" => [__TwigTemplate_0a41589a0652ebec4aa22746af92b9cf9b09282ed0cb00371505310b8f038372, \\\"block_content\\\"]]\"},{\"objectClass\":\"__TwigTemplate_d2918587beb70be0f8197de8e08edd1bef1a96f5ea2247592a7062e68321de48\",\"file\":\"/var/www/html/padstone3/storage/runtime/compiled_templates/56/56c79cfff18b8570c1141fed86f1ad7b2a477cd8cfbe41d6271d17f1336c58b4.php\",\"line\":270,\"class\":\"Twig_Template\",\"method\":\"displayBlock\",\"args\":\"\\\"content\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"content\\\" => [__TwigTemplate_0a41589a0652ebec4aa22746af92b9cf9b09282ed0cb00371505310b8f038372, \\\"block_content\\\"]]\"},{\"objectClass\":\"__TwigTemplate_d2918587beb70be0f8197de8e08edd1bef1a96f5ea2247592a7062e68321de48\",\"file\":\"/var/www/html/padstone3/vendor/twig/twig/lib/Twig/Template.php\",\"line\":386,\"class\":\"__TwigTemplate_d2918587beb70be0f8197de8e08edd1bef1a96f5ea2247592a7062e68321de48\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"content\\\" => [__TwigTemplate_0a41589a0652ebec4aa22746af92b9cf9b09282ed0cb00371505310b8f038372, \\\"block_content\\\"]]\"},{\"objectClass\":\"__TwigTemplate_d2918587beb70be0f8197de8e08edd1bef1a96f5ea2247592a7062e68321de48\",\"file\":\"/var/www/html/padstone3/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":49,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"content\\\" => [__TwigTemplate_0a41589a0652ebec4aa22746af92b9cf9b09282ed0cb00371505310b8f038372, \\\"block_content\\\"]]\"},{\"objectClass\":\"__TwigTemplate_d2918587beb70be0f8197de8e08edd1bef1a96f5ea2247592a7062e68321de48\",\"file\":\"/var/www/html/padstone3/vendor/twig/twig/lib/Twig/Template.php\",\"line\":363,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"content\\\" => [__TwigTemplate_0a41589a0652ebec4aa22746af92b9cf9b09282ed0cb00371505310b8f038372, \\\"block_content\\\"]]\"},{\"objectClass\":\"__TwigTemplate_d2918587beb70be0f8197de8e08edd1bef1a96f5ea2247592a7062e68321de48\",\"file\":\"/var/www/html/padstone3/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":31,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"content\\\" => [__TwigTemplate_0a41589a0652ebec4aa22746af92b9cf9b09282ed0cb00371505310b8f038372, \\\"block_content\\\"]]\"},{\"objectClass\":\"__TwigTemplate_d2918587beb70be0f8197de8e08edd1bef1a96f5ea2247592a7062e68321de48\",\"file\":\"/var/www/html/padstone3/storage/runtime/compiled_templates/46/46d2ebf1ab24057b70047e3c3512a27d4c53cfcb4cd113ab82d2942dd7188ea6.php\",\"line\":33,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"content\\\" => [__TwigTemplate_0a41589a0652ebec4aa22746af92b9cf9b09282ed0cb00371505310b8f038372, \\\"block_content\\\"]]\"},{\"objectClass\":\"__TwigTemplate_0a41589a0652ebec4aa22746af92b9cf9b09282ed0cb00371505310b8f038372\",\"file\":\"/var/www/html/padstone3/vendor/twig/twig/lib/Twig/Template.php\",\"line\":386,\"class\":\"__TwigTemplate_0a41589a0652ebec4aa22746af92b9cf9b09282ed0cb00371505310b8f038372\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"content\\\" => [__TwigTemplate_0a41589a0652ebec4aa22746af92b9cf9b09282ed0cb00371505310b8f038372, \\\"block_content\\\"]]\"},{\"objectClass\":\"__TwigTemplate_0a41589a0652ebec4aa22746af92b9cf9b09282ed0cb00371505310b8f038372\",\"file\":\"/var/www/html/padstone3/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":49,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"content\\\" => [__TwigTemplate_0a41589a0652ebec4aa22746af92b9cf9b09282ed0cb00371505310b8f038372, \\\"block_content\\\"]]\"},{\"objectClass\":\"__TwigTemplate_0a41589a0652ebec4aa22746af92b9cf9b09282ed0cb00371505310b8f038372\",\"file\":\"/var/www/html/padstone3/vendor/twig/twig/lib/Twig/Template.php\",\"line\":363,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"content\\\" => [__TwigTemplate_0a41589a0652ebec4aa22746af92b9cf9b09282ed0cb00371505310b8f038372, \\\"block_content\\\"]]\"},{\"objectClass\":\"__TwigTemplate_0a41589a0652ebec4aa22746af92b9cf9b09282ed0cb00371505310b8f038372\",\"file\":\"/var/www/html/padstone3/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":31,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"__TwigTemplate_0a41589a0652ebec4aa22746af92b9cf9b09282ed0cb00371505310b8f038372\",\"file\":\"/var/www/html/padstone3/vendor/twig/twig/lib/Twig/Template.php\",\"line\":371,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"__TwigTemplate_0a41589a0652ebec4aa22746af92b9cf9b09282ed0cb00371505310b8f038372\",\"file\":\"/var/www/html/padstone3/vendor/twig/twig/lib/Twig/Environment.php\",\"line\":289,\"class\":\"Twig_Template\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/var/www/html/padstone3/vendor/craftcms/cms/src/web/View.php\",\"line\":337,\"class\":\"Twig_Environment\",\"method\":\"render\",\"args\":\"\\\"_index\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/var/www/html/padstone3/vendor/craftcms/cms/src/web/View.php\",\"line\":384,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderTemplate\",\"args\":\"\\\"_index\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/var/www/html/padstone3/vendor/craftcms/cms/src/web/Controller.php\",\"line\":161,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderPageTemplate\",\"args\":\"\\\"_index\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/var/www/html/padstone3/vendor/craftcms/cms/src/controllers/TemplatesController.php\",\"line\":78,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"renderTemplate\",\"args\":\"\\\"_index\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":null,\"line\":null,\"class\":\"craft\\\\controllers\\\\TemplatesController\",\"method\":\"actionRender\",\"args\":\"\\\"_index\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":null,\"file\":\"/var/www/html/padstone3/vendor/yiisoft/yii2/base/InlineAction.php\",\"line\":57,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"[craft\\\\controllers\\\\TemplatesController, \\\"actionRender\\\"], [\\\"_index\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"yii\\\\base\\\\InlineAction\",\"file\":\"/var/www/html/padstone3/vendor/yiisoft/yii2/base/Controller.php\",\"line\":157,\"class\":\"yii\\\\base\\\\InlineAction\",\"method\":\"runWithParams\",\"args\":\"[\\\"template\\\" => \\\"_index\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/var/www/html/padstone3/vendor/craftcms/cms/src/web/Controller.php\",\"line\":109,\"class\":\"yii\\\\base\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"_index\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/var/www/html/padstone3/vendor/yiisoft/yii2/base/Module.php\",\"line\":528,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"_index\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/var/www/html/padstone3/vendor/craftcms/cms/src/web/Application.php\",\"line\":297,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"_index\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/var/www/html/padstone3/vendor/yiisoft/yii2/web/Application.php\",\"line\":103,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"_index\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/var/www/html/padstone3/vendor/craftcms/cms/src/web/Application.php\",\"line\":286,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/var/www/html/padstone3/vendor/yiisoft/yii2/base/Application.php\",\"line\":386,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/var/www/html/padstone3/web/index.php\",\"line\":21,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"run\",\"args\":null}]','2019-03-12 18:15:08','2019-03-12 18:15:08','e52ff173-7cbf-4e2e-85ee-5e031094e110');
/*!40000 ALTER TABLE `deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dolphiq_redirects`
--

DROP TABLE IF EXISTS `dolphiq_redirects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dolphiq_redirects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceUrl` varchar(1000) NOT NULL DEFAULT '',
  `destinationUrl` varchar(1000) NOT NULL DEFAULT '',
  `statusCode` varchar(255) DEFAULT NULL,
  `hitCount` int(11) unsigned NOT NULL DEFAULT 0,
  `hitAt` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  CONSTRAINT `dolphiq_redirects_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dolphiq_redirects`
--

LOCK TABLES `dolphiq_redirects` WRITE;
/*!40000 ALTER TABLE `dolphiq_redirects` DISABLE KEYS */;
/*!40000 ALTER TABLE `dolphiq_redirects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drafts`
--

DROP TABLE IF EXISTS `drafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) DEFAULT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `drafts_sourceId_fk` (`sourceId`),
  KEY `drafts_creatorId_fk` (`creatorId`),
  CONSTRAINT `drafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `drafts_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drafts`
--

LOCK TABLES `drafts` WRITE;
/*!40000 ALTER TABLE `drafts` DISABLE KEYS */;
/*!40000 ALTER TABLE `drafts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elementindexsettings`
--

DROP TABLE IF EXISTS `elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elementindexsettings`
--

LOCK TABLES `elementindexsettings` WRITE;
/*!40000 ALTER TABLE `elementindexsettings` DISABLE KEYS */;
INSERT INTO `elementindexsettings` VALUES (1,'craft\\elements\\Entry','{\"sourceOrder\":[[\"key\",\"*\"],[\"key\",\"single:804ebac0-45d8-49c0-9e1f-418cc9c708e7\"],[\"heading\",\"Blog\"],[\"key\",\"single:1e6d0ae4-0c2d-4c61-aa0e-f67a0d64d0be\"],[\"key\",\"section:fdc8d709-53c4-4104-ba7b-f424bad5b7fc\"],[\"heading\",\"News & Events\"],[\"key\",\"single:ca363472-ca75-4a5e-9e46-dc48bfec0b5d\"],[\"key\",\"section:550e9481-b606-4b2b-83e1-9a895a224d38\"],[\"key\",\"section:7b352338-e4c1-4527-8c7b-dd3ae5e9d28f\"],[\"heading\",\"Resources\"],[\"key\",\"single:20423d03-2767-4e23-8ba6-41dc15391050\"],[\"key\",\"section:31726602-42e3-461e-ad79-08d69e6e899a\"],[\"heading\",\"About\"],[\"key\",\"single:ebac57bc-baaf-4975-bf81-a0f4c66bad4d\"],[\"key\",\"section:3375cf3e-4d50-4b42-b4ab-d8ad7e40cdfb\"],[\"key\",\"single:0041c886-3d54-4352-801b-0450a61a9011\"],[\"key\",\"section:c87b5acc-afe1-4ddf-b73c-b449c9f29c2d\"],[\"key\",\"single:548dacf3-a377-4ba7-9bc4-d9102a1fc455\"],[\"key\",\"single:698462dc-1720-42e6-a09e-9e59bce0aa23\"],[\"heading\",\"Miscellaneous\"],[\"key\",\"section:16f0db7d-a9b8-4569-8198-d836625cea77\"],[\"key\",\"single:6e318b58-9c19-4a89-aece-8db4a7b52124\"],[\"key\",\"single:aa4b309e-df7a-47cf-9aa5-25285f46796f\"],[\"key\",\"single:d44a5a95-fa08-4efd-8496-2ac825c5acd1\"],[\"heading\",\"\"],[\"key\",\"section:16e6b8c8-fd2d-4fa3-9219-9d81e2ab1e98\"]],\"sources\":{\"section:31726602-42e3-461e-ad79-08d69e6e899a\":{\"tableAttributes\":{\"1\":\"postDate\",\"2\":\"expiryDate\",\"3\":\"author\",\"4\":\"link\"}},\"section:16f0db7d-a9b8-4569-8198-d836625cea77\":{\"tableAttributes\":{\"1\":\"postDate\",\"2\":\"expiryDate\",\"3\":\"author\",\"4\":\"link\"}},\"*\":{\"tableAttributes\":{\"1\":\"section\",\"2\":\"postDate\",\"3\":\"expiryDate\",\"4\":\"link\"}},\"section:c87b5acc-afe1-4ddf-b73c-b449c9f29c2d\":{\"tableAttributes\":{\"1\":\"postDate\",\"2\":\"expiryDate\",\"3\":\"link\"}}}}','2019-10-25 19:19:15','2019-10-25 19:19:15','8e24a6f8-b4de-48f5-b339-c705c9dead0b');
/*!40000 ALTER TABLE `elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elements`
--

DROP TABLE IF EXISTS `elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `draftId` int(11) DEFAULT NULL,
  `revisionId` int(11) DEFAULT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `archived` tinyint(1) NOT NULL DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  KEY `elements_dateDeleted_idx` (`dateDeleted`),
  KEY `elements_draftId_fk` (`draftId`),
  KEY `elements_revisionId_fk` (`revisionId`),
  CONSTRAINT `elements_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `drafts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `elements_revisionId_fk` FOREIGN KEY (`revisionId`) REFERENCES `revisions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elements`
--

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;
INSERT INTO `elements` VALUES (1,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2017-11-29 20:51:54','2019-03-12 15:51:37',NULL,'ecaa119c-fd2b-4fa5-b6c6-da4c09cb2cfb'),(4,NULL,NULL,2,'craft\\elements\\Asset',1,0,'2018-01-17 16:36:22','2018-02-05 19:48:38',NULL,'be394d4e-a35b-4b8f-b7f6-05107d040857'),(5,NULL,NULL,6,'craft\\elements\\Category',1,0,'2018-01-31 19:53:20','2018-01-31 19:53:20',NULL,'4cb5351f-f8d9-4405-9f3c-9fed157dfbf8'),(6,NULL,NULL,6,'craft\\elements\\Category',1,0,'2018-01-31 19:53:25','2018-01-31 19:53:25',NULL,'d45cc3c1-af53-4c5f-a2c5-04807131f67f'),(7,NULL,NULL,6,'craft\\elements\\Category',1,0,'2018-01-31 19:53:36','2018-01-31 19:53:36',NULL,'74fd8c9f-b7e2-467e-9c00-06d0681be0b4'),(8,NULL,NULL,6,'craft\\elements\\Category',1,0,'2018-01-31 19:53:45','2018-01-31 19:53:45',NULL,'45521071-001f-4fab-9662-f7df5d8896be'),(9,NULL,NULL,6,'craft\\elements\\Category',1,0,'2018-01-31 19:53:51','2018-01-31 19:53:51',NULL,'dd1e7b4b-d4dd-457f-af6c-7b93a8cb9015'),(15,NULL,NULL,8,'craft\\elements\\Entry',1,0,'2018-02-02 05:31:09','2019-03-12 16:06:41',NULL,'c8719f54-b20a-4386-b779-69a010bc8071'),(16,NULL,NULL,9,'craft\\elements\\Entry',1,0,'2018-02-02 05:34:35','2019-03-11 18:14:20',NULL,'9b9e62bd-c75c-4494-a061-5a2274727b86'),(17,NULL,NULL,10,'craft\\elements\\Entry',1,0,'2018-02-02 05:34:50','2019-03-11 18:15:49',NULL,'2efc74d3-f4c0-4496-bb08-7fc9141250bc'),(18,NULL,NULL,21,'craft\\elements\\Category',1,0,'2018-02-04 18:18:49','2018-02-04 18:18:49',NULL,'54b1f292-56c2-4d83-872a-b3b098d49f19'),(19,NULL,NULL,21,'craft\\elements\\Category',1,0,'2018-02-04 18:18:57','2018-02-04 18:18:57',NULL,'94d04c1f-15f1-4e9d-8fcb-40d27cc2a1c1'),(20,NULL,NULL,21,'craft\\elements\\Category',1,0,'2018-02-04 22:11:29','2018-02-04 22:11:29',NULL,'d0393319-5cdc-46ab-8f1c-000f4f4efcbe'),(21,NULL,NULL,21,'craft\\elements\\Category',1,0,'2018-02-04 22:11:36','2018-02-04 22:11:36',NULL,'4262839e-4493-4938-8a99-674f073c7f5a'),(22,NULL,NULL,24,'craft\\elements\\Entry',1,0,'2018-02-04 22:14:34','2019-03-11 18:01:52',NULL,'e3a22c88-e8a8-49a2-9711-c3365c8d2ccd'),(23,NULL,NULL,26,'craft\\elements\\Entry',1,0,'2018-02-04 23:03:59','2019-10-22 14:53:49',NULL,'c40b51b9-7bf6-4af3-8c89-71b863b60ebf'),(24,NULL,NULL,27,'craft\\elements\\Entry',1,0,'2018-02-04 23:08:53','2019-03-11 18:13:11',NULL,'b7acd71b-a397-445a-879d-cd37f8ae7b01'),(25,NULL,NULL,28,'craft\\elements\\Entry',1,0,'2018-02-05 06:20:14','2019-10-21 19:16:03',NULL,'eea5fec4-0cda-4a4d-9de5-7f9afd764be9'),(26,NULL,NULL,29,'craft\\elements\\Entry',1,0,'2018-02-05 06:20:40','2019-10-21 19:16:11',NULL,'b584a194-fd92-4a73-b321-cb612c3faff8'),(27,NULL,NULL,30,'craft\\elements\\Entry',1,0,'2018-02-05 06:21:29','2019-10-21 18:08:52',NULL,'a4f2e670-0b34-4b8c-b30b-ed99372c8140'),(29,NULL,NULL,2,'craft\\elements\\Asset',1,0,'2018-02-05 19:49:24','2018-02-05 19:49:24',NULL,'119da192-a673-4adc-8551-ed7b81449b96'),(32,NULL,NULL,11,'craft\\elements\\MatrixBlock',1,0,'2019-03-05 23:02:52','2019-03-12 16:06:41',NULL,'77d2038e-17e1-47f8-9d06-050f1ddf9a60'),(33,NULL,NULL,12,'craft\\elements\\MatrixBlock',1,0,'2019-03-05 23:02:53','2019-03-12 16:06:41',NULL,'86b862ee-392a-462a-984e-6c790f7cc41a'),(34,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2019-03-05 23:02:53','2019-03-12 16:06:42',NULL,'7c3da6dc-494f-4f97-898f-a32dea960605'),(35,NULL,NULL,18,'craft\\elements\\MatrixBlock',1,0,'2019-03-05 23:02:53','2019-03-12 16:06:42',NULL,'1d82b6cd-abba-4842-b526-9a6ee3069c05'),(36,NULL,NULL,22,'craft\\elements\\Entry',1,0,'2019-03-11 18:17:26','2019-03-11 19:42:02',NULL,'0fbdc429-20fb-4970-b90b-7c47ef51ab06'),(37,NULL,NULL,11,'craft\\elements\\MatrixBlock',1,0,'2019-03-11 18:17:26','2019-03-11 19:42:02',NULL,'158dc6dd-5fd1-4b47-a36e-4ecc14a7986c'),(38,NULL,NULL,19,'craft\\elements\\Entry',1,0,'2019-03-11 18:18:29','2019-03-11 21:07:48',NULL,'19d19645-5525-4534-a3b4-761aae1e65d9'),(39,NULL,NULL,11,'craft\\elements\\MatrixBlock',1,0,'2019-03-11 18:18:29','2019-03-11 21:07:48',NULL,'e39d0ec7-682a-4147-9e4d-363e01bf3742'),(40,NULL,NULL,4,'craft\\elements\\Entry',1,0,'2019-03-11 18:19:11','2019-03-11 20:00:25',NULL,'19f15a37-9b25-47cd-8c0e-eb86dd25fb65'),(41,NULL,NULL,11,'craft\\elements\\MatrixBlock',1,0,'2019-03-11 18:19:11','2019-03-11 18:19:28',NULL,'2ae69797-ea8a-49aa-9ec7-b9f18349aa84'),(42,NULL,NULL,4,'craft\\elements\\Entry',1,0,'2019-03-11 18:21:49','2019-03-11 20:00:25',NULL,'c7e6dcb6-10ce-462e-a62a-f8537c8e249c'),(43,NULL,NULL,12,'craft\\elements\\MatrixBlock',1,0,'2019-03-11 19:42:02','2019-03-11 19:42:02',NULL,'a2e1ec16-e0c2-46a6-bd0d-dd1ddf049d53'),(44,NULL,NULL,3,'craft\\elements\\Entry',1,0,'2019-03-11 20:01:52','2019-03-11 20:02:43',NULL,'f29e0e53-8608-4814-83d2-13a0af565901'),(45,NULL,NULL,11,'craft\\elements\\MatrixBlock',1,0,'2019-03-11 20:01:52','2019-03-11 20:02:43',NULL,'e2f3ed3b-52cc-49d2-bf62-2c92e2360621'),(46,NULL,NULL,20,'craft\\elements\\Entry',1,0,'2019-03-11 21:30:37','2019-03-11 22:01:52',NULL,'d5e0e544-d71c-4e71-8841-0df0ac8b4bc1'),(47,NULL,NULL,32,'craft\\elements\\Entry',1,0,'2019-03-11 21:31:27','2019-10-21 18:10:02',NULL,'62f12c01-d474-4615-b3cb-e7cf47ab15a9'),(48,NULL,NULL,33,'craft\\elements\\Entry',1,0,'2019-03-12 16:06:37','2019-03-12 16:06:37',NULL,'66a04838-51f2-4cc9-8c79-70a3c9943586'),(49,NULL,NULL,11,'craft\\elements\\MatrixBlock',1,0,'2019-03-12 16:06:37','2019-03-12 16:06:37',NULL,'e333bca2-f877-48f0-9ee1-e3eb12e020de'),(50,NULL,NULL,34,'craft\\elements\\MatrixBlock',1,0,'2019-03-12 16:06:42','2019-03-12 16:06:42',NULL,'88fc1d0d-5a87-4c75-b6c5-b8673e7b355b'),(51,NULL,NULL,NULL,'craft\\elements\\Asset',1,0,'2019-04-25 18:09:18','2019-04-25 18:09:18',NULL,'6014082d-9c11-4723-8669-1d0a2d631404'),(52,NULL,NULL,35,'craft\\elements\\Entry',1,0,'2019-10-25 18:39:21','2019-10-25 19:24:36',NULL,'92248b0b-da8f-4209-b43c-354a2219bc61'),(53,NULL,1,35,'craft\\elements\\Entry',1,0,'2019-10-25 19:24:36','2019-12-20 16:17:51',NULL,'635af7d3-7f0a-47d1-9892-550e243875ce'),(54,NULL,2,35,'craft\\elements\\Entry',1,0,'2019-10-25 19:24:35','2019-12-20 16:17:52',NULL,'09aaaeb2-e536-41a6-a5cc-7834a8907987'),(55,NULL,3,30,'craft\\elements\\Entry',1,0,'2019-03-19 17:31:16','2019-12-20 16:17:52',NULL,'e4df3d9e-5ab2-44f3-9f3a-a82fc27da231'),(56,NULL,4,8,'craft\\elements\\Entry',1,0,'2019-03-12 16:06:42','2019-12-20 16:17:55',NULL,'e23d0e45-503f-4482-826d-f9b3e629a160'),(57,NULL,NULL,11,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:17:53','2019-12-20 16:17:55',NULL,'8fb15364-5606-4be3-8ac5-635782b8ec11'),(58,NULL,NULL,12,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:17:54','2019-12-20 16:17:55',NULL,'7775995b-7a29-40a2-a90c-c366aa36a7b1'),(59,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:17:54','2019-12-20 16:17:55',NULL,'31600964-78f7-4185-8e79-18b51fa7f05f'),(60,NULL,NULL,18,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:17:54','2019-12-20 16:17:56',NULL,'71feefee-2abc-4d4f-a4bd-b0cfb7241ad3'),(61,NULL,NULL,34,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:17:55','2019-12-20 16:17:56',NULL,'684497cf-b4d9-4976-90c8-4995b3b8fc0c'),(62,NULL,5,33,'craft\\elements\\Entry',1,0,'2019-03-12 16:06:37','2019-12-20 16:17:57',NULL,'7e044d89-afa2-4bb9-a0f4-27e22660d787'),(63,NULL,NULL,11,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:17:56','2019-12-20 16:17:57',NULL,'b5004739-8089-499b-a73d-a504e7e18261'),(64,NULL,6,32,'craft\\elements\\Entry',1,0,'2019-03-11 22:04:05','2019-12-20 16:17:58',NULL,'d294169b-40df-4d1b-aa9b-b7f794cb21d8'),(65,NULL,7,32,'craft\\elements\\Entry',1,0,'2019-03-11 21:33:22','2019-12-20 16:17:58',NULL,'0991d535-0bd5-49d7-898f-e2152dc76248'),(66,NULL,8,32,'craft\\elements\\Entry',1,0,'2019-03-11 21:33:22','2019-12-20 16:17:58',NULL,'01b9b538-5e08-4701-b57e-c69dbb42aac7'),(67,NULL,9,20,'craft\\elements\\Entry',1,0,'2019-03-11 21:30:37','2019-12-20 16:18:00',NULL,'3ef0ebb5-d801-43cb-84be-46c56ab09da4'),(68,NULL,10,3,'craft\\elements\\Entry',1,0,'2019-03-11 20:02:43','2019-12-20 16:18:03',NULL,'54d8ced2-a154-4a8b-b9d5-7e848db04e25'),(69,NULL,NULL,11,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:02','2019-12-20 16:18:03',NULL,'056458db-ee8d-479e-b4de-5ae8c6dbbbd2'),(70,NULL,11,3,'craft\\elements\\Entry',1,0,'2019-03-11 20:01:52','2019-12-20 16:18:05',NULL,'d798b1ef-42b7-4f24-a48d-30aad37156c6'),(71,NULL,NULL,11,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:04','2019-12-20 16:18:05',NULL,'93a9dd5f-99ac-4431-804b-9bc88c5aa357'),(72,NULL,12,4,'craft\\elements\\Entry',1,0,'2019-03-11 19:51:03','2019-12-20 16:18:07',NULL,'5bc8f292-0b1b-4ebd-9f1a-57c77e17aced'),(73,NULL,13,4,'craft\\elements\\Entry',1,0,'2019-03-11 19:50:57','2019-12-20 16:18:09',NULL,'490ee1b7-809a-4db4-a18a-0608b9d1b535'),(74,NULL,14,22,'craft\\elements\\Entry',1,0,'2019-03-11 19:42:02','2019-12-20 16:18:12',NULL,'c7affc34-ffc6-4f11-8d7f-5438c1facc07'),(75,NULL,NULL,11,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:11','2019-12-20 16:18:12',NULL,'88a53655-120b-4b21-85ce-b5a4f5b2b8c4'),(76,NULL,NULL,12,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:11','2019-12-20 16:18:12',NULL,'8211782f-c5b7-432c-8dc5-f6f14332e6a7'),(77,NULL,15,4,'craft\\elements\\Entry',1,0,'2019-03-11 18:21:56','2019-12-20 16:18:14',NULL,'85ad2299-f53c-43df-af9e-9665491ab443'),(78,NULL,16,4,'craft\\elements\\Entry',1,0,'2019-03-11 18:21:50','2019-12-20 16:18:16',NULL,'5c1433d5-68ee-4c34-b54d-138d32e810a3'),(79,NULL,17,4,'craft\\elements\\Entry',1,0,'2019-03-11 18:21:00','2019-12-20 16:18:18',NULL,'0b7f5552-5cac-4c29-ba43-9f7c13c65bd1'),(80,NULL,18,4,'craft\\elements\\Entry',1,0,'2019-03-11 18:19:28','2019-12-20 16:18:19',NULL,'4be9d53e-dcd7-4a81-83a1-1dc0d8d0220b'),(81,NULL,19,4,'craft\\elements\\Entry',1,0,'2019-03-11 18:19:11','2019-12-20 16:18:20',NULL,'233fb96b-4125-473f-8824-7c0d93b73a7c'),(82,NULL,20,19,'craft\\elements\\Entry',1,0,'2019-03-11 18:18:29','2019-12-20 16:18:21',NULL,'01e8095c-5693-4396-ad32-1e2a12494379'),(83,NULL,NULL,11,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:21','2019-12-20 16:18:21',NULL,'e93a9411-ee8c-4964-91fb-fd7d5894e1ef'),(84,NULL,21,22,'craft\\elements\\Entry',1,0,'2019-03-11 18:17:26','2019-12-20 16:18:23',NULL,'4b9bd8dd-11de-4731-a0b2-76743c83e5e0'),(85,NULL,NULL,11,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:22','2019-12-20 16:18:23',NULL,'e9ff93f1-6a3d-4437-bd83-3ac7baf45b64'),(86,NULL,NULL,12,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:22','2019-03-11 19:42:02','2019-12-20 16:18:23','0a0b0224-a3ee-45d7-81c7-62dfc19e1378'),(87,NULL,22,10,'craft\\elements\\Entry',1,0,'2019-03-11 18:15:14','2019-12-20 16:18:24',NULL,'f1778b9d-3d28-4045-b901-657d7163c795'),(88,NULL,23,30,'craft\\elements\\Entry',1,0,'2019-03-11 18:03:55','2019-12-20 16:18:24',NULL,'51856492-7757-432e-a146-18ea957a70f7'),(89,NULL,24,28,'craft\\elements\\Entry',1,0,'2019-03-11 18:03:47','2019-12-20 16:18:25',NULL,'4fef54d2-e0ee-42d7-a589-515f1cc99d30'),(90,NULL,25,29,'craft\\elements\\Entry',1,0,'2019-03-11 18:03:12','2019-12-20 16:18:25',NULL,'a28ebc28-bbfb-46dc-af89-92351cb62a3b'),(91,NULL,26,26,'craft\\elements\\Entry',1,0,'2019-03-11 18:02:40','2019-12-20 16:18:26',NULL,'37155567-c95e-41ba-98df-7a70f47e69d0'),(92,NULL,27,26,'craft\\elements\\Entry',1,0,'2019-03-11 18:02:26','2019-12-20 16:18:26',NULL,'39fd23db-6f08-4a34-b579-4fe2444266f4'),(93,NULL,28,24,'craft\\elements\\Entry',1,0,'2019-03-11 18:01:52','2019-12-20 16:18:27',NULL,'980c3d98-9cc4-40e5-b769-ca1d8094f3ac'),(94,NULL,29,27,'craft\\elements\\Entry',1,0,'2019-03-11 18:01:28','2019-12-20 16:18:28',NULL,'68573e56-9856-4c0a-9c36-d0ea9f2a8b64'),(95,NULL,30,9,'craft\\elements\\Entry',1,0,'2019-03-11 18:01:12','2019-12-20 16:18:29',NULL,'1515feb2-9b92-4e36-a1e8-3647a750f6b8'),(96,NULL,31,10,'craft\\elements\\Entry',1,0,'2019-03-11 18:00:14','2019-12-20 16:18:29',NULL,'5ac45091-f958-4962-9e0d-2d63234b5ee8'),(97,NULL,32,10,'craft\\elements\\Entry',1,0,'2019-03-11 17:57:24','2019-12-20 16:18:29',NULL,'97d91455-2b1a-421e-8b46-6bc0fbf74156'),(98,NULL,33,10,'craft\\elements\\Entry',1,0,'2019-03-11 17:57:24','2019-12-20 16:18:30',NULL,'f3354259-d655-4848-bd1f-c9abb4da6dd3'),(99,NULL,34,8,'craft\\elements\\Entry',1,0,'2019-03-11 17:55:50','2019-12-20 16:18:32',NULL,'049c4183-e4f6-424d-9e6d-35a0f5436f7b'),(100,NULL,NULL,11,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:31','2019-12-20 16:18:33',NULL,'b31bcd68-0342-423f-9af4-b7c64d508e60'),(101,NULL,NULL,12,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:31','2019-12-20 16:18:33',NULL,'820c43ee-ea25-4934-a856-863fe793ad9c'),(102,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:32','2019-12-20 16:18:33',NULL,'a819c3b4-cfab-469a-875c-8f95c315cc6e'),(103,NULL,NULL,18,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:32','2019-12-20 16:18:33',NULL,'e116a87d-240c-4e9d-9d06-0de3324c9539'),(104,NULL,NULL,34,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:32','2019-03-12 16:06:42','2019-12-20 16:18:33','e65afc97-a035-4010-a512-5e3f35b78d81'),(105,NULL,35,9,'craft\\elements\\Entry',1,0,'2019-03-08 16:50:09','2019-12-20 16:18:34',NULL,'65f527e4-3162-434a-9dad-eb45d0258a20'),(106,NULL,36,9,'craft\\elements\\Entry',1,0,'2019-03-08 16:50:09','2019-12-20 16:18:35',NULL,'254424c7-812f-4f58-8387-9c33e52be9fe'),(107,NULL,37,27,'craft\\elements\\Entry',1,0,'2019-03-08 16:50:06','2019-12-20 16:18:35',NULL,'61f3db13-5635-46e2-bcf0-d2c648a60027'),(108,NULL,38,27,'craft\\elements\\Entry',1,0,'2019-03-08 16:50:06','2019-12-20 16:18:36',NULL,'f6ff62e5-250e-4a37-bb6e-51a348c9d529'),(109,NULL,39,24,'craft\\elements\\Entry',1,0,'2019-03-08 16:49:48','2019-12-20 16:18:37',NULL,'989e61b7-2ab1-49e8-b697-bbf88851688f'),(110,NULL,40,24,'craft\\elements\\Entry',1,0,'2019-03-08 16:49:48','2019-12-20 16:18:38',NULL,'d383577f-b018-48a1-abf6-8fb12cff94e0'),(111,NULL,41,26,'craft\\elements\\Entry',1,0,'2019-03-08 16:49:46','2019-12-20 16:18:38',NULL,'2e2b6eac-6461-471f-8ee3-df20bbbb5fa9'),(112,NULL,42,29,'craft\\elements\\Entry',1,0,'2019-03-08 16:49:42','2019-12-20 16:18:39',NULL,'7d3f3ee5-2549-4af8-90d7-ad1d17c32af4'),(113,NULL,43,29,'craft\\elements\\Entry',1,0,'2019-03-08 16:49:42','2019-12-20 16:18:39',NULL,'e124a458-e5dc-4421-b413-edc4d81e5e17'),(114,NULL,44,28,'craft\\elements\\Entry',1,0,'2019-03-08 16:49:39','2019-12-20 16:18:40',NULL,'d673c170-0e88-4035-9d50-cc748b08ce36'),(115,NULL,45,28,'craft\\elements\\Entry',1,0,'2019-03-08 16:49:39','2019-12-20 16:18:40',NULL,'558c5893-35fc-409f-9779-72f9f3d26e2c'),(116,NULL,46,30,'craft\\elements\\Entry',1,0,'2019-03-08 16:49:36','2019-12-20 16:18:40',NULL,'871b5d61-5d74-4087-885e-0d74975cb102'),(117,NULL,47,30,'craft\\elements\\Entry',1,0,'2019-03-08 16:49:36','2019-12-20 16:18:41',NULL,'05894382-b8ef-40db-9490-8d27d66e234d'),(118,NULL,48,8,'craft\\elements\\Entry',1,0,'2019-03-08 16:49:33','2019-12-20 16:18:43',NULL,'41a10d38-fbd0-4204-ae62-1c96dcafac1c'),(119,NULL,NULL,11,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:41','2019-12-20 16:18:43',NULL,'1931550a-fa42-438f-bfcd-326730484ae2'),(120,NULL,NULL,12,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:41','2019-12-20 16:18:43',NULL,'90181b96-de94-4621-b095-51e7509deb87'),(121,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:42','2019-12-20 16:18:44',NULL,'c91cddab-1d91-4fdf-8f99-bd7224220f2d'),(122,NULL,NULL,18,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:43','2019-12-20 16:18:44',NULL,'7e9bb9ba-3594-4398-b71d-5c58d5beb57f'),(123,NULL,NULL,34,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:43','2019-03-12 16:06:42','2019-12-20 16:18:44','6e01f42e-3f54-4e76-9ddf-87cb257a694b'),(124,NULL,49,8,'craft\\elements\\Entry',1,0,'2019-03-05 23:02:53','2019-12-20 16:18:46',NULL,'57c52123-6f14-492d-9e4e-b5ad1c3c9a4a'),(125,NULL,NULL,11,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:44','2019-12-20 16:18:46',NULL,'570aeee4-5672-422b-925b-a82d10cfc9ac'),(126,NULL,NULL,12,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:45','2019-12-20 16:18:46',NULL,'5431f3c2-c820-4097-976f-7a3fd56bfe65'),(127,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:45','2019-12-20 16:18:47',NULL,'7af5a590-261d-46f9-a5be-8a2c5315855d'),(128,NULL,NULL,18,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:46','2019-12-20 16:18:47',NULL,'d49fb670-f4c1-482b-96b0-68ae9175ab07'),(129,NULL,NULL,34,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:46','2019-03-12 16:06:42','2019-12-20 16:18:47','a6f6a8f0-00aa-4064-98a8-b65d71dd4529'),(130,NULL,50,26,'craft\\elements\\Entry',1,0,'2018-02-06 19:56:05','2019-12-20 16:18:48',NULL,'46edb401-1286-4a09-9e43-069c5b5eb0ca'),(131,NULL,51,26,'craft\\elements\\Entry',1,0,'2018-02-06 19:55:57','2019-12-20 16:18:48',NULL,'3cb62caa-6b3e-4fdb-a5c9-951193746a4b'),(132,NULL,52,8,'craft\\elements\\Entry',1,0,'2018-02-06 14:23:52','2019-12-20 16:18:51',NULL,'2e40da52-2045-431e-ba02-435f4ee2ebcd'),(133,NULL,NULL,11,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:49','2019-03-12 16:06:41','2019-12-20 16:18:51','a05700e2-bfd0-4588-8ff3-d516f899ba28'),(134,NULL,NULL,12,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:50','2019-03-12 16:06:41','2019-12-20 16:18:51','1a7de4be-f467-4e40-9a86-bb00a52a55f2'),(135,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:50','2019-03-12 16:06:42','2019-12-20 16:18:51','8f323c26-4869-475e-b718-3d678a9b7bbe'),(136,NULL,NULL,18,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:50','2019-03-12 16:06:42','2019-12-20 16:18:51','0c526e00-2b6c-4979-af5a-1d19d4c13bcb'),(137,NULL,NULL,34,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:51','2019-03-12 16:06:42','2019-12-20 16:18:51','12ff9e69-fb87-40ee-9b03-e4b900fe6af7'),(138,NULL,53,8,'craft\\elements\\Entry',1,0,'2018-02-06 14:23:52','2019-12-20 16:18:53',NULL,'c21fa456-11c0-4486-8106-504755c7e701'),(139,NULL,NULL,11,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:52','2019-03-12 16:06:41','2019-12-20 16:18:54','2f9a1320-18e7-4101-917c-4a2687c85581'),(140,NULL,NULL,12,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:52','2019-03-12 16:06:41','2019-12-20 16:18:54','b1444329-93a2-42ce-91ee-6389120bcf25'),(141,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:53','2019-03-12 16:06:42','2019-12-20 16:18:54','0d2f36be-b058-46e9-a9fc-9e3dd474e4b7'),(142,NULL,NULL,18,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:53','2019-03-12 16:06:42','2019-12-20 16:18:54','8f2fcdee-9705-4b8d-9550-d45ac5fa7cf8'),(143,NULL,NULL,34,'craft\\elements\\MatrixBlock',1,0,'2019-12-20 16:18:53','2019-03-12 16:06:42','2019-12-20 16:18:54','f3c682bd-87d3-43bc-bd4b-d90d1ff2e018');
/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elements_sites`
--

DROP TABLE IF EXISTS `elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `elements_sites_siteId_idx` (`siteId`),
  KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `elements_sites_enabled_idx` (`enabled`),
  KEY `elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elements_sites`
--

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;
INSERT INTO `elements_sites` VALUES (1,1,1,NULL,NULL,1,'2017-11-29 20:51:54','2019-03-12 15:51:37','8e1ef923-2fc5-48af-ad34-e3ea533b3d0a'),(4,4,1,NULL,NULL,1,'2018-01-17 16:36:22','2018-02-05 19:48:38','a888c81c-392d-4b0d-9fdf-224f4e8c5a70'),(5,5,1,'white-papers','resource-categories/white-papers',1,'2018-01-31 19:53:20','2018-01-31 19:53:57','a205ceb3-6dc9-486b-9b13-c2428430394f'),(6,6,1,'videos','resource-categories/videos',1,'2018-01-31 19:53:25','2018-01-31 19:54:00','1985cceb-f343-4360-9199-404812c9a041'),(7,7,1,'case-studies','resource-categories/case-studies',1,'2018-01-31 19:53:36','2018-01-31 19:53:59','121101c9-e0fb-49bc-b2f7-2ae8792b1e3d'),(8,8,1,'webinars','resource-categories/webinars',1,'2018-01-31 19:53:45','2018-01-31 19:53:55','a4d0a42e-2f0f-422a-beae-2ade9e900a5f'),(9,9,1,'reports','resource-categories/reports',1,'2018-01-31 19:53:51','2018-01-31 19:53:51','84bf2245-7aae-4590-9170-d18d90d31eb0'),(15,15,1,'homepage','__home__',1,'2018-02-02 05:31:09','2019-03-12 16:06:41','51ec2ef8-c422-44d5-b26e-7a5c9fde2dc9'),(16,16,1,'error-page','500',1,'2018-02-02 05:34:35','2019-03-11 18:14:20','d6907eb5-0203-4b41-a842-a047b2331203'),(17,17,1,'page-not-found','404',1,'2018-02-02 05:34:50','2019-03-11 18:15:49','40251971-8782-4491-b2b3-ac6507cc89fd'),(18,18,1,'culture','blog-categories/culture',1,'2018-02-04 18:18:49','2018-02-04 18:18:50','05978a64-5422-4b50-b735-a8ca4af37525'),(19,19,1,'hiring','blog-categories/hiring',1,'2018-02-04 18:18:57','2018-02-04 18:18:58','b4fc0b21-d94d-44a6-b7cf-b96aff45acb7'),(20,20,1,'announcement','blog-categories/announcement',1,'2018-02-04 22:11:29','2018-02-04 22:11:29','885898ab-d457-42d5-9bf1-aec0c58c7bd5'),(21,21,1,'press-release','blog-categories/press-release',1,'2018-02-04 22:11:36','2018-02-04 22:11:37','e1c032a3-555a-470b-9151-cba64781ebef'),(22,22,1,'contact','contact',1,'2018-02-04 22:14:34','2019-03-11 18:01:52','3e4ffb22-2bb9-4eaa-9e84-f1a2155969e8'),(23,23,1,'about','about',1,'2018-02-04 23:03:59','2019-10-22 14:53:49','65a9c0f0-6956-4e7d-88ae-0c9070f85f14'),(24,24,1,'privacy-page','privacy',1,'2018-02-04 23:08:53','2019-03-11 18:13:11','3fbef1f2-5a5f-4095-a334-bffabea2fec3'),(25,25,1,'news-events-page','news',1,'2018-02-05 06:20:14','2019-10-21 19:16:03','49c2f583-1ab3-4d8c-a867-a68f996d1102'),(26,26,1,'resources-page','resources',1,'2018-02-05 06:20:40','2019-10-21 19:16:11','0223cc91-4e84-4afa-b4a9-eb4fd89ec0b9'),(27,27,1,'blog-page','blog',1,'2018-02-05 06:21:29','2019-10-21 18:08:52','33c04630-1e4c-405d-87fd-cce516b9f008'),(29,29,1,NULL,NULL,1,'2018-02-05 19:49:24','2018-02-05 19:49:24','acc6a3fd-4e34-4e81-8924-fde05376ae87'),(32,32,1,NULL,NULL,1,'2019-03-05 23:02:52','2019-03-12 16:06:41','dbfb405f-6877-453f-b053-6ff759f6254d'),(33,33,1,NULL,NULL,1,'2019-03-05 23:02:53','2019-03-12 16:06:41','b22406ff-fe15-4d12-ac25-7810793ec330'),(34,34,1,NULL,NULL,1,'2019-03-05 23:02:53','2019-03-12 16:06:42','136be40b-3f9a-4b67-8cc6-e03b1b859a3f'),(35,35,1,NULL,NULL,1,'2019-03-05 23:02:53','2019-03-12 16:06:42','813d2ccd-5114-440a-bb30-4ea69004c1e2'),(36,36,1,'welcome-to-the-blog','blog/welcome-to-the-blog',1,'2019-03-11 18:17:26','2019-03-11 19:42:02','e64e95b0-95d4-424e-a83d-3fce3d7fa64d'),(37,37,1,NULL,NULL,1,'2019-03-11 18:17:26','2019-03-11 19:42:02','4076f2e1-2fa6-4071-8457-f79a3cbb5736'),(38,38,1,'new-website-successfully-created','news/new-website-successfully-created',1,'2019-03-11 18:18:29','2019-03-11 21:07:48','6a09db19-2780-477d-b7ab-707eab720e47'),(39,39,1,NULL,NULL,1,'2019-03-11 18:18:29','2019-03-11 21:07:48','4a3f25c7-8780-4e36-84fa-216b0ae9a233'),(40,40,1,'import-resource','resources/import-resource',1,'2019-03-11 18:19:11','2019-03-11 20:00:25','5d3495b4-2a3c-4b32-94d1-9e9ea3347030'),(41,41,1,NULL,NULL,1,'2019-03-11 18:19:11','2019-03-11 18:19:28','b274074e-837b-4df5-aa7e-184da6660217'),(42,42,1,'imarc-website','resources/imarc-website',1,'2019-03-11 18:21:49','2019-03-11 20:00:25','b3996d24-5f80-4649-81da-93be4586ed3b'),(43,43,1,NULL,NULL,1,'2019-03-11 19:42:02','2019-03-11 19:42:02','a6f94a0d-b59a-44df-ab6b-36fd7bf523bb'),(44,44,1,'acme-resource','resources/acme-resource',1,'2019-03-11 20:01:52','2019-03-11 20:13:28','e5393d66-871b-42e7-9128-f777b698a86e'),(45,45,1,NULL,NULL,1,'2019-03-11 20:01:52','2019-03-11 20:02:43','77ee80af-17ab-4e25-94c8-595ec049cb5b'),(46,46,1,'first-lastername','leadership/first-lastername',1,'2019-03-11 21:30:37','2019-03-11 22:01:52','7dacd30c-fe74-4f15-8861-6615acae9c5f'),(47,47,1,'leadership-page','leadership',1,'2019-03-11 21:31:27','2019-10-21 18:10:02','3cb5c41e-84fb-4835-ba8a-5e2a4dc8346c'),(48,48,1,'example-shared-block',NULL,1,'2019-03-12 16:06:37','2019-03-12 16:06:42','a95c59f4-3ae0-44e6-b3e2-48f16c69590a'),(49,49,1,NULL,NULL,1,'2019-03-12 16:06:37','2019-03-12 16:06:37','cabd7e21-7fd5-46ec-a9b9-1cbe123b35d7'),(50,50,1,NULL,NULL,1,'2019-03-12 16:06:42','2019-03-12 16:06:42','90600b99-23a4-4972-bb58-c8d77b45d234'),(51,51,1,NULL,NULL,1,'2019-04-25 18:09:18','2019-04-25 18:09:18','7070aadc-8183-4162-a38b-ad56bfceab48'),(52,52,1,'service-unavailable-page','503',1,'2019-10-25 18:39:21','2019-10-25 19:24:36','60059e92-33a6-40a8-a827-8032a0adef77'),(53,53,1,'service-unavailable-page','503',1,'2019-12-20 16:17:51','2019-12-20 16:17:51','f14245e2-50e1-4861-bb87-e88735ae50cc'),(54,54,1,'service-unavailable-page','503',1,'2019-12-20 16:17:51','2019-12-20 16:17:51','7a2f267d-a8fb-4e2e-8dd5-d3f077a28b0b'),(55,55,1,'blog-page','blog',1,'2019-12-20 16:17:52','2019-12-20 16:17:52','22a78c10-a64d-4975-9879-4a4ecb9c4b27'),(56,56,1,'homepage','__home__',1,'2019-12-20 16:17:52','2019-12-20 16:17:52','e649676f-6bd2-4416-bc95-e69f6aefb5d7'),(57,57,1,NULL,NULL,1,'2019-12-20 16:17:53','2019-12-20 16:17:53','10d84d01-c4bc-41cb-9387-43a07c81c956'),(58,58,1,NULL,NULL,1,'2019-12-20 16:17:54','2019-12-20 16:17:54','5bf19640-98b5-4fe4-b806-0bd949c1c89c'),(59,59,1,NULL,NULL,1,'2019-12-20 16:17:54','2019-12-20 16:17:54','95f34098-f411-4207-ac8e-5e8f58da2f0c'),(60,60,1,NULL,NULL,1,'2019-12-20 16:17:54','2019-12-20 16:17:54','c768bf3a-a6c1-4f46-9ed1-4b9904315a05'),(61,61,1,NULL,NULL,1,'2019-12-20 16:17:55','2019-12-20 16:17:55','0557d0ca-5bcf-4362-b733-c74055c1889c'),(62,62,1,'example-shared-block',NULL,1,'2019-12-20 16:17:56','2019-12-20 16:17:56','512cce55-a9e4-4462-80fd-2da92353071c'),(63,63,1,NULL,NULL,1,'2019-12-20 16:17:56','2019-12-20 16:17:56','418d1b85-3ff0-4e80-88e3-2a75bd82a79d'),(64,64,1,'leadership-page','leadership',1,'2019-12-20 16:17:57','2019-12-20 16:17:57','f95f4f71-6d8f-4596-b99f-d182bcbea778'),(65,65,1,'leadership-page','leadership',1,'2019-12-20 16:17:58','2019-12-20 16:17:58','5661b75d-f6e4-4b73-86f6-59f9684ba3ec'),(66,66,1,'leadership-page','leadership',1,'2019-12-20 16:17:58','2019-12-20 16:17:58','0cce1ed4-b999-4e80-8292-a290ceaa8db9'),(67,67,1,'first-lastername','leadership/first-lastername',1,'2019-12-20 16:17:59','2019-12-20 16:17:59','a14e70bf-3475-4e54-bfd5-45a06ede1a47'),(68,68,1,'acme-resource','resources/acme-resource',1,'2019-12-20 16:18:02','2019-12-20 16:18:02','9f4a1b81-6422-4321-abac-595d7b831ac9'),(69,69,1,NULL,NULL,1,'2019-12-20 16:18:02','2019-12-20 16:18:02','04026b67-2ec9-4800-bd0a-e3475d820e12'),(70,70,1,'acme-resource','resources/acme-resource',1,'2019-12-20 16:18:04','2019-12-20 16:18:04','534547ca-7403-48b4-a671-da3d942f60d7'),(71,71,1,NULL,NULL,1,'2019-12-20 16:18:04','2019-12-20 16:18:04','cced6555-4ce6-4da0-b171-74691aee9f28'),(72,72,1,'import-resource','resources/import-resource',1,'2019-12-20 16:18:06','2019-12-20 16:18:06','cfbce580-d7f3-493e-8431-dea8ef529c9c'),(73,73,1,'imarc-website','resources/imarc-website',1,'2019-12-20 16:18:08','2019-12-20 16:18:08','fc7b752e-a787-427c-b0f8-5c2d5cd0b79b'),(74,74,1,'welcome-to-the-blog','blog/welcome-to-the-blog',1,'2019-12-20 16:18:10','2019-12-20 16:18:10','2f779169-b0f8-49d7-a7c6-e4ec08e34664'),(75,75,1,NULL,NULL,1,'2019-12-20 16:18:11','2019-12-20 16:18:11','85ed6407-9250-4811-94f0-e83804f4f135'),(76,76,1,NULL,NULL,1,'2019-12-20 16:18:11','2019-12-20 16:18:11','ec12dc29-085f-433e-819d-c9612d15da64'),(77,77,1,'import-resource','resources/import-resource',1,'2019-12-20 16:18:13','2019-12-20 16:18:13','ae61f789-3453-4ae7-822a-b6c7b6d3e5f7'),(78,78,1,'imarc-website','resources/imarc-website',1,'2019-12-20 16:18:15','2019-12-20 16:18:15','abe0b250-53b6-4c87-a0f5-5bd316c81e49'),(79,79,1,'import-resource','resources/import-resource',1,'2019-12-20 16:18:17','2019-12-20 16:18:17','705f2f6f-2c41-4159-b474-323803446e2d'),(80,80,1,'import-resource','resources/import-resource',1,'2019-12-20 16:18:18','2019-12-20 16:18:18','37c28165-2d18-4399-9527-ba6048c02a92'),(81,81,1,'import-resource','resources/import-resource',1,'2019-12-20 16:18:19','2019-12-20 16:18:19','cf7b8ad0-6fba-4861-8ce5-4e46e49b11bb'),(82,82,1,'new-website-successfully-created','news/new-website-successfully-created',1,'2019-12-20 16:18:20','2019-12-20 16:18:20','2b09f220-c122-4e7b-84a6-b0486d0d21d6'),(83,83,1,NULL,NULL,1,'2019-12-20 16:18:21','2019-12-20 16:18:21','eba4dd6e-d896-435c-8c8b-a1e3d6582ae5'),(84,84,1,'welcome-to-the-blog','blog/welcome-to-the-blog',1,'2019-12-20 16:18:22','2019-12-20 16:18:22','a20917e0-d65d-44f3-9697-fef0e3acd113'),(85,85,1,NULL,NULL,1,'2019-12-20 16:18:22','2019-12-20 16:18:22','89c835dd-3c9c-42b5-a571-e48270d38935'),(86,86,1,NULL,NULL,1,'2019-12-20 16:18:22','2019-12-20 16:18:22','79db7697-b3e3-4963-b428-1e81bd24c7b4'),(87,87,1,'page-not-found','404',1,'2019-12-20 16:18:23','2019-12-20 16:18:23','043af3dd-9768-4c3e-880a-42c034fde8d8'),(88,88,1,'blog-page','blog',1,'2019-12-20 16:18:24','2019-12-20 16:18:24','a6a31c9e-033a-413b-accc-7ea1e5f9f0ff'),(89,89,1,'news-events-page','news',1,'2019-12-20 16:18:24','2019-12-20 16:18:24','55d1995a-d6d4-480b-b699-36773d99b134'),(90,90,1,'resources-page','resources',1,'2019-12-20 16:18:25','2019-12-20 16:18:25','09f5ee51-c706-4016-ad5a-f051d7ef1ed6'),(91,91,1,'about','about',1,'2019-12-20 16:18:25','2019-12-20 16:18:25','fddb4cc4-e404-482f-ae71-eb8b7563a0fe'),(92,92,1,'about','about',1,'2019-12-20 16:18:26','2019-12-20 16:18:26','e07b40a7-bb78-4b48-bbab-51fdddfaae72'),(93,93,1,'contact','contact',1,'2019-12-20 16:18:27','2019-12-20 16:18:27','bbe68c48-efa5-4b52-a6bb-14dbd2211546'),(94,94,1,'privacy-page','privacy',1,'2019-12-20 16:18:28','2019-12-20 16:18:28','b259341c-b45f-4ce2-bf2d-a96cf660d3b1'),(95,95,1,'error-page','500',1,'2019-12-20 16:18:28','2019-12-20 16:18:28','1791c804-e4e8-49ec-8471-66882dde3ec7'),(96,96,1,'page-not-found','404',1,'2019-12-20 16:18:29','2019-12-20 16:18:29','c07fd63e-54ac-4d47-8456-6c634c80398a'),(97,97,1,'page-not-found','404',1,'2019-12-20 16:18:29','2019-12-20 16:18:29','1560c662-5060-4ff3-8d1f-28832a223a6c'),(98,98,1,'page-not-found','404',1,'2019-12-20 16:18:29','2019-12-20 16:18:29','b252107b-fa2a-462c-812a-1d75cd545287'),(99,99,1,'homepage','__home__',1,'2019-12-20 16:18:31','2019-12-20 16:18:31','d4dda634-300b-40a9-9696-f3169cc11c66'),(100,100,1,NULL,NULL,1,'2019-12-20 16:18:31','2019-12-20 16:18:31','61816849-6609-4bb3-ac02-bfe6fe61c68e'),(101,101,1,NULL,NULL,1,'2019-12-20 16:18:31','2019-12-20 16:18:31','37c6d3d7-e52d-468c-bfd8-616af54e9121'),(102,102,1,NULL,NULL,1,'2019-12-20 16:18:32','2019-12-20 16:18:32','180197e4-a7ae-4288-a5ec-84a83d9c4d52'),(103,103,1,NULL,NULL,1,'2019-12-20 16:18:32','2019-12-20 16:18:32','4007fe37-00d5-41e2-b2cc-a407a93875c9'),(104,104,1,NULL,NULL,1,'2019-12-20 16:18:32','2019-12-20 16:18:32','f4297f8e-4597-4367-8453-013478a4bae0'),(105,105,1,'error-page','500',1,'2019-12-20 16:18:34','2019-12-20 16:18:34','ba529232-8a1e-421a-808f-9326c3161e72'),(106,106,1,'error-page','500',1,'2019-12-20 16:18:34','2019-12-20 16:18:34','1dfeaf68-907a-4a1d-8c9c-9a7037d73ded'),(107,107,1,'privacy-page','privacy',1,'2019-12-20 16:18:35','2019-12-20 16:18:35','eb44a403-4413-49d9-bdfa-620b1941907d'),(108,108,1,'privacy-page','privacy',1,'2019-12-20 16:18:36','2019-12-20 16:18:36','30336de1-5faf-4975-b81b-75440814728e'),(109,109,1,'contact','contact',1,'2019-12-20 16:18:36','2019-12-20 16:18:36','56a4877e-7d03-4163-bc6f-0cafc492ae14'),(110,110,1,'contact','contact',1,'2019-12-20 16:18:38','2019-12-20 16:18:38','f8d8e662-1ce2-42d1-8f7f-f62df19fba81'),(111,111,1,'about','about',1,'2019-12-20 16:18:38','2019-12-20 16:18:38','a65efcbb-8b3d-494d-a36c-73b859cd2cef'),(112,112,1,'resources-page','resources',1,'2019-12-20 16:18:39','2019-12-20 16:18:39','5dd926b9-e9a3-48de-b127-8031cabef21d'),(113,113,1,'resources-page','resources',1,'2019-12-20 16:18:39','2019-12-20 16:18:39','e67e96f6-6fd3-4b2a-b779-1dee7c244275'),(114,114,1,'news-events-page','news',1,'2019-12-20 16:18:39','2019-12-20 16:18:39','cfced2a6-5498-423d-aece-d6b42378db47'),(115,115,1,'news-events-page','news',1,'2019-12-20 16:18:40','2019-12-20 16:18:40','199599cb-3375-439e-9a13-2e8f8f37dc1e'),(116,116,1,'blog-page','blog',1,'2019-12-20 16:18:40','2019-12-20 16:18:40','6d89014f-bee3-4ef0-94c2-7bbfc09d5c27'),(117,117,1,'blog-page','blog',1,'2019-12-20 16:18:40','2019-12-20 16:18:40','958649b7-aaa7-422c-9e0c-9dbefde14a93'),(118,118,1,'homepage','__home__',1,'2019-12-20 16:18:41','2019-12-20 16:18:41','4268df44-7286-45f8-b409-3b93b1853ed4'),(119,119,1,NULL,NULL,1,'2019-12-20 16:18:41','2019-12-20 16:18:41','0645ff44-c159-47a7-bb01-1890bc670ae1'),(120,120,1,NULL,NULL,1,'2019-12-20 16:18:41','2019-12-20 16:18:41','a981c5f9-cb4e-43c2-aa73-226960054006'),(121,121,1,NULL,NULL,1,'2019-12-20 16:18:42','2019-12-20 16:18:42','a62b6c31-61e2-44e6-9c49-3654a5f2cd7f'),(122,122,1,NULL,NULL,1,'2019-12-20 16:18:43','2019-12-20 16:18:43','0f432c94-a504-442c-92b2-95976147ee05'),(123,123,1,NULL,NULL,1,'2019-12-20 16:18:43','2019-12-20 16:18:43','69bb4022-98df-484a-bd54-82842170ed06'),(124,124,1,'homepage','__home__',1,'2019-12-20 16:18:44','2019-12-20 16:18:44','a1b68e5c-c2c8-4c8f-bf9a-3e079496d7c7'),(125,125,1,NULL,NULL,1,'2019-12-20 16:18:44','2019-12-20 16:18:44','67ce3e63-01a5-4efe-8af1-ab008ce4868c'),(126,126,1,NULL,NULL,1,'2019-12-20 16:18:45','2019-12-20 16:18:45','2e46332d-8d54-4827-a8b3-b92593a8d337'),(127,127,1,NULL,NULL,1,'2019-12-20 16:18:45','2019-12-20 16:18:45','a37e30a3-1e35-4ac5-b83f-7dec42fa435a'),(128,128,1,NULL,NULL,1,'2019-12-20 16:18:46','2019-12-20 16:18:46','d136f992-8d21-40a9-8c3c-c591ca445ef0'),(129,129,1,NULL,NULL,1,'2019-12-20 16:18:46','2019-12-20 16:18:46','2d883f28-8d65-46b2-8190-a327dc552acc'),(130,130,1,'about','about',1,'2019-12-20 16:18:47','2019-12-20 16:18:47','7acd29f7-c4ff-4f61-9957-63115b102026'),(131,131,1,'about','about',1,'2019-12-20 16:18:48','2019-12-20 16:18:48','7da4df9f-c994-481b-847e-c0ec93af1f38'),(132,132,1,'homepage','__home__',1,'2019-12-20 16:18:49','2019-12-20 16:18:49','3ee165e6-c1da-4313-bd65-390bc4704ba3'),(133,133,1,NULL,NULL,1,'2019-12-20 16:18:49','2019-12-20 16:18:49','6f3831c9-e667-4ffb-be23-0988cbe30951'),(134,134,1,NULL,NULL,1,'2019-12-20 16:18:50','2019-12-20 16:18:50','28e6913f-6a6e-46be-acb1-69346f02be81'),(135,135,1,NULL,NULL,1,'2019-12-20 16:18:50','2019-12-20 16:18:50','ae19bde2-2379-4db5-bbf1-fdf8239b09dd'),(136,136,1,NULL,NULL,1,'2019-12-20 16:18:50','2019-12-20 16:18:50','9f540953-6be1-42e0-a69e-8df21062756d'),(137,137,1,NULL,NULL,1,'2019-12-20 16:18:51','2019-12-20 16:18:51','3499ae98-a304-4ca3-9bfc-765eeb722a73'),(138,138,1,'homepage','__home__',1,'2019-12-20 16:18:51','2019-12-20 16:18:51','a29f34ca-a7b7-45d5-872c-a6ace7ec07f4'),(139,139,1,NULL,NULL,1,'2019-12-20 16:18:52','2019-12-20 16:18:52','5ee1e402-8432-4c92-b3f9-22eb5916c395'),(140,140,1,NULL,NULL,1,'2019-12-20 16:18:52','2019-12-20 16:18:52','e4f15cef-e22c-4eab-ac1c-6ca7d2a02d17'),(141,141,1,NULL,NULL,1,'2019-12-20 16:18:53','2019-12-20 16:18:53','392a57c3-a1a8-41e3-8abd-b022963d3254'),(142,142,1,NULL,NULL,1,'2019-12-20 16:18:53','2019-12-20 16:18:53','9d2eaeb0-32d5-419f-8977-231566cd5c13'),(143,143,1,NULL,NULL,1,'2019-12-20 16:18:53','2019-12-20 16:18:53','75fdf7a3-1e03-4ec2-a2a5-779b65dbe533');
/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entries`
--

DROP TABLE IF EXISTS `entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  KEY `entries_parentId_fk` (`parentId`),
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entries`
--

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;
INSERT INTO `entries` VALUES (15,3,NULL,5,NULL,'2018-02-02 05:31:09',NULL,NULL,'2018-02-02 05:31:09','2019-03-12 16:06:41','f6da0b2a-7782-4e84-93a2-72cb7487a4f1'),(16,4,NULL,6,NULL,'2018-02-02 05:34:35',NULL,NULL,'2018-02-02 05:34:35','2019-03-11 18:14:20','e2e21fc5-9c1e-4b1a-9982-320c88ac4b16'),(17,5,NULL,7,NULL,'2018-02-02 05:34:50',NULL,NULL,'2018-02-02 05:34:50','2019-03-11 18:15:49','65f7ddb2-ee8a-49be-a0af-be1562214b70'),(22,10,NULL,12,NULL,'2018-02-04 22:14:34',NULL,NULL,'2018-02-04 22:14:34','2019-03-11 18:01:52','ad87f44c-ffd5-4245-b05d-b7defa213752'),(23,12,NULL,14,NULL,'2018-02-04 23:03:59',NULL,NULL,'2018-02-04 23:03:59','2019-10-22 14:53:49','091cf386-ba9b-4821-b21f-bba5d74b1e88'),(24,13,NULL,15,NULL,'2018-02-04 23:08:53',NULL,NULL,'2018-02-04 23:08:53','2019-03-11 18:13:11','7591a08c-3410-4784-8cba-770bc879b46b'),(25,14,NULL,16,NULL,'2018-02-05 06:20:14',NULL,NULL,'2018-02-05 06:20:14','2019-10-21 19:16:03','24945042-370b-43b9-9b8e-7cdf4231dc9e'),(26,15,NULL,17,NULL,'2018-02-05 06:20:40',NULL,NULL,'2018-02-05 06:20:40','2019-10-21 19:16:11','f130efce-41a3-4e55-be18-17dab696ebb7'),(27,16,NULL,18,NULL,'2018-02-05 06:21:29',NULL,NULL,'2018-02-05 06:21:29','2019-10-21 18:08:53','740dbd22-fdac-46f8-95f7-7ed4bca98882'),(36,8,NULL,10,1,'2019-03-11 18:17:00',NULL,NULL,'2019-03-11 18:17:26','2019-03-11 19:42:02','ab5cf54b-a498-476e-9d21-27b8f3217936'),(38,6,NULL,8,1,'2019-03-11 18:18:00',NULL,NULL,'2019-03-11 18:18:29','2019-03-11 21:07:48','556a5de1-15b6-4517-840f-6421947230bf'),(40,2,NULL,3,1,'2019-03-11 18:19:00',NULL,NULL,'2019-03-11 18:19:11','2019-03-11 20:00:25','627d3d6f-ce94-4c9c-9bb4-a6ed790bc4b9'),(42,2,NULL,3,1,'2019-03-11 18:21:00',NULL,NULL,'2019-03-11 18:21:49','2019-03-11 20:00:25','e2d92824-d53d-41b7-9bb6-b5f4a3a10864'),(44,2,NULL,2,1,'2019-03-11 20:01:00',NULL,NULL,'2019-03-11 20:01:52','2019-03-11 20:02:43','55eee79b-f264-4973-b9aa-6a422b9669ba'),(46,7,NULL,9,1,'2019-03-11 21:30:00',NULL,NULL,'2019-03-11 21:30:37','2019-03-11 22:01:52','cf3e86ac-f81e-43d5-a8f1-815b1bde77dd'),(47,18,NULL,20,NULL,'2019-03-11 21:31:00',NULL,NULL,'2019-03-11 21:31:27','2019-10-21 18:10:02','25d8d604-f62b-4945-afc3-57c511218169'),(48,19,NULL,21,1,'2019-03-12 16:06:00',NULL,NULL,'2019-03-12 16:06:37','2019-03-12 16:06:37','6b9d686a-e49b-48d6-b05b-523093bcbce7'),(52,20,NULL,22,NULL,'2019-10-25 18:39:00',NULL,NULL,'2019-10-25 18:39:21','2019-10-25 19:24:36','71cbf93b-3642-4700-a54c-70bc73d01a78'),(53,20,NULL,22,NULL,'2019-10-25 18:39:00',NULL,NULL,'2019-12-20 16:17:51','2019-12-20 16:17:51','3715a468-f96f-4ae3-b09e-88af1d8186e5'),(54,20,NULL,22,NULL,'2019-10-25 18:39:00',NULL,NULL,'2019-12-20 16:17:51','2019-12-20 16:17:51','1997d8dc-7066-43e1-8c4e-07899f375850'),(55,16,NULL,18,NULL,'2018-02-05 06:21:29',NULL,NULL,'2019-12-20 16:17:52','2019-12-20 16:17:52','28e7fcbe-326a-44ab-b3d6-566b4480b7af'),(56,3,NULL,5,NULL,'2018-02-02 05:31:09',NULL,NULL,'2019-12-20 16:17:52','2019-12-20 16:17:52','bc61b68b-57eb-449e-8ea5-20aae2c59615'),(62,19,NULL,21,1,'2019-03-12 16:06:00',NULL,NULL,'2019-12-20 16:17:56','2019-12-20 16:17:56','65b895f6-87d5-4c44-b297-d26ba20e8fb7'),(64,18,NULL,20,NULL,'2019-03-11 21:31:00',NULL,NULL,'2019-12-20 16:17:57','2019-12-20 16:17:57','b32482c7-b7ff-4b10-9038-075f347cf8c7'),(65,18,NULL,20,NULL,'2019-03-11 21:31:00',NULL,NULL,'2019-12-20 16:17:58','2019-12-20 16:17:58','3a8de2f5-2b8a-4ff3-98d8-4e28eab4f3d0'),(66,18,NULL,20,NULL,'2019-03-11 21:31:00',NULL,NULL,'2019-12-20 16:17:58','2019-12-20 16:17:58','6781f280-8ba5-45c2-92ef-399b1aa106db'),(67,7,NULL,9,1,'2019-03-11 21:30:00',NULL,NULL,'2019-12-20 16:17:59','2019-12-20 16:17:59','a4f3a16b-8324-4930-95b0-4fefbfef6d04'),(68,2,NULL,2,1,'2019-03-11 20:01:00',NULL,NULL,'2019-12-20 16:18:02','2019-12-20 16:18:02','8f2f1071-8b60-43f5-8e53-55f28ef814ac'),(70,2,NULL,2,1,'2019-03-11 20:01:00',NULL,NULL,'2019-12-20 16:18:04','2019-12-20 16:18:04','f768b356-03ba-4989-b38b-83214091ce16'),(72,2,NULL,3,1,'2019-03-11 18:19:00',NULL,NULL,'2019-12-20 16:18:06','2019-12-20 16:18:06','143a6f3d-615a-4f21-a483-3079f5896fd3'),(73,2,NULL,3,1,'2019-03-11 18:21:00',NULL,NULL,'2019-12-20 16:18:08','2019-12-20 16:18:08','03e799d4-cb33-4677-a84a-bf1c7386f7f7'),(74,8,NULL,10,1,'2019-03-11 18:17:00',NULL,NULL,'2019-12-20 16:18:10','2019-12-20 16:18:10','0d8bed9a-c544-4760-8d81-d980626acfb3'),(77,2,NULL,3,1,'2019-03-11 18:19:00',NULL,NULL,'2019-12-20 16:18:13','2019-12-20 16:18:13','d5819829-7e34-4dfd-b8d8-d12249faa21d'),(78,2,NULL,3,1,'2019-03-11 18:21:00',NULL,NULL,'2019-12-20 16:18:15','2019-12-20 16:18:15','5ba19ff8-9a6e-4692-9a6f-089806136e53'),(79,2,NULL,3,1,'2019-03-11 18:19:00',NULL,NULL,'2019-12-20 16:18:17','2019-12-20 16:18:17','4841d1b9-bce0-4073-8281-da2f56c85bec'),(80,2,NULL,2,1,'2019-03-11 18:19:00',NULL,NULL,'2019-12-20 16:18:18','2019-12-20 16:18:19','ed4cf564-641e-447f-b525-8efa04bb8690'),(81,2,NULL,2,1,'2019-03-11 18:19:00',NULL,NULL,'2019-12-20 16:18:19','2019-12-20 16:18:20','19d72d3d-64d7-4a6d-9995-efbeaf0273fa'),(82,6,NULL,8,1,'2019-03-11 18:18:00',NULL,NULL,'2019-12-20 16:18:20','2019-12-20 16:18:20','f85302b7-a2ef-4496-893b-48233ef75461'),(84,8,NULL,10,1,'2019-03-11 18:17:00',NULL,NULL,'2019-12-20 16:18:22','2019-12-20 16:18:22','af8d55bb-7aa6-44f4-b071-86d1aef7ccb2'),(87,5,NULL,7,NULL,'2018-02-02 05:34:50',NULL,NULL,'2019-12-20 16:18:23','2019-12-20 16:18:23','5a28ee16-d2b0-4f2d-9635-34ad1c69d9aa'),(88,16,NULL,18,NULL,'2018-02-05 06:21:29',NULL,NULL,'2019-12-20 16:18:24','2019-12-20 16:18:24','e052d418-a306-4a86-8e2a-91b4fc4a3ab2'),(89,14,NULL,16,NULL,'2018-02-05 06:20:14',NULL,NULL,'2019-12-20 16:18:24','2019-12-20 16:18:24','22b9d3d8-79f5-4bae-bc94-1fc6c75ac648'),(90,15,NULL,17,NULL,'2018-02-05 06:20:40',NULL,NULL,'2019-12-20 16:18:25','2019-12-20 16:18:25','1d343f80-f25b-43b4-a3ad-f69fb22beb5c'),(91,12,NULL,14,NULL,'2018-02-04 23:03:59',NULL,NULL,'2019-12-20 16:18:25','2019-12-20 16:18:25','d057fa1f-a8be-43a4-a0df-937c3c31e810'),(92,12,NULL,14,NULL,'2018-02-04 23:03:59',NULL,NULL,'2019-12-20 16:18:26','2019-12-20 16:18:26','3ca6119b-2bbb-45e6-b5b5-7b2a61206a11'),(93,10,NULL,12,NULL,'2018-02-04 22:14:34',NULL,NULL,'2019-12-20 16:18:27','2019-12-20 16:18:27','69c97c55-aa26-45e4-a037-225a71d1deef'),(94,13,NULL,15,NULL,'2018-02-04 23:08:53',NULL,NULL,'2019-12-20 16:18:28','2019-12-20 16:18:28','3a516cb3-0085-4ec5-83c7-dd05b509d807'),(95,4,NULL,6,NULL,'2018-02-02 05:34:35',NULL,NULL,'2019-12-20 16:18:28','2019-12-20 16:18:28','f6182e0f-a4bd-46f2-a681-83f19eef332e'),(96,5,NULL,7,NULL,'2018-02-02 05:34:50',NULL,NULL,'2019-12-20 16:18:29','2019-12-20 16:18:29','82eb955f-9ce4-4d2b-9e49-48d4ed8cbd3f'),(97,5,NULL,7,NULL,'2018-02-02 05:34:50',NULL,NULL,'2019-12-20 16:18:29','2019-12-20 16:18:29','57f10639-2f55-44a5-932f-643df6fefe2f'),(98,5,NULL,7,NULL,'2018-02-02 05:34:50',NULL,NULL,'2019-12-20 16:18:30','2019-12-20 16:18:30','e523ab2e-8a05-4abf-b1ef-b57e87a5991d'),(99,3,NULL,5,NULL,'2018-02-02 05:31:09',NULL,NULL,'2019-12-20 16:18:31','2019-12-20 16:18:31','221088bb-5389-42b2-bc76-bb156acf9f34'),(105,4,NULL,6,NULL,'2018-02-02 05:34:35',NULL,NULL,'2019-12-20 16:18:34','2019-12-20 16:18:34','359ace50-25d8-4f62-b2c2-d52c518cf12c'),(106,4,NULL,6,NULL,'2018-02-02 05:34:35',NULL,NULL,'2019-12-20 16:18:34','2019-12-20 16:18:34','379c5542-23b3-4a87-b181-9b51b3cb8120'),(107,13,NULL,15,NULL,'2018-02-04 23:08:53',NULL,NULL,'2019-12-20 16:18:35','2019-12-20 16:18:35','02860193-9199-43e2-8658-259c767bf49f'),(108,13,NULL,15,NULL,'2018-02-04 23:08:53',NULL,NULL,'2019-12-20 16:18:36','2019-12-20 16:18:36','e9c4ec9d-bf65-49ac-9983-61bcacbc8530'),(109,10,NULL,12,NULL,'2018-02-04 22:14:34',NULL,NULL,'2019-12-20 16:18:37','2019-12-20 16:18:37','843f05e1-47c3-404f-ac5e-416cb424ad4f'),(110,10,NULL,12,NULL,'2018-02-04 22:14:34',NULL,NULL,'2019-12-20 16:18:38','2019-12-20 16:18:38','3dd0fc38-5edd-467d-abff-71b63d4db7da'),(111,12,NULL,14,NULL,'2018-02-04 23:03:59',NULL,NULL,'2019-12-20 16:18:38','2019-12-20 16:18:38','cf0e2b89-f8f5-4519-80e5-7d9437ad214f'),(112,15,NULL,17,NULL,'2018-02-05 06:20:40',NULL,NULL,'2019-12-20 16:18:39','2019-12-20 16:18:39','c43168b8-e33a-419b-b573-bbb490aa0ec2'),(113,15,NULL,17,NULL,'2018-02-05 06:20:40',NULL,NULL,'2019-12-20 16:18:39','2019-12-20 16:18:39','597b2ac0-5fab-45ad-9dd7-f9917d8d3cb0'),(114,14,NULL,16,NULL,'2018-02-05 06:20:14',NULL,NULL,'2019-12-20 16:18:39','2019-12-20 16:18:39','4bf8a57d-582c-4460-85c4-2ea3f778a5b3'),(115,14,NULL,16,NULL,'2018-02-05 06:20:14',NULL,NULL,'2019-12-20 16:18:40','2019-12-20 16:18:40','59b6a6d6-53ed-4857-99d3-153eed203961'),(116,16,NULL,18,NULL,'2018-02-05 06:21:29',NULL,NULL,'2019-12-20 16:18:40','2019-12-20 16:18:40','bfea6a06-8ef6-4dea-9bf7-6aee0c942eb7'),(117,16,NULL,18,NULL,'2018-02-05 06:21:29',NULL,NULL,'2019-12-20 16:18:40','2019-12-20 16:18:40','712d3a4d-8ce7-4b6e-8792-1d90735cedda'),(118,3,NULL,5,NULL,'2018-02-02 05:31:09',NULL,NULL,'2019-12-20 16:18:41','2019-12-20 16:18:41','83753991-ba16-458f-bb37-15e69bc0cbe5'),(124,3,NULL,5,NULL,'2018-02-02 05:31:09',NULL,NULL,'2019-12-20 16:18:44','2019-12-20 16:18:44','a2783f87-bdc5-4446-8b9a-4f4ca8c985f6'),(130,12,NULL,14,NULL,'2018-02-04 23:03:59',NULL,NULL,'2019-12-20 16:18:48','2019-12-20 16:18:48','8b7bb4a6-9f25-40ef-b18e-a3a32b3a395f'),(131,12,NULL,14,NULL,'2018-02-04 23:03:59',NULL,NULL,'2019-12-20 16:18:48','2019-12-20 16:18:48','997e7f39-d1b2-4d4c-b096-a55757b76d1e'),(132,3,NULL,5,NULL,'2018-02-02 05:31:09',NULL,NULL,'2019-12-20 16:18:49','2019-12-20 16:18:49','94e79067-fc10-43b3-8e65-d2b78f6c1577'),(138,3,NULL,5,NULL,'2018-02-02 05:31:09',NULL,NULL,'2019-12-20 16:18:51','2019-12-20 16:18:51','78586906-ce90-46eb-9d6a-4eb4a285a5ac');
/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entrydrafterrors`
--

DROP TABLE IF EXISTS `entrydrafterrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entrydrafterrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `draftId` int(11) DEFAULT NULL,
  `error` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entrydrafterrors_draftId_fk` (`draftId`),
  CONSTRAINT `entrydrafterrors_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `entrydrafts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrydrafterrors`
--

LOCK TABLES `entrydrafterrors` WRITE;
/*!40000 ALTER TABLE `entrydrafterrors` DISABLE KEYS */;
/*!40000 ALTER TABLE `entrydrafterrors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entrydrafts`
--

DROP TABLE IF EXISTS `entrydrafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entrydrafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text DEFAULT NULL,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrydrafts_sectionId_idx` (`sectionId`),
  KEY `entrydrafts_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entrydrafts_siteId_idx` (`siteId`),
  KEY `entrydrafts_creatorId_idx` (`creatorId`),
  CONSTRAINT `entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrydrafts`
--

LOCK TABLES `entrydrafts` WRITE;
/*!40000 ALTER TABLE `entrydrafts` DISABLE KEYS */;
/*!40000 ALTER TABLE `entrydrafts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entrytypes`
--

DROP TABLE IF EXISTS `entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT 1,
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `entrytypes_dateDeleted_idx` (`dateDeleted`),
  KEY `entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrytypes`
--

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;
INSERT INTO `entrytypes` VALUES (2,2,3,'Resource with Detail Page','resourceFile',1,'Title','',1,'2018-01-31 19:49:43','2019-03-11 19:59:21',NULL,'9de11a83-392f-4ebb-9d01-e5ebaf22cf18'),(3,2,4,'Direct Link','resourceLink',1,'Link Title','',2,'2018-01-31 19:51:47','2019-03-11 20:00:24',NULL,'437719cf-795d-42cf-8b92-2ea1224939b4'),(4,2,5,'Video','resourceVideo',1,'Title','',3,'2018-01-31 19:52:25','2019-03-11 19:57:45',NULL,'a30dc10d-322d-4159-b375-7566cebf3755'),(5,3,8,'Homepage','homepage',1,'Title','',1,'2018-02-02 05:31:09','2019-03-08 21:54:31',NULL,'969995e1-dbd5-42c5-917f-a13e492a5c83'),(6,4,9,'Error Page','errorPage',1,'Title','',1,'2018-02-02 05:34:35','2019-03-11 14:58:35',NULL,'181988f5-74b6-4bf7-8825-b5e458651ce9'),(7,5,10,'404 Page','notFoundPage',1,'Title','',1,'2018-02-02 05:34:50','2019-03-11 18:15:48',NULL,'754177a1-494c-4f11-806a-112af873ab1d'),(8,6,19,'News Article','newsArticle',1,'Title','',1,'2018-02-02 22:08:02','2019-03-11 21:07:48',NULL,'349bc9d5-448b-4314-a81e-d76e7cca8758'),(9,7,20,'Person','person',1,'Name',NULL,1,'2018-02-02 22:10:38','2018-02-04 22:07:57',NULL,'1eb9445b-5596-41c4-b25c-ec44e9a4ec0a'),(10,8,22,'Blog Article','blog',1,'Title',NULL,1,'2018-02-02 22:22:44','2018-02-02 22:23:45',NULL,'2bce713c-e1dd-4517-8bf0-60f2c1165bc3'),(11,9,23,'Event','event',1,'Title',NULL,1,'2018-02-04 22:10:01','2018-02-04 22:10:31',NULL,'f1e078e0-561e-47be-a5bb-1ad7b61ab109'),(12,10,24,'Contact Page','contact',1,'Title','',1,'2018-02-04 22:14:34','2019-03-11 14:58:26',NULL,'c9969320-6f22-4fd2-a0f8-0c16e95de058'),(13,11,25,'Landing Page','landingPage',1,'Title','',1,'2018-02-04 23:02:31','2019-03-11 18:14:53',NULL,'ca7b7e4c-25a6-449f-ad1d-bd7a08c52a99'),(14,12,26,'About Page','aboutPage',1,'Title','',1,'2018-02-04 23:03:59','2019-03-11 14:58:12',NULL,'2091741e-3916-401f-8b4c-00ee93c78914'),(15,13,27,'Privacy Page','privacyPage',1,'Title','',1,'2018-02-04 23:08:53','2019-03-11 14:59:01',NULL,'3e918fe0-05a0-4a21-88e8-4fe6125a5fae'),(16,14,28,'News & Events Page','newsEventsPage',1,'Title','',1,'2018-02-05 06:20:14','2019-03-11 18:09:50',NULL,'035617c5-1f35-490e-9216-fd539fee3802'),(17,15,29,'Resources Page','resourcesPage',1,'Title','',1,'2018-02-05 06:20:40','2019-03-11 18:09:53',NULL,'462c63db-f464-467b-ab60-114cf3cfa50a'),(18,16,30,'Blog Page','blogPage',1,'Title','',1,'2018-02-05 06:21:29','2019-03-11 18:09:47',NULL,'f4b21aa5-34c8-486b-9a4a-2283e15f1b00'),(19,17,31,'About Page','aboutPage',1,'Title','',1,'2018-02-05 19:14:26','2019-03-12 15:53:47',NULL,'7e27ed3f-7f88-4e7a-a754-8a958f75b010'),(20,18,32,'Leadership Page','leadershipPage',1,'Title','{section.name|raw}',1,'2019-03-11 21:31:27','2019-03-11 21:32:33',NULL,'6ac1334c-5153-47fa-94c2-6a80dfeecc9b'),(21,19,33,'Shared Block','sharedBlock',1,'Title','',1,'2019-03-12 15:53:08','2019-03-12 15:54:08',NULL,'5ca24464-6fc5-4ec1-b72f-bd44b3d7f72f'),(22,20,35,'Service Unavailable Page','serviceUnavailablePage',1,'Title','{section.name|raw}',1,'2019-10-25 18:39:21','2019-10-25 19:20:47',NULL,'2ddfd638-9959-4fb7-877b-10b6424503bc');
/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entryversionerrors`
--

DROP TABLE IF EXISTS `entryversionerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entryversionerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `versionId` int(11) DEFAULT NULL,
  `error` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entryversionerrors_versionId_fk` (`versionId`),
  CONSTRAINT `entryversionerrors_versionId_fk` FOREIGN KEY (`versionId`) REFERENCES `entryversions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entryversionerrors`
--

LOCK TABLES `entryversionerrors` WRITE;
/*!40000 ALTER TABLE `entryversionerrors` DISABLE KEYS */;
/*!40000 ALTER TABLE `entryversionerrors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entryversions`
--

DROP TABLE IF EXISTS `entryversions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entryversions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `siteId` int(11) NOT NULL,
  `num` smallint(6) unsigned NOT NULL,
  `notes` text DEFAULT NULL,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entryversions_sectionId_idx` (`sectionId`),
  KEY `entryversions_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entryversions_siteId_idx` (`siteId`),
  KEY `entryversions_creatorId_idx` (`creatorId`),
  CONSTRAINT `entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entryversions`
--

LOCK TABLES `entryversions` WRITE;
/*!40000 ALTER TABLE `entryversions` DISABLE KEYS */;
/*!40000 ALTER TABLE `entryversions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedme_feeds`
--

DROP TABLE IF EXISTS `feedme_feeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feedme_feeds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `feedUrl` text NOT NULL,
  `feedType` varchar(255) DEFAULT NULL,
  `primaryElement` varchar(255) DEFAULT NULL,
  `elementType` varchar(255) NOT NULL,
  `elementGroup` text DEFAULT NULL,
  `siteId` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `duplicateHandle` text DEFAULT NULL,
  `paginationNode` text DEFAULT NULL,
  `fieldMapping` text DEFAULT NULL,
  `fieldUnique` text DEFAULT NULL,
  `passkey` varchar(255) NOT NULL,
  `backup` tinyint(1) NOT NULL DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedme_feeds`
--

LOCK TABLES `feedme_feeds` WRITE;
/*!40000 ALTER TABLE `feedme_feeds` DISABLE KEYS */;
/*!40000 ALTER TABLE `feedme_feeds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldgroups`
--

DROP TABLE IF EXISTS `fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldgroups`
--

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;
INSERT INTO `fieldgroups` VALUES (1,'Common','2017-11-29 20:51:54','2017-11-29 20:51:54','c4593c73-7ed0-4694-9aa8-fa73bd8c1b1b'),(2,'Resources','2018-01-31 19:42:02','2018-01-31 19:42:02','bbb87adb-e632-4579-b223-79796ba4ff1a'),(3,'SEO','2018-02-02 06:44:37','2018-02-02 06:44:37','4cd84b5c-0162-4148-a588-37b2fcc1da0a'),(4,'People','2018-02-02 22:02:33','2018-02-02 22:02:33','28bbb761-2bca-4754-ba9e-c0bfe22f4496'),(5,'News','2018-02-02 22:05:28','2018-02-02 22:05:28','6533045f-a95c-45a5-a67a-c8da4cec0d5d'),(6,'Blog','2018-02-02 22:09:13','2018-02-02 22:09:13','b2e9d0fb-ba4b-4b23-9fcf-459ad68c0ea9'),(7,'Events','2018-02-04 22:08:27','2018-02-04 22:08:27','61009477-6ca8-4122-b871-b3b715eec012'),(8,'Homepage','2019-03-08 21:44:53','2019-03-08 21:44:53','1cd65752-f86f-48a3-9924-90919c9ca915');
/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldlayoutfields`
--

DROP TABLE IF EXISTS `fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=858 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldlayoutfields`
--

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;
INSERT INTO `fieldlayoutfields` VALUES (172,22,49,54,0,1,'2018-02-02 22:23:45','2018-02-02 22:23:45','2472ef4e-93b9-434c-9d74-443865f02bc9'),(173,22,49,56,0,2,'2018-02-02 22:23:45','2018-02-02 22:23:45','ce8b1e40-018c-4c27-bcce-8dc956e2596a'),(174,22,49,55,0,3,'2018-02-02 22:23:45','2018-02-02 22:23:45','c4d5f505-9cbd-4007-95d5-144f006c8b50'),(175,22,49,58,0,4,'2018-02-02 22:23:45','2018-02-02 22:23:45','226b2eb5-f94c-4c06-9ca4-30c7bd82fa44'),(176,22,49,57,0,5,'2018-02-02 22:23:45','2018-02-02 22:23:45','d4e7daf7-9590-4e4e-baf7-536c59b6fc7c'),(177,22,49,11,1,6,'2018-02-02 22:23:45','2018-02-02 22:23:45','0be457c0-fabf-4e96-8978-cc76608ce643'),(178,22,50,39,0,1,'2018-02-02 22:23:45','2018-02-02 22:23:45','1a566aac-a5c7-415a-8d92-40310aa5ebf6'),(179,22,50,40,0,2,'2018-02-02 22:23:45','2018-02-02 22:23:45','e848cd3e-b2ec-492e-a885-fe30aa46cce1'),(180,22,50,41,0,3,'2018-02-02 22:23:45','2018-02-02 22:23:45','48476983-4047-492c-a873-9f5b98010d39'),(181,22,50,42,0,4,'2018-02-02 22:23:45','2018-02-02 22:23:45','43b0d9fa-be6b-48a0-aee5-a1b148202c21'),(182,22,50,43,0,5,'2018-02-02 22:23:45','2018-02-02 22:23:45','328923a4-bd47-45e8-ba0f-651e75424e35'),(183,22,50,44,0,6,'2018-02-02 22:23:45','2018-02-02 22:23:45','aef67749-c19c-4688-acbf-75c6f84ca2c4'),(184,22,50,45,0,7,'2018-02-02 22:23:45','2018-02-02 22:23:45','04b9cb0b-96a2-42e6-9bf5-8f0aa697bce7'),(271,20,68,48,0,1,'2018-02-04 22:07:57','2018-02-04 22:07:57','a00962a1-f116-4886-83e8-bf4251fe456c'),(272,20,68,49,0,2,'2018-02-04 22:07:57','2018-02-04 22:07:57','58f7f7da-846e-452f-9426-a60ab636717d'),(273,20,68,50,1,3,'2018-02-04 22:07:57','2018-02-04 22:07:57','946eb649-ea85-461e-a128-dd6747c14705'),(274,20,68,51,1,4,'2018-02-04 22:07:57','2018-02-04 22:07:57','d7bbe499-de5a-478c-bf2e-641300d5eb9a'),(275,20,69,39,0,1,'2018-02-04 22:07:57','2018-02-04 22:07:57','4f701908-da54-4b6d-b4aa-3913a044dd69'),(276,20,69,40,0,2,'2018-02-04 22:07:57','2018-02-04 22:07:57','bbdd18d0-b020-4275-8a83-617ec57cc4a3'),(277,20,69,41,0,3,'2018-02-04 22:07:57','2018-02-04 22:07:57','76ecacf1-fc3c-4210-8efb-f1d57ee31a2c'),(278,20,69,42,0,4,'2018-02-04 22:07:57','2018-02-04 22:07:57','01a43bf0-7e07-4562-8ddb-70ba8fef5f8d'),(279,20,69,43,0,5,'2018-02-04 22:07:57','2018-02-04 22:07:57','3709bba1-1068-46e3-9be5-ad27cc8041d0'),(280,20,69,44,0,6,'2018-02-04 22:07:57','2018-02-04 22:07:57','24e74eba-977a-4e99-8438-b342e591e395'),(281,20,69,45,0,7,'2018-02-04 22:07:57','2018-02-04 22:07:57','7dc11647-c790-4397-8e7e-e9afd7ba8210'),(282,23,70,59,1,1,'2018-02-04 22:10:31','2018-02-04 22:10:31','ed553185-dcb6-48df-ba71-054e9e029fda'),(283,23,70,60,0,2,'2018-02-04 22:10:31','2018-02-04 22:10:31','4f3f740a-dd1a-46ea-bfbd-cfa3fa77b6fd'),(284,23,70,61,0,3,'2018-02-04 22:10:31','2018-02-04 22:10:31','6e513b97-923f-4a50-b05f-87ae0131042e'),(285,23,70,11,0,4,'2018-02-04 22:10:31','2018-02-04 22:10:31','3cc69fda-d3e2-4c08-97fc-39afee1dbe7c'),(286,23,71,39,0,1,'2018-02-04 22:10:31','2018-02-04 22:10:31','de1dd77a-9466-4344-9bed-d4f7088796e2'),(287,23,71,40,0,2,'2018-02-04 22:10:31','2018-02-04 22:10:31','4624c121-6fd6-4bbe-a653-6fdc407e5191'),(288,23,71,41,0,3,'2018-02-04 22:10:31','2018-02-04 22:10:31','95ad86c5-b713-4d02-a454-0e7e5474b17b'),(289,23,71,42,0,4,'2018-02-04 22:10:31','2018-02-04 22:10:31','d3a6648f-e68d-465a-bcb5-ca18401f32c2'),(290,23,71,43,0,5,'2018-02-04 22:10:31','2018-02-04 22:10:31','a915d6be-fb34-44cf-9618-aeadfe7943ec'),(291,23,71,44,0,6,'2018-02-04 22:10:31','2018-02-04 22:10:31','3062bab0-cb93-4399-ae64-a104491b0ac1'),(292,23,71,45,0,7,'2018-02-04 22:10:31','2018-02-04 22:10:31','f17e4d90-032b-47ab-9d23-bd613fad911d'),(476,8,120,67,0,2,'2019-03-08 21:54:31','2019-03-08 21:54:31','aac44821-a0dc-4c69-bdaf-896e7a1ba753'),(477,8,120,66,0,1,'2019-03-08 21:54:31','2019-03-08 21:54:31','6a3c2298-6d57-472d-bbad-8bce36a7dddd'),(478,8,120,11,0,3,'2019-03-08 21:54:31','2019-03-08 21:54:31','1ab2a47b-5c9d-48e9-ad39-ad05a35fccf9'),(479,8,121,43,0,5,'2019-03-08 21:54:31','2019-03-08 21:54:31','3e351439-470b-4e9c-afd7-a6d973091acd'),(480,8,121,39,0,1,'2019-03-08 21:54:31','2019-03-08 21:54:31','4be60c11-2bfc-4da5-aba9-00045c26da20'),(481,8,121,40,0,2,'2019-03-08 21:54:31','2019-03-08 21:54:31','1cc620da-d9d5-4adb-9aba-c036dbdff829'),(482,8,121,42,0,4,'2019-03-08 21:54:31','2019-03-08 21:54:31','a521c21b-3cc1-4c05-b97e-e3d3c6b580f0'),(483,8,121,44,0,6,'2019-03-08 21:54:31','2019-03-08 21:54:31','cd6dc31e-5e72-4af5-a27d-eeb249d99b3e'),(484,8,121,45,0,7,'2019-03-08 21:54:31','2019-03-08 21:54:31','2933d9e2-6886-4e5d-9162-579e6945d670'),(485,8,121,41,0,3,'2019-03-08 21:54:31','2019-03-08 21:54:31','d07464df-704c-4d99-b048-0159e67d3b31'),(486,26,122,67,0,2,'2019-03-11 14:58:12','2019-03-11 14:58:12','8614faae-d442-489d-ae39-fc3dd58d0b0c'),(487,26,122,66,0,1,'2019-03-11 14:58:12','2019-03-11 14:58:12','129737c8-04e2-418b-9529-ac11ed8919e9'),(488,26,122,11,0,3,'2019-03-11 14:58:12','2019-03-11 14:58:12','8a9cc325-c1ec-4be7-b882-388784e1e1c4'),(489,26,123,43,0,5,'2019-03-11 14:58:12','2019-03-11 14:58:12','cf455094-3783-45e5-8be1-a73de9e01583'),(490,26,123,39,0,1,'2019-03-11 14:58:12','2019-03-11 14:58:12','609a81e0-9285-4100-8a51-0a021568dee3'),(491,26,123,40,0,2,'2019-03-11 14:58:12','2019-03-11 14:58:12','9538207e-4fe2-49a5-a427-0bd44012cfd7'),(492,26,123,42,0,4,'2019-03-11 14:58:12','2019-03-11 14:58:12','97f1abde-729a-405b-be47-e28d38e0c151'),(493,26,123,44,0,6,'2019-03-11 14:58:12','2019-03-11 14:58:12','09dd193c-be69-4d98-b5f0-c62c27183de5'),(494,26,123,45,0,7,'2019-03-11 14:58:12','2019-03-11 14:58:12','38dc3091-5efa-4b7d-9669-d0425ee0f031'),(495,26,123,41,0,3,'2019-03-11 14:58:12','2019-03-11 14:58:12','ce4b2fcd-6f69-4560-9a51-cd7f5542e1e7'),(506,24,126,67,0,2,'2019-03-11 14:58:26','2019-03-11 14:58:26','9308cde5-28bc-41a2-b450-94cab066615b'),(507,24,126,66,0,1,'2019-03-11 14:58:26','2019-03-11 14:58:26','b7c034da-7b65-4622-b626-ec01b8f25c96'),(508,24,126,11,0,3,'2019-03-11 14:58:26','2019-03-11 14:58:26','d12d33e8-b25d-4286-8382-5c85caa1dc4d'),(509,24,127,43,0,5,'2019-03-11 14:58:26','2019-03-11 14:58:26','82f94b9d-a6d7-46d8-9705-9da23f441ddc'),(510,24,127,39,0,1,'2019-03-11 14:58:26','2019-03-11 14:58:26','518c24b6-4123-4562-a105-3b96cf92c1f9'),(511,24,127,40,0,2,'2019-03-11 14:58:26','2019-03-11 14:58:26','a598f096-2a8f-4b48-948c-1c0cd2c9ece1'),(512,24,127,42,0,4,'2019-03-11 14:58:26','2019-03-11 14:58:26','fb5a1380-acff-4ebf-a390-ea05eeae5f13'),(513,24,127,44,0,6,'2019-03-11 14:58:26','2019-03-11 14:58:26','0f97048d-07de-4e12-9882-dd717af97734'),(514,24,127,45,0,7,'2019-03-11 14:58:26','2019-03-11 14:58:26','8d6ed06c-00eb-4a15-aed1-e2f905ffdb45'),(515,24,127,41,0,3,'2019-03-11 14:58:26','2019-03-11 14:58:26','63b4c0e9-8325-426b-897a-2f255c836159'),(516,9,128,67,0,2,'2019-03-11 14:58:35','2019-03-11 14:58:35','785a3eb3-e834-4632-b3eb-0e969737a605'),(517,9,128,66,0,1,'2019-03-11 14:58:35','2019-03-11 14:58:35','ffcd8a22-5836-4af1-8d64-fd930b4b5318'),(518,9,128,11,0,3,'2019-03-11 14:58:35','2019-03-11 14:58:35','e15ecf1d-dd80-46c1-9c1f-82a2146522c9'),(519,9,129,43,0,5,'2019-03-11 14:58:35','2019-03-11 14:58:35','b3612979-914b-4e1c-b2c7-3bdbc57f27df'),(520,9,129,39,0,1,'2019-03-11 14:58:35','2019-03-11 14:58:35','411ac056-a0ce-4009-8d71-96cc22bb76ef'),(521,9,129,40,0,2,'2019-03-11 14:58:35','2019-03-11 14:58:35','fbcebe35-e1b5-4635-87d6-e15373ab0508'),(522,9,129,42,0,4,'2019-03-11 14:58:35','2019-03-11 14:58:35','b047b5e6-f973-4384-b3c8-4b2e36a9a8bc'),(523,9,129,44,0,6,'2019-03-11 14:58:35','2019-03-11 14:58:35','5cdf674b-259c-40fd-adfc-d9c6b7ff49cf'),(524,9,129,45,0,7,'2019-03-11 14:58:35','2019-03-11 14:58:35','d2563ff6-737c-498c-a9bf-80ea0ff092ba'),(525,9,129,41,0,3,'2019-03-11 14:58:35','2019-03-11 14:58:35','8641c4f6-5efb-47c9-8ef7-f6aca8c90fd6'),(546,27,134,67,0,2,'2019-03-11 14:59:01','2019-03-11 14:59:01','fb359e73-6ce4-4dfb-981b-f894903ba3fe'),(547,27,134,66,0,1,'2019-03-11 14:59:01','2019-03-11 14:59:01','efef9583-6906-4c91-8666-dcf798a8f8bb'),(548,27,134,11,0,3,'2019-03-11 14:59:01','2019-03-11 14:59:01','0525f045-9e41-424c-9efc-a4cc20b31095'),(549,27,135,43,0,5,'2019-03-11 14:59:01','2019-03-11 14:59:01','db8ce302-ccae-466d-8a59-0eb6865fbf95'),(550,27,135,39,0,1,'2019-03-11 14:59:01','2019-03-11 14:59:01','b843339d-3b80-43f7-9734-ce2aaa1001ff'),(551,27,135,40,0,2,'2019-03-11 14:59:01','2019-03-11 14:59:01','7b0dc783-24e1-4697-810e-0cbc3f89b0cc'),(552,27,135,42,0,4,'2019-03-11 14:59:01','2019-03-11 14:59:01','3ee4bc30-2f19-4162-8dc2-a3af56b99289'),(553,27,135,44,0,6,'2019-03-11 14:59:01','2019-03-11 14:59:01','bd96c0a1-dc9e-4efd-a7ea-55b3b0ce269b'),(554,27,135,45,0,7,'2019-03-11 14:59:01','2019-03-11 14:59:01','253c9941-c5de-4a0c-8252-fd292c771de9'),(555,27,135,41,0,3,'2019-03-11 14:59:01','2019-03-11 14:59:01','eab138cb-4d37-4e3c-b9db-6e3fe55d27c2'),(577,30,140,67,0,2,'2019-03-11 18:09:47','2019-03-11 18:09:47','666216e8-aef5-432d-8c22-0cec0dc5dff1'),(578,30,140,66,0,1,'2019-03-11 18:09:47','2019-03-11 18:09:47','3a4bc5c8-0290-4071-9a58-24eba20c7574'),(579,30,141,43,0,5,'2019-03-11 18:09:47','2019-03-11 18:09:47','c16b443d-4790-4aeb-b041-5d2db0ab3f98'),(580,30,141,39,0,1,'2019-03-11 18:09:47','2019-03-11 18:09:47','f1b0954e-2e43-41f6-b7c0-0383dd2177f7'),(581,30,141,40,0,2,'2019-03-11 18:09:47','2019-03-11 18:09:47','1e5e2483-b3a6-4953-816a-ab58ecb6ec76'),(582,30,141,42,0,4,'2019-03-11 18:09:47','2019-03-11 18:09:47','5fcb6313-29b2-4f80-a528-11d3d3c9f5b8'),(583,30,141,44,0,6,'2019-03-11 18:09:47','2019-03-11 18:09:47','aa9c89ca-2d78-410f-8591-d44bc21ee42d'),(584,30,141,45,0,7,'2019-03-11 18:09:47','2019-03-11 18:09:47','c0ba86f0-97d9-4abf-9c08-be028c424090'),(585,30,141,41,0,3,'2019-03-11 18:09:47','2019-03-11 18:09:47','052e53f2-3542-4248-8c07-e5025ed439b6'),(586,28,142,67,0,2,'2019-03-11 18:09:50','2019-03-11 18:09:50','36df47b5-771d-4453-ad93-ba5e3bd92359'),(587,28,142,66,0,1,'2019-03-11 18:09:50','2019-03-11 18:09:50','3e6e6a95-be48-4f33-a8ff-a1c215d3ad77'),(588,28,143,43,0,5,'2019-03-11 18:09:50','2019-03-11 18:09:50','b4a98fbc-1690-4c8d-a307-1af2e37a2c1e'),(589,28,143,39,0,1,'2019-03-11 18:09:50','2019-03-11 18:09:50','16f0e22a-bfa8-434c-a451-d56020bf3039'),(590,28,143,40,0,2,'2019-03-11 18:09:50','2019-03-11 18:09:50','dcba3ca2-12bc-42fd-877e-a17070327f61'),(591,28,143,42,0,4,'2019-03-11 18:09:50','2019-03-11 18:09:50','b694a969-4582-45f6-903e-d6bea1f937aa'),(592,28,143,44,0,6,'2019-03-11 18:09:50','2019-03-11 18:09:50','c7b66186-b099-46b4-b904-59ef9cdcb044'),(593,28,143,45,0,7,'2019-03-11 18:09:50','2019-03-11 18:09:50','98ab2cf2-9deb-4de0-850c-f1241473370e'),(594,28,143,41,0,3,'2019-03-11 18:09:50','2019-03-11 18:09:50','6a76cf48-4394-404b-b656-6513fe989ca7'),(595,29,144,67,0,2,'2019-03-11 18:09:53','2019-03-11 18:09:53','8e86c7e1-7219-4187-8b1b-de477cbb8ebd'),(596,29,144,66,0,1,'2019-03-11 18:09:53','2019-03-11 18:09:53','3697c505-b71e-45e8-bd5f-0b76aa784d9e'),(597,29,145,43,0,5,'2019-03-11 18:09:53','2019-03-11 18:09:53','e9c07f03-fd01-416f-b11a-27ae3707cee5'),(598,29,145,39,0,1,'2019-03-11 18:09:53','2019-03-11 18:09:53','63ec147b-039a-4d94-bb53-dc5c5e5f8a02'),(599,29,145,40,0,2,'2019-03-11 18:09:53','2019-03-11 18:09:53','c84f3ed2-f7e4-4506-9dde-3c772afd40ef'),(600,29,145,42,0,4,'2019-03-11 18:09:53','2019-03-11 18:09:53','3ce49af9-fd2a-45a0-a515-cc08a77bb0ae'),(601,29,145,44,0,6,'2019-03-11 18:09:53','2019-03-11 18:09:53','aab131ac-5357-4bef-b866-cd6a5727d7e6'),(602,29,145,45,0,7,'2019-03-11 18:09:53','2019-03-11 18:09:53','57f7d9bc-3308-4c5b-9d4a-a43d24d46c69'),(603,29,145,41,0,3,'2019-03-11 18:09:53','2019-03-11 18:09:53','a94d61ae-baa1-4c13-85c4-cdf5e144ffbe'),(614,25,148,67,0,2,'2019-03-11 18:14:52','2019-03-11 18:14:52','279146d5-6351-41c4-b575-03d38219b256'),(615,25,148,66,0,1,'2019-03-11 18:14:52','2019-03-11 18:14:52','13e1a723-10db-4480-aa65-3604c7ac7d5a'),(616,25,148,11,0,3,'2019-03-11 18:14:52','2019-03-11 18:14:52','20f8e57e-d1a6-4962-bf04-677814cdd294'),(617,25,149,43,0,5,'2019-03-11 18:14:52','2019-03-11 18:14:52','b05b5d47-9c64-4100-950a-832d01a063d8'),(618,25,149,39,0,1,'2019-03-11 18:14:52','2019-03-11 18:14:52','602ab3f4-9e93-4be2-8443-faba9866df1e'),(619,25,149,40,0,2,'2019-03-11 18:14:52','2019-03-11 18:14:52','e4785896-4625-409c-a10c-4bce40a00d79'),(620,25,149,42,0,4,'2019-03-11 18:14:53','2019-03-11 18:14:53','1cb2a113-1b24-452f-ad79-e5480116cb11'),(621,25,149,44,0,6,'2019-03-11 18:14:53','2019-03-11 18:14:53','0b835848-51cb-439f-9a1a-1733bf90de3d'),(622,25,149,45,0,7,'2019-03-11 18:14:53','2019-03-11 18:14:53','a78e291b-5e5a-4e7e-9949-8ffda39fabf0'),(623,25,149,41,0,3,'2019-03-11 18:14:53','2019-03-11 18:14:53','0bec0731-b64e-4ac0-8f7e-645c8f8d9abf'),(634,10,152,67,0,2,'2019-03-11 18:15:48','2019-03-11 18:15:48','f358e43a-410c-437e-9d58-3b33615c6f35'),(635,10,152,66,0,1,'2019-03-11 18:15:48','2019-03-11 18:15:48','d0dbe4b0-19f4-4386-9dc0-a1e8ced0ec9d'),(636,10,152,11,0,3,'2019-03-11 18:15:48','2019-03-11 18:15:48','cfc0f727-0424-48ca-8ebc-0db300ee1818'),(637,10,153,43,0,5,'2019-03-11 18:15:48','2019-03-11 18:15:48','00b224ca-cb73-47c3-85d3-1c99193d4012'),(638,10,153,39,0,1,'2019-03-11 18:15:48','2019-03-11 18:15:48','825487c8-f65e-4bbf-9290-bb2747732903'),(639,10,153,40,0,2,'2019-03-11 18:15:48','2019-03-11 18:15:48','52f71376-db0d-45f6-8dac-6616ee7eb29c'),(640,10,153,42,0,4,'2019-03-11 18:15:48','2019-03-11 18:15:48','7248c1bc-8880-4de0-ba82-9138cfb8c3af'),(641,10,153,44,0,6,'2019-03-11 18:15:48','2019-03-11 18:15:48','308fa29d-b1ec-4040-b488-592b3e191d99'),(642,10,153,45,0,7,'2019-03-11 18:15:48','2019-03-11 18:15:48','2b48c0ca-dc19-4022-a511-ab5ca754fd1e'),(643,10,153,41,0,3,'2019-03-11 18:15:48','2019-03-11 18:15:48','e1ead852-0482-4f3b-82ab-a49508412ea1'),(697,5,162,9,0,6,'2019-03-11 19:57:45','2019-03-11 19:57:45','a7cfa529-539b-465c-9e5f-e6d93022a5d1'),(698,5,162,4,0,5,'2019-03-11 19:57:45','2019-03-11 19:57:45','7a89c27b-f40f-4974-a1da-6d5ce081281a'),(699,5,162,11,0,7,'2019-03-11 19:57:45','2019-03-11 19:57:45','5ede83d0-5bfb-499b-bcbb-850e70756d3d'),(700,5,162,5,0,3,'2019-03-11 19:57:45','2019-03-11 19:57:45','f0b2c8b8-ad11-4b79-866c-f22ee418af72'),(701,5,162,8,0,2,'2019-03-11 19:57:45','2019-03-11 19:57:45','dea168c1-08cd-4048-84ad-24fcf5d9197c'),(702,5,162,10,0,4,'2019-03-11 19:57:45','2019-03-11 19:57:45','ef8626c2-e87f-4582-bb12-eb4ed6b085d6'),(703,5,162,69,0,1,'2019-03-11 19:57:45','2019-03-11 19:57:45','eaa6f298-c2d2-466b-8d25-fe3606ccf41b'),(704,5,163,43,0,5,'2019-03-11 19:57:45','2019-03-11 19:57:45','f637c165-2698-4c7d-a148-94f80ccdbb7e'),(705,5,163,39,0,1,'2019-03-11 19:57:45','2019-03-11 19:57:45','f71fa4e3-6b0c-4f5f-b37e-69cffc25fc3a'),(706,5,163,40,0,2,'2019-03-11 19:57:45','2019-03-11 19:57:45','6e32a732-a0e6-4a05-98ce-f3abf0ba71e7'),(707,5,163,42,0,4,'2019-03-11 19:57:45','2019-03-11 19:57:45','d4e1210d-2c0b-45b7-8f35-2847bbf889c4'),(708,5,163,44,0,6,'2019-03-11 19:57:45','2019-03-11 19:57:45','e142d878-d61a-47c2-aeb2-3a90b84b6869'),(709,5,163,45,0,7,'2019-03-11 19:57:45','2019-03-11 19:57:45','533b5e75-bf59-401f-8144-3b7710069dad'),(710,5,163,41,0,3,'2019-03-11 19:57:45','2019-03-11 19:57:45','1015238b-bd56-48f1-9f31-8fe5441285d1'),(751,3,170,4,0,6,'2019-03-11 19:59:21','2019-03-11 19:59:21','2326aece-e00c-4a5f-bd76-26c24e31f161'),(752,3,170,11,0,7,'2019-03-11 19:59:21','2019-03-11 19:59:21','90699455-d8a2-45fc-954d-79858c2b73e6'),(753,3,170,5,0,4,'2019-03-11 19:59:21','2019-03-11 19:59:21','e86333b2-ed3c-4b10-bcf4-7a73de1a5dc1'),(754,3,170,8,0,2,'2019-03-11 19:59:21','2019-03-11 19:59:21','705474b5-6d43-4cec-90af-6d233e75476d'),(755,3,170,6,0,3,'2019-03-11 19:59:21','2019-03-11 19:59:21','0a5a4c03-06aa-43a0-93f4-77f369ddd9a8'),(756,3,170,10,0,5,'2019-03-11 19:59:21','2019-03-11 19:59:21','53970070-96a7-4cae-ab69-08d3ee91ac5d'),(757,3,170,69,0,1,'2019-03-11 19:59:21','2019-03-11 19:59:21','ab7ce360-9ff7-4c40-b250-ad0781c11c22'),(758,3,171,43,0,5,'2019-03-11 19:59:21','2019-03-11 19:59:21','69c2121b-3516-4fcb-aa87-aa996af9300f'),(759,3,171,39,0,1,'2019-03-11 19:59:21','2019-03-11 19:59:21','5b347bfc-1da1-4f30-95dc-cff2e1b77d49'),(760,3,171,40,0,2,'2019-03-11 19:59:21','2019-03-11 19:59:21','f530308e-ce57-4abb-96e1-483ea2feb916'),(761,3,171,42,0,4,'2019-03-11 19:59:21','2019-03-11 19:59:21','9a323843-992f-4662-853f-e3945ad94ee9'),(762,3,171,44,0,6,'2019-03-11 19:59:21','2019-03-11 19:59:21','7a54d02c-4aa2-464d-8d11-4c00f45e284e'),(763,3,171,45,0,7,'2019-03-11 19:59:21','2019-03-11 19:59:21','c4950049-d9f8-4ce0-b4a2-5766d69370a0'),(764,3,171,41,0,3,'2019-03-11 19:59:21','2019-03-11 19:59:21','59e6762a-feb7-43f2-9ad1-fae7aaffed4c'),(765,4,173,4,0,5,'2019-03-11 20:00:24','2019-03-11 20:00:24','355cf32c-294b-450d-8926-354d0f1f4782'),(766,4,173,5,0,3,'2019-03-11 20:00:24','2019-03-11 20:00:24','6f4d3e38-3fae-4605-9058-8506c7dfd466'),(767,4,173,6,0,2,'2019-03-11 20:00:24','2019-03-11 20:00:24','7b19d86f-f3f9-4679-9ce5-195bb4eaeb98'),(768,4,173,10,0,4,'2019-03-11 20:00:24','2019-03-11 20:00:24','4c5e59b8-a7ff-41a2-8cfd-0a83d87da8d6'),(769,4,173,69,0,1,'2019-03-11 20:00:24','2019-03-11 20:00:24','80110d36-a933-443b-9999-42faafe4852d'),(770,4,174,43,0,5,'2019-03-11 20:00:24','2019-03-11 20:00:24','801bf6f1-5e70-41ff-9aaa-6cab9dd59534'),(771,4,174,39,0,1,'2019-03-11 20:00:24','2019-03-11 20:00:24','cd4aa63c-efe1-49b0-b6c2-778488ad242f'),(772,4,174,40,0,2,'2019-03-11 20:00:24','2019-03-11 20:00:24','e58fbdc0-90d4-4763-a2a8-050e84764e93'),(773,4,174,42,0,4,'2019-03-11 20:00:24','2019-03-11 20:00:24','bc7c741c-dcbd-4db6-a581-b475ac53af6f'),(774,4,174,44,0,6,'2019-03-11 20:00:24','2019-03-11 20:00:24','0e8de6db-2b7f-4481-8bbb-dba0352055e0'),(775,4,174,45,0,7,'2019-03-11 20:00:24','2019-03-11 20:00:24','124c5da0-ef90-4db5-88c6-3e87765fa30e'),(776,4,174,41,0,3,'2019-03-11 20:00:24','2019-03-11 20:00:24','89f09040-45c2-4da0-9db9-72ef32c76132'),(777,19,175,52,0,1,'2019-03-11 21:07:48','2019-03-11 21:07:48','5126a52e-7882-4914-b4a4-b76e5c37f238'),(778,19,175,11,0,3,'2019-03-11 21:07:48','2019-03-11 21:07:48','f708193f-9cbe-4b76-9aeb-ad2fc04829e5'),(779,19,175,61,0,2,'2019-03-11 21:07:48','2019-03-11 21:07:48','b440ee01-0cb1-486b-908c-adf1d0637d0d'),(780,19,176,43,0,5,'2019-03-11 21:07:48','2019-03-11 21:07:48','b58b3e2a-ec46-4b5f-bc94-0167af0d84c7'),(781,19,176,39,0,1,'2019-03-11 21:07:48','2019-03-11 21:07:48','1af5d946-9a15-4173-aab7-c97326445c11'),(782,19,176,40,0,2,'2019-03-11 21:07:48','2019-03-11 21:07:48','77d6a896-7bd7-49ca-944d-16cc159506be'),(783,19,176,42,0,4,'2019-03-11 21:07:48','2019-03-11 21:07:48','03d9908b-9bd5-4cc9-80b6-d4cdcec7485e'),(784,19,176,44,0,6,'2019-03-11 21:07:48','2019-03-11 21:07:48','e4f62591-3786-4add-b4e5-4a5257a34f26'),(785,19,176,45,0,7,'2019-03-11 21:07:48','2019-03-11 21:07:48','8ad48c79-02c9-4c40-9ada-e6f94d23751e'),(786,19,176,41,0,3,'2019-03-11 21:07:48','2019-03-11 21:07:48','1cebbc3f-9682-424c-b0e4-0367694a0a7c'),(796,32,179,67,0,2,'2019-03-11 21:32:33','2019-03-11 21:32:33','29758901-67a4-462b-907c-b38645a986b6'),(797,32,179,66,0,1,'2019-03-11 21:32:33','2019-03-11 21:32:33','3165cb06-27a6-4622-b1c8-8a4f69a8d34a'),(798,32,180,43,0,5,'2019-03-11 21:32:33','2019-03-11 21:32:33','a183942c-aa3a-4f07-8f01-de2521051de5'),(799,32,180,39,0,1,'2019-03-11 21:32:33','2019-03-11 21:32:33','d7aacd3a-7340-4770-9789-38218555f686'),(800,32,180,40,0,2,'2019-03-11 21:32:33','2019-03-11 21:32:33','d863d13f-caa8-4b02-b3b9-8e06c26f7523'),(801,32,180,42,0,4,'2019-03-11 21:32:33','2019-03-11 21:32:33','cd662d3f-ae6a-44a5-bc05-54e9c1f265bb'),(802,32,180,44,0,6,'2019-03-11 21:32:33','2019-03-11 21:32:33','93a76a15-6046-4b8e-977f-582a4546c004'),(803,32,180,45,0,7,'2019-03-11 21:32:33','2019-03-11 21:32:33','f6636eae-b441-4f6c-a4cf-1f4ba7286205'),(804,32,180,41,0,3,'2019-03-11 21:32:33','2019-03-11 21:32:33','5a28f030-f3c8-462e-8ffe-2ddddd665fb5'),(805,31,181,11,0,1,'2019-03-12 15:53:47','2019-03-12 15:53:47','167ccc73-22f8-4cf9-95de-b80271c1f45a'),(806,31,182,43,0,5,'2019-03-12 15:53:47','2019-03-12 15:53:47','2d4da96a-79d0-46b2-b01b-b6974ea3467c'),(807,31,182,39,0,1,'2019-03-12 15:53:47','2019-03-12 15:53:47','879061f6-8097-4d21-b5b7-2b97a597ca3c'),(808,31,182,40,0,2,'2019-03-12 15:53:47','2019-03-12 15:53:47','ef18cded-81ce-4766-9df5-ae7842bd1988'),(809,31,182,42,0,4,'2019-03-12 15:53:47','2019-03-12 15:53:47','fde8f4e9-f31a-4474-9606-de3a607f7017'),(810,31,182,44,0,6,'2019-03-12 15:53:47','2019-03-12 15:53:47','1598a623-e5b1-44fa-9c35-1b0f378a54ea'),(811,31,182,45,0,7,'2019-03-12 15:53:47','2019-03-12 15:53:47','d59c1cc6-4398-40a7-b9a6-9ee49b943f41'),(812,31,182,41,0,3,'2019-03-12 15:53:47','2019-03-12 15:53:47','4d1632e6-e93f-4fce-87e5-2c985181e0c7'),(813,33,183,11,1,1,'2019-03-12 15:54:08','2019-03-12 15:54:08','d697da19-fd02-4530-b87e-861e412e520d'),(814,11,184,15,1,2,'2019-03-12 15:59:23','2019-03-12 15:59:23','edcf56d6-56c8-484a-8ca8-73fb73a0293d'),(815,11,184,14,0,1,'2019-03-12 15:59:23','2019-03-12 15:59:23','9e9921e0-7b17-4c06-a806-235b62aa0b7a'),(816,12,185,17,1,2,'2019-03-12 15:59:23','2019-03-12 15:59:23','6a796cac-15c9-4da1-b172-fdf150ab5919'),(817,12,185,18,1,3,'2019-03-12 15:59:23','2019-03-12 15:59:23','6297803a-aa29-4bac-ae19-f9af51303ab0'),(818,12,185,16,0,1,'2019-03-12 15:59:23','2019-03-12 15:59:23','39eaff2d-367a-4049-8e5e-e103a8a93d7e'),(819,14,186,23,0,1,'2019-03-12 15:59:24','2019-03-12 15:59:24','d4a43670-4f7a-4eb1-811d-8c48d3f081cd'),(820,14,186,46,1,3,'2019-03-12 15:59:24','2019-03-12 15:59:24','cba1ab37-f155-49e5-8a85-97927ec6ad3f'),(821,14,186,24,1,2,'2019-03-12 15:59:24','2019-03-12 15:59:24','3a3193b1-e69b-47ac-8f3c-7f326e4e0410'),(822,14,186,25,1,4,'2019-03-12 15:59:24','2019-03-12 15:59:24','09c03e97-2511-4f99-a8cc-0762df602fc4'),(823,15,187,27,1,2,'2019-03-12 15:59:24','2019-03-12 15:59:24','e881c21f-fde0-484c-9f66-22c6907d6e46'),(824,15,187,47,0,3,'2019-03-12 15:59:24','2019-03-12 15:59:24','8ea13979-19cb-4ee7-98c1-122952558058'),(825,15,187,26,0,1,'2019-03-12 15:59:24','2019-03-12 15:59:24','8c997606-52d7-4830-aef7-8c5ecf527216'),(826,15,187,28,1,4,'2019-03-12 15:59:24','2019-03-12 15:59:24','87c819f9-f7f7-4a25-a467-af2c4321c1ad'),(827,16,188,31,1,3,'2019-03-12 15:59:24','2019-03-12 15:59:24','b34cf444-096a-4d94-bf41-ae6796dcb00c'),(828,16,188,32,0,4,'2019-03-12 15:59:24','2019-03-12 15:59:24','f80ddf5c-fc9b-4de4-91e1-92ca008741d3'),(829,16,188,29,0,1,'2019-03-12 15:59:24','2019-03-12 15:59:24','110d493f-fabd-46e5-95a5-7630ecd1fc60'),(830,16,188,30,1,2,'2019-03-12 15:59:24','2019-03-12 15:59:24','8cc49192-ffd9-4300-80da-4956f685015b'),(831,17,189,33,0,1,'2019-03-12 15:59:25','2019-03-12 15:59:25','f68bb6a9-12ac-41dd-b80a-a8b19227edc7'),(832,17,189,34,1,2,'2019-03-12 15:59:25','2019-03-12 15:59:25','086776bc-d8a0-4c90-b7ca-7d762f1f380f'),(833,18,190,38,1,3,'2019-03-12 15:59:25','2019-03-12 15:59:25','45f70ecd-244a-47ca-9cec-a11d4e29689b'),(834,18,190,36,0,2,'2019-03-12 15:59:25','2019-03-12 15:59:25','0e5edf55-648a-4270-96c5-51398bbbae58'),(835,18,190,35,0,1,'2019-03-12 15:59:25','2019-03-12 15:59:25','2bc770ba-26ee-4f6c-9119-ce6ec2d09cf5'),(836,34,191,70,1,1,'2019-03-12 15:59:25','2019-03-12 15:59:25','bb08ae55-4573-4c6d-b847-62366f1c68a0'),(847,35,194,67,0,2,'2019-10-25 19:20:47','2019-10-25 19:20:47','f8ecb34d-1357-4680-8e07-69335b3b1460'),(848,35,194,66,0,1,'2019-10-25 19:20:47','2019-10-25 19:20:47','b0ab9d86-0198-47d5-8434-e34854603b89'),(849,35,194,11,0,3,'2019-10-25 19:20:47','2019-10-25 19:20:47','2257b608-eed2-41a5-a8fa-5d31814feca6'),(850,35,195,43,0,5,'2019-10-25 19:20:47','2019-10-25 19:20:47','d44cf7cf-b094-4dd3-9946-019222531896'),(851,35,195,39,0,1,'2019-10-25 19:20:47','2019-10-25 19:20:47','13b61944-560e-4e13-9211-a5acfb7ec8ea'),(852,35,195,40,0,2,'2019-10-25 19:20:47','2019-10-25 19:20:47','723ef266-b3aa-4134-b0f6-e083dfa83e06'),(853,35,195,42,0,4,'2019-10-25 19:20:47','2019-10-25 19:20:47','41d7ba5d-08a5-4078-8e35-095df164e339'),(854,35,195,44,0,6,'2019-10-25 19:20:47','2019-10-25 19:20:47','8a911aa4-5b64-4c16-bcac-3bf6c5cef98a'),(855,35,195,45,0,7,'2019-10-25 19:20:47','2019-10-25 19:20:47','6078c5cf-f875-4b19-acd8-013bee7193ce'),(856,35,195,41,0,3,'2019-10-25 19:20:47','2019-10-25 19:20:47','87db3340-bf7e-493b-9a53-8057e0979915'),(857,2,196,71,0,1,'2019-12-23 15:24:44','2019-12-23 15:24:44','cfa0c40c-ea00-49d1-be87-68c386dc8df7');
/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldlayouts`
--

DROP TABLE IF EXISTS `fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_type_idx` (`type`),
  KEY `fieldlayouts_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldlayouts`
--

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;
INSERT INTO `fieldlayouts` VALUES (2,'craft\\elements\\Asset','2018-01-16 22:11:14','2018-01-16 22:11:14',NULL,'de763855-6652-40e7-a14a-311417ca2d41'),(3,'craft\\elements\\Entry','2018-01-31 19:49:43','2019-03-11 19:59:21',NULL,'d076b5fb-86ae-4ca5-9a46-a9146d0aa724'),(4,'craft\\elements\\Entry','2018-01-31 19:51:47','2019-03-11 20:00:24',NULL,'d20835c1-2f59-4ee5-b54d-788dc9d4205d'),(5,'craft\\elements\\Entry','2018-01-31 19:52:25','2019-03-11 19:57:45',NULL,'2d846778-5b1a-417f-974c-9cf135d5493e'),(6,'craft\\elements\\Category','2018-01-31 19:53:07','2019-03-11 19:59:48',NULL,'6890171e-e900-455f-9fa7-5bdf37b57e09'),(8,'craft\\elements\\Entry','2018-02-02 05:31:09','2019-03-08 21:54:31',NULL,'e20267cc-14f4-404a-8584-47f2d9632f91'),(9,'craft\\elements\\Entry','2018-02-02 05:34:35','2019-03-11 14:58:35',NULL,'8de5acbb-9542-411b-a05d-37bfd2da5cae'),(10,'craft\\elements\\Entry','2018-02-02 05:34:50','2019-03-11 18:15:48',NULL,'4e5979ac-1357-4a9f-82a0-518c1c980b52'),(11,'craft\\elements\\MatrixBlock','2018-02-02 06:41:11','2019-03-12 15:59:23',NULL,'fe2c269e-89ba-4c9d-ac5f-0f838b2feb0a'),(12,'craft\\elements\\MatrixBlock','2018-02-02 06:41:11','2019-03-12 15:59:23',NULL,'49e26187-fbb5-4dfa-bb12-84da586a1fa8'),(14,'craft\\elements\\MatrixBlock','2018-02-02 06:41:12','2019-03-12 15:59:24',NULL,'096b5368-187c-4cd6-b902-b1b49cf655c7'),(15,'craft\\elements\\MatrixBlock','2018-02-02 06:41:12','2019-03-12 15:59:24',NULL,'6fc702e7-b87f-4bdb-ac4e-32313f70cfc6'),(16,'craft\\elements\\MatrixBlock','2018-02-02 06:41:12','2019-03-12 15:59:24',NULL,'6cb110a9-f0e7-44b2-9c12-d87b89912a8f'),(17,'craft\\elements\\MatrixBlock','2018-02-02 06:41:12','2019-03-12 15:59:25',NULL,'1c5f2520-7bd1-40f4-a03e-5acbf1cf588e'),(18,'craft\\elements\\MatrixBlock','2018-02-02 06:41:12','2019-03-12 15:59:25',NULL,'3cb15008-c34e-4c01-a542-0a152034242a'),(19,'craft\\elements\\Entry','2018-02-02 22:08:02','2019-03-11 21:07:48',NULL,'ac958f47-de51-41e3-984f-6805af639de4'),(20,'craft\\elements\\Entry','2018-02-02 22:10:38','2018-02-04 22:07:57',NULL,'1a8ec962-5e1a-4f63-9419-4a15ee59deea'),(21,'craft\\elements\\Category','2018-02-02 22:17:15','2018-02-02 22:17:15',NULL,'4c2cbd8a-4b55-44af-b01d-e7c4a67e9af7'),(22,'craft\\elements\\Entry','2018-02-02 22:22:44','2018-02-02 22:23:45',NULL,'e744b3df-827b-46ec-b7e0-fe4738064897'),(23,'craft\\elements\\Entry','2018-02-04 22:10:01','2018-02-04 22:10:31',NULL,'86bcae7c-d21c-4701-ac07-b3365f0ec05a'),(24,'craft\\elements\\Entry','2018-02-04 22:14:34','2019-03-11 14:58:26',NULL,'9cf50bf1-ba63-4ee8-a245-f5178587bf11'),(25,'craft\\elements\\Entry','2018-02-04 23:02:31','2019-03-11 18:14:52',NULL,'b6393a40-7fb4-4baa-b883-52d02bac97ee'),(26,'craft\\elements\\Entry','2018-02-04 23:03:59','2019-03-11 14:58:12',NULL,'fcafbf82-4515-43af-a24a-7f217a658441'),(27,'craft\\elements\\Entry','2018-02-04 23:08:53','2019-03-11 14:59:01',NULL,'ea944f54-0a0b-4e11-8d1c-ea74cbdd2e20'),(28,'craft\\elements\\Entry','2018-02-05 06:20:14','2019-03-11 18:09:50',NULL,'53a19581-50e6-4ccd-8371-183e0b95c440'),(29,'craft\\elements\\Entry','2018-02-05 06:20:40','2019-03-11 18:09:53',NULL,'7e0a24cd-8e6d-48c0-8404-10b93f7f1df3'),(30,'craft\\elements\\Entry','2018-02-05 06:21:29','2019-03-11 18:09:47',NULL,'0552ae81-bc51-4d11-b923-4b4dd7e4a932'),(31,'craft\\elements\\Entry','2018-02-05 19:14:26','2019-03-12 15:53:47',NULL,'526d5de5-d527-4c83-a427-cd04ea5d1700'),(32,'craft\\elements\\Entry','2019-03-11 21:32:25','2019-03-11 21:32:33',NULL,'ccf7885d-403b-4127-abd4-94aff255ea11'),(33,'craft\\elements\\Entry','2019-03-12 15:54:08','2019-03-12 15:54:08',NULL,'26a6743b-375d-4250-b3e1-7e399520fb34'),(34,'craft\\elements\\MatrixBlock','2019-03-12 15:59:25','2019-03-12 15:59:25',NULL,'1326cf27-56cb-47cf-b4ce-a4f127cd00ef'),(35,'craft\\elements\\Entry','2019-10-25 18:40:20','2019-10-25 19:20:47',NULL,'645a65f2-ba3e-489e-a506-53888b688a58');
/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldlayouttabs`
--

DROP TABLE IF EXISTS `fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=197 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldlayouttabs`
--

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;
INSERT INTO `fieldlayouttabs` VALUES (49,22,'Blog',1,'2018-02-02 22:23:45','2018-02-02 22:23:45','0aa33455-4a0d-4230-bc78-d7f775c9b2ed'),(50,22,'SEO',2,'2018-02-02 22:23:45','2018-02-02 22:23:45','3a616b9d-5838-4026-b697-ddc3e2c36812'),(68,20,'People',1,'2018-02-04 22:07:57','2018-02-04 22:07:57','af47a996-3f0f-4fdf-bdcb-16b9b45d88e7'),(69,20,'SEO',2,'2018-02-04 22:07:57','2018-02-04 22:07:57','6038b184-86fb-4867-bff2-cb9519e98c56'),(70,23,'Events',1,'2018-02-04 22:10:31','2018-02-04 22:10:31','1699a166-0126-4137-bc77-97c2b0150c36'),(71,23,'SEO',2,'2018-02-04 22:10:31','2018-02-04 22:10:31','e4bef85c-3b19-4642-ba45-32d41c8cbf32'),(120,8,'Homepage',1,'2019-03-08 21:54:31','2019-03-08 21:54:31','8df14e87-ce25-4977-b404-4b89ee9d052b'),(121,8,'SEO',2,'2019-03-08 21:54:31','2019-03-08 21:54:31','6b00ce72-3b8f-45b3-84e6-67bf1edac32c'),(122,26,'About Page',1,'2019-03-11 14:58:12','2019-03-11 14:58:12','4c8c8563-aa1b-4203-aa47-e4a83c66bb7d'),(123,26,'SEO',2,'2019-03-11 14:58:12','2019-03-11 14:58:12','a1863996-9a90-4f48-b886-2fff060fa46f'),(126,24,'Contact Page',1,'2019-03-11 14:58:26','2019-03-11 14:58:26','7a21d4d8-38c1-4e7d-be12-d9775bb24825'),(127,24,'SEO',2,'2019-03-11 14:58:26','2019-03-11 14:58:26','97d1f8d9-6f04-4080-86b9-91791c49e3e0'),(128,9,'Error Page',1,'2019-03-11 14:58:35','2019-03-11 14:58:35','a8a37a39-673d-45db-8335-5ec2a619759f'),(129,9,'SEO',2,'2019-03-11 14:58:35','2019-03-11 14:58:35','e6427adb-e47b-48b1-ac3b-8d6c221b8df2'),(134,27,'Privacy Page',1,'2019-03-11 14:59:01','2019-03-11 14:59:01','b1637b77-dea5-48fb-8c55-e6a06b29b4fd'),(135,27,'SEO',2,'2019-03-11 14:59:01','2019-03-11 14:59:01','4d70e728-3b3c-453d-af96-80be8271e8e8'),(140,30,'Blog Page',1,'2019-03-11 18:09:47','2019-03-11 18:09:47','79d99d24-831c-410f-a41f-a53a091c9776'),(141,30,'SEO',2,'2019-03-11 18:09:47','2019-03-11 18:09:47','c3be7a38-a363-4575-ab14-6b69ba8fc131'),(142,28,'News & Events Page',1,'2019-03-11 18:09:50','2019-03-11 18:09:50','aa0f40e3-5f9d-4e97-844a-54476c381b20'),(143,28,'SEO',2,'2019-03-11 18:09:50','2019-03-11 18:09:50','79a1cbf7-a360-4acc-a02e-bed344effcc0'),(144,29,'Resources Page',1,'2019-03-11 18:09:53','2019-03-11 18:09:53','b947a6a6-aad9-4042-8b9b-f3178a18829c'),(145,29,'SEO',2,'2019-03-11 18:09:53','2019-03-11 18:09:53','84d2799e-3c58-42c0-99e9-208e9609c8ff'),(148,25,'Landing Pages',1,'2019-03-11 18:14:52','2019-03-11 18:14:52','61115b05-5ce3-4a3b-b8c6-12d3808e879c'),(149,25,'SEO',2,'2019-03-11 18:14:52','2019-03-11 18:14:52','5984d7d8-35af-4812-8673-f11169803999'),(152,10,'Page Not Found',1,'2019-03-11 18:15:48','2019-03-11 18:15:48','68eb52c6-bb17-45fd-9d67-44c36c373871'),(153,10,'SEO',2,'2019-03-11 18:15:48','2019-03-11 18:15:48','bdcc4638-b21b-4f76-9377-ff585819745e'),(162,5,'Resources',1,'2019-03-11 19:57:45','2019-03-11 19:57:45','0a5f4c5a-19e5-4423-8704-9dfe36781529'),(163,5,'SEO',2,'2019-03-11 19:57:45','2019-03-11 19:57:45','79c8e826-ada7-45f8-ae00-d580379ec786'),(170,3,'Resources',1,'2019-03-11 19:59:21','2019-03-11 19:59:21','5c0cc4b7-ab8e-45b9-adcc-bdeea263f6bb'),(171,3,'SEO',2,'2019-03-11 19:59:21','2019-03-11 19:59:21','33082d4e-519b-42eb-bd50-ba034bd90a95'),(172,6,'Resource Category',1,'2019-03-11 19:59:48','2019-03-11 19:59:48','d3478cee-0b31-4978-ad07-688bd00c8179'),(173,4,'Resources',1,'2019-03-11 20:00:24','2019-03-11 20:00:24','927a6fbf-0059-4880-ada6-001cf641810c'),(174,4,'SEO',2,'2019-03-11 20:00:24','2019-03-11 20:00:24','4707a070-9d70-49e8-b2b8-433daf0d8053'),(175,19,'News',1,'2019-03-11 21:07:48','2019-03-11 21:07:48','0076dbb3-2a51-4bd8-addb-34bbf835c9db'),(176,19,'SEO',2,'2019-03-11 21:07:48','2019-03-11 21:07:48','1206867a-407a-4a1b-bace-07b51209aa1b'),(179,32,'Leadership',1,'2019-03-11 21:32:33','2019-03-11 21:32:33','e9336b9f-8313-4ef5-b874-236631befc11'),(180,32,'SEO',2,'2019-03-11 21:32:33','2019-03-11 21:32:33','2922257b-fc45-4b78-91bc-e6111781ecf1'),(181,31,'Page',1,'2019-03-12 15:53:47','2019-03-12 15:53:47','ee662135-8c56-406c-9537-5bf70d7f680c'),(182,31,'SEO',2,'2019-03-12 15:53:47','2019-03-12 15:53:47','99f13ffd-696f-454b-858e-a7e8f5abe1cd'),(183,33,'Shared Block',1,'2019-03-12 15:54:08','2019-03-12 15:54:08','ff5b4a44-ba31-4333-9eb1-bc07b47b2ad1'),(184,11,'Content',1,'2019-03-12 15:59:23','2019-03-12 15:59:23','eb1bb7e4-d183-4938-a974-98ac0bc5a6e3'),(185,12,'Content',1,'2019-03-12 15:59:23','2019-03-12 15:59:23','8c610b78-367d-463d-8a31-9eea30acee5a'),(186,14,'Content',1,'2019-03-12 15:59:24','2019-03-12 15:59:24','d84c9e2d-b06e-412a-b16d-7f148d6e09fe'),(187,15,'Content',1,'2019-03-12 15:59:24','2019-03-12 15:59:24','3713bf72-dce1-46aa-9bf3-972a9e1e7288'),(188,16,'Content',1,'2019-03-12 15:59:24','2019-03-12 15:59:24','6ed5245b-5bd9-44e1-ba81-3599df5f2259'),(189,17,'Content',1,'2019-03-12 15:59:25','2019-03-12 15:59:25','41a3223c-8982-4acf-a0ef-cfd78ecf4c01'),(190,18,'Content',1,'2019-03-12 15:59:25','2019-03-12 15:59:25','da558620-2776-4989-9c70-a717ebdbdec1'),(191,34,'Content',1,'2019-03-12 15:59:25','2019-03-12 15:59:25','4ab181f2-7c37-4d29-aa1f-7a481df732a0'),(194,35,'Service Unavailable Page',1,'2019-10-25 19:20:47','2019-10-25 19:20:47','6c6a91e2-8b2b-4933-a65b-e71e6956815c'),(195,35,'SEO',2,'2019-10-25 19:20:47','2019-10-25 19:20:47','79e13898-d899-413c-8738-2587b0d1f3bd'),(196,2,'Content',1,'2019-12-23 15:24:44','2019-12-23 15:24:44','d6a1718e-a766-4ca6-9552-8888a6544fc3');
/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fields`
--

DROP TABLE IF EXISTS `fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text DEFAULT NULL,
  `searchable` tinyint(1) NOT NULL DEFAULT 1,
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
INSERT INTO `fields` VALUES (4,2,'Featured Image','resourceFeaturedImage','global','This image will be shown in lists and other places this resource is featured.',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"volume:09773b73-a304-4513-84fd-c4d5d4dd953a\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"volume:09773b73-a304-4513-84fd-c4d5d4dd953a\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"\",\"allowedKinds\":null,\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"Add a featured image\",\"localizeRelations\":false,\"validateRelatedElements\":\"\"}','2018-01-31 19:42:47','2019-12-20 16:49:50','0f8aa3f7-de9e-4beb-a7e9-e98793b3b60e'),(5,2,'Resource Categories','resourceCategories','global','',1,'site',NULL,'craft\\fields\\Categories','{\"branchLimit\":\"\",\"sources\":\"*\",\"source\":\"group:d9b26dd3-8815-474a-b2d1-df10d1da9ea4\",\"targetSiteId\":null,\"viewMode\":null,\"limit\":null,\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-01-31 19:43:33','2018-01-31 19:54:18','86444c22-bd97-4a40-9136-f5613c95ba48'),(6,2,'Resource','resourceUrl','global','URL for this resource.',1,'none',NULL,'typedlinkfield\\fields\\LinkField','{\"allowCustomText\":\"1\",\"allowTarget\":\"\",\"allowedLinkNames\":{\"3\":\"entry\",\"9\":\"url\"},\"autoNoReferrer\":\"\",\"defaultLinkName\":\"asset\",\"defaultText\":\"\",\"enableAriaLabel\":\"\",\"enableTitle\":\"\",\"typeSettings\":{\"asset\":{\"allowCustomQuery\":\"\",\"sources\":\"*\"},\"category\":{\"allowCustomQuery\":\"\",\"sources\":\"*\"},\"custom\":{\"allowAliases\":\"\",\"disableValidation\":\"\"},\"email\":{\"allowAliases\":\"\",\"disableValidation\":\"\"},\"entry\":{\"allowCustomQuery\":\"\",\"sources\":\"*\"},\"site\":{\"sites\":\"*\"},\"tel\":{\"allowAliases\":\"\",\"disableValidation\":\"\"},\"url\":{\"allowAliases\":\"\",\"disableValidation\":\"\"},\"user\":{\"allowCustomQuery\":\"\",\"sources\":\"*\"}}}','2018-01-31 19:44:49','2019-03-11 19:59:36','93e2b1ce-6b60-40c8-ad40-4b1c92d2ecd1'),(8,2,'Call to Action','resourceCTA','global','Text shown on the Call to Action to download this file.',1,'none',NULL,'craft\\fields\\PlainText','{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2018-01-31 19:46:09','2019-03-11 19:57:04','8db154b4-31aa-4a46-bd7e-e040f96b91a8'),(9,2,'Embed','resourceEmbed','global','Paste code to embed a video or other widget here.',1,'none',NULL,'luwes\\codemirror\\fields\\CodeMirrorField','[]','2018-01-31 19:48:46','2018-01-31 19:54:51','0610a849-e9bc-455c-86d5-ee8175b2ae9a'),(10,2,'Resource Date','resourceDate','global','',1,'none',NULL,'craft\\fields\\Date','{\"showDate\":true,\"showTime\":false,\"minuteIncrement\":\"30\"}','2018-01-31 19:49:25','2018-01-31 19:49:25','d5e98a9a-c478-4cf5-8c85-1083950e2e9f'),(11,1,'Content Designer','designedContent','global','Add one or more blocks of content and choose the layout or design you\'d like that content to use.',1,'site',NULL,'craft\\fields\\Matrix','{\"contentTable\":\"{{%matrixcontent_designedcontent}}\",\"localizeBlocks\":false,\"maxBlocks\":\"\",\"minBlocks\":\"\"}','2018-01-31 19:58:30','2019-03-12 15:59:22','7ccca481-afc6-4d2d-a691-46d51885c73e'),(14,NULL,'Section Title','sectionTitle','matrixBlockType:ddfe72db-cc91-496e-a097-1be94045f971','Optional title for this section.',1,'none',NULL,'craft\\fields\\PlainText','{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2018-02-02 06:41:11','2019-03-12 15:59:23','f4709cc7-103f-4722-860c-463eb0524b7b'),(15,NULL,'Content','blockContent','matrixBlockType:ddfe72db-cc91-496e-a097-1be94045f971','',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Standard.json\",\"removeInlineStyles\":\"1\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\"}','2018-02-02 06:41:11','2019-12-20 16:16:02','8cf354bc-58ad-42e1-aeb4-f6439b839750'),(16,NULL,'Section Title','sectionTitle','matrixBlockType:dc575719-2de8-473b-9872-9e294da811a2','Optional title for this section.',1,'none',NULL,'craft\\fields\\PlainText','{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2018-02-02 06:41:11','2019-03-12 15:59:23','a52f1e8a-cba5-455a-ab66-c739b9463856'),(17,NULL,'Left Content','leftContent','matrixBlockType:dc575719-2de8-473b-9872-9e294da811a2','',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Standard.json\",\"removeInlineStyles\":\"1\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\"}','2018-02-02 06:41:11','2019-12-20 16:16:02','562f7fa1-cbca-4b54-afad-7d44b1be171a'),(18,NULL,'Right Content','rightContent','matrixBlockType:dc575719-2de8-473b-9872-9e294da811a2','',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Standard.json\",\"removeInlineStyles\":\"1\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\"}','2018-02-02 06:41:11','2019-12-20 16:16:02','670d63fe-1da6-4a38-b355-941b9c53c5d7'),(23,NULL,'Section Title','sectionTitle','matrixBlockType:318e27c6-9622-4e58-9013-b8731641271f','Optional title for this section.',1,'none',NULL,'craft\\fields\\PlainText','{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2018-02-02 06:41:12','2019-03-12 15:59:23','44cce794-ef87-4267-b50d-b4234ba0bd59'),(24,NULL,'Image','image','matrixBlockType:318e27c6-9622-4e58-9013-b8731641271f','',1,'site',NULL,'craft\\fields\\Assets','{\"allowedKinds\":null,\"defaultUploadLocationSource\":\"volume:09773b73-a304-4513-84fd-c4d5d4dd953a\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"\",\"selectionLabel\":\"Choose an image\",\"singleUploadLocationSource\":\"volume:09773b73-a304-4513-84fd-c4d5d4dd953a\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":\"\",\"viewMode\":\"large\"}','2018-02-02 06:41:12','2019-03-12 15:59:23','7a63a845-8a3f-4576-948f-5e1699226882'),(25,NULL,'Content','blockContent','matrixBlockType:318e27c6-9622-4e58-9013-b8731641271f','Content to accompany this image.',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Standard.json\",\"removeInlineStyles\":\"1\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\"}','2018-02-02 06:41:12','2019-12-20 16:16:02','f01c690c-38f2-4d42-8123-2f1ef7ab7a1e'),(26,NULL,'Section Title','sectionTitle','matrixBlockType:c5c9e5cd-cbe8-4b48-b85e-2dcccae569ba','Optional title for this section.',1,'none',NULL,'craft\\fields\\PlainText','{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2018-02-02 06:41:12','2019-03-12 15:59:24','c1bad40b-bf3e-410f-9d20-499eeff520bf'),(27,NULL,'Video or Embed Code','videoOrEmbedCode','matrixBlockType:c5c9e5cd-cbe8-4b48-b85e-2dcccae569ba','Raw code for this video or embed. Be careful!',1,'none',NULL,'luwes\\codemirror\\fields\\CodeMirrorField','{\"mode\":\"gfm\"}','2018-02-02 06:41:12','2019-03-12 15:59:24','8526fc89-e8e9-4565-bdf0-a16ed9a6bc69'),(28,NULL,'Content','blockContent','matrixBlockType:c5c9e5cd-cbe8-4b48-b85e-2dcccae569ba','Content to accompany the video.',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Standard.json\",\"removeInlineStyles\":\"1\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\"}','2018-02-02 06:41:12','2019-12-20 16:16:02','f085c9a4-9812-4550-a6ac-84dfb0c4459d'),(29,NULL,'Section Title','sectionTitle','matrixBlockType:12dbddde-14fb-4b79-98fe-6c9bee0e3de8','Optional title for this section.',1,'none',NULL,'craft\\fields\\PlainText','{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2018-02-02 06:41:12','2019-03-12 15:59:24','c04d3133-756c-44d2-ae47-41f5946dddaf'),(30,NULL,'Quote','quote','matrixBlockType:12dbddde-14fb-4b79-98fe-6c9bee0e3de8','',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Standard.json\",\"removeInlineStyles\":\"1\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\"}','2018-02-02 06:41:12','2019-12-20 16:16:02','c5eb763d-fb5a-4f00-8fc2-74e9b242860b'),(31,NULL,'Person','person','matrixBlockType:12dbddde-14fb-4b79-98fe-6c9bee0e3de8','',1,'none',NULL,'craft\\fields\\PlainText','{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2018-02-02 06:41:12','2019-03-12 15:59:24','832bda63-d7a5-494e-a960-dbc6d4f71755'),(32,NULL,'Job Title','jobTitle','matrixBlockType:12dbddde-14fb-4b79-98fe-6c9bee0e3de8','Optional job title for this person.',1,'none',NULL,'craft\\fields\\PlainText','{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2018-02-02 06:41:12','2019-03-12 15:59:24','8b129965-072e-4380-bd83-2cc75fe7c989'),(33,NULL,'Section Title','sectionTitle','matrixBlockType:7f264ef3-9650-4cb3-9de7-cdc442a98a4d','Optional title for this section.',1,'none',NULL,'craft\\fields\\PlainText','{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2018-02-02 06:41:12','2019-03-12 15:59:24','3ebface3-3651-4864-b86f-2eaa76ff7b82'),(34,NULL,'HTML Widget or Embed','embed','matrixBlockType:7f264ef3-9650-4cb3-9de7-cdc442a98a4d','Raw code for this widget or embed. Be careful!',1,'none',NULL,'luwes\\codemirror\\fields\\CodeMirrorField','{\"mode\":\"gfm\"}','2018-02-02 06:41:12','2019-03-12 15:59:25','fd5e975b-61c7-46ca-9927-12fcb7d04fcd'),(35,NULL,'Section Title','sectionTitle','matrixBlockType:edc14065-98d5-402c-a1ed-a745b252ada4','Optional title for this section.',1,'none',NULL,'craft\\fields\\PlainText','{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2018-02-02 06:41:12','2019-03-12 15:59:25','85c7e535-dbcd-4e5d-af41-3bf0b93d5c89'),(36,NULL,'Content','blockContent','matrixBlockType:edc14065-98d5-402c-a1ed-a745b252ada4','Optional content displayed next to this Call to Action.',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Standard.json\",\"removeInlineStyles\":\"1\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\"}','2018-02-02 06:41:12','2019-12-20 16:16:02','24bcd6a1-3fa6-4839-940a-af27d389740b'),(38,NULL,'Call to Action','cta','matrixBlockType:edc14065-98d5-402c-a1ed-a745b252ada4','This is the link and label for the Call to Action button itself. If you don\'t specify link text, it will default to \"Learn More\".',1,'none',NULL,'typedlinkfield\\fields\\LinkField','{\"allowCustomText\":\"1\",\"allowTarget\":\"\",\"allowedLinkNames\":\"*\",\"autoNoReferrer\":\"\",\"defaultLinkName\":\"asset\",\"defaultText\":\"Learn More\",\"enableAriaLabel\":\"\",\"enableTitle\":\"\",\"typeSettings\":{\"asset\":{\"allowCustomQuery\":\"\",\"sources\":\"*\"},\"category\":{\"allowCustomQuery\":\"\",\"sources\":\"*\"},\"custom\":{\"allowAliases\":\"\",\"disableValidation\":\"\"},\"email\":{\"allowAliases\":\"\",\"disableValidation\":\"\"},\"entry\":{\"allowCustomQuery\":\"\",\"sources\":\"*\"},\"site\":{\"sites\":\"*\"},\"tel\":{\"allowAliases\":\"\",\"disableValidation\":\"\"},\"url\":{\"allowAliases\":\"\",\"disableValidation\":\"\"},\"user\":{\"allowCustomQuery\":\"\",\"sources\":\"*\"}}}','2018-02-02 06:41:12','2019-03-12 15:59:25','245fe7e9-d7f5-4de8-8cb6-0ed50edddffb'),(39,3,'HTML Title Override','htmlTitleOverride','global','If provided, this field will override the TITLE tag for this landing page or the detail page for this entry. Title tags are often truncated around 60 characters, so when possible, try to keep them under that length.',1,'none',NULL,'craft\\fields\\PlainText','{\"charLimit\":\"155\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2018-02-02 06:46:17','2019-03-20 19:55:22','27247eb3-ce02-4776-a57d-c34c35c19127'),(40,3,'Meta Description','metaDescription','global','If provided, this field will be used as the meta description for this landing page or the detail page for this entry. It is better to leave this field blank if you don\'t have specific content for this page or entry.',1,'none',NULL,'craft\\fields\\PlainText','{\"charLimit\":\"300\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2018-02-02 06:46:35','2019-03-20 19:58:02','71853a8b-b74d-4320-83d5-b8ef585bc335'),(41,3,'Open Graph Title','openGraphTitle','global','If provided, this field will be used as the Open Graph title for this landing page or the detail page for this entry.',1,'none',NULL,'craft\\fields\\PlainText','{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2018-02-02 06:46:44','2019-03-20 19:57:19','e72e6691-b2c5-41b9-b75e-56b6a7200933'),(42,3,'Open Graph Description','openGraphDescription','global','If provided, this field will be used as the Open Graph description for this landing page or the detail page for this entry.',1,'none',NULL,'craft\\fields\\PlainText','{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2018-02-02 06:46:51','2019-03-20 19:56:17','b1abef14-c4df-4e03-adf6-740fbfae5ddf'),(43,3,'Open Graph Image','openGraphImage','global','If provided, this image will show up when shared on social media. A landscape image at 1200x630 pixels works best.',1,'site',NULL,'craft\\fields\\Assets','{\"allowedKinds\":null,\"defaultUploadLocationSource\":\"volume:09773b73-a304-4513-84fd-c4d5d4dd953a\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"\",\"selectionLabel\":\"Choose an image\",\"singleUploadLocationSource\":\"volume:09773b73-a304-4513-84fd-c4d5d4dd953a\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":\"\",\"viewMode\":\"large\"}','2018-02-02 06:47:10','2019-04-25 18:09:07','0ba5cfaa-93ea-41f9-8b0b-46c048b5b209'),(44,3,'Additional Header Code','headerCode','global','Provide any relevant meta tags, Open Graph tags, or Javascript to be placed on in the page\'s header. Useful for Twitter Cards - https://dev.twitter.com/cards/overview - or additional Open Graph tags.',1,'none',NULL,'luwes\\codemirror\\fields\\CodeMirrorField','{\"mode\":\"gfm\"}','2018-02-02 06:47:54','2019-03-20 19:56:56','d1edff97-994f-4f78-9318-6cdbbdfd446d'),(45,3,'Additional Footer Code','footerCode','global','Any raw code or Javascript entered here will be output at the bottom of this page. This can be used for calling specific Marketo or Google Analytics scripts that are specific to this page and not part of the global template.',1,'none',NULL,'luwes\\codemirror\\fields\\CodeMirrorField','{\"mode\":\"gfm\"}','2018-02-02 06:49:10','2019-03-20 19:56:31','e60a84f5-789c-489b-a95e-ae0419f4ae7d'),(46,NULL,'Image Position','position','matrixBlockType:318e27c6-9622-4e58-9013-b8731641271f','Whether the image should be displayed to the left or right of the content.',1,'none',NULL,'rias\\positionfieldtype\\fields\\Position','{\"default\":\"\",\"options\":{\"center\":\"\",\"drop-left\":\"\",\"drop-right\":\"\",\"full\":\"\",\"left\":\"1\",\"right\":\"1\"}}','2018-02-02 22:00:48','2019-03-12 15:59:23','5f8ee8da-9277-4b2e-9482-9f78c77a131a'),(47,NULL,'Video Position','position','matrixBlockType:c5c9e5cd-cbe8-4b48-b85e-2dcccae569ba','Whether the video should be displayed to the left or right of the content.',1,'none',NULL,'rias\\positionfieldtype\\fields\\Position','{\"default\":\"\",\"options\":{\"center\":\"\",\"drop-left\":\"\",\"drop-right\":\"\",\"full\":\"\",\"left\":\"1\",\"right\":\"1\"}}','2018-02-02 22:00:48','2019-03-12 15:59:24','a83d00fb-de79-47a0-bd4d-e2778c73ef0c'),(48,4,'Job Title','personJobTitle','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-02-02 22:03:25','2018-02-02 22:03:25','a3601ba7-e21f-4718-86f2-0c19eae0d32f'),(49,4,'Photo','personPhoto','global','',1,'site',NULL,'craft\\fields\\Assets','{\"allowedKinds\":null,\"defaultUploadLocationSource\":\"volume:09773b73-a304-4513-84fd-c4d5d4dd953a\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"\",\"selectionLabel\":\"Choose a photo\",\"singleUploadLocationSource\":\"volume:09773b73-a304-4513-84fd-c4d5d4dd953a\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":\"\",\"viewMode\":\"large\"}','2018-02-02 22:03:44','2019-03-04 20:33:10','48df7913-438b-433b-96d3-163d33a83ea7'),(50,4,'Abstract','personAbstract','global','This is a short paragraph used to describe this person when not viewing their full bio.',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Simple.json\",\"removeInlineStyles\":\"1\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\"}','2018-02-02 22:04:45','2019-12-20 16:16:02','c2fc9bf0-5ff5-4af8-ae54-5ca0a7ce5db4'),(51,4,'Bio','personBio','global','Full bio of this person.',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Standard.json\",\"removeInlineStyles\":\"1\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\"}','2018-02-02 22:05:12','2019-12-20 16:16:02','a3f637cc-edb1-4bae-83f3-a40127804401'),(52,5,'Date','newsDate','global','Date of this article.',1,'none',NULL,'craft\\fields\\Date','{\"showDate\":true,\"showTime\":false,\"minuteIncrement\":\"30\"}','2018-02-02 22:06:14','2018-02-02 22:06:14','26f42a7b-fe45-4cc5-9535-49a9e14a7446'),(54,6,'Blog Date','blogDate','global','',1,'none',NULL,'craft\\fields\\Date','{\"showDate\":true,\"showTime\":false,\"minuteIncrement\":\"30\"}','2018-02-02 22:09:37','2018-02-02 22:09:37','c2b63486-bb0e-42d6-9986-12cead0acc47'),(55,6,'Featured Image','blogFeaturedImage','global','',1,'site',NULL,'craft\\fields\\Assets','{\"allowedKinds\":null,\"defaultUploadLocationSource\":\"volume:09773b73-a304-4513-84fd-c4d5d4dd953a\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"\",\"selectionLabel\":\"Choose an image\",\"singleUploadLocationSource\":\"volume:09773b73-a304-4513-84fd-c4d5d4dd953a\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":\"\",\"viewMode\":\"large\"}','2018-02-02 22:10:05','2019-03-04 20:33:10','fe9f15e5-2b68-477e-af16-c6e83c83e642'),(56,6,'Author','blogAuthor','global','',1,'site',NULL,'craft\\fields\\Entries','{\"sources\":[\"section:c87b5acc-afe1-4ddf-b73c-b449c9f29c2d\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":null,\"limit\":\"1\",\"selectionLabel\":\"Specify the author\",\"localizeRelations\":false}','2018-02-02 22:12:44','2018-02-02 22:12:56','b54bac54-a6a2-4e19-af8b-eead56deed68'),(57,6,'Abstract','blogAbstract','global','',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Simple.json\",\"removeInlineStyles\":\"1\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\"}','2018-02-02 22:13:30','2019-12-20 16:16:02','2575b2df-9c7d-43dc-b00c-7c8b4a389b22'),(58,6,'Blog Categories','blogCategories','global','',1,'site',NULL,'craft\\fields\\Categories','{\"branchLimit\":\"\",\"sources\":\"*\",\"source\":\"group:380fab36-d288-4b53-9d1b-d5aad2afc914\",\"targetSiteId\":null,\"viewMode\":null,\"limit\":null,\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-02-02 22:17:51','2018-02-02 22:17:51','a889cfc2-e16d-4719-88be-773bf11567f4'),(59,7,'Start Date','eventStartDate','global','',1,'none',NULL,'craft\\fields\\Date','{\"showDate\":true,\"showTime\":false,\"minuteIncrement\":\"30\"}','2018-02-04 22:08:45','2018-02-04 22:08:45','c2f6ae57-a58a-4ddb-8776-b3510df685a6'),(60,7,'End Date','eventEndDate','global','',1,'none',NULL,'craft\\fields\\Date','{\"showDate\":true,\"showTime\":false,\"minuteIncrement\":\"30\"}','2018-02-04 22:08:59','2018-02-04 22:08:59','cd059144-5cb6-46db-bcea-8d8e1d747107'),(61,5,'Abstract','newsAbstract','global','Short description for lists.',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Simple.json\",\"removeInlineStyles\":\"1\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\"}','2018-02-04 22:09:35','2019-12-20 16:16:02','fcc7f6c3-97c3-4ab3-8555-f630f7deb9cb'),(64,7,'Location','eventLocation','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-02-08 18:46:35','2018-02-08 18:46:35','4f214271-7640-4763-948d-3eb791a16473'),(66,1,'Headline','headline','global','Most prominent text on the page; typically shown on top of the hero.',1,'none',NULL,'craft\\fields\\PlainText','{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2019-03-08 21:45:10','2019-03-11 14:57:44','4e031b1d-eb8f-4453-90bc-165adf99fd49'),(67,1,'Subheadline','subheadline','global','Shown just below the headline on the page.',1,'none',NULL,'craft\\fields\\PlainText','{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2019-03-08 21:45:27','2019-03-11 14:57:34','41f2c51a-22b8-4d31-ac8e-1c7b72590f7b'),(69,2,'Description','resourceDescription','global','',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Simple.json\",\"removeInlineStyles\":\"1\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\"}','2019-03-11 19:49:03','2019-12-20 16:16:02','e6810524-42e4-4e35-8fe8-edfb548dd138'),(70,NULL,'Shared Block','sharedBlock','matrixBlockType:ebbc6a1f-74ae-456e-8091-ad2853f1f503','Choose a Shared Block to display.',1,'site',NULL,'craft\\fields\\Entries','{\"limit\":\"\",\"localizeRelations\":false,\"selectionLabel\":\"Choose Shared Block\",\"source\":null,\"sources\":[\"section:16e6b8c8-fd2d-4fa3-9219-9d81e2ab1e98\"],\"targetSiteId\":null,\"viewMode\":null}','2019-03-12 15:59:25','2019-03-12 15:59:25','cb951d67-04af-4a80-9936-c2183b970628'),(71,1,'Alt Text','altText','global','Alt text is the content that appears in place of an image on a webpage if the image fails to load on a user\'s screen. This text helps screen-reading tools describe images to visually impaired readers and allows search engines to better crawl and rank your website.',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-12-23 15:24:10','2019-12-23 15:24:10','8fda9d17-0a07-4bc1-a1f4-1fe23066f315');
/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `globalsets`
--

DROP TABLE IF EXISTS `globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `globalsets_name_idx` (`name`),
  KEY `globalsets_handle_idx` (`handle`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `globalsets`
--

LOCK TABLES `globalsets` WRITE;
/*!40000 ALTER TABLE `globalsets` DISABLE KEYS */;
/*!40000 ALTER TABLE `globalsets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gqlschemas`
--

DROP TABLE IF EXISTS `gqlschemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gqlschemas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `expiryDate` datetime DEFAULT NULL,
  `lastUsed` datetime DEFAULT NULL,
  `scope` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gqlschemas_accessToken_unq_idx` (`accessToken`),
  UNIQUE KEY `gqlschemas_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gqlschemas`
--

LOCK TABLES `gqlschemas` WRITE;
/*!40000 ALTER TABLE `gqlschemas` DISABLE KEYS */;
/*!40000 ALTER TABLE `gqlschemas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `info`
--

DROP TABLE IF EXISTS `info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT 0,
  `config` mediumtext DEFAULT NULL,
  `configMap` mediumtext DEFAULT NULL,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `info`
--

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;
INSERT INTO `info` VALUES (1,'3.3.18.3','3.3.3',0,'{\"categoryGroups\":{\"380fab36-d288-4b53-9d1b-d5aad2afc914\":{\"handle\":\"blogCategories\",\"name\":\"Blog Categories\",\"siteSettings\":{\"5a949caa-356a-45ea-b408-2b267055c99c\":{\"hasUrls\":\"1\",\"template\":\"blog-categories/_category\",\"uriFormat\":\"blog-categories/{slug}\"}},\"structure\":{\"maxLevels\":null,\"uid\":\"7500937b-aa4b-4094-9a13-5480a3ca0589\"}},\"d9b26dd3-8815-474a-b2d1-df10d1da9ea4\":{\"fieldLayouts\":{\"6890171e-e900-455f-9fa7-5bdf37b57e09\":{\"tabs\":[{\"name\":\"Resource Category\",\"sortOrder\":\"1\"}]}},\"handle\":\"resourceCategories\",\"name\":\"Resource Categories\",\"siteSettings\":{\"5a949caa-356a-45ea-b408-2b267055c99c\":{\"hasUrls\":\"1\",\"template\":\"resource-categories/_category\",\"uriFormat\":\"resource-categories/{slug}\"}},\"structure\":{\"maxLevels\":null,\"uid\":\"a05bccd3-a5b7-4519-a8de-a9fd24a1f6fe\"}}},\"dateModified\":1577114681,\"email\":{\"fromEmail\":\"kevin@imarc.com\",\"fromName\":\"Padstone\",\"transportType\":\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"},\"fieldGroups\":{\"1cd65752-f86f-48a3-9924-90919c9ca915\":{\"name\":\"Homepage\"},\"28bbb761-2bca-4754-ba9e-c0bfe22f4496\":{\"name\":\"People\"},\"4cd84b5c-0162-4148-a588-37b2fcc1da0a\":{\"name\":\"SEO\"},\"61009477-6ca8-4122-b871-b3b715eec012\":{\"name\":\"Events\"},\"6533045f-a95c-45a5-a67a-c8da4cec0d5d\":{\"name\":\"News\"},\"b2e9d0fb-ba4b-4b23-9fcf-459ad68c0ea9\":{\"name\":\"Blog\"},\"bbb87adb-e632-4579-b223-79796ba4ff1a\":{\"name\":\"Resources\"},\"c4593c73-7ed0-4694-9aa8-fa73bd8c1b1b\":{\"name\":\"Common\"}},\"fields\":{\"0610a849-e9bc-455c-86d5-ee8175b2ae9a\":{\"contentColumnType\":\"text\",\"fieldGroup\":\"bbb87adb-e632-4579-b223-79796ba4ff1a\",\"handle\":\"resourceEmbed\",\"instructions\":\"Paste code to embed a video or other widget here.\",\"name\":\"Embed\",\"searchable\":\"1\",\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"luwes\\\\codemirror\\\\fields\\\\CodeMirrorField\"},\"0ba5cfaa-93ea-41f9-8b0b-46c048b5b209\":{\"contentColumnType\":\"string\",\"fieldGroup\":\"4cd84b5c-0162-4148-a588-37b2fcc1da0a\",\"handle\":\"openGraphImage\",\"instructions\":\"If provided, this image will show up when shared on social media. A landscape image at 1200x630 pixels works best.\",\"name\":\"Open Graph Image\",\"searchable\":true,\"settings\":{\"allowedKinds\":null,\"defaultUploadLocationSource\":\"volume:09773b73-a304-4513-84fd-c4d5d4dd953a\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"\",\"selectionLabel\":\"Choose an image\",\"singleUploadLocationSource\":\"volume:09773b73-a304-4513-84fd-c4d5d4dd953a\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":\"\",\"viewMode\":\"large\"},\"translationKeyFormat\":null,\"translationMethod\":\"site\",\"type\":\"craft\\\\fields\\\\Assets\"},\"0f8aa3f7-de9e-4beb-a7e9-e98793b3b60e\":{\"name\":\"Featured Image\",\"handle\":\"resourceFeaturedImage\",\"instructions\":\"This image will be shown in lists and other places this resource is featured.\",\"searchable\":true,\"translationMethod\":\"site\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\Assets\",\"settings\":{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"volume:09773b73-a304-4513-84fd-c4d5d4dd953a\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"volume:09773b73-a304-4513-84fd-c4d5d4dd953a\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"\",\"allowedKinds\":null,\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"Add a featured image\",\"localizeRelations\":false,\"validateRelatedElements\":\"\"},\"contentColumnType\":\"string\",\"fieldGroup\":\"bbb87adb-e632-4579-b223-79796ba4ff1a\"},\"2575b2df-9c7d-43dc-b00c-7c8b4a389b22\":{\"contentColumnType\":\"text\",\"fieldGroup\":\"b2e9d0fb-ba4b-4b23-9fcf-459ad68c0ea9\",\"handle\":\"blogAbstract\",\"instructions\":\"\",\"name\":\"Abstract\",\"searchable\":\"1\",\"settings\":{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Simple.json\",\"removeInlineStyles\":\"1\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\redactor\\\\Field\"},\"26f42a7b-fe45-4cc5-9535-49a9e14a7446\":{\"contentColumnType\":\"datetime\",\"fieldGroup\":\"6533045f-a95c-45a5-a67a-c8da4cec0d5d\",\"handle\":\"newsDate\",\"instructions\":\"Date of this article.\",\"name\":\"Date\",\"searchable\":\"1\",\"settings\":{\"minuteIncrement\":\"30\",\"showDate\":true,\"showTime\":false},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\fields\\\\Date\"},\"27247eb3-ce02-4776-a57d-c34c35c19127\":{\"contentColumnType\":\"text\",\"fieldGroup\":\"4cd84b5c-0162-4148-a588-37b2fcc1da0a\",\"handle\":\"htmlTitleOverride\",\"instructions\":\"If provided, this field will override the TITLE tag for this landing page or the detail page for this entry. Title tags are often truncated around 60 characters, so when possible, try to keep them under that length.\",\"name\":\"HTML Title Override\",\"searchable\":true,\"settings\":{\"charLimit\":\"155\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\fields\\\\PlainText\"},\"41f2c51a-22b8-4d31-ac8e-1c7b72590f7b\":{\"contentColumnType\":\"text\",\"fieldGroup\":\"c4593c73-7ed0-4694-9aa8-fa73bd8c1b1b\",\"handle\":\"subheadline\",\"instructions\":\"Shown just below the headline on the page.\",\"name\":\"Subheadline\",\"searchable\":true,\"settings\":{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\fields\\\\PlainText\"},\"48df7913-438b-433b-96d3-163d33a83ea7\":{\"contentColumnType\":\"string\",\"fieldGroup\":\"28bbb761-2bca-4754-ba9e-c0bfe22f4496\",\"handle\":\"personPhoto\",\"instructions\":\"\",\"name\":\"Photo\",\"searchable\":\"1\",\"settings\":{\"allowedKinds\":null,\"defaultUploadLocationSource\":\"volume:09773b73-a304-4513-84fd-c4d5d4dd953a\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"\",\"selectionLabel\":\"Choose a photo\",\"singleUploadLocationSource\":\"volume:09773b73-a304-4513-84fd-c4d5d4dd953a\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":\"\",\"viewMode\":\"large\"},\"translationKeyFormat\":null,\"translationMethod\":\"site\",\"type\":\"craft\\\\fields\\\\Assets\"},\"4e031b1d-eb8f-4453-90bc-165adf99fd49\":{\"contentColumnType\":\"text\",\"fieldGroup\":\"c4593c73-7ed0-4694-9aa8-fa73bd8c1b1b\",\"handle\":\"headline\",\"instructions\":\"Most prominent text on the page; typically shown on top of the hero.\",\"name\":\"Headline\",\"searchable\":true,\"settings\":{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\fields\\\\PlainText\"},\"4f214271-7640-4763-948d-3eb791a16473\":{\"contentColumnType\":\"text\",\"fieldGroup\":\"61009477-6ca8-4122-b871-b3b715eec012\",\"handle\":\"eventLocation\",\"instructions\":\"\",\"name\":\"Location\",\"searchable\":\"1\",\"settings\":{\"charLimit\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\fields\\\\PlainText\"},\"71853a8b-b74d-4320-83d5-b8ef585bc335\":{\"contentColumnType\":\"text\",\"fieldGroup\":\"4cd84b5c-0162-4148-a588-37b2fcc1da0a\",\"handle\":\"metaDescription\",\"instructions\":\"If provided, this field will be used as the meta description for this landing page or the detail page for this entry. It is better to leave this field blank if you don\'t have specific content for this page or entry.\",\"name\":\"Meta Description\",\"searchable\":true,\"settings\":{\"charLimit\":\"300\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\fields\\\\PlainText\"},\"7ccca481-afc6-4d2d-a691-46d51885c73e\":{\"contentColumnType\":\"string\",\"fieldGroup\":\"c4593c73-7ed0-4694-9aa8-fa73bd8c1b1b\",\"handle\":\"designedContent\",\"instructions\":\"Add one or more blocks of content and choose the layout or design you\'d like that content to use.\",\"name\":\"Content Designer\",\"searchable\":true,\"settings\":{\"contentTable\":\"{{%matrixcontent_designedcontent}}\",\"localizeBlocks\":false,\"maxBlocks\":\"\",\"minBlocks\":\"\"},\"translationKeyFormat\":null,\"translationMethod\":\"site\",\"type\":\"craft\\\\fields\\\\Matrix\"},\"86444c22-bd97-4a40-9136-f5613c95ba48\":{\"contentColumnType\":\"string\",\"fieldGroup\":\"bbb87adb-e632-4579-b223-79796ba4ff1a\",\"handle\":\"resourceCategories\",\"instructions\":\"\",\"name\":\"Resource Categories\",\"searchable\":\"1\",\"settings\":{\"branchLimit\":\"\",\"limit\":null,\"localizeRelations\":false,\"selectionLabel\":\"\",\"source\":\"group:d9b26dd3-8815-474a-b2d1-df10d1da9ea4\",\"sources\":\"*\",\"targetSiteId\":null,\"viewMode\":null},\"translationKeyFormat\":null,\"translationMethod\":\"site\",\"type\":\"craft\\\\fields\\\\Categories\"},\"8db154b4-31aa-4a46-bd7e-e040f96b91a8\":{\"contentColumnType\":\"text\",\"fieldGroup\":\"bbb87adb-e632-4579-b223-79796ba4ff1a\",\"handle\":\"resourceCTA\",\"instructions\":\"Text shown on the Call to Action to download this file.\",\"name\":\"Call to Action\",\"searchable\":true,\"settings\":{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\fields\\\\PlainText\"},\"8fda9d17-0a07-4bc1-a1f4-1fe23066f315\":{\"name\":\"Alt Text\",\"handle\":\"altText\",\"instructions\":\"Alt text is the content that appears in place of an image on a webpage if the image fails to load on a user\'s screen. This text helps screen-reading tools describe images to visually impaired readers and allows search engines to better crawl and rank your website.\",\"searchable\":true,\"translationMethod\":\"none\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\PlainText\",\"settings\":{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"},\"contentColumnType\":\"text\",\"fieldGroup\":\"c4593c73-7ed0-4694-9aa8-fa73bd8c1b1b\"},\"93e2b1ce-6b60-40c8-ad40-4b1c92d2ecd1\":{\"contentColumnType\":\"text\",\"fieldGroup\":\"bbb87adb-e632-4579-b223-79796ba4ff1a\",\"handle\":\"resourceUrl\",\"instructions\":\"URL for this resource.\",\"name\":\"Resource\",\"searchable\":true,\"settings\":{\"allowCustomText\":\"1\",\"allowTarget\":\"\",\"allowedLinkNames\":{\"3\":\"entry\",\"9\":\"url\"},\"autoNoReferrer\":\"\",\"defaultLinkName\":\"asset\",\"defaultText\":\"\",\"enableAriaLabel\":\"\",\"enableTitle\":\"\",\"typeSettings\":{\"asset\":{\"allowCustomQuery\":\"\",\"sources\":\"*\"},\"category\":{\"allowCustomQuery\":\"\",\"sources\":\"*\"},\"custom\":{\"allowAliases\":\"\",\"disableValidation\":\"\"},\"email\":{\"allowAliases\":\"\",\"disableValidation\":\"\"},\"entry\":{\"allowCustomQuery\":\"\",\"sources\":\"*\"},\"site\":{\"sites\":\"*\"},\"tel\":{\"allowAliases\":\"\",\"disableValidation\":\"\"},\"url\":{\"allowAliases\":\"\",\"disableValidation\":\"\"},\"user\":{\"allowCustomQuery\":\"\",\"sources\":\"*\"}}},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"typedlinkfield\\\\fields\\\\LinkField\"},\"a3601ba7-e21f-4718-86f2-0c19eae0d32f\":{\"contentColumnType\":\"text\",\"fieldGroup\":\"28bbb761-2bca-4754-ba9e-c0bfe22f4496\",\"handle\":\"personJobTitle\",\"instructions\":\"\",\"name\":\"Job Title\",\"searchable\":\"1\",\"settings\":{\"charLimit\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\fields\\\\PlainText\"},\"a3f637cc-edb1-4bae-83f3-a40127804401\":{\"contentColumnType\":\"text\",\"fieldGroup\":\"28bbb761-2bca-4754-ba9e-c0bfe22f4496\",\"handle\":\"personBio\",\"instructions\":\"Full bio of this person.\",\"name\":\"Bio\",\"searchable\":\"1\",\"settings\":{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Standard.json\",\"removeInlineStyles\":\"1\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\redactor\\\\Field\"},\"a889cfc2-e16d-4719-88be-773bf11567f4\":{\"contentColumnType\":\"string\",\"fieldGroup\":\"b2e9d0fb-ba4b-4b23-9fcf-459ad68c0ea9\",\"handle\":\"blogCategories\",\"instructions\":\"\",\"name\":\"Blog Categories\",\"searchable\":\"1\",\"settings\":{\"branchLimit\":\"\",\"limit\":null,\"localizeRelations\":false,\"selectionLabel\":\"\",\"source\":\"group:380fab36-d288-4b53-9d1b-d5aad2afc914\",\"sources\":\"*\",\"targetSiteId\":null,\"viewMode\":null},\"translationKeyFormat\":null,\"translationMethod\":\"site\",\"type\":\"craft\\\\fields\\\\Categories\"},\"b1abef14-c4df-4e03-adf6-740fbfae5ddf\":{\"contentColumnType\":\"text\",\"fieldGroup\":\"4cd84b5c-0162-4148-a588-37b2fcc1da0a\",\"handle\":\"openGraphDescription\",\"instructions\":\"If provided, this field will be used as the Open Graph description for this landing page or the detail page for this entry.\",\"name\":\"Open Graph Description\",\"searchable\":true,\"settings\":{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\fields\\\\PlainText\"},\"b54bac54-a6a2-4e19-af8b-eead56deed68\":{\"contentColumnType\":\"string\",\"fieldGroup\":\"b2e9d0fb-ba4b-4b23-9fcf-459ad68c0ea9\",\"handle\":\"blogAuthor\",\"instructions\":\"\",\"name\":\"Author\",\"searchable\":\"1\",\"settings\":{\"limit\":\"1\",\"localizeRelations\":false,\"selectionLabel\":\"Specify the author\",\"source\":null,\"sources\":[\"section:c87b5acc-afe1-4ddf-b73c-b449c9f29c2d\"],\"targetSiteId\":null,\"viewMode\":null},\"translationKeyFormat\":null,\"translationMethod\":\"site\",\"type\":\"craft\\\\fields\\\\Entries\"},\"c2b63486-bb0e-42d6-9986-12cead0acc47\":{\"contentColumnType\":\"datetime\",\"fieldGroup\":\"b2e9d0fb-ba4b-4b23-9fcf-459ad68c0ea9\",\"handle\":\"blogDate\",\"instructions\":\"\",\"name\":\"Blog Date\",\"searchable\":\"1\",\"settings\":{\"minuteIncrement\":\"30\",\"showDate\":true,\"showTime\":false},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\fields\\\\Date\"},\"c2f6ae57-a58a-4ddb-8776-b3510df685a6\":{\"contentColumnType\":\"datetime\",\"fieldGroup\":\"61009477-6ca8-4122-b871-b3b715eec012\",\"handle\":\"eventStartDate\",\"instructions\":\"\",\"name\":\"Start Date\",\"searchable\":\"1\",\"settings\":{\"minuteIncrement\":\"30\",\"showDate\":true,\"showTime\":false},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\fields\\\\Date\"},\"c2fc9bf0-5ff5-4af8-ae54-5ca0a7ce5db4\":{\"contentColumnType\":\"text\",\"fieldGroup\":\"28bbb761-2bca-4754-ba9e-c0bfe22f4496\",\"handle\":\"personAbstract\",\"instructions\":\"This is a short paragraph used to describe this person when not viewing their full bio.\",\"name\":\"Abstract\",\"searchable\":\"1\",\"settings\":{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Simple.json\",\"removeInlineStyles\":\"1\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\redactor\\\\Field\"},\"cd059144-5cb6-46db-bcea-8d8e1d747107\":{\"contentColumnType\":\"datetime\",\"fieldGroup\":\"61009477-6ca8-4122-b871-b3b715eec012\",\"handle\":\"eventEndDate\",\"instructions\":\"\",\"name\":\"End Date\",\"searchable\":\"1\",\"settings\":{\"minuteIncrement\":\"30\",\"showDate\":true,\"showTime\":false},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\fields\\\\Date\"},\"d1edff97-994f-4f78-9318-6cdbbdfd446d\":{\"contentColumnType\":\"text\",\"fieldGroup\":\"4cd84b5c-0162-4148-a588-37b2fcc1da0a\",\"handle\":\"headerCode\",\"instructions\":\"Provide any relevant meta tags, Open Graph tags, or Javascript to be placed on in the page\'s header. Useful for Twitter Cards - https://dev.twitter.com/cards/overview - or additional Open Graph tags.\",\"name\":\"Additional Header Code\",\"searchable\":true,\"settings\":{\"mode\":\"gfm\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"luwes\\\\codemirror\\\\fields\\\\CodeMirrorField\"},\"d5e98a9a-c478-4cf5-8c85-1083950e2e9f\":{\"contentColumnType\":\"datetime\",\"fieldGroup\":\"bbb87adb-e632-4579-b223-79796ba4ff1a\",\"handle\":\"resourceDate\",\"instructions\":\"\",\"name\":\"Resource Date\",\"searchable\":\"1\",\"settings\":{\"minuteIncrement\":\"30\",\"showDate\":true,\"showTime\":false},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\fields\\\\Date\"},\"e60a84f5-789c-489b-a95e-ae0419f4ae7d\":{\"contentColumnType\":\"text\",\"fieldGroup\":\"4cd84b5c-0162-4148-a588-37b2fcc1da0a\",\"handle\":\"footerCode\",\"instructions\":\"Any raw code or Javascript entered here will be output at the bottom of this page. This can be used for calling specific Marketo or Google Analytics scripts that are specific to this page and not part of the global template.\",\"name\":\"Additional Footer Code\",\"searchable\":true,\"settings\":{\"mode\":\"gfm\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"luwes\\\\codemirror\\\\fields\\\\CodeMirrorField\"},\"e6810524-42e4-4e35-8fe8-edfb548dd138\":{\"contentColumnType\":\"text\",\"fieldGroup\":\"bbb87adb-e632-4579-b223-79796ba4ff1a\",\"handle\":\"resourceDescription\",\"instructions\":\"\",\"name\":\"Description\",\"searchable\":true,\"settings\":{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Simple.json\",\"removeInlineStyles\":\"1\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\redactor\\\\Field\"},\"e72e6691-b2c5-41b9-b75e-56b6a7200933\":{\"contentColumnType\":\"text\",\"fieldGroup\":\"4cd84b5c-0162-4148-a588-37b2fcc1da0a\",\"handle\":\"openGraphTitle\",\"instructions\":\"If provided, this field will be used as the Open Graph title for this landing page or the detail page for this entry.\",\"name\":\"Open Graph Title\",\"searchable\":true,\"settings\":{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\fields\\\\PlainText\"},\"fcc7f6c3-97c3-4ab3-8555-f630f7deb9cb\":{\"contentColumnType\":\"text\",\"fieldGroup\":\"6533045f-a95c-45a5-a67a-c8da4cec0d5d\",\"handle\":\"newsAbstract\",\"instructions\":\"Short description for lists.\",\"name\":\"Abstract\",\"searchable\":true,\"settings\":{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Simple.json\",\"removeInlineStyles\":\"1\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\redactor\\\\Field\"},\"fe9f15e5-2b68-477e-af16-c6e83c83e642\":{\"contentColumnType\":\"string\",\"fieldGroup\":\"b2e9d0fb-ba4b-4b23-9fcf-459ad68c0ea9\",\"handle\":\"blogFeaturedImage\",\"instructions\":\"\",\"name\":\"Featured Image\",\"searchable\":\"1\",\"settings\":{\"allowedKinds\":null,\"defaultUploadLocationSource\":\"volume:09773b73-a304-4513-84fd-c4d5d4dd953a\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"\",\"selectionLabel\":\"Choose an image\",\"singleUploadLocationSource\":\"volume:09773b73-a304-4513-84fd-c4d5d4dd953a\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":\"\",\"viewMode\":\"large\"},\"translationKeyFormat\":null,\"translationMethod\":\"site\",\"type\":\"craft\\\\fields\\\\Assets\"}},\"matrixBlockTypes\":{\"12dbddde-14fb-4b79-98fe-6c9bee0e3de8\":{\"field\":\"7ccca481-afc6-4d2d-a691-46d51885c73e\",\"fieldLayouts\":{\"6cb110a9-f0e7-44b2-9c12-d87b89912a8f\":{\"tabs\":[{\"fields\":{\"832bda63-d7a5-494e-a960-dbc6d4f71755\":{\"required\":true,\"sortOrder\":3},\"8b129965-072e-4380-bd83-2cc75fe7c989\":{\"required\":false,\"sortOrder\":4},\"c04d3133-756c-44d2-ae47-41f5946dddaf\":{\"required\":false,\"sortOrder\":1},\"c5eb763d-fb5a-4f00-8fc2-74e9b242860b\":{\"required\":true,\"sortOrder\":2}},\"name\":\"Content\",\"sortOrder\":1}]}},\"fields\":{\"832bda63-d7a5-494e-a960-dbc6d4f71755\":{\"contentColumnType\":\"text\",\"fieldGroup\":null,\"handle\":\"person\",\"instructions\":\"\",\"name\":\"Person\",\"searchable\":true,\"settings\":{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\fields\\\\PlainText\"},\"8b129965-072e-4380-bd83-2cc75fe7c989\":{\"contentColumnType\":\"text\",\"fieldGroup\":null,\"handle\":\"jobTitle\",\"instructions\":\"Optional job title for this person.\",\"name\":\"Job Title\",\"searchable\":true,\"settings\":{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\fields\\\\PlainText\"},\"c04d3133-756c-44d2-ae47-41f5946dddaf\":{\"contentColumnType\":\"text\",\"fieldGroup\":null,\"handle\":\"sectionTitle\",\"instructions\":\"Optional title for this section.\",\"name\":\"Section Title\",\"searchable\":true,\"settings\":{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\fields\\\\PlainText\"},\"c5eb763d-fb5a-4f00-8fc2-74e9b242860b\":{\"contentColumnType\":\"text\",\"fieldGroup\":null,\"handle\":\"quote\",\"instructions\":\"\",\"name\":\"Quote\",\"searchable\":true,\"settings\":{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Standard.json\",\"removeInlineStyles\":\"1\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\redactor\\\\Field\"}},\"handle\":\"testimonial\",\"name\":\"Testimonial\",\"sortOrder\":5},\"318e27c6-9622-4e58-9013-b8731641271f\":{\"field\":\"7ccca481-afc6-4d2d-a691-46d51885c73e\",\"fieldLayouts\":{\"096b5368-187c-4cd6-b902-b1b49cf655c7\":{\"tabs\":[{\"fields\":{\"44cce794-ef87-4267-b50d-b4234ba0bd59\":{\"required\":false,\"sortOrder\":1},\"5f8ee8da-9277-4b2e-9482-9f78c77a131a\":{\"required\":true,\"sortOrder\":3},\"7a63a845-8a3f-4576-948f-5e1699226882\":{\"required\":true,\"sortOrder\":2},\"f01c690c-38f2-4d42-8123-2f1ef7ab7a1e\":{\"required\":true,\"sortOrder\":4}},\"name\":\"Content\",\"sortOrder\":1}]}},\"fields\":{\"44cce794-ef87-4267-b50d-b4234ba0bd59\":{\"contentColumnType\":\"text\",\"fieldGroup\":null,\"handle\":\"sectionTitle\",\"instructions\":\"Optional title for this section.\",\"name\":\"Section Title\",\"searchable\":true,\"settings\":{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\fields\\\\PlainText\"},\"5f8ee8da-9277-4b2e-9482-9f78c77a131a\":{\"contentColumnType\":\"string\",\"fieldGroup\":null,\"handle\":\"position\",\"instructions\":\"Whether the image should be displayed to the left or right of the content.\",\"name\":\"Image Position\",\"searchable\":true,\"settings\":{\"default\":\"\",\"options\":{\"center\":\"\",\"drop-left\":\"\",\"drop-right\":\"\",\"full\":\"\",\"left\":\"1\",\"right\":\"1\"}},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"rias\\\\positionfieldtype\\\\fields\\\\Position\"},\"7a63a845-8a3f-4576-948f-5e1699226882\":{\"contentColumnType\":\"string\",\"fieldGroup\":null,\"handle\":\"image\",\"instructions\":\"\",\"name\":\"Image\",\"searchable\":true,\"settings\":{\"allowedKinds\":null,\"defaultUploadLocationSource\":\"volume:09773b73-a304-4513-84fd-c4d5d4dd953a\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"\",\"selectionLabel\":\"Choose an image\",\"singleUploadLocationSource\":\"volume:09773b73-a304-4513-84fd-c4d5d4dd953a\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":\"\",\"viewMode\":\"large\"},\"translationKeyFormat\":null,\"translationMethod\":\"site\",\"type\":\"craft\\\\fields\\\\Assets\"},\"f01c690c-38f2-4d42-8123-2f1ef7ab7a1e\":{\"contentColumnType\":\"text\",\"fieldGroup\":null,\"handle\":\"blockContent\",\"instructions\":\"Content to accompany this image.\",\"name\":\"Content\",\"searchable\":true,\"settings\":{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Standard.json\",\"removeInlineStyles\":\"1\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\redactor\\\\Field\"}},\"handle\":\"imageWithText\",\"name\":\"Image with Text\",\"sortOrder\":3},\"7f264ef3-9650-4cb3-9de7-cdc442a98a4d\":{\"field\":\"7ccca481-afc6-4d2d-a691-46d51885c73e\",\"fieldLayouts\":{\"1c5f2520-7bd1-40f4-a03e-5acbf1cf588e\":{\"tabs\":[{\"fields\":{\"3ebface3-3651-4864-b86f-2eaa76ff7b82\":{\"required\":false,\"sortOrder\":1},\"fd5e975b-61c7-46ca-9927-12fcb7d04fcd\":{\"required\":true,\"sortOrder\":2}},\"name\":\"Content\",\"sortOrder\":1}]}},\"fields\":{\"3ebface3-3651-4864-b86f-2eaa76ff7b82\":{\"contentColumnType\":\"text\",\"fieldGroup\":null,\"handle\":\"sectionTitle\",\"instructions\":\"Optional title for this section.\",\"name\":\"Section Title\",\"searchable\":true,\"settings\":{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\fields\\\\PlainText\"},\"fd5e975b-61c7-46ca-9927-12fcb7d04fcd\":{\"contentColumnType\":\"text\",\"fieldGroup\":null,\"handle\":\"embed\",\"instructions\":\"Raw code for this widget or embed. Be careful!\",\"name\":\"HTML Widget or Embed\",\"searchable\":true,\"settings\":{\"mode\":\"gfm\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"luwes\\\\codemirror\\\\fields\\\\CodeMirrorField\"}},\"handle\":\"htmlWidgetEmbed\",\"name\":\"HTML Widget/Embed\",\"sortOrder\":6},\"c5c9e5cd-cbe8-4b48-b85e-2dcccae569ba\":{\"field\":\"7ccca481-afc6-4d2d-a691-46d51885c73e\",\"fieldLayouts\":{\"6fc702e7-b87f-4bdb-ac4e-32313f70cfc6\":{\"tabs\":[{\"fields\":{\"8526fc89-e8e9-4565-bdf0-a16ed9a6bc69\":{\"required\":true,\"sortOrder\":2},\"a83d00fb-de79-47a0-bd4d-e2778c73ef0c\":{\"required\":false,\"sortOrder\":3},\"c1bad40b-bf3e-410f-9d20-499eeff520bf\":{\"required\":false,\"sortOrder\":1},\"f085c9a4-9812-4550-a6ac-84dfb0c4459d\":{\"required\":true,\"sortOrder\":4}},\"name\":\"Content\",\"sortOrder\":1}]}},\"fields\":{\"8526fc89-e8e9-4565-bdf0-a16ed9a6bc69\":{\"contentColumnType\":\"text\",\"fieldGroup\":null,\"handle\":\"videoOrEmbedCode\",\"instructions\":\"Raw code for this video or embed. Be careful!\",\"name\":\"Video or Embed Code\",\"searchable\":true,\"settings\":{\"mode\":\"gfm\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"luwes\\\\codemirror\\\\fields\\\\CodeMirrorField\"},\"a83d00fb-de79-47a0-bd4d-e2778c73ef0c\":{\"contentColumnType\":\"string\",\"fieldGroup\":null,\"handle\":\"position\",\"instructions\":\"Whether the video should be displayed to the left or right of the content.\",\"name\":\"Video Position\",\"searchable\":true,\"settings\":{\"default\":\"\",\"options\":{\"center\":\"\",\"drop-left\":\"\",\"drop-right\":\"\",\"full\":\"\",\"left\":\"1\",\"right\":\"1\"}},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"rias\\\\positionfieldtype\\\\fields\\\\Position\"},\"c1bad40b-bf3e-410f-9d20-499eeff520bf\":{\"contentColumnType\":\"text\",\"fieldGroup\":null,\"handle\":\"sectionTitle\",\"instructions\":\"Optional title for this section.\",\"name\":\"Section Title\",\"searchable\":true,\"settings\":{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\fields\\\\PlainText\"},\"f085c9a4-9812-4550-a6ac-84dfb0c4459d\":{\"contentColumnType\":\"text\",\"fieldGroup\":null,\"handle\":\"blockContent\",\"instructions\":\"Content to accompany the video.\",\"name\":\"Content\",\"searchable\":true,\"settings\":{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Standard.json\",\"removeInlineStyles\":\"1\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\redactor\\\\Field\"}},\"handle\":\"videoWithText\",\"name\":\"Video with Text\",\"sortOrder\":4},\"dc575719-2de8-473b-9872-9e294da811a2\":{\"field\":\"7ccca481-afc6-4d2d-a691-46d51885c73e\",\"fieldLayouts\":{\"49e26187-fbb5-4dfa-bb12-84da586a1fa8\":{\"tabs\":[{\"fields\":{\"562f7fa1-cbca-4b54-afad-7d44b1be171a\":{\"required\":true,\"sortOrder\":2},\"670d63fe-1da6-4a38-b355-941b9c53c5d7\":{\"required\":true,\"sortOrder\":3},\"a52f1e8a-cba5-455a-ab66-c739b9463856\":{\"required\":false,\"sortOrder\":1}},\"name\":\"Content\",\"sortOrder\":1}]}},\"fields\":{\"562f7fa1-cbca-4b54-afad-7d44b1be171a\":{\"contentColumnType\":\"text\",\"fieldGroup\":null,\"handle\":\"leftContent\",\"instructions\":\"\",\"name\":\"Left Content\",\"searchable\":true,\"settings\":{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Standard.json\",\"removeInlineStyles\":\"1\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\redactor\\\\Field\"},\"670d63fe-1da6-4a38-b355-941b9c53c5d7\":{\"contentColumnType\":\"text\",\"fieldGroup\":null,\"handle\":\"rightContent\",\"instructions\":\"\",\"name\":\"Right Content\",\"searchable\":true,\"settings\":{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Standard.json\",\"removeInlineStyles\":\"1\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\redactor\\\\Field\"},\"a52f1e8a-cba5-455a-ab66-c739b9463856\":{\"contentColumnType\":\"text\",\"fieldGroup\":null,\"handle\":\"sectionTitle\",\"instructions\":\"Optional title for this section.\",\"name\":\"Section Title\",\"searchable\":true,\"settings\":{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\fields\\\\PlainText\"}},\"handle\":\"twoColumns\",\"name\":\"Two Columns\",\"sortOrder\":2},\"ddfe72db-cc91-496e-a097-1be94045f971\":{\"field\":\"7ccca481-afc6-4d2d-a691-46d51885c73e\",\"fieldLayouts\":{\"fe2c269e-89ba-4c9d-ac5f-0f838b2feb0a\":{\"tabs\":[{\"fields\":{\"8cf354bc-58ad-42e1-aeb4-f6439b839750\":{\"required\":true,\"sortOrder\":2},\"f4709cc7-103f-4722-860c-463eb0524b7b\":{\"required\":false,\"sortOrder\":1}},\"name\":\"Content\",\"sortOrder\":1}]}},\"fields\":{\"8cf354bc-58ad-42e1-aeb4-f6439b839750\":{\"contentColumnType\":\"text\",\"fieldGroup\":null,\"handle\":\"blockContent\",\"instructions\":\"\",\"name\":\"Content\",\"searchable\":true,\"settings\":{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Standard.json\",\"removeInlineStyles\":\"1\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\redactor\\\\Field\"},\"f4709cc7-103f-4722-860c-463eb0524b7b\":{\"contentColumnType\":\"text\",\"fieldGroup\":null,\"handle\":\"sectionTitle\",\"instructions\":\"Optional title for this section.\",\"name\":\"Section Title\",\"searchable\":true,\"settings\":{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\fields\\\\PlainText\"}},\"handle\":\"richText\",\"name\":\"Rich Text\",\"sortOrder\":1},\"ebbc6a1f-74ae-456e-8091-ad2853f1f503\":{\"field\":\"7ccca481-afc6-4d2d-a691-46d51885c73e\",\"fieldLayouts\":{\"1326cf27-56cb-47cf-b4ce-a4f127cd00ef\":{\"tabs\":[{\"fields\":{\"cb951d67-04af-4a80-9936-c2183b970628\":{\"required\":true,\"sortOrder\":1}},\"name\":\"Content\",\"sortOrder\":1}]}},\"fields\":{\"cb951d67-04af-4a80-9936-c2183b970628\":{\"contentColumnType\":\"string\",\"fieldGroup\":null,\"handle\":\"sharedBlock\",\"instructions\":\"Choose a Shared Block to display.\",\"name\":\"Shared Block\",\"searchable\":true,\"settings\":{\"limit\":\"\",\"localizeRelations\":false,\"selectionLabel\":\"Choose Shared Block\",\"source\":null,\"sources\":[\"section:16e6b8c8-fd2d-4fa3-9219-9d81e2ab1e98\"],\"targetSiteId\":null,\"viewMode\":null},\"translationKeyFormat\":null,\"translationMethod\":\"site\",\"type\":\"craft\\\\fields\\\\Entries\"}},\"handle\":\"sharedBlock\",\"name\":\"Shared Block\",\"sortOrder\":8},\"edc14065-98d5-402c-a1ed-a745b252ada4\":{\"field\":\"7ccca481-afc6-4d2d-a691-46d51885c73e\",\"fieldLayouts\":{\"3cb15008-c34e-4c01-a542-0a152034242a\":{\"tabs\":[{\"fields\":{\"245fe7e9-d7f5-4de8-8cb6-0ed50edddffb\":{\"required\":true,\"sortOrder\":3},\"24bcd6a1-3fa6-4839-940a-af27d389740b\":{\"required\":false,\"sortOrder\":2},\"85c7e535-dbcd-4e5d-af41-3bf0b93d5c89\":{\"required\":false,\"sortOrder\":1}},\"name\":\"Content\",\"sortOrder\":1}]}},\"fields\":{\"245fe7e9-d7f5-4de8-8cb6-0ed50edddffb\":{\"contentColumnType\":\"text\",\"fieldGroup\":null,\"handle\":\"cta\",\"instructions\":\"This is the link and label for the Call to Action button itself. If you don\'t specify link text, it will default to \\\"Learn More\\\".\",\"name\":\"Call to Action\",\"searchable\":true,\"settings\":{\"allowCustomText\":\"1\",\"allowTarget\":\"\",\"allowedLinkNames\":\"*\",\"autoNoReferrer\":\"\",\"defaultLinkName\":\"asset\",\"defaultText\":\"Learn More\",\"enableAriaLabel\":\"\",\"enableTitle\":\"\",\"typeSettings\":{\"asset\":{\"allowCustomQuery\":\"\",\"sources\":\"*\"},\"category\":{\"allowCustomQuery\":\"\",\"sources\":\"*\"},\"custom\":{\"allowAliases\":\"\",\"disableValidation\":\"\"},\"email\":{\"allowAliases\":\"\",\"disableValidation\":\"\"},\"entry\":{\"allowCustomQuery\":\"\",\"sources\":\"*\"},\"site\":{\"sites\":\"*\"},\"tel\":{\"allowAliases\":\"\",\"disableValidation\":\"\"},\"url\":{\"allowAliases\":\"\",\"disableValidation\":\"\"},\"user\":{\"allowCustomQuery\":\"\",\"sources\":\"*\"}}},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"typedlinkfield\\\\fields\\\\LinkField\"},\"24bcd6a1-3fa6-4839-940a-af27d389740b\":{\"contentColumnType\":\"text\",\"fieldGroup\":null,\"handle\":\"blockContent\",\"instructions\":\"Optional content displayed next to this Call to Action.\",\"name\":\"Content\",\"searchable\":true,\"settings\":{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Standard.json\",\"removeInlineStyles\":\"1\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\redactor\\\\Field\"},\"85c7e535-dbcd-4e5d-af41-3bf0b93d5c89\":{\"contentColumnType\":\"text\",\"fieldGroup\":null,\"handle\":\"sectionTitle\",\"instructions\":\"Optional title for this section.\",\"name\":\"Section Title\",\"searchable\":true,\"settings\":{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"},\"translationKeyFormat\":null,\"translationMethod\":\"none\",\"type\":\"craft\\\\fields\\\\PlainText\"}},\"handle\":\"callToAction\",\"name\":\"Call to Action\",\"sortOrder\":7}},\"plugins\":{\"admin-bar\":{\"enabled\":\"1\",\"licenseKey\":null,\"schemaVersion\":\"3.1.0\",\"settings\":{\"bgColor\":\"#000000\",\"cacheBar\":true,\"customLinks\":[{\"adminOnly\":\"\",\"linkLabel\":\"foo\",\"linkUrl\":\"fooo\"}],\"displayDashboardLink\":true,\"displayDefaultEditSection\":true,\"displayEditAuthor\":true,\"displayEditDate\":true,\"displayGreeting\":true,\"displayLogout\":true,\"displayRevisionNote\":true,\"displaySettingsLink\":true,\"enableMobileMenu\":true,\"highlightColor\":\"#D85B4B\",\"scrollLinks\":true,\"textColor\":\"#FFFFFF\"}},\"code-mirror\":{\"enabled\":\"1\",\"licenseKey\":null,\"schemaVersion\":\"1.0.0\",\"settings\":null},\"contact-form\":{\"enabled\":\"1\",\"licenseKey\":null,\"schemaVersion\":\"1.0.0\",\"settings\":null},\"contact-form-honeypot\":{\"enabled\":\"1\",\"licenseKey\":null,\"schemaVersion\":\"1.0.0\",\"settings\":null},\"craft-kindling\":{\"edition\":\"standard\",\"enabled\":true,\"schemaVersion\":\"1.0.0\"},\"expanded-singles\":{\"enabled\":true,\"licenseKey\":null,\"schemaVersion\":\"1.0.0\",\"settings\":{\"expandSingles\":\"1\",\"redirectToEntry\":\"1\"}},\"googlecustomsearch\":{\"edition\":\"standard\",\"enabled\":true,\"schemaVersion\":\"2.0.0\"},\"mix\":{\"enabled\":\"1\",\"licenseKey\":null,\"schemaVersion\":\"1.0.0\",\"settings\":{\"assetPath\":\"/\",\"publicPath\":\"web\"}},\"position-fieldtype\":{\"enabled\":\"1\",\"licenseKey\":null,\"schemaVersion\":\"1.0.0\",\"settings\":null},\"redactor\":{\"enabled\":\"1\",\"licenseKey\":null,\"schemaVersion\":\"2.3.0\",\"settings\":null},\"redirect\":{\"enabled\":\"1\",\"licenseKey\":null,\"schemaVersion\":\"1.0.5\",\"settings\":null},\"tag-manager\":{\"edition\":\"standard\",\"enabled\":true,\"schemaVersion\":\"1.0.0\"},\"typedlinkfield\":{\"enabled\":\"1\",\"licenseKey\":null,\"schemaVersion\":\"1.0.0\",\"settings\":null},\"feed-me\":{\"edition\":\"standard\",\"enabled\":true,\"schemaVersion\":\"2.1.2\"},\"element-api\":{\"edition\":\"standard\",\"enabled\":true,\"schemaVersion\":\"1.0.0\"},\"imager\":{\"edition\":\"standard\",\"enabled\":true,\"schemaVersion\":\"2.0.0\"}},\"sections\":{\"0041c886-3d54-4352-801b-0450a61a9011\":{\"enableVersioning\":true,\"entryTypes\":{\"6ac1334c-5153-47fa-94c2-6a80dfeecc9b\":{\"fieldLayouts\":{\"ccf7885d-403b-4127-abd4-94aff255ea11\":{\"tabs\":[{\"fields\":{\"41f2c51a-22b8-4d31-ac8e-1c7b72590f7b\":{\"required\":false,\"sortOrder\":2},\"4e031b1d-eb8f-4453-90bc-165adf99fd49\":{\"required\":false,\"sortOrder\":1}},\"name\":\"Leadership\",\"sortOrder\":1},{\"fields\":{\"0ba5cfaa-93ea-41f9-8b0b-46c048b5b209\":{\"required\":false,\"sortOrder\":5},\"27247eb3-ce02-4776-a57d-c34c35c19127\":{\"required\":false,\"sortOrder\":1},\"71853a8b-b74d-4320-83d5-b8ef585bc335\":{\"required\":false,\"sortOrder\":2},\"b1abef14-c4df-4e03-adf6-740fbfae5ddf\":{\"required\":false,\"sortOrder\":4},\"d1edff97-994f-4f78-9318-6cdbbdfd446d\":{\"required\":false,\"sortOrder\":6},\"e60a84f5-789c-489b-a95e-ae0419f4ae7d\":{\"required\":false,\"sortOrder\":7},\"e72e6691-b2c5-41b9-b75e-56b6a7200933\":{\"required\":false,\"sortOrder\":3}},\"name\":\"SEO\",\"sortOrder\":2}]}},\"handle\":\"leadershipPage\",\"hasTitleField\":true,\"name\":\"Leadership Page\",\"sortOrder\":1,\"titleFormat\":\"{section.name|raw}\",\"titleLabel\":\"Title\"}},\"handle\":\"leadershipPage\",\"name\":\"Leadership Page\",\"siteSettings\":{\"5a949caa-356a-45ea-b408-2b267055c99c\":{\"enabledByDefault\":true,\"hasUrls\":true,\"template\":\"leadership/_index\",\"uriFormat\":\"leadership\"}},\"type\":\"single\",\"propagationMethod\":\"all\"},\"16e6b8c8-fd2d-4fa3-9219-9d81e2ab1e98\":{\"enableVersioning\":true,\"entryTypes\":{\"5ca24464-6fc5-4ec1-b72f-bd44b3d7f72f\":{\"fieldLayouts\":{\"26a6743b-375d-4250-b3e1-7e399520fb34\":{\"tabs\":[{\"fields\":{\"7ccca481-afc6-4d2d-a691-46d51885c73e\":{\"required\":true,\"sortOrder\":1}},\"name\":\"Shared Block\",\"sortOrder\":1}]}},\"handle\":\"sharedBlock\",\"hasTitleField\":true,\"name\":\"Shared Block\",\"sortOrder\":1,\"titleFormat\":\"\",\"titleLabel\":\"Title\"}},\"handle\":\"sharedBlocks\",\"name\":\"Shared Blocks\",\"siteSettings\":{\"5a949caa-356a-45ea-b408-2b267055c99c\":{\"enabledByDefault\":false,\"hasUrls\":false,\"template\":null,\"uriFormat\":null}},\"structure\":{\"maxLevels\":\"\",\"uid\":\"2f71ab53-78c9-442d-a830-50cc16e2c184\"},\"type\":\"structure\",\"propagationMethod\":\"all\"},\"16f0db7d-a9b8-4569-8198-d836625cea77\":{\"enableVersioning\":true,\"entryTypes\":{\"ca7b7e4c-25a6-449f-ad1d-bd7a08c52a99\":{\"fieldLayouts\":{\"b6393a40-7fb4-4baa-b883-52d02bac97ee\":{\"tabs\":[{\"fields\":{\"41f2c51a-22b8-4d31-ac8e-1c7b72590f7b\":{\"required\":false,\"sortOrder\":2},\"4e031b1d-eb8f-4453-90bc-165adf99fd49\":{\"required\":false,\"sortOrder\":1},\"7ccca481-afc6-4d2d-a691-46d51885c73e\":{\"required\":false,\"sortOrder\":3}},\"name\":\"Landing Pages\",\"sortOrder\":1},{\"fields\":{\"0ba5cfaa-93ea-41f9-8b0b-46c048b5b209\":{\"required\":false,\"sortOrder\":5},\"27247eb3-ce02-4776-a57d-c34c35c19127\":{\"required\":false,\"sortOrder\":1},\"71853a8b-b74d-4320-83d5-b8ef585bc335\":{\"required\":false,\"sortOrder\":2},\"b1abef14-c4df-4e03-adf6-740fbfae5ddf\":{\"required\":false,\"sortOrder\":4},\"d1edff97-994f-4f78-9318-6cdbbdfd446d\":{\"required\":false,\"sortOrder\":6},\"e60a84f5-789c-489b-a95e-ae0419f4ae7d\":{\"required\":false,\"sortOrder\":7},\"e72e6691-b2c5-41b9-b75e-56b6a7200933\":{\"required\":false,\"sortOrder\":3}},\"name\":\"SEO\",\"sortOrder\":2}]}},\"handle\":\"landingPage\",\"hasTitleField\":true,\"name\":\"Landing Page\",\"sortOrder\":1,\"titleFormat\":\"\",\"titleLabel\":\"Title\"}},\"handle\":\"landingPages\",\"name\":\"Landing Pages\",\"siteSettings\":{\"5a949caa-356a-45ea-b408-2b267055c99c\":{\"enabledByDefault\":true,\"hasUrls\":true,\"template\":\"_default\",\"uriFormat\":\"{slug}\"}},\"structure\":{\"maxLevels\":\"\",\"uid\":\"6934792a-730e-492e-9701-92209d98f59b\"},\"type\":\"structure\",\"propagationMethod\":\"all\"},\"1e6d0ae4-0c2d-4c61-aa0e-f67a0d64d0be\":{\"enableVersioning\":true,\"entryTypes\":{\"f4b21aa5-34c8-486b-9a4a-2283e15f1b00\":{\"fieldLayouts\":{\"0552ae81-bc51-4d11-b923-4b4dd7e4a932\":{\"tabs\":[{\"fields\":{\"41f2c51a-22b8-4d31-ac8e-1c7b72590f7b\":{\"required\":false,\"sortOrder\":2},\"4e031b1d-eb8f-4453-90bc-165adf99fd49\":{\"required\":false,\"sortOrder\":1}},\"name\":\"Blog Page\",\"sortOrder\":1},{\"fields\":{\"0ba5cfaa-93ea-41f9-8b0b-46c048b5b209\":{\"required\":false,\"sortOrder\":5},\"27247eb3-ce02-4776-a57d-c34c35c19127\":{\"required\":false,\"sortOrder\":1},\"71853a8b-b74d-4320-83d5-b8ef585bc335\":{\"required\":false,\"sortOrder\":2},\"b1abef14-c4df-4e03-adf6-740fbfae5ddf\":{\"required\":false,\"sortOrder\":4},\"d1edff97-994f-4f78-9318-6cdbbdfd446d\":{\"required\":false,\"sortOrder\":6},\"e60a84f5-789c-489b-a95e-ae0419f4ae7d\":{\"required\":false,\"sortOrder\":7},\"e72e6691-b2c5-41b9-b75e-56b6a7200933\":{\"required\":false,\"sortOrder\":3}},\"name\":\"SEO\",\"sortOrder\":2}]}},\"handle\":\"blogPage\",\"hasTitleField\":true,\"name\":\"Blog Page\",\"sortOrder\":1,\"titleFormat\":\"\",\"titleLabel\":\"Title\"}},\"handle\":\"blogPage\",\"name\":\"Blog Page\",\"siteSettings\":{\"5a949caa-356a-45ea-b408-2b267055c99c\":{\"enabledByDefault\":true,\"hasUrls\":true,\"template\":\"blog/_index\",\"uriFormat\":\"blog\"}},\"type\":\"single\",\"propagationMethod\":\"all\"},\"20423d03-2767-4e23-8ba6-41dc15391050\":{\"enableVersioning\":true,\"entryTypes\":{\"462c63db-f464-467b-ab60-114cf3cfa50a\":{\"fieldLayouts\":{\"7e0a24cd-8e6d-48c0-8404-10b93f7f1df3\":{\"tabs\":[{\"fields\":{\"41f2c51a-22b8-4d31-ac8e-1c7b72590f7b\":{\"required\":false,\"sortOrder\":2},\"4e031b1d-eb8f-4453-90bc-165adf99fd49\":{\"required\":false,\"sortOrder\":1}},\"name\":\"Resources Page\",\"sortOrder\":1},{\"fields\":{\"0ba5cfaa-93ea-41f9-8b0b-46c048b5b209\":{\"required\":false,\"sortOrder\":5},\"27247eb3-ce02-4776-a57d-c34c35c19127\":{\"required\":false,\"sortOrder\":1},\"71853a8b-b74d-4320-83d5-b8ef585bc335\":{\"required\":false,\"sortOrder\":2},\"b1abef14-c4df-4e03-adf6-740fbfae5ddf\":{\"required\":false,\"sortOrder\":4},\"d1edff97-994f-4f78-9318-6cdbbdfd446d\":{\"required\":false,\"sortOrder\":6},\"e60a84f5-789c-489b-a95e-ae0419f4ae7d\":{\"required\":false,\"sortOrder\":7},\"e72e6691-b2c5-41b9-b75e-56b6a7200933\":{\"required\":false,\"sortOrder\":3}},\"name\":\"SEO\",\"sortOrder\":2}]}},\"handle\":\"resourcesPage\",\"hasTitleField\":true,\"name\":\"Resources Page\",\"sortOrder\":1,\"titleFormat\":\"\",\"titleLabel\":\"Title\"}},\"handle\":\"resourcesPage\",\"name\":\"Resources Page\",\"siteSettings\":{\"5a949caa-356a-45ea-b408-2b267055c99c\":{\"enabledByDefault\":true,\"hasUrls\":true,\"template\":\"resources/_index\",\"uriFormat\":\"resources\"}},\"type\":\"single\",\"propagationMethod\":\"all\"},\"31726602-42e3-461e-ad79-08d69e6e899a\":{\"enableVersioning\":\"1\",\"entryTypes\":{\"437719cf-795d-42cf-8b92-2ea1224939b4\":{\"fieldLayouts\":{\"d20835c1-2f59-4ee5-b54d-788dc9d4205d\":{\"tabs\":[{\"fields\":{\"0f8aa3f7-de9e-4beb-a7e9-e98793b3b60e\":{\"required\":false,\"sortOrder\":5},\"86444c22-bd97-4a40-9136-f5613c95ba48\":{\"required\":false,\"sortOrder\":3},\"93e2b1ce-6b60-40c8-ad40-4b1c92d2ecd1\":{\"required\":false,\"sortOrder\":2},\"d5e98a9a-c478-4cf5-8c85-1083950e2e9f\":{\"required\":false,\"sortOrder\":4},\"e6810524-42e4-4e35-8fe8-edfb548dd138\":{\"required\":false,\"sortOrder\":1}},\"name\":\"Resources\",\"sortOrder\":1},{\"fields\":{\"0ba5cfaa-93ea-41f9-8b0b-46c048b5b209\":{\"required\":false,\"sortOrder\":5},\"27247eb3-ce02-4776-a57d-c34c35c19127\":{\"required\":false,\"sortOrder\":1},\"71853a8b-b74d-4320-83d5-b8ef585bc335\":{\"required\":false,\"sortOrder\":2},\"b1abef14-c4df-4e03-adf6-740fbfae5ddf\":{\"required\":false,\"sortOrder\":4},\"d1edff97-994f-4f78-9318-6cdbbdfd446d\":{\"required\":false,\"sortOrder\":6},\"e60a84f5-789c-489b-a95e-ae0419f4ae7d\":{\"required\":false,\"sortOrder\":7},\"e72e6691-b2c5-41b9-b75e-56b6a7200933\":{\"required\":false,\"sortOrder\":3}},\"name\":\"SEO\",\"sortOrder\":2}]}},\"handle\":\"resourceLink\",\"hasTitleField\":true,\"name\":\"Direct Link\",\"sortOrder\":2,\"titleFormat\":\"\",\"titleLabel\":\"Link Title\"},\"9de11a83-392f-4ebb-9d01-e5ebaf22cf18\":{\"fieldLayouts\":{\"d076b5fb-86ae-4ca5-9a46-a9146d0aa724\":{\"tabs\":[{\"fields\":{\"0f8aa3f7-de9e-4beb-a7e9-e98793b3b60e\":{\"required\":false,\"sortOrder\":6},\"7ccca481-afc6-4d2d-a691-46d51885c73e\":{\"required\":false,\"sortOrder\":7},\"86444c22-bd97-4a40-9136-f5613c95ba48\":{\"required\":false,\"sortOrder\":4},\"8db154b4-31aa-4a46-bd7e-e040f96b91a8\":{\"required\":false,\"sortOrder\":2},\"93e2b1ce-6b60-40c8-ad40-4b1c92d2ecd1\":{\"required\":false,\"sortOrder\":3},\"d5e98a9a-c478-4cf5-8c85-1083950e2e9f\":{\"required\":false,\"sortOrder\":5},\"e6810524-42e4-4e35-8fe8-edfb548dd138\":{\"required\":false,\"sortOrder\":1}},\"name\":\"Resources\",\"sortOrder\":1},{\"fields\":{\"0ba5cfaa-93ea-41f9-8b0b-46c048b5b209\":{\"required\":false,\"sortOrder\":5},\"27247eb3-ce02-4776-a57d-c34c35c19127\":{\"required\":false,\"sortOrder\":1},\"71853a8b-b74d-4320-83d5-b8ef585bc335\":{\"required\":false,\"sortOrder\":2},\"b1abef14-c4df-4e03-adf6-740fbfae5ddf\":{\"required\":false,\"sortOrder\":4},\"d1edff97-994f-4f78-9318-6cdbbdfd446d\":{\"required\":false,\"sortOrder\":6},\"e60a84f5-789c-489b-a95e-ae0419f4ae7d\":{\"required\":false,\"sortOrder\":7},\"e72e6691-b2c5-41b9-b75e-56b6a7200933\":{\"required\":false,\"sortOrder\":3}},\"name\":\"SEO\",\"sortOrder\":2}]}},\"handle\":\"resourceFile\",\"hasTitleField\":true,\"name\":\"Resource with Detail Page\",\"sortOrder\":1,\"titleFormat\":\"\",\"titleLabel\":\"Title\"},\"a30dc10d-322d-4159-b375-7566cebf3755\":{\"fieldLayouts\":{\"2d846778-5b1a-417f-974c-9cf135d5493e\":{\"tabs\":[{\"fields\":{\"0610a849-e9bc-455c-86d5-ee8175b2ae9a\":{\"required\":false,\"sortOrder\":6},\"0f8aa3f7-de9e-4beb-a7e9-e98793b3b60e\":{\"required\":false,\"sortOrder\":5},\"7ccca481-afc6-4d2d-a691-46d51885c73e\":{\"required\":false,\"sortOrder\":7},\"86444c22-bd97-4a40-9136-f5613c95ba48\":{\"required\":false,\"sortOrder\":3},\"8db154b4-31aa-4a46-bd7e-e040f96b91a8\":{\"required\":false,\"sortOrder\":2},\"d5e98a9a-c478-4cf5-8c85-1083950e2e9f\":{\"required\":false,\"sortOrder\":4},\"e6810524-42e4-4e35-8fe8-edfb548dd138\":{\"required\":false,\"sortOrder\":1}},\"name\":\"Resources\",\"sortOrder\":1},{\"fields\":{\"0ba5cfaa-93ea-41f9-8b0b-46c048b5b209\":{\"required\":false,\"sortOrder\":5},\"27247eb3-ce02-4776-a57d-c34c35c19127\":{\"required\":false,\"sortOrder\":1},\"71853a8b-b74d-4320-83d5-b8ef585bc335\":{\"required\":false,\"sortOrder\":2},\"b1abef14-c4df-4e03-adf6-740fbfae5ddf\":{\"required\":false,\"sortOrder\":4},\"d1edff97-994f-4f78-9318-6cdbbdfd446d\":{\"required\":false,\"sortOrder\":6},\"e60a84f5-789c-489b-a95e-ae0419f4ae7d\":{\"required\":false,\"sortOrder\":7},\"e72e6691-b2c5-41b9-b75e-56b6a7200933\":{\"required\":false,\"sortOrder\":3}},\"name\":\"SEO\",\"sortOrder\":2}]}},\"handle\":\"resourceVideo\",\"hasTitleField\":true,\"name\":\"Video\",\"sortOrder\":3,\"titleFormat\":\"\",\"titleLabel\":\"Title\"}},\"handle\":\"resources\",\"name\":\"Resources\",\"siteSettings\":{\"5a949caa-356a-45ea-b408-2b267055c99c\":{\"enabledByDefault\":\"1\",\"hasUrls\":\"1\",\"template\":\"resources/_entry\",\"uriFormat\":\"resources/{slug}\"}},\"structure\":{\"maxLevels\":null,\"uid\":\"160e63e2-a512-4ade-9f18-2171d2cd84eb\"},\"type\":\"structure\",\"propagationMethod\":\"all\"},\"3375cf3e-4d50-4b42-b4ab-d8ad7e40cdfb\":{\"enableVersioning\":true,\"entryTypes\":{\"7e27ed3f-7f88-4e7a-a754-8a958f75b010\":{\"fieldLayouts\":{\"526d5de5-d527-4c83-a427-cd04ea5d1700\":{\"tabs\":[{\"fields\":{\"7ccca481-afc6-4d2d-a691-46d51885c73e\":{\"required\":false,\"sortOrder\":1}},\"name\":\"Page\",\"sortOrder\":1},{\"fields\":{\"0ba5cfaa-93ea-41f9-8b0b-46c048b5b209\":{\"required\":false,\"sortOrder\":5},\"27247eb3-ce02-4776-a57d-c34c35c19127\":{\"required\":false,\"sortOrder\":1},\"71853a8b-b74d-4320-83d5-b8ef585bc335\":{\"required\":false,\"sortOrder\":2},\"b1abef14-c4df-4e03-adf6-740fbfae5ddf\":{\"required\":false,\"sortOrder\":4},\"d1edff97-994f-4f78-9318-6cdbbdfd446d\":{\"required\":false,\"sortOrder\":6},\"e60a84f5-789c-489b-a95e-ae0419f4ae7d\":{\"required\":false,\"sortOrder\":7},\"e72e6691-b2c5-41b9-b75e-56b6a7200933\":{\"required\":false,\"sortOrder\":3}},\"name\":\"SEO\",\"sortOrder\":2}]}},\"handle\":\"aboutPage\",\"hasTitleField\":true,\"name\":\"About Page\",\"sortOrder\":1,\"titleFormat\":\"\",\"titleLabel\":\"Title\"}},\"handle\":\"aboutPages\",\"name\":\"About Pages\",\"siteSettings\":{\"5a949caa-356a-45ea-b408-2b267055c99c\":{\"enabledByDefault\":true,\"hasUrls\":true,\"template\":\"about-pages/_entry\",\"uriFormat\":\"about/{slug}\"}},\"structure\":{\"maxLevels\":\"\",\"uid\":\"bdbf4600-d3a2-4085-9cec-643027e88562\"},\"type\":\"structure\",\"propagationMethod\":\"all\"},\"548dacf3-a377-4ba7-9bc4-d9102a1fc455\":{\"enableVersioning\":\"1\",\"entryTypes\":{\"c9969320-6f22-4fd2-a0f8-0c16e95de058\":{\"fieldLayouts\":{\"9cf50bf1-ba63-4ee8-a245-f5178587bf11\":{\"tabs\":[{\"fields\":{\"41f2c51a-22b8-4d31-ac8e-1c7b72590f7b\":{\"required\":false,\"sortOrder\":2},\"4e031b1d-eb8f-4453-90bc-165adf99fd49\":{\"required\":false,\"sortOrder\":1},\"7ccca481-afc6-4d2d-a691-46d51885c73e\":{\"required\":false,\"sortOrder\":3}},\"name\":\"Contact Page\",\"sortOrder\":1},{\"fields\":{\"0ba5cfaa-93ea-41f9-8b0b-46c048b5b209\":{\"required\":false,\"sortOrder\":5},\"27247eb3-ce02-4776-a57d-c34c35c19127\":{\"required\":false,\"sortOrder\":1},\"71853a8b-b74d-4320-83d5-b8ef585bc335\":{\"required\":false,\"sortOrder\":2},\"b1abef14-c4df-4e03-adf6-740fbfae5ddf\":{\"required\":false,\"sortOrder\":4},\"d1edff97-994f-4f78-9318-6cdbbdfd446d\":{\"required\":false,\"sortOrder\":6},\"e60a84f5-789c-489b-a95e-ae0419f4ae7d\":{\"required\":false,\"sortOrder\":7},\"e72e6691-b2c5-41b9-b75e-56b6a7200933\":{\"required\":false,\"sortOrder\":3}},\"name\":\"SEO\",\"sortOrder\":2}]}},\"handle\":\"contact\",\"hasTitleField\":true,\"name\":\"Contact Page\",\"sortOrder\":1,\"titleFormat\":\"\",\"titleLabel\":\"Title\"}},\"handle\":\"contactPage\",\"name\":\"Contact Page\",\"siteSettings\":{\"5a949caa-356a-45ea-b408-2b267055c99c\":{\"enabledByDefault\":\"1\",\"hasUrls\":\"1\",\"template\":\"_contact\",\"uriFormat\":\"contact\"}},\"type\":\"single\",\"propagationMethod\":\"all\"},\"550e9481-b606-4b2b-83e1-9a895a224d38\":{\"enableVersioning\":\"1\",\"entryTypes\":{\"349bc9d5-448b-4314-a81e-d76e7cca8758\":{\"fieldLayouts\":{\"ac958f47-de51-41e3-984f-6805af639de4\":{\"tabs\":[{\"fields\":{\"26f42a7b-fe45-4cc5-9535-49a9e14a7446\":{\"required\":false,\"sortOrder\":1},\"7ccca481-afc6-4d2d-a691-46d51885c73e\":{\"required\":false,\"sortOrder\":3},\"fcc7f6c3-97c3-4ab3-8555-f630f7deb9cb\":{\"required\":false,\"sortOrder\":2}},\"name\":\"News\",\"sortOrder\":1},{\"fields\":{\"0ba5cfaa-93ea-41f9-8b0b-46c048b5b209\":{\"required\":false,\"sortOrder\":5},\"27247eb3-ce02-4776-a57d-c34c35c19127\":{\"required\":false,\"sortOrder\":1},\"71853a8b-b74d-4320-83d5-b8ef585bc335\":{\"required\":false,\"sortOrder\":2},\"b1abef14-c4df-4e03-adf6-740fbfae5ddf\":{\"required\":false,\"sortOrder\":4},\"d1edff97-994f-4f78-9318-6cdbbdfd446d\":{\"required\":false,\"sortOrder\":6},\"e60a84f5-789c-489b-a95e-ae0419f4ae7d\":{\"required\":false,\"sortOrder\":7},\"e72e6691-b2c5-41b9-b75e-56b6a7200933\":{\"required\":false,\"sortOrder\":3}},\"name\":\"SEO\",\"sortOrder\":2}]}},\"handle\":\"newsArticle\",\"hasTitleField\":true,\"name\":\"News Article\",\"sortOrder\":1,\"titleFormat\":\"\",\"titleLabel\":\"Title\"}},\"handle\":\"news\",\"name\":\"News Articles\",\"siteSettings\":{\"5a949caa-356a-45ea-b408-2b267055c99c\":{\"enabledByDefault\":\"1\",\"hasUrls\":\"1\",\"template\":\"news/_entry\",\"uriFormat\":\"news/{slug}\"}},\"type\":\"channel\",\"propagationMethod\":\"all\"},\"698462dc-1720-42e6-a09e-9e59bce0aa23\":{\"enableVersioning\":true,\"entryTypes\":{\"3e918fe0-05a0-4a21-88e8-4fe6125a5fae\":{\"fieldLayouts\":{\"ea944f54-0a0b-4e11-8d1c-ea74cbdd2e20\":{\"tabs\":[{\"fields\":{\"41f2c51a-22b8-4d31-ac8e-1c7b72590f7b\":{\"required\":false,\"sortOrder\":2},\"4e031b1d-eb8f-4453-90bc-165adf99fd49\":{\"required\":false,\"sortOrder\":1},\"7ccca481-afc6-4d2d-a691-46d51885c73e\":{\"required\":false,\"sortOrder\":3}},\"name\":\"Privacy Page\",\"sortOrder\":1},{\"fields\":{\"0ba5cfaa-93ea-41f9-8b0b-46c048b5b209\":{\"required\":false,\"sortOrder\":5},\"27247eb3-ce02-4776-a57d-c34c35c19127\":{\"required\":false,\"sortOrder\":1},\"71853a8b-b74d-4320-83d5-b8ef585bc335\":{\"required\":false,\"sortOrder\":2},\"b1abef14-c4df-4e03-adf6-740fbfae5ddf\":{\"required\":false,\"sortOrder\":4},\"d1edff97-994f-4f78-9318-6cdbbdfd446d\":{\"required\":false,\"sortOrder\":6},\"e60a84f5-789c-489b-a95e-ae0419f4ae7d\":{\"required\":false,\"sortOrder\":7},\"e72e6691-b2c5-41b9-b75e-56b6a7200933\":{\"required\":false,\"sortOrder\":3}},\"name\":\"SEO\",\"sortOrder\":2}]}},\"handle\":\"privacyPage\",\"hasTitleField\":true,\"name\":\"Privacy Page\",\"sortOrder\":1,\"titleFormat\":\"\",\"titleLabel\":\"Title\"}},\"handle\":\"privacyPage\",\"name\":\"Privacy Page\",\"siteSettings\":{\"5a949caa-356a-45ea-b408-2b267055c99c\":{\"enabledByDefault\":true,\"hasUrls\":true,\"template\":\"_default\",\"uriFormat\":\"privacy\"}},\"type\":\"single\",\"propagationMethod\":\"all\"},\"6e318b58-9c19-4a89-aece-8db4a7b52124\":{\"enableVersioning\":true,\"entryTypes\":{\"181988f5-74b6-4bf7-8825-b5e458651ce9\":{\"fieldLayouts\":{\"8de5acbb-9542-411b-a05d-37bfd2da5cae\":{\"tabs\":[{\"fields\":{\"41f2c51a-22b8-4d31-ac8e-1c7b72590f7b\":{\"required\":false,\"sortOrder\":2},\"4e031b1d-eb8f-4453-90bc-165adf99fd49\":{\"required\":false,\"sortOrder\":1},\"7ccca481-afc6-4d2d-a691-46d51885c73e\":{\"required\":false,\"sortOrder\":3}},\"name\":\"Error Page\",\"sortOrder\":1},{\"fields\":{\"0ba5cfaa-93ea-41f9-8b0b-46c048b5b209\":{\"required\":false,\"sortOrder\":5},\"27247eb3-ce02-4776-a57d-c34c35c19127\":{\"required\":false,\"sortOrder\":1},\"71853a8b-b74d-4320-83d5-b8ef585bc335\":{\"required\":false,\"sortOrder\":2},\"b1abef14-c4df-4e03-adf6-740fbfae5ddf\":{\"required\":false,\"sortOrder\":4},\"d1edff97-994f-4f78-9318-6cdbbdfd446d\":{\"required\":false,\"sortOrder\":6},\"e60a84f5-789c-489b-a95e-ae0419f4ae7d\":{\"required\":false,\"sortOrder\":7},\"e72e6691-b2c5-41b9-b75e-56b6a7200933\":{\"required\":false,\"sortOrder\":3}},\"name\":\"SEO\",\"sortOrder\":2}]}},\"handle\":\"errorPage\",\"hasTitleField\":true,\"name\":\"Error Page\",\"sortOrder\":1,\"titleFormat\":\"\",\"titleLabel\":\"Title\"}},\"handle\":\"errorPage\",\"name\":\"Error Page\",\"siteSettings\":{\"5a949caa-356a-45ea-b408-2b267055c99c\":{\"enabledByDefault\":true,\"hasUrls\":true,\"template\":\"_500\",\"uriFormat\":\"500\"}},\"type\":\"single\",\"propagationMethod\":\"all\"},\"7b352338-e4c1-4527-8c7b-dd3ae5e9d28f\":{\"enableVersioning\":\"1\",\"entryTypes\":{\"f1e078e0-561e-47be-a5bb-1ad7b61ab109\":{\"fieldLayouts\":{\"86bcae7c-d21c-4701-ac07-b3365f0ec05a\":{\"tabs\":[{\"fields\":{\"7ccca481-afc6-4d2d-a691-46d51885c73e\":{\"required\":\"0\",\"sortOrder\":\"4\"},\"c2f6ae57-a58a-4ddb-8776-b3510df685a6\":{\"required\":\"1\",\"sortOrder\":\"1\"},\"cd059144-5cb6-46db-bcea-8d8e1d747107\":{\"required\":\"0\",\"sortOrder\":\"2\"},\"fcc7f6c3-97c3-4ab3-8555-f630f7deb9cb\":{\"required\":\"0\",\"sortOrder\":\"3\"}},\"name\":\"Events\",\"sortOrder\":\"1\"},{\"fields\":{\"0ba5cfaa-93ea-41f9-8b0b-46c048b5b209\":{\"required\":\"0\",\"sortOrder\":\"5\"},\"27247eb3-ce02-4776-a57d-c34c35c19127\":{\"required\":\"0\",\"sortOrder\":\"1\"},\"71853a8b-b74d-4320-83d5-b8ef585bc335\":{\"required\":\"0\",\"sortOrder\":\"2\"},\"b1abef14-c4df-4e03-adf6-740fbfae5ddf\":{\"required\":\"0\",\"sortOrder\":\"4\"},\"d1edff97-994f-4f78-9318-6cdbbdfd446d\":{\"required\":\"0\",\"sortOrder\":\"6\"},\"e60a84f5-789c-489b-a95e-ae0419f4ae7d\":{\"required\":\"0\",\"sortOrder\":\"7\"},\"e72e6691-b2c5-41b9-b75e-56b6a7200933\":{\"required\":\"0\",\"sortOrder\":\"3\"}},\"name\":\"SEO\",\"sortOrder\":\"2\"}]}},\"handle\":\"event\",\"hasTitleField\":\"1\",\"name\":\"Event\",\"sortOrder\":\"1\",\"titleFormat\":null,\"titleLabel\":\"Title\"}},\"handle\":\"events\",\"name\":\"Events\",\"siteSettings\":{\"5a949caa-356a-45ea-b408-2b267055c99c\":{\"enabledByDefault\":\"1\",\"hasUrls\":\"1\",\"template\":\"events/_entry\",\"uriFormat\":\"events/{slug}\"}},\"type\":\"channel\",\"propagationMethod\":\"all\"},\"804ebac0-45d8-49c0-9e1f-418cc9c708e7\":{\"enableVersioning\":true,\"entryTypes\":{\"969995e1-dbd5-42c5-917f-a13e492a5c83\":{\"fieldLayouts\":{\"e20267cc-14f4-404a-8584-47f2d9632f91\":{\"tabs\":[{\"fields\":{\"41f2c51a-22b8-4d31-ac8e-1c7b72590f7b\":{\"required\":false,\"sortOrder\":2},\"4e031b1d-eb8f-4453-90bc-165adf99fd49\":{\"required\":false,\"sortOrder\":1},\"7ccca481-afc6-4d2d-a691-46d51885c73e\":{\"required\":false,\"sortOrder\":3}},\"name\":\"Homepage\",\"sortOrder\":1},{\"fields\":{\"0ba5cfaa-93ea-41f9-8b0b-46c048b5b209\":{\"required\":false,\"sortOrder\":5},\"27247eb3-ce02-4776-a57d-c34c35c19127\":{\"required\":false,\"sortOrder\":1},\"71853a8b-b74d-4320-83d5-b8ef585bc335\":{\"required\":false,\"sortOrder\":2},\"b1abef14-c4df-4e03-adf6-740fbfae5ddf\":{\"required\":false,\"sortOrder\":4},\"d1edff97-994f-4f78-9318-6cdbbdfd446d\":{\"required\":false,\"sortOrder\":6},\"e60a84f5-789c-489b-a95e-ae0419f4ae7d\":{\"required\":false,\"sortOrder\":7},\"e72e6691-b2c5-41b9-b75e-56b6a7200933\":{\"required\":false,\"sortOrder\":3}},\"name\":\"SEO\",\"sortOrder\":2}]}},\"handle\":\"homepage\",\"hasTitleField\":true,\"name\":\"Homepage\",\"sortOrder\":1,\"titleFormat\":\"\",\"titleLabel\":\"Title\"}},\"handle\":\"homepage\",\"name\":\"Homepage\",\"siteSettings\":{\"5a949caa-356a-45ea-b408-2b267055c99c\":{\"enabledByDefault\":true,\"hasUrls\":true,\"template\":\"_index\",\"uriFormat\":\"__home__\"}},\"type\":\"single\",\"propagationMethod\":\"all\"},\"aa4b309e-df7a-47cf-9aa5-25285f46796f\":{\"enableVersioning\":true,\"entryTypes\":{\"754177a1-494c-4f11-806a-112af873ab1d\":{\"fieldLayouts\":{\"4e5979ac-1357-4a9f-82a0-518c1c980b52\":{\"tabs\":[{\"fields\":{\"41f2c51a-22b8-4d31-ac8e-1c7b72590f7b\":{\"required\":\"0\",\"sortOrder\":\"2\"},\"4e031b1d-eb8f-4453-90bc-165adf99fd49\":{\"required\":\"0\",\"sortOrder\":\"1\"},\"7ccca481-afc6-4d2d-a691-46d51885c73e\":{\"required\":\"0\",\"sortOrder\":\"3\"}},\"name\":\"Page Not Found\",\"sortOrder\":\"1\"},{\"fields\":{\"0ba5cfaa-93ea-41f9-8b0b-46c048b5b209\":{\"required\":\"0\",\"sortOrder\":\"5\"},\"27247eb3-ce02-4776-a57d-c34c35c19127\":{\"required\":\"0\",\"sortOrder\":\"1\"},\"71853a8b-b74d-4320-83d5-b8ef585bc335\":{\"required\":\"0\",\"sortOrder\":\"2\"},\"b1abef14-c4df-4e03-adf6-740fbfae5ddf\":{\"required\":\"0\",\"sortOrder\":\"4\"},\"d1edff97-994f-4f78-9318-6cdbbdfd446d\":{\"required\":\"0\",\"sortOrder\":\"6\"},\"e60a84f5-789c-489b-a95e-ae0419f4ae7d\":{\"required\":\"0\",\"sortOrder\":\"7\"},\"e72e6691-b2c5-41b9-b75e-56b6a7200933\":{\"required\":\"0\",\"sortOrder\":\"3\"}},\"name\":\"SEO\",\"sortOrder\":\"2\"}]}},\"handle\":\"notFoundPage\",\"hasTitleField\":\"1\",\"name\":\"404 Page\",\"sortOrder\":1,\"titleFormat\":\"\",\"titleLabel\":\"Title\"}},\"handle\":\"notFoundPage\",\"name\":\"404 Page\",\"siteSettings\":{\"5a949caa-356a-45ea-b408-2b267055c99c\":{\"enabledByDefault\":true,\"hasUrls\":true,\"template\":\"_404\",\"uriFormat\":\"404\"}},\"type\":\"single\",\"propagationMethod\":\"all\"},\"c87b5acc-afe1-4ddf-b73c-b449c9f29c2d\":{\"enableVersioning\":true,\"entryTypes\":{\"1eb9445b-5596-41c4-b25c-ec44e9a4ec0a\":{\"fieldLayouts\":{\"1a8ec962-5e1a-4f63-9419-4a15ee59deea\":{\"tabs\":[{\"fields\":{\"48df7913-438b-433b-96d3-163d33a83ea7\":{\"required\":\"0\",\"sortOrder\":\"2\"},\"a3601ba7-e21f-4718-86f2-0c19eae0d32f\":{\"required\":\"0\",\"sortOrder\":\"1\"},\"a3f637cc-edb1-4bae-83f3-a40127804401\":{\"required\":\"1\",\"sortOrder\":\"4\"},\"c2fc9bf0-5ff5-4af8-ae54-5ca0a7ce5db4\":{\"required\":\"1\",\"sortOrder\":\"3\"}},\"name\":\"People\",\"sortOrder\":\"1\"},{\"fields\":{\"0ba5cfaa-93ea-41f9-8b0b-46c048b5b209\":{\"required\":\"0\",\"sortOrder\":\"5\"},\"27247eb3-ce02-4776-a57d-c34c35c19127\":{\"required\":\"0\",\"sortOrder\":\"1\"},\"71853a8b-b74d-4320-83d5-b8ef585bc335\":{\"required\":\"0\",\"sortOrder\":\"2\"},\"b1abef14-c4df-4e03-adf6-740fbfae5ddf\":{\"required\":\"0\",\"sortOrder\":\"4\"},\"d1edff97-994f-4f78-9318-6cdbbdfd446d\":{\"required\":\"0\",\"sortOrder\":\"6\"},\"e60a84f5-789c-489b-a95e-ae0419f4ae7d\":{\"required\":\"0\",\"sortOrder\":\"7\"},\"e72e6691-b2c5-41b9-b75e-56b6a7200933\":{\"required\":\"0\",\"sortOrder\":\"3\"}},\"name\":\"SEO\",\"sortOrder\":\"2\"}]}},\"handle\":\"person\",\"hasTitleField\":\"1\",\"name\":\"Person\",\"sortOrder\":\"1\",\"titleFormat\":null,\"titleLabel\":\"Name\"}},\"handle\":\"people\",\"name\":\"People\",\"siteSettings\":{\"5a949caa-356a-45ea-b408-2b267055c99c\":{\"enabledByDefault\":true,\"hasUrls\":true,\"template\":\"leadership/_entry\",\"uriFormat\":\"leadership/{slug}\"}},\"structure\":{\"maxLevels\":\"\",\"uid\":\"4b707a60-93c9-4e86-a44c-587eb894590e\"},\"type\":\"structure\",\"propagationMethod\":\"all\"},\"ca363472-ca75-4a5e-9e46-dc48bfec0b5d\":{\"enableVersioning\":true,\"entryTypes\":{\"035617c5-1f35-490e-9216-fd539fee3802\":{\"fieldLayouts\":{\"53a19581-50e6-4ccd-8371-183e0b95c440\":{\"tabs\":[{\"fields\":{\"41f2c51a-22b8-4d31-ac8e-1c7b72590f7b\":{\"required\":false,\"sortOrder\":2},\"4e031b1d-eb8f-4453-90bc-165adf99fd49\":{\"required\":false,\"sortOrder\":1}},\"name\":\"News & Events Page\",\"sortOrder\":1},{\"fields\":{\"0ba5cfaa-93ea-41f9-8b0b-46c048b5b209\":{\"required\":false,\"sortOrder\":5},\"27247eb3-ce02-4776-a57d-c34c35c19127\":{\"required\":false,\"sortOrder\":1},\"71853a8b-b74d-4320-83d5-b8ef585bc335\":{\"required\":false,\"sortOrder\":2},\"b1abef14-c4df-4e03-adf6-740fbfae5ddf\":{\"required\":false,\"sortOrder\":4},\"d1edff97-994f-4f78-9318-6cdbbdfd446d\":{\"required\":false,\"sortOrder\":6},\"e60a84f5-789c-489b-a95e-ae0419f4ae7d\":{\"required\":false,\"sortOrder\":7},\"e72e6691-b2c5-41b9-b75e-56b6a7200933\":{\"required\":false,\"sortOrder\":3}},\"name\":\"SEO\",\"sortOrder\":2}]}},\"handle\":\"newsEventsPage\",\"hasTitleField\":true,\"name\":\"News & Events Page\",\"sortOrder\":1,\"titleFormat\":\"\",\"titleLabel\":\"Title\"}},\"handle\":\"newsEventsPage\",\"name\":\"News & Events Page\",\"siteSettings\":{\"5a949caa-356a-45ea-b408-2b267055c99c\":{\"enabledByDefault\":true,\"hasUrls\":true,\"template\":\"news/_index\",\"uriFormat\":\"news\"}},\"type\":\"single\",\"propagationMethod\":\"all\"},\"d44a5a95-fa08-4efd-8496-2ac825c5acd1\":{\"enableVersioning\":true,\"entryTypes\":{\"2ddfd638-9959-4fb7-877b-10b6424503bc\":{\"fieldLayouts\":{\"645a65f2-ba3e-489e-a506-53888b688a58\":{\"tabs\":[{\"fields\":{\"41f2c51a-22b8-4d31-ac8e-1c7b72590f7b\":{\"required\":false,\"sortOrder\":2},\"4e031b1d-eb8f-4453-90bc-165adf99fd49\":{\"required\":false,\"sortOrder\":1},\"7ccca481-afc6-4d2d-a691-46d51885c73e\":{\"required\":false,\"sortOrder\":3}},\"name\":\"Service Unavailable Page\",\"sortOrder\":1},{\"fields\":{\"0ba5cfaa-93ea-41f9-8b0b-46c048b5b209\":{\"required\":false,\"sortOrder\":5},\"27247eb3-ce02-4776-a57d-c34c35c19127\":{\"required\":false,\"sortOrder\":1},\"71853a8b-b74d-4320-83d5-b8ef585bc335\":{\"required\":false,\"sortOrder\":2},\"b1abef14-c4df-4e03-adf6-740fbfae5ddf\":{\"required\":false,\"sortOrder\":4},\"d1edff97-994f-4f78-9318-6cdbbdfd446d\":{\"required\":false,\"sortOrder\":6},\"e60a84f5-789c-489b-a95e-ae0419f4ae7d\":{\"required\":false,\"sortOrder\":7},\"e72e6691-b2c5-41b9-b75e-56b6a7200933\":{\"required\":false,\"sortOrder\":3}},\"name\":\"SEO\",\"sortOrder\":2}]}},\"handle\":\"serviceUnavailablePage\",\"hasTitleField\":true,\"name\":\"Service Unavailable Page\",\"sortOrder\":1,\"titleFormat\":\"{section.name|raw}\",\"titleLabel\":\"Title\"}},\"handle\":\"serviceUnavailablePage\",\"name\":\"Service Unavailable Page\",\"siteSettings\":{\"5a949caa-356a-45ea-b408-2b267055c99c\":{\"enabledByDefault\":true,\"hasUrls\":true,\"template\":\"503\",\"uriFormat\":\"503\"}},\"type\":\"single\",\"propagationMethod\":\"all\"},\"ebac57bc-baaf-4975-bf81-a0f4c66bad4d\":{\"enableVersioning\":true,\"entryTypes\":{\"2091741e-3916-401f-8b4c-00ee93c78914\":{\"fieldLayouts\":{\"fcafbf82-4515-43af-a24a-7f217a658441\":{\"tabs\":[{\"fields\":{\"41f2c51a-22b8-4d31-ac8e-1c7b72590f7b\":{\"required\":false,\"sortOrder\":2},\"4e031b1d-eb8f-4453-90bc-165adf99fd49\":{\"required\":false,\"sortOrder\":1},\"7ccca481-afc6-4d2d-a691-46d51885c73e\":{\"required\":false,\"sortOrder\":3}},\"name\":\"About Page\",\"sortOrder\":1},{\"fields\":{\"0ba5cfaa-93ea-41f9-8b0b-46c048b5b209\":{\"required\":false,\"sortOrder\":5},\"27247eb3-ce02-4776-a57d-c34c35c19127\":{\"required\":false,\"sortOrder\":1},\"71853a8b-b74d-4320-83d5-b8ef585bc335\":{\"required\":false,\"sortOrder\":2},\"b1abef14-c4df-4e03-adf6-740fbfae5ddf\":{\"required\":false,\"sortOrder\":4},\"d1edff97-994f-4f78-9318-6cdbbdfd446d\":{\"required\":false,\"sortOrder\":6},\"e60a84f5-789c-489b-a95e-ae0419f4ae7d\":{\"required\":false,\"sortOrder\":7},\"e72e6691-b2c5-41b9-b75e-56b6a7200933\":{\"required\":false,\"sortOrder\":3}},\"name\":\"SEO\",\"sortOrder\":2}]}},\"handle\":\"aboutPage\",\"hasTitleField\":true,\"name\":\"About Page\",\"sortOrder\":1,\"titleFormat\":\"\",\"titleLabel\":\"Title\"}},\"handle\":\"aboutPage\",\"name\":\"About Page\",\"siteSettings\":{\"5a949caa-356a-45ea-b408-2b267055c99c\":{\"enabledByDefault\":true,\"hasUrls\":true,\"template\":\"about/_index\",\"uriFormat\":\"about\"}},\"type\":\"single\",\"propagationMethod\":\"all\"},\"fdc8d709-53c4-4104-ba7b-f424bad5b7fc\":{\"enableVersioning\":\"1\",\"entryTypes\":{\"2bce713c-e1dd-4517-8bf0-60f2c1165bc3\":{\"fieldLayouts\":{\"e744b3df-827b-46ec-b7e0-fe4738064897\":{\"tabs\":[{\"fields\":{\"2575b2df-9c7d-43dc-b00c-7c8b4a389b22\":{\"required\":\"0\",\"sortOrder\":\"5\"},\"7ccca481-afc6-4d2d-a691-46d51885c73e\":{\"required\":\"1\",\"sortOrder\":\"6\"},\"a889cfc2-e16d-4719-88be-773bf11567f4\":{\"required\":\"0\",\"sortOrder\":\"4\"},\"b54bac54-a6a2-4e19-af8b-eead56deed68\":{\"required\":\"0\",\"sortOrder\":\"2\"},\"c2b63486-bb0e-42d6-9986-12cead0acc47\":{\"required\":\"0\",\"sortOrder\":\"1\"},\"fe9f15e5-2b68-477e-af16-c6e83c83e642\":{\"required\":\"0\",\"sortOrder\":\"3\"}},\"name\":\"Blog\",\"sortOrder\":\"1\"},{\"fields\":{\"0ba5cfaa-93ea-41f9-8b0b-46c048b5b209\":{\"required\":\"0\",\"sortOrder\":\"5\"},\"27247eb3-ce02-4776-a57d-c34c35c19127\":{\"required\":\"0\",\"sortOrder\":\"1\"},\"71853a8b-b74d-4320-83d5-b8ef585bc335\":{\"required\":\"0\",\"sortOrder\":\"2\"},\"b1abef14-c4df-4e03-adf6-740fbfae5ddf\":{\"required\":\"0\",\"sortOrder\":\"4\"},\"d1edff97-994f-4f78-9318-6cdbbdfd446d\":{\"required\":\"0\",\"sortOrder\":\"6\"},\"e60a84f5-789c-489b-a95e-ae0419f4ae7d\":{\"required\":\"0\",\"sortOrder\":\"7\"},\"e72e6691-b2c5-41b9-b75e-56b6a7200933\":{\"required\":\"0\",\"sortOrder\":\"3\"}},\"name\":\"SEO\",\"sortOrder\":\"2\"}]}},\"handle\":\"blog\",\"hasTitleField\":\"1\",\"name\":\"Blog Article\",\"sortOrder\":\"1\",\"titleFormat\":null,\"titleLabel\":\"Title\"}},\"handle\":\"blog\",\"name\":\"Blog Articles\",\"siteSettings\":{\"5a949caa-356a-45ea-b408-2b267055c99c\":{\"enabledByDefault\":\"1\",\"hasUrls\":\"1\",\"template\":\"blog/_entry\",\"uriFormat\":\"blog/{slug}\"}},\"type\":\"channel\",\"propagationMethod\":\"all\"}},\"siteGroups\":{\"a20a79e6-31e4-4179-833c-e756db8c0d15\":{\"name\":\"Padstone\"}},\"sites\":{\"5a949caa-356a-45ea-b408-2b267055c99c\":{\"baseUrl\":\"http://dev.padstone.imarc.com/\",\"handle\":\"default\",\"hasUrls\":\"1\",\"language\":\"en-US\",\"name\":\"Padstone\",\"primary\":\"1\",\"siteGroup\":\"a20a79e6-31e4-4179-833c-e756db8c0d15\",\"sortOrder\":\"1\"}},\"system\":{\"edition\":\"solo\",\"live\":true,\"name\":\"Padstone\",\"schemaVersion\":\"3.3.3\",\"timeZone\":\"America/Los_Angeles\"},\"users\":{\"allowPublicRegistration\":false,\"defaultGroup\":null,\"photoSubpath\":\"\",\"photoVolumeUid\":null,\"requireEmailVerification\":true},\"volumes\":{\"09773b73-a304-4513-84fd-c4d5d4dd953a\":{\"name\":\"Images\",\"handle\":\"images\",\"type\":\"craft\\\\volumes\\\\Local\",\"hasUrls\":true,\"url\":\"/images\",\"settings\":{\"path\":\"@webroot/images\"},\"sortOrder\":1,\"fieldLayouts\":{\"de763855-6652-40e7-a14a-311417ca2d41\":{\"tabs\":[{\"name\":\"Content\",\"sortOrder\":1,\"fields\":{\"8fda9d17-0a07-4bc1-a1f4-1fe23066f315\":{\"required\":false,\"sortOrder\":1}}}]}}},\"57423459-e14e-4a06-af08-3f1c378379ba\":{\"handle\":\"resources\",\"hasUrls\":true,\"name\":\"Resources\",\"settings\":{\"path\":\"@webroot/resources\"},\"sortOrder\":2,\"type\":\"craft\\\\volumes\\\\Local\",\"url\":\"/resources\"}}}','{\"categoryGroups\":\"@config/project.yaml\",\"dateModified\":\"@config/project.yaml\",\"email\":\"@config/project.yaml\",\"fieldGroups\":\"@config/project.yaml\",\"fields\":\"@config/project.yaml\",\"matrixBlockTypes\":\"@config/project.yaml\",\"plugins\":\"@config/project.yaml\",\"sections\":\"@config/project.yaml\",\"siteGroups\":\"@config/project.yaml\",\"sites\":\"@config/project.yaml\",\"system\":\"@config/project.yaml\",\"users\":\"@config/project.yaml\",\"volumes\":\"@config/project.yaml\"}','DuDgVeNlfMIF','2017-11-29 20:51:54','2019-12-20 16:16:04','c186921c-3ab0-4627-92da-ad0c58d9dd65');
/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matrixblocks`
--

DROP TABLE IF EXISTS `matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matrixblocks`
--

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;
INSERT INTO `matrixblocks` VALUES (32,15,11,1,1,NULL,'2019-03-05 23:02:52','2019-03-12 16:06:41','6ba14581-9248-46fe-a1dc-0c398379d465'),(33,15,11,2,2,NULL,'2019-03-05 23:02:53','2019-03-12 16:06:42','dc19009c-b8ec-477c-9838-5e7b9a6ae70c'),(34,15,11,6,3,NULL,'2019-03-05 23:02:53','2019-03-12 16:06:42','85474df0-27b3-4482-b57d-039df9313fdf'),(35,15,11,8,4,NULL,'2019-03-05 23:02:53','2019-03-12 16:06:42','c8687d91-c2a5-4399-905a-bf9bc3374b98'),(37,36,11,1,1,NULL,'2019-03-11 18:17:26','2019-03-11 19:42:02','50bf9066-d5eb-4a77-b205-4b79f6041af4'),(39,38,11,1,1,NULL,'2019-03-11 18:18:29','2019-03-11 21:07:48','af4cb2fc-eb6e-4deb-b013-0dd05f246819'),(41,40,11,1,1,NULL,'2019-03-11 18:19:11','2019-03-11 18:19:28','99017285-d9bc-424e-be02-43ab7909dcb5'),(43,36,11,2,2,NULL,'2019-03-11 19:42:02','2019-03-11 19:42:02','24fd778e-11f0-4313-97af-f296d145944d'),(45,44,11,1,1,NULL,'2019-03-11 20:01:52','2019-03-11 20:02:43','ae5b9c5a-61c0-4b32-b95d-71e53c28aa6c'),(49,48,11,1,1,NULL,'2019-03-12 16:06:37','2019-03-12 16:06:37','cb352b1d-767f-4bb9-8131-3f1cfc4510ae'),(50,15,11,9,5,NULL,'2019-03-12 16:06:42','2019-03-12 16:06:42','1079b25c-86ed-47e1-952b-8537b8cf3786'),(57,56,11,1,1,NULL,'2019-12-20 16:17:53','2019-12-20 16:17:53','7e7e1968-1188-47ac-b0b2-23c1072f483c'),(58,56,11,2,2,NULL,'2019-12-20 16:17:54','2019-12-20 16:17:54','14422df1-b5c6-4ff5-8ab2-0d3103aaf33f'),(59,56,11,6,3,NULL,'2019-12-20 16:17:54','2019-12-20 16:17:54','0c7e04e8-01c8-4a7d-8584-a4e30e846899'),(60,56,11,8,4,NULL,'2019-12-20 16:17:54','2019-12-20 16:17:54','bfdfcf61-99e9-4753-b094-b7e3bcd0e55d'),(61,56,11,9,5,NULL,'2019-12-20 16:17:55','2019-12-20 16:17:55','15ebd1f0-e2c3-4a87-886a-d67c6b6266f4'),(63,62,11,1,1,NULL,'2019-12-20 16:17:57','2019-12-20 16:17:57','057673c0-d076-43c7-b41b-3d9fa357de58'),(69,68,11,1,1,NULL,'2019-12-20 16:18:02','2019-12-20 16:18:02','c4bacf43-2d15-46ef-853e-320fc269c132'),(71,70,11,1,1,NULL,'2019-12-20 16:18:04','2019-12-20 16:18:04','5e2bfecb-f335-456b-bbde-7050a1948edb'),(75,74,11,1,1,NULL,'2019-12-20 16:18:11','2019-12-20 16:18:11','4a784981-8ea9-4eab-ad4c-33c4e1a6919f'),(76,74,11,2,2,NULL,'2019-12-20 16:18:12','2019-12-20 16:18:12','790120e0-cd97-4122-96b8-86b98a19741c'),(83,82,11,1,1,NULL,'2019-12-20 16:18:21','2019-12-20 16:18:21','970099dd-6404-40cd-85c7-602fcbe0f5b7'),(85,84,11,1,1,NULL,'2019-12-20 16:18:22','2019-12-20 16:18:22','8e263834-574a-499f-8cc6-338d129c5271'),(86,84,11,2,2,0,'2019-12-20 16:18:23','2019-12-20 16:18:23','d72f5eb2-b16e-4950-a162-d28d34aebeea'),(100,99,11,1,1,NULL,'2019-12-20 16:18:31','2019-12-20 16:18:31','a0c4b748-4e79-4527-9087-f97042129ab7'),(101,99,11,2,2,NULL,'2019-12-20 16:18:32','2019-12-20 16:18:32','68df8273-b28a-4237-b012-1e96c8643307'),(102,99,11,6,3,NULL,'2019-12-20 16:18:32','2019-12-20 16:18:32','09449bb3-cef5-4f1b-a37f-372421faad5d'),(103,99,11,8,4,NULL,'2019-12-20 16:18:32','2019-12-20 16:18:32','fe922381-c4d9-4fbb-8df4-e536c68c239e'),(104,99,11,9,5,0,'2019-12-20 16:18:32','2019-12-20 16:18:32','c15967c5-16c1-44a5-9951-fb2f0b166189'),(119,118,11,1,1,NULL,'2019-12-20 16:18:41','2019-12-20 16:18:41','9a661430-b5e6-4154-897f-af43f20a0ab0'),(120,118,11,2,2,NULL,'2019-12-20 16:18:42','2019-12-20 16:18:42','ac25c442-901a-4abd-acd8-8eff55299d21'),(121,118,11,6,3,NULL,'2019-12-20 16:18:43','2019-12-20 16:18:43','5e9c039b-5dcf-4d20-873c-8562e03c3a59'),(122,118,11,8,4,NULL,'2019-12-20 16:18:43','2019-12-20 16:18:43','2736dc56-556d-430d-9e23-c9c4855324b8'),(123,118,11,9,5,0,'2019-12-20 16:18:43','2019-12-20 16:18:43','16e37c3f-b446-40a0-adfa-2291be0dcd5b'),(125,124,11,1,1,NULL,'2019-12-20 16:18:44','2019-12-20 16:18:44','333fb6ab-ee37-4290-9126-92ab5c77fd33'),(126,124,11,2,2,NULL,'2019-12-20 16:18:45','2019-12-20 16:18:45','7649d01a-1fbd-45f5-b29b-a4335a4516c2'),(127,124,11,6,3,NULL,'2019-12-20 16:18:45','2019-12-20 16:18:45','8977dde1-22c7-477e-a256-e13e51e3f783'),(128,124,11,8,4,NULL,'2019-12-20 16:18:46','2019-12-20 16:18:46','df998020-71a8-4622-9435-593505e3b8e9'),(129,124,11,9,5,0,'2019-12-20 16:18:46','2019-12-20 16:18:46','bce6f97c-0b72-4da5-84ca-c1139d0cc2ad'),(133,132,11,1,1,0,'2019-12-20 16:18:49','2019-12-20 16:18:49','696e1405-162c-4e02-8e81-2afdff66ac5d'),(134,132,11,2,2,0,'2019-12-20 16:18:50','2019-12-20 16:18:50','9dbd61ed-9f82-4b57-bc8f-e0961f711892'),(135,132,11,6,3,0,'2019-12-20 16:18:50','2019-12-20 16:18:50','3262a9c7-6098-4a5f-a8f8-f060979e5178'),(136,132,11,8,4,0,'2019-12-20 16:18:51','2019-12-20 16:18:51','ed46082a-ffe0-4722-b303-66da767ebc4b'),(137,132,11,9,5,0,'2019-12-20 16:18:51','2019-12-20 16:18:51','b0a2254b-b901-43d0-96a0-3e37e6c7f44c'),(139,138,11,1,1,0,'2019-12-20 16:18:52','2019-12-20 16:18:52','341cbbdd-80d4-494c-80fb-ccfc790880d2'),(140,138,11,2,2,0,'2019-12-20 16:18:53','2019-12-20 16:18:53','607d249b-ad54-41ed-bb6b-eb0d371b3854'),(141,138,11,6,3,0,'2019-12-20 16:18:53','2019-12-20 16:18:53','9486878e-d0e3-4cbf-bf59-b60735530d63'),(142,138,11,8,4,0,'2019-12-20 16:18:53','2019-12-20 16:18:53','e0feb440-ef14-499e-87ca-0f5fb71f4172'),(143,138,11,9,5,0,'2019-12-20 16:18:53','2019-12-20 16:18:53','e8576420-b2b0-44d6-8af9-dc04149cffe8');
/*!40000 ALTER TABLE `matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matrixblocktypes`
--

DROP TABLE IF EXISTS `matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matrixblocktypes`
--

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;
INSERT INTO `matrixblocktypes` VALUES (1,11,11,'Rich Text','richText',1,'2018-02-02 06:41:11','2019-03-12 15:59:23','ddfe72db-cc91-496e-a097-1be94045f971'),(2,11,12,'Two Columns','twoColumns',2,'2018-02-02 06:41:11','2019-03-12 15:59:23','dc575719-2de8-473b-9872-9e294da811a2'),(4,11,14,'Image with Text','imageWithText',3,'2018-02-02 06:41:12','2019-03-12 15:59:24','318e27c6-9622-4e58-9013-b8731641271f'),(5,11,15,'Video with Text','videoWithText',4,'2018-02-02 06:41:12','2019-03-12 15:59:24','c5c9e5cd-cbe8-4b48-b85e-2dcccae569ba'),(6,11,16,'Testimonial','testimonial',5,'2018-02-02 06:41:12','2019-03-12 15:59:24','12dbddde-14fb-4b79-98fe-6c9bee0e3de8'),(7,11,17,'HTML Widget/Embed','htmlWidgetEmbed',6,'2018-02-02 06:41:12','2019-03-12 15:59:25','7f264ef3-9650-4cb3-9de7-cdc442a98a4d'),(8,11,18,'Call to Action','callToAction',7,'2018-02-02 06:41:12','2019-03-12 15:59:25','edc14065-98d5-402c-a1ed-a745b252ada4'),(9,11,34,'Shared Block','sharedBlock',8,'2019-03-12 15:59:25','2019-03-12 15:59:25','ebbc6a1f-74ae-456e-8091-ad2853f1f503');
/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matrixcontent_designedcontent`
--

DROP TABLE IF EXISTS `matrixcontent_designedcontent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixcontent_designedcontent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_richText_sectionTitle` text DEFAULT NULL,
  `field_richText_blockContent` text DEFAULT NULL,
  `field_twoColumns_sectionTitle` text DEFAULT NULL,
  `field_twoColumns_leftContent` text DEFAULT NULL,
  `field_twoColumns_rightContent` text DEFAULT NULL,
  `field_imageWithText_sectionTitle` text DEFAULT NULL,
  `field_imageWithText_blockContent` text DEFAULT NULL,
  `field_videoWithText_sectionTitle` text DEFAULT NULL,
  `field_videoWithText_videoOrEmbedCode` text DEFAULT NULL,
  `field_videoWithText_blockContent` text DEFAULT NULL,
  `field_testimonial_sectionTitle` text DEFAULT NULL,
  `field_testimonial_quote` text DEFAULT NULL,
  `field_testimonial_person` text DEFAULT NULL,
  `field_testimonial_jobTitle` text DEFAULT NULL,
  `field_htmlWidgetEmbed_sectionTitle` text DEFAULT NULL,
  `field_htmlWidgetEmbed_embed` text DEFAULT NULL,
  `field_callToAction_sectionTitle` text DEFAULT NULL,
  `field_callToAction_blockContent` text DEFAULT NULL,
  `field_callToAction_cta` text DEFAULT NULL,
  `field_imageWithText_position` varchar(255) DEFAULT NULL,
  `field_videoWithText_position` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixcontent_designedcontent_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `matrixcontent_designedcontent_siteId_idx` (`siteId`),
  CONSTRAINT `matrixcontent_designedcontent_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixcontent_designedcontent_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matrixcontent_designedcontent`
--

LOCK TABLES `matrixcontent_designedcontent` WRITE;
/*!40000 ALTER TABLE `matrixcontent_designedcontent` DISABLE KEYS */;
INSERT INTO `matrixcontent_designedcontent` VALUES (1,32,1,'2019-03-05 23:02:52','2019-03-12 16:06:41','c1bb4e85-d906-4ae4-9328-ef29ed6f712e','Rich Text','<p>Convallis ullamcorper potenti curabitur dictum lectus in ligula facilisis phasellus, curabitur himenaeos turpis quam rhoncus consequat auctor duis, ligula aliquam consectetur sapien neque fusce elit mi facilisis tortor ullamcorper lorem gravida libero vehicula.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,33,1,'2019-03-05 23:02:53','2019-03-12 16:06:42','cc1c1526-696d-471a-ad75-60d1f1f8b412',NULL,NULL,'Two Columns','<p>Diam justo orci consectetur conubia sapien hac fames morbi, mi massa fringilla habitant quisque nostra aenean neque, diam dui magna ornare fames inceptos egestas viverra curae netus sit non etiam lacus.</p>','<p>Dolor fusce etiam nec donec habitasse dui laoreet, tristique tortor convallis donec viverra amet, nisi augue ultricies donec est habitasse dui tellus magna cursus laoreet posuere egestas eros libero quisque vulputate cras aliquam ut.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,34,1,'2019-03-05 23:02:53','2019-03-12 16:06:42','137a9799-bdb4-4186-8701-5e54cf933f5b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Testimonial','<p>Amet elit class varius risus ipsum duis, mollis bibendum placerat non volutpat ad, conubia feugiat habitant conubia gravida.</p>','First Lastername','Chief Employee',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,35,1,'2019-03-05 23:02:53','2019-03-12 16:06:42','0e0849d9-063a-411f-a452-76a7bcce253c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Call to Action','<p>Volutpat ad, conubia feugiat habitant conubia gravida.</p>','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Amet elit varius\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://www.imarc.com/\"}',NULL,NULL),(5,37,1,'2019-03-11 18:17:26','2019-03-11 19:42:02','d90ab43f-8762-4b8f-b73a-69392ba6b0ab',NULL,'<p>You\'ve successfully found the blog section within Padstone. Feel free to delete this entry and add your own articles.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,39,1,'2019-03-11 18:18:29','2019-03-11 21:07:48','186b6d68-d43c-49aa-8b3a-ab9e1b245c37',NULL,'<p>A new website was successfully created using Padstone, a starter package built by Imarc. Feel free to delete this entry and add your own news.<br /></p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,41,1,'2019-03-11 18:19:11','2019-03-11 18:19:28','a3a920ad-4e78-43d4-9729-a2e1d086af4c',NULL,'<p>This is an example featured resource.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,43,1,'2019-03-11 19:42:02','2019-03-11 19:42:02','67aa8771-c7ee-475a-8c67-efb715547bff',NULL,NULL,NULL,'<p>Quisque pharetra sollicitudin lectus, scelerisque congue nisi volutpat id. Nulla facilisi. Etiam a vestibulum nisl, a suscipit erat. Nunc vitae ullamcorper elit, quis porta mi. Donec eu nisl sit amet metus dictum dapibus. Sed mattis nulla et nulla sollicitudin, non semper augue pharetra.</p>\n','<p>Morbi fringilla sem sed pellentesque dignissim. Sed eget ultrices erat. Suspendisse a leo viverra, facilisis justo ut, feugiat diam. Integer in vehicula ex. Donec egestas consequat lectus aliquam porta. Donec ultricies arcu at dolor mattis, id euismod nisi rutrum. Suspendisse potenti. Donec id odio ante. Donec sollicitudin eleifend tempor.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,45,1,'2019-03-11 20:01:52','2019-03-11 20:02:43','6ca1629c-0548-4ff2-abb2-ebead8b0131f',NULL,'<p>Integer non pretium nulla. Nullam accumsan, justo eu maximus tincidunt, ligula augue venenatis odio, in luctus nisi arcu quis ex. Aenean non lacus eget ipsum laoreet faucibus at fringilla nibh. Praesent eget eleifend dolor. Donec iaculis diam id justo condimentum egestas.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(10,49,1,'2019-03-12 16:06:37','2019-03-12 16:06:37','b2b75311-9378-44ef-a0e3-8f795bf20b59','This is a Shared Block','<p>This is a shared block.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11,50,1,'2019-03-12 16:06:42','2019-03-12 16:06:42','74bb1c3d-a407-41ff-8930-a8dad312150c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(12,57,1,'2019-12-20 16:17:53','2019-12-20 16:17:55','72124c38-821d-4f24-873f-1ce03940b7ad','Rich Text','<p>Convallis ullamcorper potenti curabitur dictum lectus in ligula facilisis phasellus, curabitur himenaeos turpis quam rhoncus consequat auctor duis, ligula aliquam consectetur sapien neque fusce elit mi facilisis tortor ullamcorper lorem gravida libero vehicula.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(13,58,1,'2019-12-20 16:17:54','2019-12-20 16:17:55','f82a15db-f58a-47d7-ab32-e95a46b2069b',NULL,NULL,'Two Columns','<p>Diam justo orci consectetur conubia sapien hac fames morbi, mi massa fringilla habitant quisque nostra aenean neque, diam dui magna ornare fames inceptos egestas viverra curae netus sit non etiam lacus.</p>','<p>Dolor fusce etiam nec donec habitasse dui laoreet, tristique tortor convallis donec viverra amet, nisi augue ultricies donec est habitasse dui tellus magna cursus laoreet posuere egestas eros libero quisque vulputate cras aliquam ut.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(14,59,1,'2019-12-20 16:17:54','2019-12-20 16:17:55','e8675fbd-33fa-4be0-b74b-218030a5984e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Testimonial','<p>Amet elit class varius risus ipsum duis, mollis bibendum placerat non volutpat ad, conubia feugiat habitant conubia gravida.</p>','First Lastername','Chief Employee',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(15,60,1,'2019-12-20 16:17:54','2019-12-20 16:17:56','e1957bd0-c29f-49cb-a8f3-9c50847db5bd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Call to Action','<p>Volutpat ad, conubia feugiat habitant conubia gravida.</p>','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Amet elit varius\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://www.imarc.com/\"}',NULL,NULL),(16,61,1,'2019-12-20 16:17:55','2019-12-20 16:17:56','99fef873-4f6a-436e-a703-1ce541331303',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(17,63,1,'2019-12-20 16:17:57','2019-12-20 16:17:57','0f9e9184-c803-4c71-8df3-471827ae791b','This is a Shared Block','<p>This is a shared block.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(18,69,1,'2019-12-20 16:18:02','2019-12-20 16:18:03','a0e37e94-c155-4b9a-87d8-243dc1293fe0',NULL,'<p>Integer non pretium nulla. Nullam accumsan, justo eu maximus tincidunt, ligula augue venenatis odio, in luctus nisi arcu quis ex. Aenean non lacus eget ipsum laoreet faucibus at fringilla nibh. Praesent eget eleifend dolor. Donec iaculis diam id justo condimentum egestas.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(19,71,1,'2019-12-20 16:18:04','2019-12-20 16:18:05','3cf146df-40fb-471d-a4ae-ab1cb1531886',NULL,'<p>Integer non pretium nulla. Nullam accumsan, justo eu maximus tincidunt, ligula augue venenatis odio, in luctus nisi arcu quis ex. Aenean non lacus eget ipsum laoreet faucibus at fringilla nibh. Praesent eget eleifend dolor. Donec iaculis diam id justo condimentum egestas.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(20,75,1,'2019-12-20 16:18:11','2019-12-20 16:18:12','e96725b5-b435-4766-a1e0-b416b8270d17',NULL,'<p>You\'ve successfully found the blog section within Padstone. Feel free to delete this entry and add your own articles.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(21,76,1,'2019-12-20 16:18:12','2019-12-20 16:18:12','fd4a03ec-2527-44c5-8569-e3b7cd20c4c2',NULL,NULL,NULL,'<p>Quisque pharetra sollicitudin lectus, scelerisque congue nisi volutpat id. Nulla facilisi. Etiam a vestibulum nisl, a suscipit erat. Nunc vitae ullamcorper elit, quis porta mi. Donec eu nisl sit amet metus dictum dapibus. Sed mattis nulla et nulla sollicitudin, non semper augue pharetra.</p>\n','<p>Morbi fringilla sem sed pellentesque dignissim. Sed eget ultrices erat. Suspendisse a leo viverra, facilisis justo ut, feugiat diam. Integer in vehicula ex. Donec egestas consequat lectus aliquam porta. Donec ultricies arcu at dolor mattis, id euismod nisi rutrum. Suspendisse potenti. Donec id odio ante. Donec sollicitudin eleifend tempor.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(22,83,1,'2019-12-20 16:18:21','2019-12-20 16:18:21','1c183aa4-c9ca-4a21-9f0f-f021631bbe30',NULL,'<p>A new website was successfully created using Padstone, a starter package built by Imarc. Feel free to delete this entry and add your own news.<br /></p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(23,85,1,'2019-12-20 16:18:22','2019-12-20 16:18:23','4e5e6e96-4628-4f23-bca0-d1085348b413',NULL,'<p>You\'ve successfully found the blog section within Padstone. Feel free to delete this entry and add your own articles.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(24,86,1,'2019-12-20 16:18:23','2019-12-20 16:18:23','f1859f14-bf9a-441a-b158-3dcdbe4e6f5e',NULL,NULL,NULL,'<p>Quisque pharetra sollicitudin lectus, scelerisque congue nisi volutpat id. Nulla facilisi. Etiam a vestibulum nisl, a suscipit erat. Nunc vitae ullamcorper elit, quis porta mi. Donec eu nisl sit amet metus dictum dapibus. Sed mattis nulla et nulla sollicitudin, non semper augue pharetra.</p>\n','<p>Morbi fringilla sem sed pellentesque dignissim. Sed eget ultrices erat. Suspendisse a leo viverra, facilisis justo ut, feugiat diam. Integer in vehicula ex. Donec egestas consequat lectus aliquam porta. Donec ultricies arcu at dolor mattis, id euismod nisi rutrum. Suspendisse potenti. Donec id odio ante. Donec sollicitudin eleifend tempor.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(25,100,1,'2019-12-20 16:18:31','2019-12-20 16:18:33','9698b80f-1263-492b-a40a-44f541416f18','Rich Text','<p>Convallis ullamcorper potenti curabitur dictum lectus in ligula facilisis phasellus, curabitur himenaeos turpis quam rhoncus consequat auctor duis, ligula aliquam consectetur sapien neque fusce elit mi facilisis tortor ullamcorper lorem gravida libero vehicula.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(26,101,1,'2019-12-20 16:18:32','2019-12-20 16:18:33','9816a6d4-80b9-4f09-a782-4bbbf1740a45',NULL,NULL,'Two Columns','<p>Diam justo orci consectetur conubia sapien hac fames morbi, mi massa fringilla habitant quisque nostra aenean neque, diam dui magna ornare fames inceptos egestas viverra curae netus sit non etiam lacus.</p>','<p>Dolor fusce etiam nec donec habitasse dui laoreet, tristique tortor convallis donec viverra amet, nisi augue ultricies donec est habitasse dui tellus magna cursus laoreet posuere egestas eros libero quisque vulputate cras aliquam ut.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(27,102,1,'2019-12-20 16:18:32','2019-12-20 16:18:33','98ea5972-c5a4-418b-a8fc-dae85dfd84d6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Testimonial','<p>Amet elit class varius risus ipsum duis, mollis bibendum placerat non volutpat ad, conubia feugiat habitant conubia gravida.</p>','First Lastername','Chief Employee',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(28,103,1,'2019-12-20 16:18:32','2019-12-20 16:18:33','48beefd9-0bf3-4a06-933a-56701f330cd5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Call to Action','<p>Volutpat ad, conubia feugiat habitant conubia gravida.</p>','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Amet elit varius\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://www.imarc.com/\"}',NULL,NULL),(29,104,1,'2019-12-20 16:18:32','2019-12-20 16:18:32','105d7568-6479-4df2-8d09-3554170e716a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(30,119,1,'2019-12-20 16:18:41','2019-12-20 16:18:43','3e8120be-45ac-453c-9e7a-96416c7ab92b','Rich Text','<p>Convallis ullamcorper potenti curabitur dictum lectus in ligula facilisis phasellus, curabitur himenaeos turpis quam rhoncus consequat auctor duis, ligula aliquam consectetur sapien neque fusce elit mi facilisis tortor ullamcorper lorem gravida libero vehicula.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(31,120,1,'2019-12-20 16:18:42','2019-12-20 16:18:44','27af2d31-1a20-428e-924f-bcac7ab89945',NULL,NULL,'Two Columns','<p>Diam justo orci consectetur conubia sapien hac fames morbi, mi massa fringilla habitant quisque nostra aenean neque, diam dui magna ornare fames inceptos egestas viverra curae netus sit non etiam lacus.</p>','<p>Dolor fusce etiam nec donec habitasse dui laoreet, tristique tortor convallis donec viverra amet, nisi augue ultricies donec est habitasse dui tellus magna cursus laoreet posuere egestas eros libero quisque vulputate cras aliquam ut.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(32,121,1,'2019-12-20 16:18:43','2019-12-20 16:18:44','fdfb09a5-80f1-4500-ab04-723a2f7ab61e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Testimonial','<p>Amet elit class varius risus ipsum duis, mollis bibendum placerat non volutpat ad, conubia feugiat habitant conubia gravida.</p>','First Lastername','Chief Employee',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(33,122,1,'2019-12-20 16:18:43','2019-12-20 16:18:44','ebd1fefd-a427-48d8-b175-92935cb14aea',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Call to Action','<p>Volutpat ad, conubia feugiat habitant conubia gravida.</p>','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Amet elit varius\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://www.imarc.com/\"}',NULL,NULL),(34,123,1,'2019-12-20 16:18:43','2019-12-20 16:18:43','b8373c28-b37a-4df1-8b73-cbe57888677b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(35,125,1,'2019-12-20 16:18:44','2019-12-20 16:18:46','a8609074-90f0-445a-95cd-33b8751c1515','Rich Text','<p>Convallis ullamcorper potenti curabitur dictum lectus in ligula facilisis phasellus, curabitur himenaeos turpis quam rhoncus consequat auctor duis, ligula aliquam consectetur sapien neque fusce elit mi facilisis tortor ullamcorper lorem gravida libero vehicula.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(36,126,1,'2019-12-20 16:18:45','2019-12-20 16:18:47','71f8f9d7-8fca-4279-be27-9a67386d36ee',NULL,NULL,'Two Columns','<p>Diam justo orci consectetur conubia sapien hac fames morbi, mi massa fringilla habitant quisque nostra aenean neque, diam dui magna ornare fames inceptos egestas viverra curae netus sit non etiam lacus.</p>','<p>Dolor fusce etiam nec donec habitasse dui laoreet, tristique tortor convallis donec viverra amet, nisi augue ultricies donec est habitasse dui tellus magna cursus laoreet posuere egestas eros libero quisque vulputate cras aliquam ut.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(37,127,1,'2019-12-20 16:18:45','2019-12-20 16:18:47','78b33dc9-b230-47f1-a7a6-7f17e045f343',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Testimonial','<p>Amet elit class varius risus ipsum duis, mollis bibendum placerat non volutpat ad, conubia feugiat habitant conubia gravida.</p>','First Lastername','Chief Employee',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(38,128,1,'2019-12-20 16:18:46','2019-12-20 16:18:47','8f5ed0bf-9228-4cf6-9ff8-6643d51db702',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Call to Action','<p>Volutpat ad, conubia feugiat habitant conubia gravida.</p>','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Amet elit varius\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://www.imarc.com/\"}',NULL,NULL),(39,129,1,'2019-12-20 16:18:46','2019-12-20 16:18:46','947a6b9a-5829-4f7a-a7f7-433b0e6433f9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(40,133,1,'2019-12-20 16:18:49','2019-12-20 16:18:49','51cd14c0-af6d-42ce-b0d4-1c18b777b09a','Rich Text','<p>Convallis ullamcorper potenti curabitur dictum lectus in ligula facilisis phasellus, curabitur himenaeos turpis quam rhoncus consequat auctor duis, ligula aliquam consectetur sapien neque fusce elit mi facilisis tortor ullamcorper lorem gravida libero vehicula.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(41,134,1,'2019-12-20 16:18:50','2019-12-20 16:18:50','e884e010-28ec-4d15-a312-1730b574e49b',NULL,NULL,'Two Columns','<p>Diam justo orci consectetur conubia sapien hac fames morbi, mi massa fringilla habitant quisque nostra aenean neque, diam dui magna ornare fames inceptos egestas viverra curae netus sit non etiam lacus.</p>','<p>Dolor fusce etiam nec donec habitasse dui laoreet, tristique tortor convallis donec viverra amet, nisi augue ultricies donec est habitasse dui tellus magna cursus laoreet posuere egestas eros libero quisque vulputate cras aliquam ut.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(42,135,1,'2019-12-20 16:18:50','2019-12-20 16:18:50','7f66a4d7-3f9e-4ecb-b3eb-ff82b9ad65fc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Testimonial','<p>Amet elit class varius risus ipsum duis, mollis bibendum placerat non volutpat ad, conubia feugiat habitant conubia gravida.</p>','First Lastername','Chief Employee',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(43,136,1,'2019-12-20 16:18:50','2019-12-20 16:18:50','1382fc3b-a0f8-4dd5-8e58-4fdffecf602b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Call to Action','<p>Volutpat ad, conubia feugiat habitant conubia gravida.</p>','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Amet elit varius\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://www.imarc.com/\"}',NULL,NULL),(44,137,1,'2019-12-20 16:18:51','2019-12-20 16:18:51','a17b309d-d59f-4443-a72d-43309c4f6b82',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(45,139,1,'2019-12-20 16:18:52','2019-12-20 16:18:52','18128951-f93d-4e70-9a2e-1619fc5ccf29','Rich Text','<p>Convallis ullamcorper potenti curabitur dictum lectus in ligula facilisis phasellus, curabitur himenaeos turpis quam rhoncus consequat auctor duis, ligula aliquam consectetur sapien neque fusce elit mi facilisis tortor ullamcorper lorem gravida libero vehicula.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(46,140,1,'2019-12-20 16:18:53','2019-12-20 16:18:53','bcc33d80-37ed-4a77-802f-e620d1ed12f1',NULL,NULL,'Two Columns','<p>Diam justo orci consectetur conubia sapien hac fames morbi, mi massa fringilla habitant quisque nostra aenean neque, diam dui magna ornare fames inceptos egestas viverra curae netus sit non etiam lacus.</p>','<p>Dolor fusce etiam nec donec habitasse dui laoreet, tristique tortor convallis donec viverra amet, nisi augue ultricies donec est habitasse dui tellus magna cursus laoreet posuere egestas eros libero quisque vulputate cras aliquam ut.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(47,141,1,'2019-12-20 16:18:53','2019-12-20 16:18:53','7cb21b5a-6b09-47c9-89da-7abedd825b03',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Testimonial','<p>Amet elit class varius risus ipsum duis, mollis bibendum placerat non volutpat ad, conubia feugiat habitant conubia gravida.</p>','First Lastername','Chief Employee',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(48,142,1,'2019-12-20 16:18:53','2019-12-20 16:18:53','3579e87a-9596-4ea2-9471-485a07d305d2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Call to Action','<p>Volutpat ad, conubia feugiat habitant conubia gravida.</p>','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Amet elit varius\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://www.imarc.com/\"}',NULL,NULL),(49,143,1,'2019-12-20 16:18:53','2019-12-20 16:18:53','2c28a235-0dbb-4e6d-b248-68f470b8ed3a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `matrixcontent_designedcontent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `migrations_pluginId_idx` (`pluginId`),
  KEY `migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,NULL,'app','Install','2017-11-29 20:51:54','2017-11-29 20:51:54','2017-11-29 20:51:54','4c0144b5-4eba-4164-a048-5fd022c849ba'),(2,NULL,'app','m150403_183908_migrations_table_changes','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','0c856f6c-5ad1-4432-961a-16cb785a2914'),(3,NULL,'app','m150403_184247_plugins_table_changes','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','1649a572-0a85-4911-9557-48fd747434a0'),(4,NULL,'app','m150403_184533_field_version','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','aad44269-787f-4a31-83ef-1f867c194e24'),(5,NULL,'app','m150403_184729_type_columns','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','b34b2f3a-4209-4f92-8993-cd8fb1a65704'),(6,NULL,'app','m150403_185142_volumes','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','a5ac3a6d-4592-4b7f-bc4f-87f7ab45c2ee'),(7,NULL,'app','m150428_231346_userpreferences','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','885958c2-780e-4846-b7da-06a45b81ed8c'),(8,NULL,'app','m150519_150900_fieldversion_conversion','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','6c4bb4d2-0b69-4fe3-bfb0-2507c62bb2cf'),(9,NULL,'app','m150617_213829_update_email_settings','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','a38d2d7e-ec1f-4801-baf4-21888c88b335'),(10,NULL,'app','m150721_124739_templatecachequeries','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','c69141dc-ed73-464c-ac54-14e36f4744ba'),(11,NULL,'app','m150724_140822_adjust_quality_settings','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','5accb70b-cc0a-429a-9e60-1207a04c0421'),(12,NULL,'app','m150815_133521_last_login_attempt_ip','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','c36f3946-eee4-4fa2-b229-abee2e532ab1'),(13,NULL,'app','m151002_095935_volume_cache_settings','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','72f5e95f-b348-41e4-991c-40b5b6486aba'),(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','5fb5273e-dcbb-4319-a233-87f74ffce10d'),(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','73b3dc31-79e3-42e6-8a27-822b2298e20b'),(16,NULL,'app','m151209_000000_move_logo','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','1c65abf9-3717-4698-b8e9-62300deb3074'),(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','b25bd8ea-8c5d-46a5-b13e-f08b7537f85f'),(18,NULL,'app','m151215_000000_rename_asset_permissions','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','94244ace-5ff4-41d2-b931-826d8a7a6f7a'),(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','b942864d-7c53-4c0e-be95-d1e6733beeaa'),(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','f36ce568-0410-452e-9778-9f2ecd4a20d6'),(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','fc4e4992-7be0-4362-9952-edbf8e502a6c'),(22,NULL,'app','m160727_194637_column_cleanup','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','9afdba7b-686c-49f7-b91b-ec8778aed165'),(23,NULL,'app','m160804_110002_userphotos_to_assets','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','125c6ed6-3406-4cc9-ab37-00c99f9394f4'),(24,NULL,'app','m160807_144858_sites','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','6c2e1141-893d-46cb-a754-17576e54ac77'),(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','e08e3e30-74c9-489b-bf39-e4ba4e156c31'),(26,NULL,'app','m160830_000000_asset_index_uri_increase','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','16813e22-cced-4cd1-9a6f-e45a131838e5'),(27,NULL,'app','m160912_230520_require_entry_type_id','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','41c87eff-b531-43e6-9f74-33bbe76e6520'),(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','baec422e-c348-4995-aa21-71550cab83b4'),(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','daff915d-c527-4e63-b6e6-af46c80d1134'),(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','512f5985-9b88-49b5-9cd6-ec90a48fffd7'),(31,NULL,'app','m160925_113941_route_uri_parts','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','5bc2a3d4-d087-4bbf-be99-72edce120e58'),(32,NULL,'app','m161006_205918_schemaVersion_not_null','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','0c9f016a-948e-4671-aefa-d5e1bf8ab9ad'),(33,NULL,'app','m161007_130653_update_email_settings','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','43fe3a64-84be-480e-a344-d3e233109f54'),(34,NULL,'app','m161013_175052_newParentId','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','f199c7d2-355d-4331-a2d1-19a56ceac0ae'),(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','825a4d69-a40d-451b-83e9-379deda15fa7'),(36,NULL,'app','m161021_182140_rename_get_help_widget','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','c58b30b8-414f-48a8-aba9-eb1c27ce22a4'),(37,NULL,'app','m161025_000000_fix_char_columns','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','07e69f84-000f-41e3-800e-448d264fd7ae'),(38,NULL,'app','m161029_124145_email_message_languages','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','b41aac1a-c872-4401-a702-6712687e3bd0'),(39,NULL,'app','m161108_000000_new_version_format','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','ee4b04cf-1b9c-47ff-8858-e381e6386c04'),(40,NULL,'app','m161109_000000_index_shuffle','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','e98c3cac-f1eb-4f3e-a9ac-16325d334724'),(41,NULL,'app','m161122_185500_no_craft_app','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','276fee4c-307f-4055-a1e7-94ba92afb806'),(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','780954fb-2ad6-4170-ba71-9952dbdc0cb0'),(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','82f7ffa2-b4c5-487a-907f-f6aae2941518'),(44,NULL,'app','m170114_161144_udates_permission','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','a48198e5-892b-4996-ba3b-d5818bb6e5c1'),(45,NULL,'app','m170120_000000_schema_cleanup','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','ebb67ae1-5076-414c-baa7-2ee4ca7bc7a9'),(46,NULL,'app','m170126_000000_assets_focal_point','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','26fe98a3-7c39-4f9a-8ce6-9db61ddfdc62'),(47,NULL,'app','m170206_142126_system_name','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','cb5e45b1-5bcc-4ced-8b80-d94aacd71311'),(48,NULL,'app','m170217_044740_category_branch_limits','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','24e74405-0487-483a-9930-c5ee851fec82'),(49,NULL,'app','m170217_120224_asset_indexing_columns','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','1ab95a58-c49b-40bc-9488-0221a8cf6f23'),(50,NULL,'app','m170223_224012_plain_text_settings','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','a2e6f352-4d90-40b4-9124-def460a02e73'),(51,NULL,'app','m170227_120814_focal_point_percentage','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','86459327-7db0-4233-9a40-75f5d87f9964'),(52,NULL,'app','m170228_171113_system_messages','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','3ef159c8-3b24-497d-afc8-c0cef89e82d2'),(53,NULL,'app','m170303_140500_asset_field_source_settings','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','7f666940-4b39-4d26-ad12-277da3827ef3'),(54,NULL,'app','m170306_150500_asset_temporary_uploads','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','60e890f6-e6ab-4981-b4b0-6482aff99d00'),(55,NULL,'app','m170414_162429_rich_text_config_setting','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','bda8409d-2c0e-40f8-b69f-923d0387c284'),(56,NULL,'app','m170523_190652_element_field_layout_ids','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','a9164e02-4421-4b77-bfc2-f99398c8e402'),(57,NULL,'app','m170612_000000_route_index_shuffle','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','01e61c30-c1d8-4014-8868-3edc6758dec4'),(58,NULL,'app','m170620_203910_no_disabled_plugins','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','3d2a5964-3a99-40f9-958f-079a4e763eef'),(59,NULL,'app','m170621_195237_format_plugin_handles','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','cfc3d47e-ef55-4152-aa87-207383e8f75f'),(60,NULL,'app','m170630_161028_deprecation_changes','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','ee3cc4a4-f252-4a56-8093-ddd235ce93fd'),(61,NULL,'app','m170703_181539_plugins_table_tweaks','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','542b6c13-fe93-4971-ae5c-752ebccecf58'),(62,NULL,'app','m170704_134916_sites_tables','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','34fa7ecf-d2e4-48b6-b411-e99be7326174'),(63,NULL,'app','m170706_183216_rename_sequences','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','b40dc2ab-f66b-402d-834b-dca3fc94c9da'),(64,NULL,'app','m170707_094758_delete_compiled_traits','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','ba1b2995-6477-42f6-8eab-21d7f00eab8e'),(65,NULL,'app','m170707_131841_fix_db_routes','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','78520ecd-4112-4a10-85bb-caa32813bc90'),(66,NULL,'app','m170731_190138_drop_asset_packagist','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','c1e69b9b-97a6-4089-9a98-ee1aef0e9e2c'),(67,NULL,'app','m170809_223338_oauth_tokens_table','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','3216578e-fc16-488e-aba8-72738efa8e9a'),(68,NULL,'app','m170810_201318_create_queue_table','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','0cfc14a2-32ce-4600-bcb1-b9c3a2642bd0'),(69,NULL,'app','m170816_133741_delete_compiled_behaviors','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','1fae8a6b-d446-466b-b523-94cfc61c470c'),(70,NULL,'app','m170821_180624_deprecation_line_nullable','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','334cce3c-40d9-4621-9e32-eeb141685e63'),(71,NULL,'app','m170903_192801_longblob_for_queue_jobs','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','fb578b9b-5838-48c4-a3ce-ca18162b6a81'),(72,NULL,'app','m170914_204621_asset_cache_shuffle','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','5ada5eba-fae7-4a44-8a06-303dd2a4a400'),(73,NULL,'app','m171107_000000_assign_group_permissions','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','df41d8d7-107c-43f9-883f-696e212d4015'),(74,NULL,'app','m171117_000001_templatecache_index_tune','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','92b1ea02-afeb-4593-a53d-fb80f67b8a7e'),(75,NULL,'app','m171011_214115_site_groups','2018-01-16 22:09:00','2018-01-16 22:09:00','2018-01-16 22:09:00','387a2f96-b745-4544-897b-8169705297f0'),(76,NULL,'app','m171012_151440_primary_site','2018-01-16 22:09:00','2018-01-16 22:09:00','2018-01-16 22:09:00','948a2dcf-db34-4aa9-a2e3-745410307de3'),(77,NULL,'app','m171013_142500_transform_interlace','2018-01-16 22:09:00','2018-01-16 22:09:00','2018-01-16 22:09:00','38fbdd3c-b2da-4a0f-89bb-3c0946d73a8f'),(78,NULL,'app','m171016_092553_drop_position_select','2018-01-16 22:09:00','2018-01-16 22:09:00','2018-01-16 22:09:00','dedd66cb-9911-4462-8953-d36c2ab531b5'),(79,NULL,'app','m171016_221244_less_strict_translation_method','2018-01-16 22:09:00','2018-01-16 22:09:00','2018-01-16 22:09:00','25cf1322-ddd0-44e2-8b99-8f385461a59f'),(80,NULL,'app','m171126_105927_disabled_plugins','2018-01-16 22:09:00','2018-01-16 22:09:00','2018-01-16 22:09:00','6b01c813-fa99-4cad-8530-2983067f973d'),(81,NULL,'app','m171130_214407_craftidtokens_table','2018-01-16 22:09:00','2018-01-16 22:09:00','2018-01-16 22:09:00','ed4e0e78-7f63-46c7-891e-129828165c52'),(82,NULL,'app','m171202_004225_update_email_settings','2018-01-16 22:09:00','2018-01-16 22:09:00','2018-01-16 22:09:00','93ecd31b-c3a9-4dd4-9d5e-cef3e865ad6c'),(83,NULL,'app','m171204_000001_templatecache_index_tune_deux','2018-01-16 22:09:00','2018-01-16 22:09:00','2018-01-16 22:09:00','3580b1fd-1e74-455c-9f14-83719b370b93'),(84,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2018-01-16 22:09:00','2018-01-16 22:09:00','2018-01-16 22:09:00','a9f54878-a80e-4010-bb54-7efd4511aa10'),(85,NULL,'app','m171210_142046_fix_db_routes','2018-01-16 22:09:00','2018-01-16 22:09:00','2018-01-16 22:09:00','f3dccaec-fd5a-4ca3-9071-73eb2c2703a0'),(86,NULL,'app','m171218_143135_longtext_query_column','2018-01-16 22:09:00','2018-01-16 22:09:00','2018-01-16 22:09:00','a79f4420-7899-4683-93cc-a498af2a1f04'),(87,NULL,'app','m171231_055546_environment_variables_to_aliases','2018-01-16 22:09:00','2018-01-16 22:09:00','2018-01-16 22:09:00','40fb909c-5cef-451e-b47a-8580501919b5'),(88,4,'plugin','Install','2018-01-16 22:36:57','2018-01-16 22:36:57','2018-01-16 22:36:57','603703ec-0c96-4f1d-bf46-6ddf24170e54'),(89,4,'plugin','m170602_080218_redirect_1_0_1','2018-01-16 22:36:57','2018-01-16 22:36:57','2018-01-16 22:36:57','1c4686e9-e003-493b-a71c-910ed6215945'),(90,4,'plugin','m170707_211256_count_fix','2018-01-16 22:36:57','2018-01-16 22:36:57','2018-01-16 22:36:57','1ac1c38b-c661-48ed-a941-c44145cc0adc'),(91,4,'plugin','m171003_120604_createmultisiteurls','2018-01-16 22:36:57','2018-01-16 22:36:57','2018-01-16 22:36:57','2eaff970-f50e-43e3-988c-cb719a33f7bf'),(92,4,'plugin','m180104_143118_c_redirects_catch_all_urls','2018-01-16 22:36:57','2018-01-16 22:36:57','2018-01-16 22:36:57','9d09cc55-f044-49a4-a896-e8a4b84d7ce0'),(94,13,'plugin','Install','2018-01-17 16:26:09','2018-01-17 16:26:09','2018-01-17 16:26:09','fdde63d4-f74a-4b41-b0e4-b59bf5e530ae'),(95,NULL,'app','m180113_153740_drop_users_archived_column','2018-01-26 14:22:14','2018-01-26 14:22:14','2018-01-26 14:22:14','2fd3db1f-ce99-409d-8f09-9c04e5c097bf'),(96,NULL,'app','m180122_213433_propagate_entries_setting','2018-01-26 14:22:14','2018-01-26 14:22:14','2018-01-26 14:22:14','63598990-f5cd-4f33-a23d-caa054a9f8bb'),(97,NULL,'app','m180124_230459_fix_propagate_entries_values','2018-01-26 14:22:14','2018-01-26 14:22:14','2018-01-26 14:22:14','e99c2bfa-358b-4936-a324-a399d92d9211'),(98,NULL,'app','m180128_235202_set_tag_slugs','2018-02-02 05:03:51','2018-02-02 05:03:51','2018-02-02 05:03:51','b4cb3181-cd6a-4329-a3ef-71ecdfc12048'),(99,NULL,'app','m180202_185551_fix_focal_points','2018-03-14 19:05:27','2018-03-14 19:05:27','2018-03-14 19:05:27','197d1adb-9ddc-4361-bcb7-75a297717cf4'),(100,NULL,'app','m180217_172123_tiny_ints','2018-03-14 19:09:30','2018-03-14 19:09:30','2018-03-14 19:09:30','c17e6a2a-5ae4-4fc8-8cab-f2cf3c15cd65'),(101,NULL,'app','m180321_233505_small_ints','2019-03-04 20:32:02','2019-03-04 20:32:02','2019-03-04 20:32:02','6ebaa9fa-90d9-42b4-af9f-90ccf0da7c66'),(102,NULL,'app','m180328_115523_new_license_key_statuses','2019-03-04 20:32:02','2019-03-04 20:32:02','2019-03-04 20:32:02','d5e91b64-0485-4ce8-ad4e-79c1cd6f047b'),(103,NULL,'app','m180404_182320_edition_changes','2019-03-04 20:32:02','2019-03-04 20:32:02','2019-03-04 20:32:02','824baa8a-3c42-413a-8e27-e99d3454e36e'),(104,NULL,'app','m180411_102218_fix_db_routes','2019-03-04 20:32:02','2019-03-04 20:32:02','2019-03-04 20:32:02','ad87ca29-3263-410f-a036-a8c75aa87cf3'),(105,NULL,'app','m180416_205628_resourcepaths_table','2019-03-04 20:32:02','2019-03-04 20:32:02','2019-03-04 20:32:02','27a1e699-481d-47b0-8496-0d5271c7c488'),(106,NULL,'app','m170630_161027_deprecation_line_nullable','2019-03-04 20:33:05','2019-03-04 20:33:05','2019-03-04 20:33:05','852bf0a0-3e3c-4da5-8055-14950b04d28d'),(107,NULL,'app','m180418_205713_widget_cleanup','2019-03-04 20:33:06','2019-03-04 20:33:06','2019-03-04 20:33:06','eaf00170-ee21-4bfc-8d77-9c845d218a70'),(108,NULL,'app','m180425_203349_searchable_fields','2019-03-04 20:33:06','2019-03-04 20:33:06','2019-03-04 20:33:06','078be607-7a2c-4adc-a37c-9bdf7715fecf'),(109,NULL,'app','m180516_153000_uids_in_field_settings','2019-03-04 20:33:06','2019-03-04 20:33:06','2019-03-04 20:33:06','8c00a041-cc64-46b8-81ec-59df1c1a555a'),(110,NULL,'app','m180517_173000_user_photo_volume_to_uid','2019-03-04 20:33:06','2019-03-04 20:33:06','2019-03-04 20:33:06','2b141596-ac52-4b11-920d-5d374f107cb1'),(111,NULL,'app','m180518_173000_permissions_to_uid','2019-03-04 20:33:06','2019-03-04 20:33:06','2019-03-04 20:33:06','ed9de363-d942-4039-938b-2178768c8c42'),(112,NULL,'app','m180520_173000_matrix_context_to_uids','2019-03-04 20:33:06','2019-03-04 20:33:06','2019-03-04 20:33:06','7627de60-e3e5-455e-a301-260774024778'),(113,NULL,'app','m180521_173000_initial_yml_and_snapshot','2019-03-04 20:33:07','2019-03-04 20:33:07','2019-03-04 20:33:07','38a09193-9959-4514-8129-62c78ab4ba0c'),(114,NULL,'app','m180731_162030_soft_delete_sites','2019-03-04 20:33:07','2019-03-04 20:33:07','2019-03-04 20:33:07','ce3e5a41-f72a-4703-bf00-b8caadbc01f9'),(115,NULL,'app','m180810_214427_soft_delete_field_layouts','2019-03-04 20:33:07','2019-03-04 20:33:07','2019-03-04 20:33:07','e0084982-843f-408d-9b84-1010cbd600cc'),(116,NULL,'app','m180810_214439_soft_delete_elements','2019-03-04 20:33:07','2019-03-04 20:33:07','2019-03-04 20:33:07','07bb849d-1cc6-4293-8b58-b26ac5d6e5c8'),(117,NULL,'app','m180824_193422_case_sensitivity_fixes','2019-03-04 20:33:08','2019-03-04 20:33:08','2019-03-04 20:33:08','97cef5ee-c4e0-4dcf-bc92-e7324a03a0ae'),(118,NULL,'app','m180901_151639_fix_matrixcontent_tables','2019-03-04 20:33:08','2019-03-04 20:33:08','2019-03-04 20:33:08','328f7c38-5c8b-40c6-8a9d-188b7a8115b2'),(119,NULL,'app','m180904_112109_permission_changes','2019-03-04 20:33:08','2019-03-04 20:33:08','2019-03-04 20:33:08','13a7ef69-d18c-44dd-ac49-80d5ec0252f9'),(120,NULL,'app','m180910_142030_soft_delete_sitegroups','2019-03-04 20:33:08','2019-03-04 20:33:08','2019-03-04 20:33:08','0fafa1d3-841f-4cae-91ad-7c194d0a7ceb'),(121,NULL,'app','m181011_160000_soft_delete_asset_support','2019-03-04 20:33:08','2019-03-04 20:33:08','2019-03-04 20:33:08','9d8b598a-7d8a-4cb0-b6bb-86160f3fc6f1'),(122,NULL,'app','m181016_183648_set_default_user_settings','2019-03-04 20:33:08','2019-03-04 20:33:08','2019-03-04 20:33:08','8a854930-bf06-4ce9-a5cb-edfd74780de4'),(123,NULL,'app','m181017_225222_system_config_settings','2019-03-04 20:33:08','2019-03-04 20:33:08','2019-03-04 20:33:08','1e5636c7-0127-4345-87db-9965df7b88e1'),(124,NULL,'app','m181018_222343_drop_userpermissions_from_config','2019-03-04 20:33:08','2019-03-04 20:33:08','2019-03-04 20:33:08','7a941b37-afd2-4bfc-9c00-9ff0dc6c773d'),(125,NULL,'app','m181029_130000_add_transforms_routes_to_config','2019-03-04 20:33:08','2019-03-04 20:33:08','2019-03-04 20:33:08','93838c83-e788-4e5f-abb1-55aadd173886'),(126,NULL,'app','m181112_203955_sequences_table','2019-03-04 20:33:08','2019-03-04 20:33:08','2019-03-04 20:33:08','d7fa8215-62e2-43fa-a1fe-a6689fdbef95'),(127,NULL,'app','m181121_001712_cleanup_field_configs','2019-03-04 20:33:08','2019-03-04 20:33:08','2019-03-04 20:33:08','64613057-1d64-4f72-b704-298fd71bf911'),(128,NULL,'app','m181128_193942_fix_project_config','2019-03-04 20:33:08','2019-03-04 20:33:08','2019-03-04 20:33:08','bc17381d-38fe-42be-a7eb-c253744ba6b8'),(129,NULL,'app','m181130_143040_fix_schema_version','2019-03-04 20:33:08','2019-03-04 20:33:08','2019-03-04 20:33:08','e10b17cd-965a-410c-972a-74c1039aea77'),(130,NULL,'app','m181211_143040_fix_entry_type_uids','2019-03-04 20:33:08','2019-03-04 20:33:08','2019-03-04 20:33:08','453a4614-424a-400a-aa8a-449a311f798b'),(131,NULL,'app','m181213_102500_config_map_aliases','2019-03-04 20:33:08','2019-03-04 20:33:08','2019-03-04 20:33:08','22494c53-35fe-4592-bc55-a9f0908d497a'),(132,NULL,'app','m181217_153000_fix_structure_uids','2019-03-04 20:33:08','2019-03-04 20:33:08','2019-03-04 20:33:08','a759e8b8-7651-4c44-a5b0-30f754e749b1'),(133,NULL,'app','m190104_152725_store_licensed_plugin_editions','2019-03-04 20:33:09','2019-03-04 20:33:09','2019-03-04 20:33:09','ce898104-4fc1-47ab-9ae6-53e785d809ac'),(134,NULL,'app','m190108_110000_cleanup_project_config','2019-03-04 20:33:09','2019-03-04 20:33:09','2019-03-04 20:33:09','030d3457-3417-4ba7-b7b4-98d19ffa21f2'),(135,NULL,'app','m190108_113000_asset_field_setting_change','2019-03-04 20:33:09','2019-03-04 20:33:09','2019-03-04 20:33:09','f31126cd-74c9-4784-ac1e-735d935732a9'),(136,NULL,'app','m190109_172845_fix_colspan','2019-03-04 20:33:09','2019-03-04 20:33:09','2019-03-04 20:33:09','f7409deb-679e-4a87-867a-dd749afdd2cf'),(137,NULL,'app','m190110_150000_prune_nonexisting_sites','2019-03-04 20:33:09','2019-03-04 20:33:09','2019-03-04 20:33:09','dcefb3f8-f01b-44ce-a51d-0ec17220f82f'),(138,NULL,'app','m190110_214819_soft_delete_volumes','2019-03-04 20:33:09','2019-03-04 20:33:09','2019-03-04 20:33:09','b215dcea-f12f-43c5-aa7a-7533e5542dca'),(139,NULL,'app','m190112_124737_fix_user_settings','2019-03-04 20:33:09','2019-03-04 20:33:09','2019-03-04 20:33:09','d2302a3f-6ca2-40de-94bb-d5d39209330f'),(140,NULL,'app','m190112_131225_fix_field_layouts','2019-03-04 20:33:09','2019-03-04 20:33:09','2019-03-04 20:33:09','4a97ccfa-5f76-45dc-9921-6bb9fafa539c'),(141,NULL,'app','m190112_201010_more_soft_deletes','2019-03-04 20:33:10','2019-03-04 20:33:10','2019-03-04 20:33:10','b1cb104c-b22b-483d-9336-1e55055051b8'),(142,NULL,'app','m190114_143000_more_asset_field_setting_changes','2019-03-04 20:33:10','2019-03-04 20:33:10','2019-03-04 20:33:10','ff783125-c712-4382-835f-857bfd21e743'),(143,NULL,'app','m190121_120000_rich_text_config_setting','2019-03-04 20:33:10','2019-03-04 20:33:10','2019-03-04 20:33:10','08b2f7dd-32a3-4bb8-832a-25c91187f283'),(144,NULL,'app','m190125_191628_fix_email_transport_password','2019-03-04 20:33:11','2019-03-04 20:33:11','2019-03-04 20:33:11','678932e0-c357-4203-9c82-89860aba891e'),(145,NULL,'app','m190128_181422_cleanup_volume_folders','2019-03-04 20:33:11','2019-03-04 20:33:11','2019-03-04 20:33:11','fd69d8b0-14a9-401f-a3b7-913d5aaef58a'),(146,NULL,'app','m190205_140000_fix_asset_soft_delete_index','2019-03-04 20:33:11','2019-03-04 20:33:11','2019-03-04 20:33:11','09d93204-1e88-49b6-99bb-31aac05dc450'),(147,NULL,'app','m190208_140000_reset_project_config_mapping','2019-03-04 20:33:11','2019-03-04 20:33:11','2019-03-04 20:33:11','3ae1e3c4-62a7-4fac-999c-bdd32e4f0b7e'),(148,NULL,'app','m190218_143000_element_index_settings_uid','2019-03-04 20:33:11','2019-03-04 20:33:11','2019-03-04 20:33:11','5f351079-a098-4562-b3ce-9791d80e0403'),(149,13,'plugin','m180430_204710_remove_old_plugins','2019-03-04 20:33:11','2019-03-04 20:33:11','2019-03-04 20:33:11','b9f7bc63-a7a7-4194-a4ba-be5f404ed8da'),(150,NULL,'app','m190401_223843_drop_old_indexes','2019-12-20 16:15:58','2019-12-20 16:15:58','2019-12-20 16:15:58','02837b58-900c-4d54-94c9-a7214914b87c'),(151,NULL,'app','m190416_014525_drop_unique_global_indexes','2019-12-20 16:15:59','2019-12-20 16:15:59','2019-12-20 16:15:59','d9b36e33-ee89-4019-94bb-dfff3fbb5404'),(152,NULL,'app','m190502_122019_store_default_user_group_uid','2019-12-20 16:16:01','2019-12-20 16:16:01','2019-12-20 16:16:01','26bcbcbd-bbce-4b2c-819f-6f1747180222'),(153,13,'plugin','m190225_003922_split_cleanup_html_settings','2019-12-20 16:16:02','2019-12-20 16:16:02','2019-12-20 16:16:02','7f655f11-1ae1-455f-bc7e-bb77097b4e3e'),(154,4,'plugin','m190426_121317_change_url_size_to_1000','2019-12-20 16:16:02','2019-12-20 16:16:02','2019-12-20 16:16:02','9a3f5b19-13e4-47bb-a3b5-3fcbc81daf9c'),(155,NULL,'app','m190312_152740_element_revisions','2019-12-20 16:17:34','2019-12-20 16:17:34','2019-12-20 16:17:34','f7c98e82-62c2-4f45-a978-d8d85a63b557'),(156,NULL,'app','m190327_235137_propagation_method','2019-12-20 16:17:38','2019-12-20 16:17:38','2019-12-20 16:17:38','65767a62-4548-4c95-b382-878c8bf429db'),(157,NULL,'app','m190417_085010_add_image_editor_permissions','2019-12-20 16:17:38','2019-12-20 16:17:38','2019-12-20 16:17:38','48851b0a-a66f-4c91-b78d-f2c21e892595'),(158,NULL,'app','m190504_150349_preview_targets','2019-12-20 16:17:38','2019-12-20 16:17:38','2019-12-20 16:17:38','047a6ab2-6484-4c41-aa33-12ec619aa9e5'),(159,NULL,'app','m190516_184711_job_progress_label','2019-12-20 16:17:38','2019-12-20 16:17:38','2019-12-20 16:17:38','9b0eb077-7870-4ad5-b0d0-6b28e1c992d5'),(160,NULL,'app','m190523_190303_optional_revision_creators','2019-12-20 16:17:38','2019-12-20 16:17:38','2019-12-20 16:17:38','bb038147-a2ba-4664-9f0a-ed9c12c0e997'),(161,NULL,'app','m190529_204501_fix_duplicate_uids','2019-12-20 16:17:38','2019-12-20 16:17:38','2019-12-20 16:17:38','2b871c89-df46-4022-b02c-5d07f43b922f'),(162,NULL,'app','m190605_223807_unsaved_drafts','2019-12-20 16:17:38','2019-12-20 16:17:38','2019-12-20 16:17:38','f2640f1d-e482-4349-8d55-8be071c582b9'),(163,NULL,'app','m190607_230042_entry_revision_error_tables','2019-12-20 16:17:38','2019-12-20 16:17:38','2019-12-20 16:17:38','39c2f636-0c49-4a48-bebc-ff531dd56200'),(164,NULL,'app','m190608_033429_drop_elements_uid_idx','2019-12-20 16:17:38','2019-12-20 16:17:38','2019-12-20 16:17:38','1e18a951-1f5f-4f3c-b42c-d4a01055ef5b'),(165,NULL,'app','m190617_164400_add_gqlschemas_table','2019-12-20 16:17:38','2019-12-20 16:17:38','2019-12-20 16:17:38','00ed53a7-9a05-4a48-aaae-eb981f822578'),(166,NULL,'app','m190624_234204_matrix_propagation_method','2019-12-20 16:17:38','2019-12-20 16:17:38','2019-12-20 16:17:38','1b798705-a1d0-4cca-a839-a79fdd71e368'),(167,NULL,'app','m190711_153020_drop_snapshots','2019-12-20 16:17:38','2019-12-20 16:17:38','2019-12-20 16:17:38','9613ea8f-fbdb-4a2e-b20e-a4a2f0a6958f'),(168,NULL,'app','m190712_195914_no_draft_revisions','2019-12-20 16:17:38','2019-12-20 16:17:38','2019-12-20 16:17:38','1a59ad8d-8039-4824-aec5-8fad249c769d'),(169,NULL,'app','m190723_140314_fix_preview_targets_column','2019-12-20 16:17:38','2019-12-20 16:17:38','2019-12-20 16:17:38','2bd6c4c6-7a73-4113-b83f-3354b6efe075'),(170,NULL,'app','m190820_003519_flush_compiled_templates','2019-12-20 16:17:38','2019-12-20 16:17:38','2019-12-20 16:17:38','5af7d944-9706-427c-ae76-7293f8d63852'),(171,NULL,'app','m190823_020339_optional_draft_creators','2019-12-20 16:17:39','2019-12-20 16:17:39','2019-12-20 16:17:39','85ab5e5d-1642-4e4c-ab71-46ffa46aa589'),(172,19,'plugin','Install','2019-12-20 21:08:01','2019-12-20 21:08:01','2019-12-20 21:08:01','602c6905-536a-44a3-9cfd-d63b0cdebaa0'),(173,19,'plugin','m180305_000000_migrate_feeds','2019-12-20 21:08:01','2019-12-20 21:08:01','2019-12-20 21:08:01','98c26307-f18a-4566-854b-17f85efa6664'),(174,19,'plugin','m181113_000000_add_paginationNode','2019-12-20 21:08:01','2019-12-20 21:08:01','2019-12-20 21:08:01','c6120a08-7990-460a-a868-b4fe1e5d9842'),(175,19,'plugin','m190201_000000_update_asset_feeds','2019-12-20 21:08:01','2019-12-20 21:08:01','2019-12-20 21:08:01','81f11999-4b20-401d-80b4-8b97503ad4ef'),(176,19,'plugin','m190320_000000_renameLocale','2019-12-20 21:08:01','2019-12-20 21:08:01','2019-12-20 21:08:01','a8695167-d4bf-453d-9d96-eb6403002b84'),(177,19,'plugin','m190406_000000_sortOrder','2019-12-20 21:08:01','2019-12-20 21:08:01','2019-12-20 21:08:01','e72173dd-08ea-4295-804c-7743ce6349b3');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugins`
--

DROP TABLE IF EXISTS `plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
INSERT INTO `plugins` VALUES (2,'expanded-singles','1.0.7','1.0.0','unknown',NULL,'2018-01-16 22:36:52','2018-01-16 22:36:52','2019-12-23 15:10:05','0d83ae9a-c05e-4793-bed4-4167f6ef0eb2'),(3,'mix','1.5.2','1.0.0','unknown',NULL,'2018-01-16 22:36:54','2018-01-16 22:36:54','2019-12-23 15:10:05','93dd15c5-c642-4523-b304-e1ebd14adc88'),(4,'redirect','1.0.23','1.0.5','unknown',NULL,'2018-01-16 22:36:57','2018-01-16 22:36:57','2019-12-23 15:10:05','12346350-4291-4a6f-9309-97b6fd3ecd99'),(5,'typedlinkfield','1.0.19','1.0.0','unknown',NULL,'2018-01-16 22:36:59','2018-01-16 22:36:59','2019-12-23 15:10:05','4920e50c-9797-4903-9bcd-26383cc1cc58'),(6,'code-mirror','1.0.2','1.0.0','unknown',NULL,'2018-01-16 23:10:45','2018-01-16 23:10:45','2019-12-23 15:10:05','505bc3be-c4db-47b5-b1f3-effe1acb0f05'),(7,'admin-bar','3.1.10','3.1.0','unknown',NULL,'2018-01-17 16:25:50','2018-01-17 16:25:50','2019-12-23 15:10:05','2529b9bd-ed93-471d-9b8e-fae4516a3424'),(8,'contact-form','2.2.6','1.0.0','unknown',NULL,'2018-01-17 16:25:53','2018-01-17 16:25:53','2019-12-23 15:10:05','1dd4fba6-e0b2-49cb-b384-846c50f78e11'),(9,'contact-form-honeypot','1.0.2','1.0.0','unknown',NULL,'2018-01-17 16:25:55','2018-01-17 16:25:55','2019-12-23 15:10:05','59720d43-ca69-43da-8472-caca0b4b99bf'),(13,'redactor','2.4.0','2.3.0','unknown',NULL,'2018-01-17 16:26:09','2018-01-17 16:26:09','2019-12-23 15:10:05','2f1227f3-32d4-4b05-80ea-7959eea1c8a7'),(15,'position-fieldtype','1.0.14','1.0.0','unknown',NULL,'2018-02-02 21:59:02','2018-02-02 21:59:02','2019-12-23 15:10:05','15913215-e2a9-4833-8e0f-831aff194c03'),(16,'craft-kindling','2.05','1.0.0','unknown',NULL,'2019-03-04 20:36:03','2019-03-04 20:36:03','2019-12-23 15:10:05','d0238968-28cc-417f-adaf-9f26ff737dd1'),(17,'tag-manager','1.0.5','1.0.0','unknown',NULL,'2019-03-05 19:23:16','2019-03-05 19:23:16','2019-12-23 15:10:05','1866fe47-bdb6-4a4f-aebb-1d6cc085ee60'),(18,'googlecustomsearch','2.0.1','2.0.0','unknown',NULL,'2019-03-11 17:39:05','2019-03-11 17:39:05','2019-12-23 15:10:05','c6ed2cdd-d02a-42f5-8e1a-5c037bd82100'),(19,'feed-me','4.1.2','2.1.2','unknown',NULL,'2019-12-20 21:08:01','2019-12-20 21:08:01','2019-12-23 15:10:05','ca40a539-b3aa-48d6-bafe-3ed8fb19ae61'),(20,'element-api','2.6.0','1.0.0','unknown',NULL,'2019-12-20 21:08:20','2019-12-20 21:08:20','2019-12-23 15:10:05','57d36160-84e7-4982-bb13-b3555cab9b5a'),(21,'imager','v2.3.0','2.0.0','unknown',NULL,'2019-12-20 21:11:28','2019-12-20 21:11:28','2019-12-23 15:10:05','59ca2bbf-0d99-4b9e-8ea8-a22f40a8b7b0');
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` longblob NOT NULL,
  `description` text DEFAULT NULL,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT 0,
  `priority` int(11) unsigned NOT NULL DEFAULT 1024,
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT 0,
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT 0,
  `dateFailed` datetime DEFAULT NULL,
  `error` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `queue_fail_timeUpdated_timePushed_idx` (`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_fail_timeUpdated_delay_idx` (`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=297 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queue`
--

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relations`
--

DROP TABLE IF EXISTS `relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `relations_sourceId_idx` (`sourceId`),
  KEY `relations_targetId_idx` (`targetId`),
  KEY `relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relations`
--

LOCK TABLES `relations` WRITE;
/*!40000 ALTER TABLE `relations` DISABLE KEYS */;
INSERT INTO `relations` VALUES (19,70,50,NULL,48,1,'2019-03-12 16:06:42','2019-03-12 16:06:42','6ecaa5e8-143f-4e17-8d73-122d46b6a7fd'),(21,70,61,NULL,48,1,'2019-12-20 16:17:56','2019-12-20 16:17:56','7ab11a98-08a6-4e29-b257-3bab13f255d6'),(22,70,104,NULL,48,1,'2019-12-20 16:18:32','2019-12-20 16:18:32','7e468eb9-f901-4426-95e9-5328f1916f45'),(23,70,123,NULL,48,1,'2019-12-20 16:18:43','2019-12-20 16:18:43','4d09a86d-6680-4729-841a-407fedbcd095'),(24,70,129,NULL,48,1,'2019-12-20 16:18:46','2019-12-20 16:18:46','973c23f6-a95e-4740-8cac-481affc5ec0a'),(25,70,137,NULL,48,1,'2019-12-20 16:18:51','2019-12-20 16:18:51','4d812ed8-fbd5-46ea-8269-229df75e06b9'),(26,70,143,NULL,48,1,'2019-12-20 16:18:53','2019-12-20 16:18:53','cbde7549-e10f-4612-bdd9-ccb1055d8cb4');
/*!40000 ALTER TABLE `relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resourcepaths`
--

DROP TABLE IF EXISTS `resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resourcepaths`
--

LOCK TABLES `resourcepaths` WRITE;
/*!40000 ALTER TABLE `resourcepaths` DISABLE KEYS */;
INSERT INTO `resourcepaths` VALUES ('15cd7e41','@lib/xregexp'),('1655c4fb','@app/web/assets/cp/dist'),('16881c0b','@vendor/craftcms/redactor/lib/redactor-plugins/widget'),('1701ae8f','@app/web/assets/plugins/dist'),('19ee725f','@lib/garnishjs'),('1f0b6acb','@lib/timepicker'),('1fa13acb','@lib/selectize'),('1fda6f13','@lib/fileupload'),('205e1d90','@app/web/assets/matrix/dist'),('20f432be','@lib/xregexp'),('21058a6','@lib/prismjs'),('21d473c3','@lib/prismjs'),('2352794a','@lib/jquery-touch-events'),('236f8f3b','@typedlinkfield/resources'),('248ea1f6','@craft/web/assets/matrix/dist'),('24f64588','@lib/picturefill'),('2a5365d9','@lib/d3'),('2a987634','@lib/selectize'),('2b79f88f','@app/web/assets/fields/dist'),('2c1ed6c1','@app/web/assets/dashboard/dist'),('2c55758f','@craft/web/assets/utilities/dist'),('2cb7537d','@craft/web/assets/cp/dist'),('2df862c4','@lib/jquery-ui'),('2f6c8d04','@lib/fabric'),('2f7c3fa4','@app/web/assets/editentry/dist'),('35a2a118','@app/web/assets/updateswidget/dist'),('39a36f5','@app/web/assets/matrix/dist'),('3a2a593a','@lib/garnishjs'),('3b220200','@craft/feedme/web/assets/feedme/dist'),('3b300dd9','@app/web/assets/craftsupport/dist'),('3c1e4476','@lib/fileupload'),('3f9054ee','@vendor/craftcms/redactor/lib/redactor-plugins/imagemanager'),('43fe6c67','@lib/garnishjs'),('451b74f3','@lib/timepicker'),('457a371e','@lib/d3'),('49557bc6','@vendor/craftcms/redactor/lib/redactor-plugins/alignment'),('4bdf174f','@lib/picturefill'),('4c7b2b8d','@lib/jquery-touch-events'),('4d11b0b7','@app/web/assets/plugins/dist'),('4f1dbfb1','@craft/web/assets/updateswidget/dist'),('5263d6ba','@craft/web/assets/recententries/dist'),('52adcdd2','@app/web/assets/fields/dist'),('533716b1','@lib/fileupload'),('534c4369','@lib/selectize'),('55636620','@craft/web/assets/cp/dist'),('567d71b4','@craft/web/assets/fields/dist'),('56b8b859','@lib/fabric'),('592007e3','@lib/xregexp'),('5c18565d','@craft/web/assets/pluginstore/dist'),('5d4ea5e9','@lib/element-resize-detector'),('5e96b55d','@wbrowar/adminbar/assetbundles/adminbar/dist'),('6351f961','@lib/velocity'),('6381f4a6','@lib/fabric'),('660e5a4e','@lib/fileupload'),('66df5f96','@lib/timepicker'),('67544d77','@app/web/assets/edituser/dist'),('67e4a994','@luwes/codemirror/assets'),('6cbb8f71','@typedlinkfield/resources'),('6cd994d4','@craft/web/assets/updateswidget/dist'),('6ed59bd2','@app/web/assets/plugins/dist'),('6f4e8f45','@app/web/assets/feed/dist'),('70437be1','@lib/d3'),('7088680c','@lib/selectize'),('71a7fddf','@craft/web/assets/recententries/dist'),('72de0e1c','@bower/jquery/dist'),('7326eed','@lib/picturefill'),('76a74d45','@craft/web/assets/cp/dist'),('76c72098','@lib/garnishjs'),('77ce345a','@craft/redactor/assets/field/dist'),('791fef67','@ether/tagManager/web/assets'),('79426772','@lib/jquery-touch-events'),('7ae42c86','@lib/xregexp'),('7e6fc3c1','@craft/web/assets/tablesettings/dist'),('7ee65bb0','@lib/picturefill'),('7f765689','@lib/jquery.payment'),('8011ee4c','@vendor/craftcms/redactor/lib/redactor-plugins/video'),('833e1d91','@rias/positionfieldtype/assetbundles/positionfieldtype/dist'),('8406ac39','@app/web/assets/matrixsettings/dist'),('8442b443','@app/web/assets/tablesettings/dist'),('86300aff','@lib/jquery.payment'),('87ccd2fa','@lib/element-resize-detector'),('8a56e8d3','@lib/vue'),('8b98526a','@bower/jquery/dist'),('8bdd3ea','@app/web/assets/fields/dist'),('8d237952','@craft/web/assets/dashboard/dist'),('8d68da1c','@app/web/assets/utilities/dist'),('905cd6f3','@app/web/assets/updater/dist'),('9076b8f7','@lib'),('92f9b8ae','@app/web/assets/login/dist'),('9608d333','@app/web/assets/feed/dist'),('96522f','@lib/jquery-touch-events'),('96c7add0','@app/web/assets/cp/dist'),('98534710','@lib/jquery-ui'),('9963cb28','@craft/web/assets/login/dist'),('9974ebc','@lib/d3'),('9a17a517','@lib/velocity'),('a0665b95','@lib/xregexp'),('a3fee12f','@app/web/assets/cp/dist'),('a408f99f','@lib/element-resize-detector'),('a5659a0c','@app/web/assets/updater/dist'),('a5f4219a','@lib/jquery.payment'),('a7869f26','@app/web/assets/tablesettings/dist'),('a7bd4ba6','@lib/axios'),('a7c0f451','@app/web/assets/login/dist'),('a7c2875c','@app/web/assets/matrixsettings/dist'),('a85c790f','@bower/jquery/dist'),('a94a9da','@vendor/craftcms/redactor/lib/redactor'),('aa0a1f1f','@lib/selectize'),('ad6a0bef','@lib/jquery-ui'),('ad85bb52','@craft/web/assets/editentry/dist'),('aeacf179','@app/web/assets/utilities/dist'),('aee75237','@craft/web/assets/dashboard/dist'),('b18e376','@app/web/assets/recententries/dist'),('b2a097ae','@craft/web/assets/deprecationerrors/dist'),('b3b29392','@lib'),('b3d4ba5e','@craft/web/assets/plugins/dist'),('b4f22604','@craft/web/assets/updates/dist'),('b5ccf856','@app/web/assets/feed/dist'),('b5e05144','@craft/web/assets/edituser/dist'),('b9d38e72','@lib/velocity'),('c27651af','@app/web/assets/craftsupport/dist'),('c36c054c','@lib/garnishjs'),('c373d510','@craft/web/assets/login/dist'),('c7752bc8','@bower/jquery/dist'),('c8e9a696','@app/web/assets/login/dist'),('c8f98406','@craft/web/assets/matrixsettings/dist'),('ca008f03','@craft/web/assets/plugins/dist'),('ca8a661','@lib/fabric'),('cadd735d','@lib/jquery.payment'),('cb7562dd','@craft/web/assets/craftsupport/dist'),('cb814c1','@app/web/assets/editentry/dist'),('ccd7b3e8','@app/web/assets/cp/dist'),('cce4fd6e','@app/web/assets/updateswidget/dist'),('d19a9465','@app/web/assets/recententries/dist'),('d4be3eb2','@lib/jquery-ui'),('d5588ab7','@app/web/assets/dashboard/dist'),('d62ad172','@lib/fabric'),('d6fadcb5','@lib/velocity'),('d7a474fc','@craft/web/assets/feed/dist'),('d7effec3','@app/web/assets/pluginstore/dist'),('dcb1af51','@app/web/assets/updater/dist'),('dddcccc2','@lib/element-resize-detector'),('de16b201','@app/web/assets/matrixsettings/dist'),('e0b7fe75','@craft/web/assets/login/dist'),('e1b27aca','@app/web/assets/craftsupport/dist'),('e3c3904a','@lib/velocity'),('e69c3365','@lib/fileupload'),('e8b149b8','@craft/web/assets/craftsupport/dist'),('e8e5803d','@lib/element-resize-detector'),('e9c4a466','@craft/web/assets/plugins/dist'),('eb2d8df3','@app/web/assets/login/dist'),('ed546ff7','@vendor/craftcms/redactor/lib/redactor-plugins/filemanager'),('ef13988d','@app/web/assets/cp/dist'),('ef20d60b','@app/web/assets/updateswidget/dist'),('f0d112ca','@lib/d3'),('f24c6737','@bower/jquery/dist'),('f25ebf00','@app/web/assets/recententries/dist'),('f42bd5a6','@app/web/assets/pluginstore/dist'),('f4605f99','@craft/web/assets/feed/dist'),('f4799fe1','@craft/web/assets/clearcaches/dist'),('f538c87b','@luwes/codemirror/assets'),('f77a15d7','@lib/jquery-ui'),('f9d00e59','@lib/jquery-touch-events'),('fd96811e','@app/web/assets/tablesettings/dist'),('fdafda4','@app/web/assets/dashboard/dist'),('fe74329b','@lib/picturefill'),('ff758434','@app/web/assets/updater/dist'),('ffe43fa2','@lib/jquery.payment');
/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `revisions`
--

DROP TABLE IF EXISTS `revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `revisions_sourceId_num_unq_idx` (`sourceId`,`num`),
  KEY `revisions_creatorId_fk` (`creatorId`),
  CONSTRAINT `revisions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `revisions_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revisions`
--

LOCK TABLES `revisions` WRITE;
/*!40000 ALTER TABLE `revisions` DISABLE KEYS */;
INSERT INTO `revisions` VALUES (1,52,1,2,NULL),(2,52,1,1,'Revision from Oct 25, 2019, 12:20:52 PM'),(3,27,1,4,NULL),(4,15,1,6,NULL),(5,48,1,1,NULL),(6,47,1,3,NULL),(7,47,1,2,NULL),(8,47,1,1,'Revision from Mar 11, 2019, 2:32:34 PM'),(9,46,1,1,NULL),(10,44,1,2,NULL),(11,44,1,1,NULL),(12,40,1,5,NULL),(13,42,1,2,NULL),(14,36,1,2,NULL),(15,40,1,4,NULL),(16,42,1,1,NULL),(17,40,1,3,NULL),(18,40,1,2,NULL),(19,40,1,1,NULL),(20,38,1,1,NULL),(21,36,1,1,NULL),(22,17,1,4,NULL),(23,27,1,3,NULL),(24,25,1,3,NULL),(25,26,1,3,NULL),(26,23,1,5,NULL),(27,23,1,4,NULL),(28,22,1,3,NULL),(29,24,1,3,NULL),(30,16,1,3,NULL),(31,17,1,3,NULL),(32,17,1,2,NULL),(33,17,1,1,'Revision from Mar 11, 2019, 7:58:56 AM'),(34,15,1,5,NULL),(35,16,1,2,NULL),(36,16,1,1,'Revision from Feb 4, 2018, 10:23:40 PM'),(37,24,1,2,NULL),(38,24,1,1,'Revision from Feb 4, 2018, 10:25:56 PM'),(39,22,1,2,NULL),(40,22,1,1,'Revision from Feb 4, 2018, 10:23:05 PM'),(41,23,1,3,NULL),(42,26,1,2,NULL),(43,26,1,1,'Revision from Feb 4, 2018, 10:26:26 PM'),(44,25,1,2,NULL),(45,25,1,1,'Revision from Feb 4, 2018, 10:25:27 PM'),(46,27,1,2,NULL),(47,27,1,1,'Revision from Feb 4, 2018, 10:22:39 PM'),(48,15,1,4,NULL),(49,15,1,3,NULL),(50,23,1,2,NULL),(51,23,1,1,'Revision from Feb 4, 2018, 10:22:07 PM'),(52,15,1,2,NULL),(53,15,1,1,'Revision from Feb 6, 2018, 6:23:33 AM');
/*!40000 ALTER TABLE `revisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `searchindex`
--

DROP TABLE IF EXISTS `searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `searchindex`
--

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;
INSERT INTO `searchindex` VALUES (1,'username',0,1,' admin '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(1,'email',0,1,' info imarc com '),(1,'slug',0,1,''),(17,'field',11,1,''),(16,'field',44,1,''),(16,'field',39,1,''),(16,'field',11,1,''),(16,'field',45,1,''),(15,'field',11,1,' convallis ullamcorper potenti curabitur dictum lectus in ligula facilisis phasellus curabitur himenaeos turpis quam rhoncus consequat auctor duis ligula aliquam consectetur sapien neque fusce elit mi facilisis tortor ullamcorper lorem gravida libero vehicula rich text diam justo orci consectetur conubia sapien hac fames morbi mi massa fringilla habitant quisque nostra aenean neque diam dui magna ornare fames inceptos egestas viverra curae netus sit non etiam lacus dolor fusce etiam nec donec habitasse dui laoreet tristique tortor convallis donec viverra amet nisi augue ultricies donec est habitasse dui tellus magna cursus laoreet posuere egestas eros libero quisque vulputate cras aliquam ut two columns chief employee first lastername amet elit class varius risus ipsum duis mollis bibendum placerat non volutpat ad conubia feugiat habitant conubia gravida testimonial https www imarc com volutpat ad conubia feugiat habitant conubia gravida call to action example shared block '),(16,'field',41,1,''),(5,'slug',0,1,' white papers '),(5,'title',0,1,' white papers '),(6,'slug',0,1,' videos '),(6,'title',0,1,' videos '),(7,'slug',0,1,' case studies '),(7,'title',0,1,' case studies '),(8,'slug',0,1,' webinars '),(8,'title',0,1,' webinars '),(9,'slug',0,1,' reports '),(9,'title',0,1,' reports '),(16,'field',42,1,''),(17,'field',41,1,''),(17,'field',42,1,''),(17,'field',43,1,''),(17,'field',40,1,''),(17,'field',39,1,''),(16,'field',40,1,''),(15,'slug',0,1,' homepage '),(15,'title',0,1,' home '),(16,'slug',0,1,' error page '),(16,'title',0,1,' error '),(17,'slug',0,1,' page not found '),(17,'title',0,1,' 404 page '),(17,'field',44,1,''),(16,'field',43,1,''),(15,'field',39,1,''),(15,'field',40,1,''),(15,'field',41,1,''),(15,'field',42,1,''),(15,'field',43,1,''),(15,'field',44,1,''),(15,'field',45,1,''),(17,'field',45,1,''),(18,'slug',0,1,' culture '),(18,'title',0,1,' culture '),(19,'slug',0,1,' hiring '),(19,'title',0,1,' hiring '),(20,'slug',0,1,' announcement '),(20,'title',0,1,' announcement '),(21,'slug',0,1,' press release '),(21,'title',0,1,' press release '),(22,'slug',0,1,' contact '),(22,'title',0,1,' contact '),(23,'slug',0,1,' about '),(23,'title',0,1,' about '),(24,'slug',0,1,' privacy page '),(24,'title',0,1,' privacy '),(25,'slug',0,1,' news events page '),(25,'title',0,1,' news events '),(26,'slug',0,1,' resources page '),(26,'title',0,1,' resources '),(27,'slug',0,1,' blog page '),(27,'title',0,1,' blog '),(23,'field',11,1,''),(23,'field',39,1,''),(23,'field',40,1,''),(23,'field',41,1,''),(23,'field',42,1,''),(23,'field',43,1,''),(23,'field',44,1,''),(23,'field',45,1,''),(27,'field',11,1,''),(27,'field',39,1,''),(27,'field',40,1,''),(27,'field',41,1,''),(27,'field',42,1,''),(27,'field',43,1,''),(27,'field',44,1,''),(27,'field',45,1,''),(22,'field',11,1,''),(22,'field',39,1,''),(22,'field',40,1,''),(22,'field',41,1,''),(22,'field',42,1,''),(22,'field',43,1,''),(22,'field',44,1,''),(22,'field',45,1,''),(25,'field',11,1,''),(25,'field',39,1,''),(25,'field',40,1,''),(25,'field',41,1,''),(25,'field',42,1,''),(25,'field',43,1,''),(25,'field',44,1,''),(25,'field',45,1,''),(24,'field',11,1,''),(24,'field',39,1,''),(24,'field',40,1,''),(24,'field',41,1,''),(24,'field',42,1,''),(24,'field',43,1,''),(24,'field',44,1,''),(24,'field',45,1,''),(26,'field',11,1,''),(26,'field',39,1,''),(26,'field',40,1,''),(26,'field',41,1,''),(26,'field',42,1,''),(26,'field',43,1,''),(26,'field',44,1,''),(26,'field',45,1,''),(15,'field',63,1,' cheesecake testing '),(32,'field',14,1,' rich text '),(32,'field',15,1,' convallis ullamcorper potenti curabitur dictum lectus in ligula facilisis phasellus curabitur himenaeos turpis quam rhoncus consequat auctor duis ligula aliquam consectetur sapien neque fusce elit mi facilisis tortor ullamcorper lorem gravida libero vehicula '),(32,'slug',0,1,''),(33,'field',16,1,' two columns '),(33,'field',17,1,' diam justo orci consectetur conubia sapien hac fames morbi mi massa fringilla habitant quisque nostra aenean neque diam dui magna ornare fames inceptos egestas viverra curae netus sit non etiam lacus '),(33,'field',18,1,' dolor fusce etiam nec donec habitasse dui laoreet tristique tortor convallis donec viverra amet nisi augue ultricies donec est habitasse dui tellus magna cursus laoreet posuere egestas eros libero quisque vulputate cras aliquam ut '),(33,'slug',0,1,''),(34,'field',29,1,' testimonial '),(34,'field',30,1,' amet elit class varius risus ipsum duis mollis bibendum placerat non volutpat ad conubia feugiat habitant conubia gravida '),(34,'field',31,1,' first lastername '),(34,'field',32,1,' chief employee '),(34,'slug',0,1,''),(35,'field',35,1,' call to action '),(35,'field',36,1,' volutpat ad conubia feugiat habitant conubia gravida '),(35,'field',38,1,' https www imarc com '),(35,'slug',0,1,''),(15,'field',66,1,' welcome to your new site '),(15,'field',67,1,' you ve successfully got a new site up and running using padstone a starter package built by imarc '),(23,'field',66,1,' get to know us '),(23,'field',67,1,' we re here for you and can t wait to help '),(27,'field',66,1,' our blog '),(27,'field',67,1,''),(22,'field',66,1,' contact us '),(22,'field',67,1,' we want to hear from you '),(16,'field',66,1,' something horrible has happened '),(16,'field',67,1,''),(25,'field',66,1,' news events '),(25,'field',67,1,' here s what s happening '),(17,'field',66,1,' page not found '),(17,'field',67,1,' we couldn t find what you re looking for '),(24,'field',66,1,' legal privacy '),(24,'field',67,1,''),(26,'field',66,1,' resources '),(26,'field',67,1,' we ve got you covered '),(27,'field',68,1,''),(36,'field',54,1,''),(36,'field',56,1,''),(36,'field',55,1,''),(36,'field',58,1,''),(36,'field',57,1,' you ve successfully found the blog section within padstone feel free to delete this entry and add your own articles '),(36,'field',11,1,' you ve successfully found the blog section within padstone feel free to delete this entry and add your own articles quisque pharetra sollicitudin lectus scelerisque congue nisi volutpat id nulla facilisi etiam a vestibulum nisl a suscipit erat nunc vitae ullamcorper elit quis porta mi donec eu nisl sit amet metus dictum dapibus sed mattis nulla et nulla sollicitudin non semper augue pharetra morbi fringilla sem sed pellentesque dignissim sed eget ultrices erat suspendisse a leo viverra facilisis justo ut feugiat diam integer in vehicula ex donec egestas consequat lectus aliquam porta donec ultricies arcu at dolor mattis id euismod nisi rutrum suspendisse potenti donec id odio ante donec sollicitudin eleifend tempor '),(36,'field',39,1,''),(36,'field',40,1,''),(36,'field',41,1,''),(36,'field',42,1,''),(36,'field',43,1,''),(36,'field',44,1,''),(36,'field',45,1,''),(37,'field',14,1,''),(37,'field',15,1,' you ve successfully found the blog section within padstone feel free to delete this entry and add your own articles '),(37,'slug',0,1,''),(36,'slug',0,1,' welcome to the blog '),(36,'title',0,1,' welcome to the blog '),(38,'field',52,1,''),(38,'field',11,1,' a new website was successfully created using padstone a starter package built by imarc feel free to delete this entry and add your own news '),(38,'field',39,1,''),(38,'field',40,1,''),(38,'field',41,1,''),(38,'field',42,1,''),(38,'field',43,1,''),(38,'field',44,1,''),(38,'field',45,1,''),(39,'field',14,1,''),(39,'field',15,1,' a new website was successfully created using padstone a starter package built by imarc feel free to delete this entry and add your own news '),(39,'slug',0,1,''),(38,'slug',0,1,' new website successfully created '),(38,'title',0,1,' new website successfully created '),(40,'field',5,1,''),(40,'field',10,1,''),(40,'field',4,1,''),(40,'field',7,1,''),(40,'field',8,1,' download now '),(40,'field',11,1,' this is an example featured resource '),(40,'field',39,1,''),(40,'field',40,1,''),(40,'field',41,1,''),(40,'field',42,1,''),(40,'field',43,1,''),(40,'field',44,1,''),(40,'field',45,1,''),(41,'field',14,1,''),(41,'field',15,1,' this is an example featured resource '),(41,'slug',0,1,''),(40,'slug',0,1,' import resource '),(40,'title',0,1,' external resource '),(40,'field',6,1,' https docs craftcms com v3 '),(42,'field',6,1,' https www imarc com '),(42,'field',5,1,''),(42,'field',10,1,''),(42,'field',4,1,''),(42,'field',39,1,''),(42,'field',40,1,''),(42,'field',41,1,''),(42,'field',42,1,''),(42,'field',43,1,''),(42,'field',44,1,''),(42,'field',45,1,''),(42,'slug',0,1,' imarc website '),(42,'title',0,1,' imarc website '),(43,'field',16,1,''),(43,'field',17,1,' quisque pharetra sollicitudin lectus scelerisque congue nisi volutpat id nulla facilisi etiam a vestibulum nisl a suscipit erat nunc vitae ullamcorper elit quis porta mi donec eu nisl sit amet metus dictum dapibus sed mattis nulla et nulla sollicitudin non semper augue pharetra '),(43,'field',18,1,' morbi fringilla sem sed pellentesque dignissim sed eget ultrices erat suspendisse a leo viverra facilisis justo ut feugiat diam integer in vehicula ex donec egestas consequat lectus aliquam porta donec ultricies arcu at dolor mattis id euismod nisi rutrum suspendisse potenti donec id odio ante donec sollicitudin eleifend tempor '),(43,'slug',0,1,''),(40,'field',69,1,' proin est libero dignissim id ex sed ultricies accumsan libero duis lobortis fermentum volutpat quisque at dignissim orci a vehicula tellus donec vel urna eleifend tincidunt purus at varius augue '),(42,'field',69,1,' mauris justo ante iaculis eget augue ac consequat sagittis odio vivamus pretium elit vitae commodo feugiat diam tortor elementum velit sit amet congue tortor ex vitae mi morbi bibendum tempus semper '),(44,'field',69,1,' pellentesque finibus sagittis placerat integer diam lorem viverra tempus libero eget sagittis faucibus mi in sit amet quam eget nibh cursus malesuada fusce nibh ante maximus fermentum arcu eu ultricies hendrerit justo '),(44,'field',8,1,' learn more '),(44,'field',6,1,' https www imarc com '),(44,'field',5,1,''),(44,'field',10,1,''),(44,'field',4,1,''),(44,'field',11,1,' integer non pretium nulla nullam accumsan justo eu maximus tincidunt ligula augue venenatis odio in luctus nisi arcu quis ex aenean non lacus eget ipsum laoreet faucibus at fringilla nibh praesent eget eleifend dolor donec iaculis diam id justo condimentum egestas '),(44,'field',39,1,''),(44,'field',40,1,''),(44,'field',41,1,''),(44,'field',42,1,''),(44,'field',43,1,''),(44,'field',44,1,''),(44,'field',45,1,''),(45,'field',14,1,''),(45,'field',15,1,' integer non pretium nulla nullam accumsan justo eu maximus tincidunt ligula augue venenatis odio in luctus nisi arcu quis ex aenean non lacus eget ipsum laoreet faucibus at fringilla nibh praesent eget eleifend dolor donec iaculis diam id justo condimentum egestas '),(45,'slug',0,1,''),(44,'slug',0,1,' acme resource '),(44,'title',0,1,' acme resource '),(38,'field',61,1,''),(46,'field',48,1,' example employee '),(46,'field',49,1,''),(46,'field',50,1,' lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua '),(46,'field',51,1,' first lastername ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum '),(46,'field',39,1,''),(46,'field',40,1,''),(46,'field',41,1,''),(46,'field',42,1,''),(46,'field',43,1,''),(46,'field',44,1,''),(46,'field',45,1,''),(46,'slug',0,1,' first lastername '),(46,'title',0,1,' first lastername '),(47,'slug',0,1,' leadership page '),(47,'title',0,1,' leadership '),(47,'field',66,1,' leadership '),(47,'field',67,1,' leading us to a brighter future '),(47,'field',39,1,''),(47,'field',40,1,''),(47,'field',41,1,''),(47,'field',42,1,''),(47,'field',43,1,''),(47,'field',44,1,''),(47,'field',45,1,''),(48,'field',11,1,' this is a shared block this is a shared block '),(49,'field',14,1,' this is a shared block '),(49,'field',15,1,' this is a shared block '),(49,'slug',0,1,''),(48,'slug',0,1,' example shared block '),(48,'title',0,1,' example shared block '),(50,'field',70,1,' example shared block '),(50,'slug',0,1,''),(51,'filename',0,1,' imarc_logo jpg '),(51,'extension',0,1,' jpg '),(51,'kind',0,1,' image '),(51,'slug',0,1,''),(51,'title',0,1,' imarc_logo '),(52,'slug',0,1,' service unavailable page '),(52,'title',0,1,' service unavailable page '),(52,'field',66,1,' site unavailable '),(52,'field',67,1,' our site is temporarily unavailable please try again later '),(52,'field',11,1,''),(52,'field',39,1,''),(52,'field',40,1,''),(52,'field',41,1,''),(52,'field',42,1,''),(52,'field',43,1,''),(52,'field',44,1,''),(52,'field',45,1,'');
/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT 0,
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `previewTargets` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sections_structureId_idx` (`structureId`),
  KEY `sections_dateDeleted_idx` (`dateDeleted`),
  KEY `sections_name_idx` (`name`),
  KEY `sections_handle_idx` (`handle`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
INSERT INTO `sections` VALUES (2,1,'Resources','resources','structure',1,'all',NULL,'2018-01-31 19:49:43','2019-03-11 20:00:24',NULL,'31726602-42e3-461e-ad79-08d69e6e899a'),(3,NULL,'Homepage','homepage','single',1,'all',NULL,'2018-02-02 05:31:09','2019-03-08 21:54:30',NULL,'804ebac0-45d8-49c0-9e1f-418cc9c708e7'),(4,NULL,'Error Page','errorPage','single',1,'all',NULL,'2018-02-02 05:34:35','2019-03-11 18:14:19',NULL,'6e318b58-9c19-4a89-aece-8db4a7b52124'),(5,NULL,'404 Page','notFoundPage','single',1,'all',NULL,'2018-02-02 05:34:50','2019-03-11 18:15:48',NULL,'aa4b309e-df7a-47cf-9aa5-25285f46796f'),(6,NULL,'News Articles','news','channel',1,'all',NULL,'2018-02-02 22:08:02','2019-03-11 21:07:47',NULL,'550e9481-b606-4b2b-83e1-9a895a224d38'),(7,3,'People','people','structure',1,'all',NULL,'2018-02-02 22:10:38','2019-03-11 22:01:51',NULL,'c87b5acc-afe1-4ddf-b73c-b449c9f29c2d'),(8,NULL,'Blog Articles','blog','channel',1,'all',NULL,'2018-02-02 22:22:44','2018-02-04 23:04:22',NULL,'fdc8d709-53c4-4104-ba7b-f424bad5b7fc'),(9,NULL,'Events','events','channel',1,'all',NULL,'2018-02-04 22:10:01','2018-02-04 22:10:01',NULL,'7b352338-e4c1-4527-8c7b-dd3ae5e9d28f'),(10,NULL,'Contact Page','contactPage','single',1,'all',NULL,'2018-02-04 22:14:34','2019-03-11 14:58:26',NULL,'548dacf3-a377-4ba7-9bc4-d9102a1fc455'),(11,5,'Landing Pages','landingPages','structure',1,'all',NULL,'2018-02-04 23:02:31','2019-03-11 18:14:52',NULL,'16f0db7d-a9b8-4569-8198-d836625cea77'),(12,NULL,'About Page','aboutPage','single',1,'all',NULL,'2018-02-04 23:03:59','2019-10-22 14:53:44',NULL,'ebac57bc-baaf-4975-bf81-a0f4c66bad4d'),(13,NULL,'Privacy Page','privacyPage','single',1,'all',NULL,'2018-02-04 23:08:53','2019-03-11 18:13:10',NULL,'698462dc-1720-42e6-a09e-9e59bce0aa23'),(14,NULL,'News & Events Page','newsEventsPage','single',1,'all',NULL,'2018-02-05 06:20:14','2019-10-21 19:15:58',NULL,'ca363472-ca75-4a5e-9e46-dc48bfec0b5d'),(15,NULL,'Resources Page','resourcesPage','single',1,'all',NULL,'2018-02-05 06:20:40','2019-10-21 19:16:06',NULL,'20423d03-2767-4e23-8ba6-41dc15391050'),(16,NULL,'Blog Page','blogPage','single',1,'all',NULL,'2018-02-05 06:21:29','2019-10-21 18:08:47',NULL,'1e6d0ae4-0c2d-4c61-aa0e-f67a0d64d0be'),(17,6,'About Pages','aboutPages','structure',1,'all',NULL,'2018-02-05 19:14:26','2019-03-12 15:53:47',NULL,'3375cf3e-4d50-4b42-b4ab-d8ad7e40cdfb'),(18,NULL,'Leadership Page','leadershipPage','single',1,'all',NULL,'2019-03-11 21:31:27','2019-10-21 18:09:57',NULL,'0041c886-3d54-4352-801b-0450a61a9011'),(19,7,'Shared Blocks','sharedBlocks','structure',1,'all',NULL,'2019-03-12 15:53:08','2019-03-12 15:54:08',NULL,'16e6b8c8-fd2d-4fa3-9219-9d81e2ab1e98'),(20,NULL,'Service Unavailable Page','serviceUnavailablePage','single',1,'all',NULL,'2019-10-25 18:39:20','2019-10-25 19:20:46',NULL,'d44a5a95-fa08-4efd-8496-2ac825c5acd1');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections_sites`
--

DROP TABLE IF EXISTS `sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT 1,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `uriFormat` text DEFAULT NULL,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections_sites`
--

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;
INSERT INTO `sections_sites` VALUES (2,2,1,1,1,'resources/{slug}','resources/_entry','2018-01-31 19:49:43','2019-03-11 20:00:24','8b79f25d-8445-48a7-be1a-71186f3c8866'),(3,3,1,1,1,'__home__','_index','2018-02-02 05:31:09','2019-03-08 21:54:30','e213bd1a-861a-4660-911c-a4de9b22dc31'),(4,4,1,1,1,'500','_500','2018-02-02 05:34:35','2019-03-11 18:14:19','3afa4602-cccf-4792-b6bc-7c8a2a862085'),(5,5,1,1,1,'404','_404','2018-02-02 05:34:50','2019-03-11 18:15:48','2918dfa6-b002-4580-88db-59652bfa379e'),(6,6,1,1,1,'news/{slug}','news/_entry','2018-02-02 22:08:02','2019-03-11 21:07:47','8cb5a00e-052a-420a-924b-bfc86845e325'),(7,7,1,1,1,'leadership/{slug}','leadership/_entry','2018-02-02 22:10:38','2019-03-11 22:01:51','f356a9c5-f987-4cfd-a6db-ce900345e7f1'),(8,8,1,1,1,'blog/{slug}','blog/_entry','2018-02-02 22:22:44','2018-02-04 23:04:22','a9a9a3f3-7275-44f5-9917-2bc700118f8a'),(9,9,1,1,1,'events/{slug}','events/_entry','2018-02-04 22:10:01','2018-02-04 22:10:01','5759ee52-1058-435c-a79b-f30752ecac01'),(10,10,1,1,1,'contact','_contact','2018-02-04 22:14:34','2019-03-11 14:58:26','7c0c2dbb-0889-40fe-a725-326e4630cf41'),(11,11,1,1,1,'{slug}','_default','2018-02-04 23:02:31','2019-03-11 18:14:52','4aabd6b2-6431-4236-8c1d-75821d56f2d0'),(12,12,1,1,1,'about','about/_index','2018-02-04 23:03:59','2019-10-22 14:53:44','3985bb76-af9f-4f82-bdcb-876df24c709d'),(13,13,1,1,1,'privacy','_default','2018-02-04 23:08:53','2019-03-11 18:13:10','455c7250-60a4-44ca-9737-ff05679e14f7'),(14,14,1,1,1,'news','news/_index','2018-02-05 06:20:14','2019-10-21 19:15:58','24d9b977-d03d-4afe-a2d9-959173a4b563'),(15,15,1,1,1,'resources','resources/_index','2018-02-05 06:20:40','2019-10-21 19:16:06','59b5b039-2a60-4b7a-9dc9-5497c51e5914'),(16,16,1,1,1,'blog','blog/_index','2018-02-05 06:21:29','2019-10-21 18:08:47','2a7563e6-ff82-460d-af89-2526fb421cde'),(17,17,1,1,1,'about/{slug}','about-pages/_entry','2018-02-05 19:14:26','2019-03-12 15:53:47','e93ea479-e8bf-4ee4-9f89-bc374ccc5eaa'),(18,18,1,1,1,'leadership','leadership/_index','2019-03-11 21:31:27','2019-10-21 18:09:57','df06c399-8a8f-42b1-a71e-104cb70dd267'),(19,19,1,0,0,NULL,NULL,'2019-03-12 15:53:08','2019-03-12 15:54:08','c654d8bd-9bd6-4559-a610-e2b15c265557'),(20,20,1,1,1,'503','503','2019-10-25 18:39:20','2019-10-25 19:20:46','8fbe8b8e-166f-4bed-98a9-e6f01442828c');
/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sequences`
--

LOCK TABLES `sequences` WRITE;
/*!40000 ALTER TABLE `sequences` DISABLE KEYS */;
/*!40000 ALTER TABLE `sequences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sessions_uid_idx` (`uid`),
  KEY `sessions_token_idx` (`token`),
  KEY `sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `sessions_userId_idx` (`userId`),
  CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (59,1,'UIonP96ca32SDTVHIIhSbiujJE3uzGFlbD49seoU3tZly_wckCorCVOD7wkgxLItnRe988qRr9wLYHjKQjqp5bAJaYeOCg8ke2KT','2019-03-12 15:51:38','2019-03-12 16:14:14','9ba83c84-1494-460e-a42c-34867e678ae8'),(60,1,'jIpW3VLrEC5quftC1rZxFk3EJSGUda5_E4kicqC8L2hgKwYG1Y1N75XDjnMBTpiHi7lCeTi68nClqC8aULH_fL3iOZyGyJFP3NZL','2019-03-12 17:27:58','2019-03-12 18:15:08','9051eb38-5ed8-4fb6-87f3-feeb0de52420'),(61,1,'bzCjPvNo2ySF_PW7CDelJA-GnjeF0Y6uxEqH4EDYi2OkQU2EW5neO6qW7SBh9vb_Xl-cLVARI_FMfkwCEZV5mIxLfwuxJXKFJSLo','2019-03-12 18:22:00','2019-03-12 18:59:40','2cfe8983-4ded-4da9-a05d-2b1ed7ab2dc1'),(62,1,'nIhUXsJyN5-hr02DCuIelka4BkNirAGfp4UrGGjL3LKUe52YE1HWjms-xqgNcE-x51QyXpaP1wARLaZck2gnDyCCCUpxtP2J6KO_','2019-03-15 14:29:40','2019-03-15 14:29:53','8303bf6d-f34f-4713-8003-ac858ebde3c9'),(63,1,'JZWwQrTRMHY8-j_wfk3XSxfD_G570d76sbQ75_-gjOUyDMWRnJCf3-V2COwJWiIeLVmbmQhmCWg7wr4Cp7G1ZxbW6dcdfLCnx1Iv','2019-03-19 17:30:49','2019-03-20 19:53:50','0cd287ab-7e18-465a-9a63-4e306527eef8'),(64,1,'kr5sy8poleNHBjrKDrdQ7Pk2-TF7sOuTekcZwKCxFVa_UZwSbSt3CmkSUlszhQBSIu6Epeta4JMn1BFVk1wmCixnFC7wt-BxneD0','2019-03-20 19:53:57','2019-03-20 19:58:03','151510f2-bf88-43ad-8d17-5366ea9739bc'),(65,1,'AcSxC4bOTv7dIjNLe9QiWk7m7OuCworQaxz_GvxAFPhLx6AQEKq2vMSfslRt1Yk09FqMYaAv9bFz3GZuOwlTcHzHVByvTgz5a2OQ','2019-04-25 18:05:47','2019-04-29 15:33:50','36845d58-c04d-4e3c-967b-7b4e68492fba'),(66,1,'_MeVMegDrI60SAZJyyY1ZrpynkgXnG7Div6i0oSC4xDEKSxlTutt3s8LV4B2LmLnHh6PUDJEXBCuHMmEsHz9w8G7tWURYftfJnIE','2019-05-06 20:11:53','2019-05-09 13:41:06','34c75e84-55a3-44e0-bfcd-81298e6f5afc'),(67,1,'DL2Q9MkO-XTHynDW25w2G7pf_RKW9I9BRPGoGQJ7X0t04IAbOgHZS9Kic5ASdCW18f-W1oFulnYhwqTNJFuEp-j_1pwlR6opGlnP','2019-10-21 18:06:42','2019-10-21 18:10:02','a12c8698-72ea-48f1-9db6-e6396c03c113'),(68,1,'ojM0arFNqZGj5CmdAr-lBnyzBDyBly7m3Q0l4-JhS7SG4Nk2TgmnDFipvrU6QB4on5T8Ds6V7l2lF8wGu0i0PoW3j9jt0HZh4bpT','2019-10-21 19:10:05','2019-10-21 19:16:11','588115dd-b06f-4ad0-b6a4-c72242571eab'),(69,1,'nQNa7q3KNR9vYUcZ3o-mvvHm-xu46ttEG_NPDGCmhEb6S-L3EHp1038UCR_OWblvRRiMBncwjNiaHLRwCyV8rwit-yrCLwj4HLLd','2019-10-21 20:16:15','2019-10-21 20:16:15','bea5e864-ef40-42fe-bfc3-1460f5d4db8b'),(70,1,'9iXbnFpats1ZtY_54LBL_AfWvexGVaTZtA_qb_-B5-4aY46sSxagyCs8Ws0DDvXozq9OpgTw2WgxdQk5ipdN7XouD3B51j52rWzr','2019-10-21 21:16:18','2019-10-21 21:16:18','0d0ce982-ee91-489f-8c59-cb6b96c64387'),(71,1,'gpxVNGO2mzWayPHLNzZ3P2VWniNlTvtsnMiEi7G3Jk3k13wV2ETGN5fwvfmAeyyVQgutn5ckffLQodVVTg5WvqcsYeryyvjgfa4P','2019-10-21 22:16:22','2019-10-21 22:16:22','02f00f2b-357b-48c5-83db-9f46833c0153'),(72,1,'LPP-4eYyNL5y50mY2pKk3VoUgVU9ahdFnLrldAh8iJN9uT--dmBxAkFZkfDt_CSxlrI6kCnwC2YYecsa2pccZf3I8EI2LQ2vOt8Y','2019-10-22 14:53:19','2019-10-22 14:53:49','6a5b76a9-b85c-4bfb-a322-f5f213d090be'),(73,1,'uDVcNYLX1dH5heJY7cqW_ZXgdrtZcZ-GjsJaCIEW4hnhQJ_359fAnzPGS2Vh1NvgrrSkBzwBrF9HLLheqNVYdVxzUHO-mnPQl8Vq','2019-10-22 15:53:53','2019-10-22 15:53:53','11bae72b-a0ed-4952-8e9d-4538d660b47b'),(74,1,'sP_hHuxu5T9qL6zjjDEKRTrw-_j3g42DTsj0PBySDZ2mharWzOwhEAuc9Oc4RTl-CPhvmSu772lF6FVsjon4iDQ7OaerqTP5de3K','2019-10-22 15:53:53','2019-10-22 15:53:53','1868d925-2744-4e77-bb6a-fab43c5860e3'),(75,1,'7fR2Oitw3Uk9oopU9nOcjyphTTSO8OVmxQKpaSVZ9syXunj4TOq4PVk2pLPFe2PJ-FSBwViVGX5fnbQ7uT6ZK26BHXUueT87om9i','2019-10-22 16:54:35','2019-10-22 16:54:35','18fe1bde-522f-41bd-9e57-755ca561fee8'),(76,1,'5gziMkL21iq6XCIHMr88juZExl0oOzKpieIYOAaaA4bUTPam_JD1buccZt-OgqKCo2MIrKiSkjZL2mixL7rZuWHfa-GSennGEmDP','2019-10-22 17:54:39','2019-10-22 17:54:39','0e57c78a-98dc-46a8-a97c-7caacbafd602'),(77,1,'vTYUBiP3L4CBcAcAw-h8OnJkyepdLoUBRng7Z7VDiZ4ZKPYWb7tSe5Pk1IQciZS0uFdgHd4MuISn9Cg-pdzQ4u7u2M1z32uXf6_o','2019-10-22 17:54:39','2019-10-22 17:54:39','9ed6ac3c-3907-4355-b68f-e8c70b950d68'),(78,1,'8kuqYN4U5hBcKRStm2SH7aRJeUXexgqMHxFAj1b27KqmAP1qBIn0tu_T5obLFnE3v554D096SKeEZzM4VRgpbYJp4iM3kJKqM3F9','2019-10-22 18:54:42','2019-10-22 18:54:42','3dff3d68-284b-4aa5-bd55-71e889fb0a27'),(79,1,'Xyk3WsDQhVh2gmjn1NPKXD2NkD7h4hnmNTt6avUpdU3xQu-3QREmCP0Tv63sY0k3vXCY-j1lSOTtyp5VALH13PrBoOSGilK9PoCk','2019-10-22 19:54:46','2019-10-22 19:54:46','69df9b06-bcd5-4546-aa22-492603871566'),(80,1,'PWRc6tnlQVEQPbiLL0zOEQ-KhhWkgxQ3IurFa0z-LkWa9lR91ZZZjlZYyNsACW3nPT4HdrjnX6R3innAIxC6h9C6IvYa7UkC4VGs','2019-10-22 20:54:50','2019-10-22 21:04:08','44712ef2-50c5-4e4b-98e5-9e8dbc0a39e0'),(81,1,'mjI-wvDbnq-u0C0bl-duxwZqisdFKgEx0JLUcePhCNE_XXQwtm8BYWrBSDJd_XZV8LdPG7-9rNKi8zyosQymj0nYZEtVIjICdxKW','2019-10-22 22:04:12','2019-10-22 22:04:12','c5df84fb-4ea0-41c8-8a2d-e74846a5c8ee'),(82,1,'un9YjiNGjVD2FGWWKVokPVThchpNxRvg1x04Qevyeluz8eRIIV1hAOEu6OCHZ-Z4yp87PvMytHm9aUPMQ1V6p6q4tOkMvdNHrL_L','2019-10-25 15:23:48','2019-10-25 15:23:48','39ac6a98-d10e-46f9-b8eb-37045e6be65a'),(83,1,'-rtqyFIm9svz2Jz0yxfnrW9I_-_aspPHCyEq6ZbF2mFAxmLcRejESaK35K61r8GEun3hQ071OW8PRpZO68xr2GxaQNXhfgXICtZy','2019-10-25 16:45:51','2019-10-25 16:45:51','6719445f-0023-45d3-8648-d28a6ed22553'),(84,1,'gpNs0VYJJhFd49CYcGCaCpFKf-gkvQuiCkKy7kO3pY3mduNlXv56e3fINZjbDNQImk7Dd3K1IKqEoqTBALHL484UUNBVFc13lybI','2019-10-25 17:45:56','2019-10-25 19:24:39','0fc2785d-22a9-4aaf-8f3e-8c11c6e12140'),(87,1,'w7jL6gODaLPmxEUJBcknAgm0Qk_ZhvRFhoVKL_7_WOdiaNWZX5znbmEkXs-3RIktBK1d3AWWaImd3S4gzskFNM-dcuq1WSNsQNuA','2019-12-23 15:09:55','2019-12-23 15:24:51','5b7847b1-e6d5-46e0-bd26-46652f155eb0');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shunnedmessages`
--

DROP TABLE IF EXISTS `shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shunnedmessages`
--

LOCK TABLES `shunnedmessages` WRITE;
/*!40000 ALTER TABLE `shunnedmessages` DISABLE KEYS */;
/*!40000 ALTER TABLE `shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sitegroups`
--

DROP TABLE IF EXISTS `sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sitegroups_dateDeleted_idx` (`dateDeleted`),
  KEY `sitegroups_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sitegroups`
--

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;
INSERT INTO `sitegroups` VALUES (1,'Padstone','2018-01-16 22:09:00','2018-01-16 22:09:00',NULL,'a20a79e6-31e4-4179-833c-e756db8c0d15');
/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 0,
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  KEY `sites_dateDeleted_idx` (`dateDeleted`),
  KEY `sites_handle_idx` (`handle`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
INSERT INTO `sites` VALUES (1,'Padstone','default','en-US',1,'http://dev.padstone.imarc.com/',1,'2017-11-29 20:51:54','2018-01-16 22:09:00',NULL,'5a949caa-356a-45ea-b408-2b267055c99c',1,1);
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `structureelements`
--

DROP TABLE IF EXISTS `structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `structureelements_root_idx` (`root`),
  KEY `structureelements_lft_idx` (`lft`),
  KEY `structureelements_rgt_idx` (`rgt`),
  KEY `structureelements_level_idx` (`level`),
  KEY `structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `structureelements`
--

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;
INSERT INTO `structureelements` VALUES (1,2,NULL,1,1,12,0,'2018-01-31 19:53:20','2018-01-31 19:54:00','9fc1377e-f891-43e0-a4c8-dc1d82039f3b'),(2,2,5,1,10,11,1,'2018-01-31 19:53:20','2018-01-31 19:54:00','49374a75-0159-44b4-8750-5d35b5ee1576'),(3,2,6,1,6,7,1,'2018-01-31 19:53:25','2018-01-31 19:54:00','7cfc0d0f-330d-49f8-aa11-2396a010ddf3'),(4,2,7,1,2,3,1,'2018-01-31 19:53:36','2018-01-31 19:53:59','0e82030a-d1e7-479e-b7ed-a78e3f87b4d2'),(5,2,8,1,8,9,1,'2018-01-31 19:53:45','2018-01-31 19:54:00','091c5d87-ce5b-4b9c-89ed-f9bdfe16dc51'),(6,2,9,1,4,5,1,'2018-01-31 19:53:51','2018-01-31 19:54:00','78f81f07-eb73-4647-9cea-3f50bb75ba05'),(7,4,NULL,7,1,10,0,'2018-02-04 18:18:49','2018-02-04 22:11:36','a0fcc4ff-3f74-4c00-b36f-e2cf74dff431'),(8,4,18,7,2,3,1,'2018-02-04 18:18:49','2018-02-04 18:18:49','3d03a2bb-27a0-4b1a-815d-28c151eb15c5'),(9,4,19,7,4,5,1,'2018-02-04 18:18:57','2018-02-04 18:18:57','8168fae9-088e-4c61-8231-7cca8e2db837'),(10,4,20,7,6,7,1,'2018-02-04 22:11:29','2018-02-04 22:11:29','ce2dbc1c-8f58-400d-8a4b-9b99d3cd7feb'),(11,4,21,7,8,9,1,'2018-02-04 22:11:36','2018-02-04 22:11:36','eae33fde-e06c-497c-a2e7-262280b84bc0'),(12,1,NULL,12,1,26,0,'2019-03-11 18:19:11','2019-12-20 16:18:20','42487dd8-3f60-4fb1-979e-a5f73d3393b1'),(13,1,40,12,2,3,1,'2019-03-11 18:19:11','2019-03-11 18:19:11','34a339a4-ab7e-40b0-b10d-7d909fd91803'),(14,1,42,12,6,7,1,'2019-03-11 18:21:50','2019-03-11 20:13:28','20cb3250-dbb6-43a5-b161-e15137051b26'),(15,1,44,12,4,5,1,'2019-03-11 20:01:52','2019-03-11 20:13:28','62e214b6-5b11-40a2-858a-51919eda8480'),(16,3,NULL,16,1,6,0,'2019-03-11 21:30:37','2019-12-20 16:18:01','1a3b54a7-478e-4808-9980-decd35d34112'),(17,3,46,16,2,3,1,'2019-03-11 21:30:37','2019-03-11 21:30:37','b8e0aa7a-9506-465c-8827-aadeddf13d50'),(18,7,NULL,18,1,6,0,'2019-03-12 16:06:37','2019-12-20 16:17:57','2614c87a-137d-4685-948f-c04cae496201'),(19,7,48,18,2,3,1,'2019-03-12 16:06:37','2019-03-12 16:06:37','b5c9025e-0ed0-4ffe-8572-7039d23ddfef'),(20,7,62,18,4,5,1,'2019-12-20 16:17:56','2019-12-20 16:17:57','951891fb-f3d7-4dde-b5b7-477fe2ea838b'),(21,3,67,16,4,5,1,'2019-12-20 16:17:59','2019-12-20 16:18:01','f600570c-541a-463c-a2ca-764e4179b785'),(22,1,68,12,8,9,1,'2019-12-20 16:18:02','2019-12-20 16:18:03','43529dba-88df-4638-99c8-6533615f6142'),(23,1,70,12,10,11,1,'2019-12-20 16:18:04','2019-12-20 16:18:05','56e262fa-c02e-4964-98d5-1a94b66263c4'),(24,1,72,12,12,13,1,'2019-12-20 16:18:06','2019-12-20 16:18:07','8072c770-2580-49b3-bcaa-8620619bd556'),(25,1,73,12,14,15,1,'2019-12-20 16:18:08','2019-12-20 16:18:09','b4cb1598-eefa-4f98-adad-28c332cd7101'),(26,1,77,12,16,17,1,'2019-12-20 16:18:13','2019-12-20 16:18:14','3070499d-7569-4317-bcd0-7ab2543a7326'),(27,1,78,12,18,19,1,'2019-12-20 16:18:15','2019-12-20 16:18:16','a7c4c5a7-d0e3-40f6-bd08-c4c1d5b72151'),(28,1,79,12,20,21,1,'2019-12-20 16:18:17','2019-12-20 16:18:18','06bb3691-2273-4e3b-a633-d35410b8b11a'),(29,1,80,12,22,23,1,'2019-12-20 16:18:18','2019-12-20 16:18:19','d78a285e-7afb-4981-bdae-2e0eee2bcbb5'),(30,1,81,12,24,25,1,'2019-12-20 16:18:19','2019-12-20 16:18:20','e6de8d39-e193-4530-9830-076333a04a83');
/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `structures`
--

DROP TABLE IF EXISTS `structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `structures`
--

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;
INSERT INTO `structures` VALUES (1,NULL,'2018-01-31 19:49:43','2019-03-11 20:00:24',NULL,'160e63e2-a512-4ade-9f18-2171d2cd84eb'),(2,NULL,'2018-01-31 19:53:07','2019-03-11 19:59:48',NULL,'a05bccd3-a5b7-4519-a8de-a9fd24a1f6fe'),(3,NULL,'2018-02-02 22:10:38','2019-03-11 22:01:51',NULL,'4b707a60-93c9-4e86-a44c-587eb894590e'),(4,NULL,'2018-02-02 22:17:15','2018-02-02 22:17:15',NULL,'7500937b-aa4b-4094-9a13-5480a3ca0589'),(5,NULL,'2018-02-04 23:02:31','2019-03-11 18:14:52',NULL,'6934792a-730e-492e-9701-92209d98f59b'),(6,NULL,'2018-02-05 19:14:26','2019-03-12 15:53:47',NULL,'bdbf4600-d3a2-4085-9cec-643027e88562'),(7,NULL,'2019-03-12 15:53:08','2019-03-12 15:54:08',NULL,'2f71ab53-78c9-442d-a830-50cc16e2c184');
/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `systemmessages`
--

DROP TABLE IF EXISTS `systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `systemmessages`
--

LOCK TABLES `systemmessages` WRITE;
/*!40000 ALTER TABLE `systemmessages` DISABLE KEYS */;
/*!40000 ALTER TABLE `systemmessages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taggroups`
--

DROP TABLE IF EXISTS `taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  KEY `taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `taggroups_name_idx` (`name`),
  KEY `taggroups_handle_idx` (`handle`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taggroups`
--

LOCK TABLES `taggroups` WRITE;
/*!40000 ALTER TABLE `taggroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `taggroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tags_groupId_idx` (`groupId`),
  CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templatecacheelements`
--

DROP TABLE IF EXISTS `templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templatecacheelements`
--

LOCK TABLES `templatecacheelements` WRITE;
/*!40000 ALTER TABLE `templatecacheelements` DISABLE KEYS */;
/*!40000 ALTER TABLE `templatecacheelements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templatecachequeries`
--

DROP TABLE IF EXISTS `templatecachequeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `templatecachequeries_type_idx` (`type`),
  CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templatecachequeries`
--

LOCK TABLES `templatecachequeries` WRITE;
/*!40000 ALTER TABLE `templatecachequeries` DISABLE KEYS */;
/*!40000 ALTER TABLE `templatecachequeries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templatecaches`
--

DROP TABLE IF EXISTS `templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecaches_siteId_idx` (`siteId`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templatecaches`
--

LOCK TABLES `templatecaches` WRITE;
/*!40000 ALTER TABLE `templatecaches` DISABLE KEYS */;
/*!40000 ALTER TABLE `templatecaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text DEFAULT NULL,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_token_unq_idx` (`token`),
  KEY `tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usergroups`
--

DROP TABLE IF EXISTS `usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usergroups`
--

LOCK TABLES `usergroups` WRITE;
/*!40000 ALTER TABLE `usergroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usergroups_users`
--

DROP TABLE IF EXISTS `usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usergroups_users`
--

LOCK TABLES `usergroups_users` WRITE;
/*!40000 ALTER TABLE `usergroups_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpermissions`
--

DROP TABLE IF EXISTS `userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpermissions`
--

LOCK TABLES `userpermissions` WRITE;
/*!40000 ALTER TABLE `userpermissions` DISABLE KEYS */;
INSERT INTO `userpermissions` VALUES (1,'editimagesinvolume:09773b73-a304-4513-84fd-c4d5d4dd953a','2019-12-20 16:17:38','2019-12-20 16:17:38','10276495-b1bc-43c8-b2ee-9c473301f4c2'),(2,'editimagesinvolume:57423459-e14e-4a06-af08-3f1c378379ba','2019-12-20 16:17:38','2019-12-20 16:17:38','32136a9a-da04-494f-86ac-569cd835ca84');
/*!40000 ALTER TABLE `userpermissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpermissions_usergroups`
--

DROP TABLE IF EXISTS `userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpermissions_usergroups`
--

LOCK TABLES `userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `userpermissions_usergroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpermissions_users`
--

DROP TABLE IF EXISTS `userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpermissions_users`
--

LOCK TABLES `userpermissions_users` WRITE;
/*!40000 ALTER TABLE `userpermissions_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpreferences`
--

DROP TABLE IF EXISTS `userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text DEFAULT NULL,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpreferences`
--

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;
INSERT INTO `userpreferences` VALUES (1,'{\"language\":\"en-US\",\"weekStartDay\":\"0\",\"enableDebugToolbarForSite\":false,\"enableDebugToolbarForCp\":false}');
/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT 0,
  `locked` tinyint(1) NOT NULL DEFAULT 0,
  `suspended` tinyint(1) NOT NULL DEFAULT 0,
  `pending` tinyint(1) NOT NULL DEFAULT 0,
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT 0,
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT 0,
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_photoId_fk` (`photoId`),
  KEY `users_email_idx` (`email`),
  KEY `users_username_idx` (`username`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin',NULL,'','','info@imarc.com','$2y$13$Bu5TqauZopqAoZt8kE5yPuNNXOpgm/hdzDjm/kSC6iMvI3v5w3rB6',1,0,0,0,'2019-12-23 15:09:55','172.28.0.1',NULL,NULL,'2019-03-05 14:46:23',NULL,1,NULL,NULL,NULL,0,'2019-03-12 15:51:38','2017-11-29 20:51:54','2019-12-23 15:09:55','c8ab3617-b18a-4315-9fad-7cb1b47eec98');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volumefolders`
--

DROP TABLE IF EXISTS `volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `volumefolders_parentId_idx` (`parentId`),
  KEY `volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volumefolders`
--

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;
INSERT INTO `volumefolders` VALUES (1,NULL,1,'Images','','2018-01-16 22:11:14','2019-12-23 15:24:44','af5b4b2e-1abb-467d-b30c-d58da9025050'),(2,NULL,NULL,'Temporary source',NULL,'2018-01-16 22:11:17','2018-01-16 22:11:17','960569f6-1f3b-4db7-b909-17f3d3921edc'),(3,2,NULL,'user_1','user_1/','2018-01-16 22:11:17','2018-01-16 22:11:17','44837918-0dab-4015-be86-d68ab61ba5dc'),(4,NULL,2,'Resources','','2019-04-25 18:09:08','2019-04-25 18:09:08','28a2ea49-df88-4cd7-b57a-c683a1768e4a');
/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volumes`
--

DROP TABLE IF EXISTS `volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `url` varchar(255) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `volumes_dateDeleted_idx` (`dateDeleted`),
  KEY `volumes_name_idx` (`name`),
  KEY `volumes_handle_idx` (`handle`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
INSERT INTO `volumes` VALUES (1,2,'Images','images','craft\\volumes\\Local',1,'/images','{\"path\":\"@webroot/images\"}',1,'2018-01-16 22:11:14','2019-12-23 15:24:44',NULL,'09773b73-a304-4513-84fd-c4d5d4dd953a'),(2,NULL,'Resources','resources','craft\\volumes\\Local',1,'/resources','{\"path\":\"@webroot/resources\"}',2,'2019-04-25 18:09:08','2019-04-25 18:09:08',NULL,'57423459-e14e-4a06-af08-3f1c378379ba');
/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `widgets`
--

DROP TABLE IF EXISTS `widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
INSERT INTO `widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,0,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}','2017-11-29 20:53:35','2017-11-29 20:53:35','7e22f562-2a45-45f7-a62e-3e492314081a'),(2,1,'craft\\widgets\\CraftSupport',2,0,'[]','2017-11-29 20:53:35','2017-11-29 20:53:35','8bd0b7af-802e-4498-8f82-beb68d0c859c'),(3,1,'craft\\widgets\\Updates',3,0,'[]','2017-11-29 20:53:35','2017-11-29 20:53:35','11fe287a-de57-4152-9435-539874e9b589'),(4,1,'craft\\widgets\\Feed',4,0,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}','2017-11-29 20:53:35','2017-11-29 20:53:35','c16bd6cd-84c0-4866-aec9-bd4385c90d98');
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-23 15:25:35
