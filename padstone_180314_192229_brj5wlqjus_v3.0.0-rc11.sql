-- MySQL dump 10.13  Distrib 5.5.59, for debian-linux-gnu (x86_64)
--
-- Host: db    Database: dev_padstone_imarc_com
-- ------------------------------------------------------
-- Server version	5.5.5-10.3.2-MariaDB-10.3.2+maria~jessie

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
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_filename_folderId_unq_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_name_unq_idx` (`name`),
  UNIQUE KEY `categorygroups_handle_unq_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `field_resourceUrl` varchar(255) DEFAULT NULL,
  `field_resourceFileCTA` text DEFAULT NULL,
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
  `field_eventAbstract` text DEFAULT NULL,
  `field_eventLocation` text DEFAULT NULL,
  `field_resourceCategoryIcon` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dolphiq_redirects`
--

DROP TABLE IF EXISTS `dolphiq_redirects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dolphiq_redirects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceUrl` varchar(255) DEFAULT NULL,
  `destinationUrl` varchar(255) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements`
--

DROP TABLE IF EXISTS `elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `archived` tinyint(1) NOT NULL DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  UNIQUE KEY `elements_sites_uri_siteId_unq_idx` (`uri`,`siteId`),
  KEY `elements_sites_siteId_idx` (`siteId`),
  KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `elements_sites_enabled_idx` (`enabled`),
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entries`
--

DROP TABLE IF EXISTS `entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `entrytypes_name_sectionId_unq_idx` (`name`,`sectionId`),
  UNIQUE KEY `entrytypes_handle_sectionId_unq_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=476 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  UNIQUE KEY `globalsets_name_unq_idx` (`name`),
  UNIQUE KEY `globalsets_handle_unq_idx` (`handle`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `edition` tinyint(3) unsigned NOT NULL,
  `timezone` varchar(30) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `on` tinyint(1) NOT NULL DEFAULT 0,
  `maintenance` tinyint(1) NOT NULL DEFAULT 0,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocks`
--

DROP TABLE IF EXISTS `matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `ownerSiteId` int(11) DEFAULT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  KEY `matrixblocks_ownerSiteId_idx` (`ownerSiteId`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerSiteId_fk` FOREIGN KEY (`ownerSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixcontent_structuredcontent`
--

DROP TABLE IF EXISTS `matrixcontent_structuredcontent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixcontent_structuredcontent` (
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
  `field_callToAction_cta` varchar(255) DEFAULT NULL,
  `field_imageWithText_position` varchar(255) DEFAULT NULL,
  `field_videoWithText_position` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixcontent_structuredcontent_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `matrixcontent_structuredcontent_siteId_fk` (`siteId`),
  CONSTRAINT `matrixcontent_structuredcontent_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixcontent_structuredcontent_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `licenseKey` char(24) DEFAULT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','unknown') NOT NULL DEFAULT 'unknown',
  `settings` text DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`),
  KEY `plugins_enabled_idx` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT 0,
  `dateFailed` datetime DEFAULT NULL,
  `error` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `queue_fail_timeUpdated_timePushed_idx` (`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_fail_timeUpdated_delay_idx` (`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `routes`
--

DROP TABLE IF EXISTS `routes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `routes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) DEFAULT NULL,
  `uriParts` varchar(255) NOT NULL,
  `uriPattern` varchar(255) NOT NULL,
  `template` varchar(500) NOT NULL,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `routes_uriPattern_idx` (`uriPattern`),
  KEY `routes_siteId_idx` (`siteId`),
  CONSTRAINT `routes_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `propagateEntries` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_handle_unq_idx` (`handle`),
  UNIQUE KEY `sections_name_unq_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sitegroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sites_handle_unq_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `systemsettings`
--

DROP TABLE IF EXISTS `systemsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `systemsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(15) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemsettings_category_unq_idx` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `taggroups_name_unq_idx` (`name`),
  UNIQUE KEY `taggroups_handle_unq_idx` (`handle`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `client` tinyint(1) NOT NULL DEFAULT 0,
  `locked` tinyint(1) NOT NULL DEFAULT 0,
  `suspended` tinyint(1) NOT NULL DEFAULT 0,
  `pending` tinyint(1) NOT NULL DEFAULT 0,
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT 0,
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unq_idx` (`username`),
  UNIQUE KEY `users_email_unq_idx` (`email`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_photoId_fk` (`photoId`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumes_name_unq_idx` (`name`),
  UNIQUE KEY `volumes_handle_unq_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `colspan` tinyint(1) NOT NULL DEFAULT 0,
  `settings` text DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'dev_padstone_imarc_com'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-03-14 19:22:29
-- MySQL dump 10.13  Distrib 5.5.59, for debian-linux-gnu (x86_64)
--
-- Host: db    Database: dev_padstone_imarc_com
-- ------------------------------------------------------
-- Server version	5.5.5-10.3.2-MariaDB-10.3.2+maria~jessie

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
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `assettransforms`
--

LOCK TABLES `assettransforms` WRITE;
/*!40000 ALTER TABLE `assettransforms` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `assettransforms` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `categories` VALUES (5,1,'2018-01-31 19:53:20','2018-01-31 19:53:20','e88de118-68c7-41f7-90e0-7b77cea66ab1'),(6,1,'2018-01-31 19:53:25','2018-01-31 19:53:25','55252392-5c48-4a8b-8658-d79796ccafe1'),(7,1,'2018-01-31 19:53:36','2018-01-31 19:53:36','fd7e0db8-a773-4ab4-9f8e-be519ae3be3b'),(8,1,'2018-01-31 19:53:45','2018-01-31 19:53:45','f8099cb9-ffed-44ea-af67-1a43cff72445'),(9,1,'2018-01-31 19:53:51','2018-01-31 19:53:51','b7fbd468-90d6-46ab-85e9-5991fd597cbd'),(18,2,'2018-02-04 18:18:49','2018-02-04 18:18:49','41794692-8d95-4ace-99af-444840d58a08'),(19,2,'2018-02-04 18:18:57','2018-02-04 18:18:57','aab589df-23c9-4015-aae9-6ad55ea007d8'),(20,2,'2018-02-04 22:11:29','2018-02-04 22:11:29','a14eb3bf-0589-4f7e-9472-3014cc96da8c'),(21,2,'2018-02-04 22:11:36','2018-02-04 22:11:36','825c7f14-483a-47dd-8b2c-c316a9eaac85');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups`
--

LOCK TABLES `categorygroups` WRITE;
/*!40000 ALTER TABLE `categorygroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `categorygroups` VALUES (1,2,6,'Resource Categories','resourceCategories','2018-01-31 19:53:07','2018-02-08 19:36:23','d9b26dd3-8815-474a-b2d1-df10d1da9ea4'),(2,4,21,'Blog Categories','blogCategories','2018-02-02 22:17:15','2018-02-02 22:17:15','380fab36-d288-4b53-9d1b-d5aad2afc914');
/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups_sites`
--

LOCK TABLES `categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `categorygroups_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `categorygroups_sites` VALUES (1,1,1,1,'resource-categories/{slug}','resource-categories/_category','2018-01-31 19:53:07','2018-02-08 19:36:23','178a1f52-69b6-4200-b3c5-8575f724254b'),(2,2,1,1,'blog-categories/{slug}','blog-categories/_category','2018-02-02 22:17:15','2018-02-02 22:17:15','09320ff7-8439-45ee-9e41-8a7a6b474e73');
/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `content` VALUES (1,1,1,NULL,'2017-11-29 20:51:54','2018-02-04 17:52:24','8a7441f7-d6f1-4e31-a1b7-12164bf985c6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,4,1,'Yypta63G-1','2018-01-17 16:36:22','2018-02-05 19:48:38','5c22d539-742a-467d-8562-5fba303b36ea',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,5,1,'White Papers','2018-01-31 19:53:20','2018-01-31 19:53:20','179970dc-e9fc-4d6c-a5d5-b1f75cce9e27',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,6,1,'Videos','2018-01-31 19:53:25','2018-01-31 19:53:25','6d8e1a8c-62d4-421c-b688-07dd2903cf62',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,7,1,'Case Studies','2018-01-31 19:53:36','2018-01-31 19:53:36','6baca749-278a-42a7-8b2f-852e206138bb',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,8,1,'Webinars','2018-01-31 19:53:45','2018-01-31 19:53:45','76badf17-d466-442d-af6f-de6dd4515e1c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,9,1,'Reports','2018-01-31 19:53:51','2018-01-31 19:53:51','056d522e-bffc-4c64-8c0e-67dd05bdafbf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(15,15,1,'Homepage','2018-02-02 05:31:09','2018-02-06 14:23:52','6ac247f1-3af3-4bba-8b3c-366d5a9bae99',NULL,NULL,NULL,NULL,'','','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(16,16,1,'Error Page','2018-02-02 05:34:35','2018-02-05 06:23:40','f248f374-04d1-4eea-a554-8b355583b1ee',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(17,17,1,'Page Not Found','2018-02-02 05:34:50','2018-02-05 06:25:19','b6a63da2-e3fb-4b59-bce8-6865714eb1e3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(18,18,1,'Culture','2018-02-04 18:18:49','2018-02-04 18:18:49','49f1275c-531e-4534-9efc-ec072cb1ea2f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(19,19,1,'Hiring','2018-02-04 18:18:57','2018-02-04 18:18:57','27264a17-1fc2-4297-8601-2d842d594fea',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(20,20,1,'Announcement','2018-02-04 22:11:29','2018-02-04 22:11:29','457610de-324f-44c2-9329-e70ccfcd2171',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(21,21,1,'Press Release','2018-02-04 22:11:36','2018-02-04 22:11:36','1fad4b5e-c717-416f-be52-516bbe2c9de3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(22,22,1,'Contact Page','2018-02-04 22:14:34','2018-02-05 06:23:05','0a4602f9-c70b-46f7-b44a-7971458a8b7b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(23,23,1,'About Page','2018-02-04 23:03:59','2018-02-06 19:56:05','b80ed219-99bb-4af9-bcd6-4e481e9a70d4',NULL,NULL,NULL,NULL,'','','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(24,24,1,'Privacy Page','2018-02-04 23:08:53','2018-02-05 06:25:56','ae7bb5ef-39a1-4352-bebf-40dfdb31d977',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(25,25,1,'News & Events Page','2018-02-05 06:20:14','2018-02-05 06:25:27','e8e7d573-73fd-4d84-8926-ec7a8b444720',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(26,26,1,'Resources Page','2018-02-05 06:20:40','2018-02-05 06:26:26','d98e0b30-38ba-4775-88de-802e6b2175eb',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(27,27,1,'Blog Page','2018-02-05 06:21:29','2018-02-05 06:22:39','a190b8ca-8dae-447a-98f8-9f0a7558a63e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(29,29,1,'Yypta63G 1','2018-02-05 19:49:24','2018-02-05 19:49:24','88e813ec-d523-47d3-b2d6-d505da954fa9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craftidtokens`
--

LOCK TABLES `craftidtokens` WRITE;
/*!40000 ALTER TABLE `craftidtokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `deprecationerrors`
--

LOCK TABLES `deprecationerrors` WRITE;
/*!40000 ALTER TABLE `deprecationerrors` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `dolphiq_redirects`
--

LOCK TABLES `dolphiq_redirects` WRITE;
/*!40000 ALTER TABLE `dolphiq_redirects` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `dolphiq_redirects` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elementindexsettings`
--

LOCK TABLES `elementindexsettings` WRITE;
/*!40000 ALTER TABLE `elementindexsettings` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elementindexsettings` VALUES (1,'craft\\elements\\Entry','{\"sourceOrder\":[[\"key\",\"*\"],[\"key\",\"single:3\"],[\"heading\",\"Blog Stuff\"],[\"key\",\"single:16\"],[\"key\",\"section:8\"],[\"heading\",\"\"],[\"key\",\"single:14\"],[\"key\",\"section:6\"],[\"key\",\"section:9\"],[\"heading\",\"\"],[\"key\",\"single:15\"],[\"key\",\"section:2\"],[\"heading\",\"\"],[\"key\",\"single:12\"],[\"key\",\"section:17\"],[\"key\",\"section:7\"],[\"heading\",\"\"],[\"key\",\"single:10\"],[\"key\",\"single:13\"],[\"key\",\"section:11\"],[\"heading\",\"\"],[\"key\",\"single:5\"],[\"key\",\"single:4\"]],\"sources\":{\"*\":{\"tableAttributes\":{\"1\":\"section\",\"2\":\"postDate\",\"3\":\"expiryDate\",\"4\":\"author\",\"5\":\"link\"}},\"section:2\":{\"tableAttributes\":{\"1\":\"postDate\",\"2\":\"expiryDate\",\"3\":\"author\",\"4\":\"link\"}},\"single:4\":{\"tableAttributes\":{\"1\":\"postDate\",\"2\":\"expiryDate\",\"3\":\"author\",\"4\":\"link\"}},\"section:11\":{\"tableAttributes\":{\"1\":\"postDate\",\"2\":\"expiryDate\",\"3\":\"author\",\"4\":\"link\"}}}}','2018-02-05 19:15:29','2018-02-05 19:15:29','62c03c20-c7ca-4a8d-a294-f3052cfa568e');
/*!40000 ALTER TABLE `elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements`
--

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements` VALUES (1,NULL,'craft\\elements\\User',1,0,'2017-11-29 20:51:54','2018-02-04 17:52:24','ecaa119c-fd2b-4fa5-b6c6-da4c09cb2cfb'),(4,2,'craft\\elements\\Asset',1,0,'2018-01-17 16:36:22','2018-02-05 19:48:38','be394d4e-a35b-4b8f-b7f6-05107d040857'),(5,6,'craft\\elements\\Category',1,0,'2018-01-31 19:53:20','2018-01-31 19:53:20','4cb5351f-f8d9-4405-9f3c-9fed157dfbf8'),(6,6,'craft\\elements\\Category',1,0,'2018-01-31 19:53:25','2018-01-31 19:53:25','d45cc3c1-af53-4c5f-a2c5-04807131f67f'),(7,6,'craft\\elements\\Category',1,0,'2018-01-31 19:53:36','2018-01-31 19:53:36','74fd8c9f-b7e2-467e-9c00-06d0681be0b4'),(8,6,'craft\\elements\\Category',1,0,'2018-01-31 19:53:45','2018-01-31 19:53:45','45521071-001f-4fab-9662-f7df5d8896be'),(9,6,'craft\\elements\\Category',1,0,'2018-01-31 19:53:51','2018-01-31 19:53:51','dd1e7b4b-d4dd-457f-af6c-7b93a8cb9015'),(15,8,'craft\\elements\\Entry',1,0,'2018-02-02 05:31:09','2018-02-06 14:23:52','c8719f54-b20a-4386-b779-69a010bc8071'),(16,9,'craft\\elements\\Entry',1,0,'2018-02-02 05:34:35','2018-02-05 06:23:40','9b9e62bd-c75c-4494-a061-5a2274727b86'),(17,10,'craft\\elements\\Entry',1,0,'2018-02-02 05:34:50','2018-02-05 06:25:19','2efc74d3-f4c0-4496-bb08-7fc9141250bc'),(18,21,'craft\\elements\\Category',1,0,'2018-02-04 18:18:49','2018-02-04 18:18:49','54b1f292-56c2-4d83-872a-b3b098d49f19'),(19,21,'craft\\elements\\Category',1,0,'2018-02-04 18:18:57','2018-02-04 18:18:57','94d04c1f-15f1-4e9d-8fcb-40d27cc2a1c1'),(20,21,'craft\\elements\\Category',1,0,'2018-02-04 22:11:29','2018-02-04 22:11:29','d0393319-5cdc-46ab-8f1c-000f4f4efcbe'),(21,21,'craft\\elements\\Category',1,0,'2018-02-04 22:11:36','2018-02-04 22:11:36','4262839e-4493-4938-8a99-674f073c7f5a'),(22,24,'craft\\elements\\Entry',1,0,'2018-02-04 22:14:34','2018-02-05 06:23:05','e3a22c88-e8a8-49a2-9711-c3365c8d2ccd'),(23,26,'craft\\elements\\Entry',1,0,'2018-02-04 23:03:59','2018-02-06 19:56:05','c40b51b9-7bf6-4af3-8c89-71b863b60ebf'),(24,27,'craft\\elements\\Entry',1,0,'2018-02-04 23:08:53','2018-02-05 06:25:56','b7acd71b-a397-445a-879d-cd37f8ae7b01'),(25,28,'craft\\elements\\Entry',1,0,'2018-02-05 06:20:14','2018-02-05 06:25:27','eea5fec4-0cda-4a4d-9de5-7f9afd764be9'),(26,29,'craft\\elements\\Entry',1,0,'2018-02-05 06:20:40','2018-02-05 06:26:26','b584a194-fd92-4a73-b321-cb612c3faff8'),(27,30,'craft\\elements\\Entry',1,0,'2018-02-05 06:21:29','2018-02-05 06:22:39','a4f2e670-0b34-4b8c-b30b-ed99372c8140'),(29,2,'craft\\elements\\Asset',1,0,'2018-02-05 19:49:24','2018-02-05 19:49:24','119da192-a673-4adc-8551-ed7b81449b96');
/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements_sites`
--

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements_sites` VALUES (1,1,1,NULL,NULL,1,'2017-11-29 20:51:54','2018-02-04 17:52:24','8e1ef923-2fc5-48af-ad34-e3ea533b3d0a'),(4,4,1,NULL,NULL,1,'2018-01-17 16:36:22','2018-02-05 19:48:38','a888c81c-392d-4b0d-9fdf-224f4e8c5a70'),(5,5,1,'white-papers','resource-categories/white-papers',1,'2018-01-31 19:53:20','2018-01-31 19:53:57','a205ceb3-6dc9-486b-9b13-c2428430394f'),(6,6,1,'videos','resource-categories/videos',1,'2018-01-31 19:53:25','2018-01-31 19:54:00','1985cceb-f343-4360-9199-404812c9a041'),(7,7,1,'case-studies','resource-categories/case-studies',1,'2018-01-31 19:53:36','2018-01-31 19:53:59','121101c9-e0fb-49bc-b2f7-2ae8792b1e3d'),(8,8,1,'webinars','resource-categories/webinars',1,'2018-01-31 19:53:45','2018-01-31 19:53:55','a4d0a42e-2f0f-422a-beae-2ade9e900a5f'),(9,9,1,'reports','resource-categories/reports',1,'2018-01-31 19:53:51','2018-01-31 19:53:51','84bf2245-7aae-4590-9170-d18d90d31eb0'),(15,15,1,'homepage','homepage',1,'2018-02-02 05:31:09','2018-02-06 14:23:52','51ec2ef8-c422-44d5-b26e-7a5c9fde2dc9'),(16,16,1,'error-page','error-page',1,'2018-02-02 05:34:35','2018-02-05 06:23:40','d6907eb5-0203-4b41-a842-a047b2331203'),(17,17,1,'page-not-found','page-not-found',1,'2018-02-02 05:34:50','2018-02-05 06:25:19','40251971-8782-4491-b2b3-ac6507cc89fd'),(18,18,1,'culture','blog-categories/culture',1,'2018-02-04 18:18:49','2018-02-04 18:18:50','05978a64-5422-4b50-b735-a8ca4af37525'),(19,19,1,'hiring','blog-categories/hiring',1,'2018-02-04 18:18:57','2018-02-04 18:18:58','b4fc0b21-d94d-44a6-b7cf-b96aff45acb7'),(20,20,1,'announcement','blog-categories/announcement',1,'2018-02-04 22:11:29','2018-02-04 22:11:29','885898ab-d457-42d5-9bf1-aec0c58c7bd5'),(21,21,1,'press-release','blog-categories/press-release',1,'2018-02-04 22:11:36','2018-02-04 22:11:37','e1c032a3-555a-470b-9151-cba64781ebef'),(22,22,1,'contact','contact',1,'2018-02-04 22:14:34','2018-02-05 06:23:05','3e4ffb22-2bb9-4eaa-9e84-f1a2155969e8'),(23,23,1,'about','about',1,'2018-02-04 23:03:59','2018-02-06 19:56:05','65a9c0f0-6956-4e7d-88ae-0c9070f85f14'),(24,24,1,'privacy-page','privacy',1,'2018-02-04 23:08:53','2018-02-05 06:25:56','3fbef1f2-5a5f-4095-a334-bffabea2fec3'),(25,25,1,'news-events-page','news',1,'2018-02-05 06:20:14','2018-02-05 06:25:27','49c2f583-1ab3-4d8c-a867-a68f996d1102'),(26,26,1,'resources-page','resources',1,'2018-02-05 06:20:40','2018-02-05 06:26:26','0223cc91-4e84-4afa-b4a9-eb4fd89ec0b9'),(27,27,1,'blog-page','blog',1,'2018-02-05 06:21:29','2018-02-05 06:22:39','33c04630-1e4c-405d-87fd-cce516b9f008'),(29,29,1,NULL,NULL,1,'2018-02-05 19:49:24','2018-02-05 19:49:24','acc6a3fd-4e34-4e81-8924-fde05376ae87');
/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entries`
--

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entries` VALUES (15,3,5,NULL,'2018-02-02 05:31:09',NULL,'2018-02-02 05:31:09','2018-02-06 14:23:52','f6da0b2a-7782-4e84-93a2-72cb7487a4f1'),(16,4,6,NULL,'2018-02-02 05:34:35',NULL,'2018-02-02 05:34:35','2018-02-05 06:23:40','e2e21fc5-9c1e-4b1a-9982-320c88ac4b16'),(17,5,7,NULL,'2018-02-02 05:34:50',NULL,'2018-02-02 05:34:50','2018-02-05 06:25:19','65f7ddb2-ee8a-49be-a0af-be1562214b70'),(22,10,12,NULL,'2018-02-04 22:14:34',NULL,'2018-02-04 22:14:34','2018-02-05 06:23:05','ad87f44c-ffd5-4245-b05d-b7defa213752'),(23,12,14,NULL,'2018-02-04 23:03:59',NULL,'2018-02-04 23:03:59','2018-02-06 19:56:05','091cf386-ba9b-4821-b21f-bba5d74b1e88'),(24,13,15,NULL,'2018-02-04 23:08:53',NULL,'2018-02-04 23:08:53','2018-02-05 06:25:56','7591a08c-3410-4784-8cba-770bc879b46b'),(25,14,16,NULL,'2018-02-05 06:20:14',NULL,'2018-02-05 06:20:14','2018-02-05 06:25:27','24945042-370b-43b9-9b8e-7cdf4231dc9e'),(26,15,17,NULL,'2018-02-05 06:20:40',NULL,'2018-02-05 06:20:40','2018-02-05 06:26:26','f130efce-41a3-4e55-be18-17dab696ebb7'),(27,16,18,NULL,'2018-02-05 06:21:29',NULL,'2018-02-05 06:21:29','2018-02-05 06:22:39','740dbd22-fdac-46f8-95f7-7ed4bca98882');
/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entrydrafts`
--

LOCK TABLES `entrydrafts` WRITE;
/*!40000 ALTER TABLE `entrydrafts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `entrydrafts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entrytypes`
--

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entrytypes` VALUES (2,2,3,'Downloadable Resource','resourceFile',1,'Title',NULL,1,'2018-01-31 19:49:43','2018-02-04 17:59:16','9de11a83-392f-4ebb-9d01-e5ebaf22cf18'),(3,2,4,'External Link','resourceLink',1,'Link Title',NULL,2,'2018-01-31 19:51:47','2018-02-04 17:59:28','437719cf-795d-42cf-8b92-2ea1224939b4'),(4,2,5,'Video','resourceVideo',1,'Title',NULL,3,'2018-01-31 19:52:25','2018-02-04 17:59:40','a30dc10d-322d-4159-b375-7566cebf3755'),(5,3,8,'Homepage','homepage',1,'Title',NULL,1,'2018-02-02 05:31:09','2018-02-06 14:23:33','969995e1-dbd5-42c5-917f-a13e492a5c83'),(6,4,9,'Error Page','errorPage',1,'Title',NULL,1,'2018-02-02 05:34:35','2018-02-05 06:23:40','181988f5-74b6-4bf7-8825-b5e458651ce9'),(7,5,10,'Page Not Found','pageNotFound',1,'Title',NULL,1,'2018-02-02 05:34:50','2018-02-05 06:25:18','754177a1-494c-4f11-806a-112af873ab1d'),(8,6,19,'News Article','newsArticle',1,'Title',NULL,1,'2018-02-02 22:08:02','2018-02-04 22:13:31','349bc9d5-448b-4314-a81e-d76e7cca8758'),(9,7,20,'Person','person',1,'Name',NULL,1,'2018-02-02 22:10:38','2018-02-04 22:07:57','1eb9445b-5596-41c4-b25c-ec44e9a4ec0a'),(10,8,22,'Blog Article','blog',1,'Title',NULL,1,'2018-02-02 22:22:44','2018-02-02 22:23:45','2bce713c-e1dd-4517-8bf0-60f2c1165bc3'),(11,9,23,'Event','event',1,'Title',NULL,1,'2018-02-04 22:10:01','2018-02-04 22:10:31','f1e078e0-561e-47be-a5bb-1ad7b61ab109'),(12,10,24,'Contact Page','contact',1,'Title',NULL,1,'2018-02-04 22:14:34','2018-02-05 06:23:04','c9969320-6f22-4fd2-a0f8-0c16e95de058'),(13,11,25,'Landing Page','landingPage',1,'Title',NULL,1,'2018-02-04 23:02:31','2018-02-04 23:03:09','ca7b7e4c-25a6-449f-ad1d-bd7a08c52a99'),(14,12,26,'About Page','aboutPage',1,'Title',NULL,1,'2018-02-04 23:03:59','2018-02-05 06:22:06','2091741e-3916-401f-8b4c-00ee93c78914'),(15,13,27,'Privacy Page','privacyPage',1,'Title',NULL,1,'2018-02-04 23:08:53','2018-02-05 06:25:56','3e918fe0-05a0-4a21-88e8-4fe6125a5fae'),(16,14,28,'News & Events Page','newsEventsPage',1,'Title',NULL,1,'2018-02-05 06:20:14','2018-02-05 06:25:26','035617c5-1f35-490e-9216-fd539fee3802'),(17,15,29,'Resources Page','resourcesPage',1,'Title',NULL,1,'2018-02-05 06:20:40','2018-02-05 06:26:25','462c63db-f464-467b-ab60-114cf3cfa50a'),(18,16,30,'Blog Page','blogPage',1,'Title',NULL,1,'2018-02-05 06:21:29','2018-02-05 06:22:38','f4b21aa5-34c8-486b-9a4a-2283e15f1b00'),(19,17,31,'About Pages','aboutPages',1,'Title',NULL,1,'2018-02-05 19:14:26','2018-02-05 19:15:01','7e27ed3f-7f88-4e7a-a754-8a958f75b010');
/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entryversions`
--

LOCK TABLES `entryversions` WRITE;
/*!40000 ALTER TABLE `entryversions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entryversions` VALUES (5,15,3,1,1,1,'Revision from Feb 6, 2018, 6:23:33 AM','{\"typeId\":\"5\",\"authorId\":\"1\",\"title\":\"Homepage\",\"slug\":\"homepage\",\"postDate\":1517549469,\"expiryDate\":null,\"enabled\":\"1\",\"newParentId\":null,\"fields\":{\"43\":[],\"11\":[],\"63\":[]}}','2018-02-06 14:23:52','2018-02-06 14:23:52','45ae148a-8860-43cf-a179-2e6c355edbfe'),(6,15,3,1,1,2,'','{\"typeId\":\"5\",\"authorId\":null,\"title\":\"Homepage\",\"slug\":\"homepage\",\"postDate\":1517549469,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"45\":\"\",\"44\":\"\",\"39\":\"\",\"40\":\"\",\"42\":\"\",\"43\":[],\"41\":\"\",\"11\":[],\"63\":[\"30\",\"31\"]}}','2018-02-06 14:23:52','2018-02-06 14:23:52','2a95918a-c8e6-41b8-813f-3d8aabb8ba14'),(7,23,12,1,1,1,'Revision from Feb 4, 2018, 10:22:07 PM','{\"typeId\":\"14\",\"authorId\":\"1\",\"title\":\"About Page\",\"slug\":\"about\",\"postDate\":1517785439,\"expiryDate\":null,\"enabled\":\"1\",\"newParentId\":null,\"fields\":{\"43\":[],\"11\":[]}}','2018-02-06 19:55:57','2018-02-06 19:55:57','ec1c7b4e-9a25-4d31-9956-f575ef40a84f'),(8,23,12,1,1,2,'','{\"typeId\":\"14\",\"authorId\":null,\"title\":\"About Page\",\"slug\":\"about\",\"postDate\":1517785439,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"45\":\"\",\"44\":\"\",\"39\":\"\",\"40\":\"\",\"42\":\"\",\"43\":[],\"41\":\"\",\"11\":[]}}','2018-02-06 19:56:05','2018-02-06 19:56:05','e40cbac1-77c0-4833-82e8-32d5a376e8f6');
/*!40000 ALTER TABLE `entryversions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldgroups`
--

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldgroups` VALUES (1,'Common','2017-11-29 20:51:54','2017-11-29 20:51:54','c4593c73-7ed0-4694-9aa8-fa73bd8c1b1b'),(2,'Resources','2018-01-31 19:42:02','2018-01-31 19:42:02','bbb87adb-e632-4579-b223-79796ba4ff1a'),(3,'SEO','2018-02-02 06:44:37','2018-02-02 06:44:37','4cd84b5c-0162-4148-a588-37b2fcc1da0a'),(4,'People','2018-02-02 22:02:33','2018-02-02 22:02:33','28bbb761-2bca-4754-ba9e-c0bfe22f4496'),(5,'News','2018-02-02 22:05:28','2018-02-02 22:05:28','6533045f-a95c-45a5-a67a-c8da4cec0d5d'),(6,'Blog','2018-02-02 22:09:13','2018-02-02 22:09:13','b2e9d0fb-ba4b-4b23-9fcf-459ad68c0ea9'),(7,'Events','2018-02-04 22:08:27','2018-02-04 22:08:27','61009477-6ca8-4122-b871-b3b715eec012');
/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayoutfields`
--

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayoutfields` VALUES (172,22,49,54,0,1,'2018-02-02 22:23:45','2018-02-02 22:23:45','2472ef4e-93b9-434c-9d74-443865f02bc9'),(173,22,49,56,0,2,'2018-02-02 22:23:45','2018-02-02 22:23:45','ce8b1e40-018c-4c27-bcce-8dc956e2596a'),(174,22,49,55,0,3,'2018-02-02 22:23:45','2018-02-02 22:23:45','c4d5f505-9cbd-4007-95d5-144f006c8b50'),(175,22,49,58,0,4,'2018-02-02 22:23:45','2018-02-02 22:23:45','226b2eb5-f94c-4c06-9ca4-30c7bd82fa44'),(176,22,49,57,0,5,'2018-02-02 22:23:45','2018-02-02 22:23:45','d4e7daf7-9590-4e4e-baf7-536c59b6fc7c'),(177,22,49,11,1,6,'2018-02-02 22:23:45','2018-02-02 22:23:45','0be457c0-fabf-4e96-8978-cc76608ce643'),(178,22,50,39,0,1,'2018-02-02 22:23:45','2018-02-02 22:23:45','1a566aac-a5c7-415a-8d92-40310aa5ebf6'),(179,22,50,40,0,2,'2018-02-02 22:23:45','2018-02-02 22:23:45','e848cd3e-b2ec-492e-a885-fe30aa46cce1'),(180,22,50,41,0,3,'2018-02-02 22:23:45','2018-02-02 22:23:45','48476983-4047-492c-a873-9f5b98010d39'),(181,22,50,42,0,4,'2018-02-02 22:23:45','2018-02-02 22:23:45','43b0d9fa-be6b-48a0-aee5-a1b148202c21'),(182,22,50,43,0,5,'2018-02-02 22:23:45','2018-02-02 22:23:45','328923a4-bd47-45e8-ba0f-651e75424e35'),(183,22,50,44,0,6,'2018-02-02 22:23:45','2018-02-02 22:23:45','aef67749-c19c-4688-acbf-75c6f84ca2c4'),(184,22,50,45,0,7,'2018-02-02 22:23:45','2018-02-02 22:23:45','04b9cb0b-96a2-42e6-9bf5-8f0aa697bce7'),(224,3,60,5,0,1,'2018-02-04 17:59:16','2018-02-04 17:59:16','694fd000-aa36-424c-9555-95ad43845aef'),(225,3,60,10,0,2,'2018-02-04 17:59:16','2018-02-04 17:59:16','d5785637-80f0-4aab-85e4-7a5c9d984190'),(226,3,60,4,0,3,'2018-02-04 17:59:16','2018-02-04 17:59:16','d4ad75ee-a876-43f8-970c-940445130277'),(227,3,60,7,0,4,'2018-02-04 17:59:16','2018-02-04 17:59:16','67e67553-9b95-4d6c-a2c4-802382a3708a'),(228,3,60,8,0,5,'2018-02-04 17:59:16','2018-02-04 17:59:16','b1b0bbb3-a325-4274-97ad-8ba81b8b6211'),(229,3,60,11,0,6,'2018-02-04 17:59:16','2018-02-04 17:59:16','470da1e4-2af7-4c63-b0b2-559ee9548bc3'),(230,3,61,39,0,1,'2018-02-04 17:59:16','2018-02-04 17:59:16','f8d6a26e-122f-4452-a6b1-6009462c1ed7'),(231,3,61,40,0,2,'2018-02-04 17:59:16','2018-02-04 17:59:16','30ac0abd-e07b-498f-b24e-ccd716761e67'),(232,3,61,41,0,3,'2018-02-04 17:59:16','2018-02-04 17:59:16','f89385cd-3142-48d6-b0b6-5820c781d2ff'),(233,3,61,42,0,4,'2018-02-04 17:59:16','2018-02-04 17:59:16','8d230c34-e617-4426-a934-8f7d8044291a'),(234,3,61,43,0,5,'2018-02-04 17:59:16','2018-02-04 17:59:16','b27027e3-379a-47e9-bdce-25459b359161'),(235,3,61,44,0,6,'2018-02-04 17:59:16','2018-02-04 17:59:16','938c98ca-4c24-4548-83cf-860e178fefab'),(236,3,61,45,0,7,'2018-02-04 17:59:16','2018-02-04 17:59:16','80d387cc-bdcb-4a10-bb0c-53a93a228acf'),(237,4,62,6,0,1,'2018-02-04 17:59:28','2018-02-04 17:59:28','9cbb69c7-b5b8-43fc-a020-33b6f855b7fb'),(238,4,62,5,0,2,'2018-02-04 17:59:28','2018-02-04 17:59:28','e7c53dfd-17b4-4004-bdf1-9ae993f4bce5'),(239,4,62,10,0,3,'2018-02-04 17:59:28','2018-02-04 17:59:28','512df490-cfe6-4d66-b6c8-d7690320f0b1'),(240,4,62,4,0,4,'2018-02-04 17:59:28','2018-02-04 17:59:28','3d704f89-af9f-4102-b21f-fa8c4d45c5aa'),(241,4,63,39,0,1,'2018-02-04 17:59:28','2018-02-04 17:59:28','6972376d-fa2d-474b-bd80-81ec162dec51'),(242,4,63,40,0,2,'2018-02-04 17:59:28','2018-02-04 17:59:28','34910c13-ec95-49ab-ba0b-bf4721c5e488'),(243,4,63,41,0,3,'2018-02-04 17:59:28','2018-02-04 17:59:28','92081442-b122-41b4-9e6e-ccda0a969a2f'),(244,4,63,42,0,4,'2018-02-04 17:59:28','2018-02-04 17:59:28','d915ec11-40e0-4f77-98e6-dfe00e6c0263'),(245,4,63,43,0,5,'2018-02-04 17:59:28','2018-02-04 17:59:28','da56b52e-acd1-4603-8649-3516dd44e206'),(246,4,63,44,0,6,'2018-02-04 17:59:28','2018-02-04 17:59:28','e3a385a3-3cbc-492b-aba1-4b9b61b7bd7a'),(247,4,63,45,0,7,'2018-02-04 17:59:28','2018-02-04 17:59:28','714149f6-a80c-479f-ac01-d7263af9d964'),(248,5,64,5,0,1,'2018-02-04 17:59:39','2018-02-04 17:59:39','650f4e0d-8f0d-4570-828f-9d2797706c8d'),(249,5,64,10,0,2,'2018-02-04 17:59:39','2018-02-04 17:59:39','d716dd5b-7b26-4f13-80e5-90548f596279'),(250,5,64,4,0,3,'2018-02-04 17:59:39','2018-02-04 17:59:39','f71591c8-8bb3-45cc-9e1f-e892428ce8f6'),(251,5,64,9,0,4,'2018-02-04 17:59:39','2018-02-04 17:59:39','fa8e0b71-98c3-4661-8504-fe31f0802f34'),(252,5,64,11,0,5,'2018-02-04 17:59:39','2018-02-04 17:59:39','4a7e9fe9-dec8-4c02-82f8-4dc119a7aa5d'),(253,5,65,39,0,1,'2018-02-04 17:59:40','2018-02-04 17:59:40','7da7f501-c42e-4f2b-9bcc-423814fa0389'),(254,5,65,40,0,2,'2018-02-04 17:59:40','2018-02-04 17:59:40','b18826eb-bb59-48b7-bc3c-9a6653b35412'),(255,5,65,41,0,3,'2018-02-04 17:59:40','2018-02-04 17:59:40','73b390a9-2542-4799-99b5-dafd2d4f1faa'),(256,5,65,42,0,4,'2018-02-04 17:59:40','2018-02-04 17:59:40','aa97a265-f08b-465e-8dfb-a7fd4839b354'),(257,5,65,43,0,5,'2018-02-04 17:59:40','2018-02-04 17:59:40','60a199d3-ed58-4a8b-a434-2e9a9a5de3e4'),(258,5,65,44,0,6,'2018-02-04 17:59:40','2018-02-04 17:59:40','4da49c1a-5272-41ac-a4c9-622a3bfafb1d'),(259,5,65,45,0,7,'2018-02-04 17:59:40','2018-02-04 17:59:40','a430657f-6066-4143-ae8c-0b842dcbf83b'),(271,20,68,48,0,1,'2018-02-04 22:07:57','2018-02-04 22:07:57','a00962a1-f116-4886-83e8-bf4251fe456c'),(272,20,68,49,0,2,'2018-02-04 22:07:57','2018-02-04 22:07:57','58f7f7da-846e-452f-9426-a60ab636717d'),(273,20,68,50,1,3,'2018-02-04 22:07:57','2018-02-04 22:07:57','946eb649-ea85-461e-a128-dd6747c14705'),(274,20,68,51,1,4,'2018-02-04 22:07:57','2018-02-04 22:07:57','d7bbe499-de5a-478c-bf2e-641300d5eb9a'),(275,20,69,39,0,1,'2018-02-04 22:07:57','2018-02-04 22:07:57','4f701908-da54-4b6d-b4aa-3913a044dd69'),(276,20,69,40,0,2,'2018-02-04 22:07:57','2018-02-04 22:07:57','bbdd18d0-b020-4275-8a83-617ec57cc4a3'),(277,20,69,41,0,3,'2018-02-04 22:07:57','2018-02-04 22:07:57','76ecacf1-fc3c-4210-8efb-f1d57ee31a2c'),(278,20,69,42,0,4,'2018-02-04 22:07:57','2018-02-04 22:07:57','01a43bf0-7e07-4562-8ddb-70ba8fef5f8d'),(279,20,69,43,0,5,'2018-02-04 22:07:57','2018-02-04 22:07:57','3709bba1-1068-46e3-9be5-ad27cc8041d0'),(280,20,69,44,0,6,'2018-02-04 22:07:57','2018-02-04 22:07:57','24e74eba-977a-4e99-8438-b342e591e395'),(281,20,69,45,0,7,'2018-02-04 22:07:57','2018-02-04 22:07:57','7dc11647-c790-4397-8e7e-e9afd7ba8210'),(282,23,70,59,1,1,'2018-02-04 22:10:31','2018-02-04 22:10:31','ed553185-dcb6-48df-ba71-054e9e029fda'),(283,23,70,60,0,2,'2018-02-04 22:10:31','2018-02-04 22:10:31','4f3f740a-dd1a-46ea-bfbd-cfa3fa77b6fd'),(284,23,70,61,0,3,'2018-02-04 22:10:31','2018-02-04 22:10:31','6e513b97-923f-4a50-b05f-87ae0131042e'),(285,23,70,11,0,4,'2018-02-04 22:10:31','2018-02-04 22:10:31','3cc69fda-d3e2-4c08-97fc-39afee1dbe7c'),(286,23,71,39,0,1,'2018-02-04 22:10:31','2018-02-04 22:10:31','de1dd77a-9466-4344-9bed-d4f7088796e2'),(287,23,71,40,0,2,'2018-02-04 22:10:31','2018-02-04 22:10:31','4624c121-6fd6-4bbe-a653-6fdc407e5191'),(288,23,71,41,0,3,'2018-02-04 22:10:31','2018-02-04 22:10:31','95ad86c5-b713-4d02-a454-0e7e5474b17b'),(289,23,71,42,0,4,'2018-02-04 22:10:31','2018-02-04 22:10:31','d3a6648f-e68d-465a-bcb5-ca18401f32c2'),(290,23,71,43,0,5,'2018-02-04 22:10:31','2018-02-04 22:10:31','a915d6be-fb34-44cf-9618-aeadfe7943ec'),(291,23,71,44,0,6,'2018-02-04 22:10:31','2018-02-04 22:10:31','3062bab0-cb93-4399-ae64-a104491b0ac1'),(292,23,71,45,0,7,'2018-02-04 22:10:31','2018-02-04 22:10:31','f17e4d90-032b-47ab-9d23-bd613fad911d'),(303,19,74,52,0,1,'2018-02-04 22:13:31','2018-02-04 22:13:31','b76c9752-a2a2-40c2-bb48-c388e4b25cb7'),(305,19,74,11,0,3,'2018-02-04 22:13:31','2018-02-04 22:13:31','48fdf4d4-37bd-41b0-8361-5377fb474716'),(306,19,75,39,0,1,'2018-02-04 22:13:31','2018-02-04 22:13:31','965870f3-3ed7-4490-8235-2f532e4d56d2'),(307,19,75,40,0,2,'2018-02-04 22:13:31','2018-02-04 22:13:31','fa3f859c-3030-4079-9ac8-d021c9460a18'),(308,19,75,41,0,3,'2018-02-04 22:13:31','2018-02-04 22:13:31','792ae90d-9abc-435d-b98a-30d4442a4240'),(309,19,75,42,0,4,'2018-02-04 22:13:31','2018-02-04 22:13:31','af5c271a-8dc0-44b1-8e58-cc3e48f87a0a'),(310,19,75,43,0,5,'2018-02-04 22:13:31','2018-02-04 22:13:31','4ec18550-171d-420d-9e56-17cc55f3da4b'),(311,19,75,44,0,6,'2018-02-04 22:13:31','2018-02-04 22:13:31','702bc51a-39e9-46dc-83ae-99567ddf19ee'),(312,19,75,45,0,7,'2018-02-04 22:13:31','2018-02-04 22:13:31','406a8d86-7808-4e3d-875e-df0d14ae524d'),(321,25,78,11,0,1,'2018-02-04 23:03:09','2018-02-04 23:03:09','79c888a6-3ada-4408-adda-589a45273b12'),(322,25,79,39,0,1,'2018-02-04 23:03:09','2018-02-04 23:03:09','648fda51-d18a-4536-b37c-23c9939408fb'),(323,25,79,40,0,2,'2018-02-04 23:03:09','2018-02-04 23:03:09','8c964d5d-aa7a-4032-94f1-1892dd8a1ac3'),(324,25,79,41,0,3,'2018-02-04 23:03:09','2018-02-04 23:03:09','35522121-f7e5-460f-8740-0f3902ceeac8'),(325,25,79,42,0,4,'2018-02-04 23:03:09','2018-02-04 23:03:09','647a31a7-2fee-4917-9c9b-7e58a9b342cc'),(326,25,79,43,0,5,'2018-02-04 23:03:09','2018-02-04 23:03:09','c187ad63-8b54-4ef9-a33c-34527773504e'),(327,25,79,44,0,6,'2018-02-04 23:03:09','2018-02-04 23:03:09','29499634-8899-43d1-ad98-a95eb407d208'),(328,25,79,45,0,7,'2018-02-04 23:03:09','2018-02-04 23:03:09','42b259cc-3693-4fe0-a321-086c63a8b656'),(353,26,86,11,0,1,'2018-02-05 06:22:06','2018-02-05 06:22:06','5a6335a0-a18c-48e0-ab2e-c15eb491ba93'),(354,26,87,39,0,1,'2018-02-05 06:22:06','2018-02-05 06:22:06','633d05d3-df2c-4e3b-961f-458087808dcc'),(355,26,87,40,0,2,'2018-02-05 06:22:06','2018-02-05 06:22:06','2aca7025-915b-4a82-8254-12272a2b0a82'),(356,26,87,41,0,3,'2018-02-05 06:22:06','2018-02-05 06:22:06','e94e51f1-7859-4db4-b4b2-4f90c8a85342'),(357,26,87,42,0,4,'2018-02-05 06:22:06','2018-02-05 06:22:06','2208da7b-1440-4c49-ad68-d0acc38dba9f'),(358,26,87,43,0,5,'2018-02-05 06:22:06','2018-02-05 06:22:06','c7aa588f-c8bd-410b-bacb-645d6b63870b'),(359,26,87,44,0,6,'2018-02-05 06:22:06','2018-02-05 06:22:06','20321419-28e6-4e79-94bb-29b3c9760bfa'),(360,26,87,45,0,7,'2018-02-05 06:22:06','2018-02-05 06:22:06','e6cb1def-d072-41cc-b50e-17c59fdde218'),(361,30,88,11,0,1,'2018-02-05 06:22:38','2018-02-05 06:22:38','d605a3ab-e6b4-4ff8-b696-ef95f1149f06'),(362,30,89,39,0,1,'2018-02-05 06:22:38','2018-02-05 06:22:38','d6cf5f05-573e-441d-9b15-0cbaffa1698f'),(363,30,89,40,0,2,'2018-02-05 06:22:38','2018-02-05 06:22:38','de95465d-305e-4c9f-9caa-485532eaeea1'),(364,30,89,41,0,3,'2018-02-05 06:22:38','2018-02-05 06:22:38','d2a12904-552b-48f7-a30b-01feaa03ef84'),(365,30,89,42,0,4,'2018-02-05 06:22:38','2018-02-05 06:22:38','74d101b6-24b0-42a3-8e52-71e9cacb589d'),(366,30,89,43,0,5,'2018-02-05 06:22:38','2018-02-05 06:22:38','8df3c575-755a-4f6c-9585-14c8169bd08c'),(367,30,89,44,0,6,'2018-02-05 06:22:38','2018-02-05 06:22:38','9df5c8d1-0bf4-48e3-b339-2fce24be9403'),(368,30,89,45,0,7,'2018-02-05 06:22:38','2018-02-05 06:22:38','5eadbd48-73e3-4871-a71b-364039266719'),(369,24,90,11,0,1,'2018-02-05 06:23:04','2018-02-05 06:23:04','91f36724-9ef4-4e7c-ac03-89b2f397f770'),(370,24,91,39,0,1,'2018-02-05 06:23:04','2018-02-05 06:23:04','eb40975b-034c-478d-a395-2a7e512e9b3f'),(371,24,91,40,0,2,'2018-02-05 06:23:04','2018-02-05 06:23:04','89cc247f-69b4-4ce6-aa0e-76bc0cadba4f'),(372,24,91,41,0,3,'2018-02-05 06:23:04','2018-02-05 06:23:04','9822c0e4-8652-42e8-817f-11a48562fc40'),(373,24,91,42,0,4,'2018-02-05 06:23:04','2018-02-05 06:23:04','97c6af76-b509-42ce-b7f7-0c39e7765eb5'),(374,24,91,43,0,5,'2018-02-05 06:23:04','2018-02-05 06:23:04','fe236243-db88-4a39-b3b9-d89a0c01a11e'),(375,24,91,44,0,6,'2018-02-05 06:23:04','2018-02-05 06:23:04','ff70249e-a08f-4dc4-ba84-c201af1da955'),(376,24,91,45,0,7,'2018-02-05 06:23:04','2018-02-05 06:23:04','b358b808-8878-4d93-ba40-56b5bfe894ca'),(377,9,92,11,0,1,'2018-02-05 06:23:40','2018-02-05 06:23:40','96a92d52-d25c-44d0-ab4e-a6793dfb3a1e'),(378,9,93,39,0,1,'2018-02-05 06:23:40','2018-02-05 06:23:40','859f4486-2e1b-4d1d-a219-bdbc2ca1aada'),(379,9,93,40,0,2,'2018-02-05 06:23:40','2018-02-05 06:23:40','680e811c-5eb8-43d4-8717-2ec44652b245'),(380,9,93,41,0,3,'2018-02-05 06:23:40','2018-02-05 06:23:40','e739dcb3-db60-425b-b6d9-8c9b1849e1fe'),(381,9,93,42,0,4,'2018-02-05 06:23:40','2018-02-05 06:23:40','4b3e6e74-9a5a-4741-a0b3-efcac51a94b6'),(382,9,93,43,0,5,'2018-02-05 06:23:40','2018-02-05 06:23:40','432afbc3-1203-4ebf-b4f9-8d49fe9d6595'),(383,9,93,44,0,6,'2018-02-05 06:23:40','2018-02-05 06:23:40','d00089a7-f055-4eda-b472-d7d6c624266d'),(384,9,93,45,0,7,'2018-02-05 06:23:40','2018-02-05 06:23:40','0c1960fb-c757-414c-b8e0-a87baaf2e964'),(401,10,98,11,0,1,'2018-02-05 06:25:18','2018-02-05 06:25:18','9890e794-5449-4988-a009-3c87be7362f9'),(402,10,99,39,0,1,'2018-02-05 06:25:18','2018-02-05 06:25:18','21515796-3052-4407-90f9-20a3babaec34'),(403,10,99,40,0,2,'2018-02-05 06:25:18','2018-02-05 06:25:18','8a954c56-d6b1-49c2-8fd4-2b6b855809f8'),(404,10,99,41,0,3,'2018-02-05 06:25:18','2018-02-05 06:25:18','5d00ab69-3e15-45fd-b317-49aefd5c5a3a'),(405,10,99,42,0,4,'2018-02-05 06:25:18','2018-02-05 06:25:18','bae707b5-f7fa-4cd8-a47c-7c6a53550ca1'),(406,10,99,43,0,5,'2018-02-05 06:25:18','2018-02-05 06:25:18','67d7595b-7635-416b-97ac-4b6b126fc9d4'),(407,10,99,44,0,6,'2018-02-05 06:25:18','2018-02-05 06:25:18','a60f202b-67d9-4add-ad22-84e8f40c750c'),(408,10,99,45,0,7,'2018-02-05 06:25:18','2018-02-05 06:25:18','804b9f0d-fe1d-4ea8-821d-16cde7c3b4d7'),(409,28,100,11,0,1,'2018-02-05 06:25:26','2018-02-05 06:25:26','f3982cc0-1b4f-4079-820a-aae682c897c1'),(410,28,101,39,0,1,'2018-02-05 06:25:26','2018-02-05 06:25:26','42ac8dcb-f553-4edd-bb38-b7954d103e21'),(411,28,101,40,0,2,'2018-02-05 06:25:26','2018-02-05 06:25:26','3654b433-0c00-4f51-95e1-6e397a20f65b'),(412,28,101,41,0,3,'2018-02-05 06:25:26','2018-02-05 06:25:26','5cb39d0b-f572-47da-90f1-df70f82e3081'),(413,28,101,42,0,4,'2018-02-05 06:25:26','2018-02-05 06:25:26','abc0d794-f9a8-46f3-9b23-20afddd9aaf7'),(414,28,101,43,0,5,'2018-02-05 06:25:26','2018-02-05 06:25:26','cbcb09a2-734f-4931-ae62-912c47024992'),(415,28,101,44,0,6,'2018-02-05 06:25:26','2018-02-05 06:25:26','deb98696-effb-4e4c-8abb-614d97c49941'),(416,28,101,45,0,7,'2018-02-05 06:25:26','2018-02-05 06:25:26','f6fa6ddc-bd8c-480b-aeca-ecd2daee3957'),(417,27,102,11,0,1,'2018-02-05 06:25:56','2018-02-05 06:25:56','3c29bdba-14a6-4381-a933-16a20fc507f6'),(418,27,103,39,0,1,'2018-02-05 06:25:56','2018-02-05 06:25:56','a748293b-0220-4bee-8d52-7a5cddfb1dfc'),(419,27,103,40,0,2,'2018-02-05 06:25:56','2018-02-05 06:25:56','43811d26-8082-4292-8824-e484004a89c1'),(420,27,103,41,0,3,'2018-02-05 06:25:56','2018-02-05 06:25:56','ecc7e37d-f18a-4ac3-9ea4-2fd9086b5462'),(421,27,103,42,0,4,'2018-02-05 06:25:56','2018-02-05 06:25:56','ebb5be06-3b85-43e7-a603-9f5dec76dcc6'),(422,27,103,43,0,5,'2018-02-05 06:25:56','2018-02-05 06:25:56','1a73c3e3-6cfe-4d63-9516-201d447c8d70'),(423,27,103,44,0,6,'2018-02-05 06:25:56','2018-02-05 06:25:56','f782fa6d-6c56-446e-a05a-00685caf9e5a'),(424,27,103,45,0,7,'2018-02-05 06:25:56','2018-02-05 06:25:56','782223d4-a3fa-4e3c-bb8e-fc4da6d19ae2'),(425,29,104,11,0,1,'2018-02-05 06:26:25','2018-02-05 06:26:25','28acb3ed-e3f8-4b84-a385-05eb039a8b6b'),(426,29,105,39,0,1,'2018-02-05 06:26:25','2018-02-05 06:26:25','4e6ce88c-d323-4cb3-889e-933693b6cb55'),(427,29,105,40,0,2,'2018-02-05 06:26:25','2018-02-05 06:26:25','9c106adc-76b2-4fdb-9d38-d597a5678659'),(428,29,105,41,0,3,'2018-02-05 06:26:25','2018-02-05 06:26:25','70141cb4-3c5d-4183-ac76-b7e469e9de13'),(429,29,105,42,0,4,'2018-02-05 06:26:25','2018-02-05 06:26:25','11f50418-724b-4cad-b2c1-938bfabe5933'),(430,29,105,43,0,5,'2018-02-05 06:26:25','2018-02-05 06:26:25','6f2bb870-84ab-4e03-b528-22cc495764d3'),(431,29,105,44,0,6,'2018-02-05 06:26:25','2018-02-05 06:26:25','96c36246-a101-4031-ae3c-1377fa672d4e'),(432,29,105,45,0,7,'2018-02-05 06:26:25','2018-02-05 06:26:25','73b09b6b-f094-4c10-826a-aca3ea9c4508'),(434,31,107,11,0,1,'2018-02-05 19:15:01','2018-02-05 19:15:01','93dd0958-c720-49c9-85b7-d9aa8fdd8056'),(435,31,108,39,0,1,'2018-02-05 19:15:01','2018-02-05 19:15:01','6c9f1d1f-e46d-423c-a45a-a66f63635993'),(436,31,108,40,0,2,'2018-02-05 19:15:01','2018-02-05 19:15:01','9045677d-67fe-475d-b303-e0af92dcf9bc'),(437,31,108,41,0,3,'2018-02-05 19:15:01','2018-02-05 19:15:01','0366299e-a005-431f-b3eb-ba3aff56cc05'),(438,31,108,42,0,4,'2018-02-05 19:15:01','2018-02-05 19:15:01','7cd78e3b-f646-40a1-99a0-868a0d577d69'),(439,31,108,43,0,5,'2018-02-05 19:15:01','2018-02-05 19:15:01','27e30da2-bcd2-4293-b1c7-93ac20057a16'),(440,31,108,44,0,6,'2018-02-05 19:15:01','2018-02-05 19:15:01','2a2a2696-9dbf-4270-9c37-9fe3e366e404'),(441,31,108,45,0,7,'2018-02-05 19:15:01','2018-02-05 19:15:01','1bd11797-d1bf-4263-a70b-de38ca06a78b'),(444,8,110,11,0,1,'2018-02-06 14:23:33','2018-02-06 14:23:33','65df789d-027e-4460-9f45-a5db8bf5418c'),(446,8,111,39,0,1,'2018-02-06 14:23:33','2018-02-06 14:23:33','ee62322e-fc4b-4fb7-a437-7b1fd6928347'),(447,8,111,40,0,2,'2018-02-06 14:23:33','2018-02-06 14:23:33','bd462d2a-3662-44c2-aec0-75188dbc734b'),(448,8,111,41,0,3,'2018-02-06 14:23:33','2018-02-06 14:23:33','1089b958-b9cd-4d4d-b9b1-1427cf48fcce'),(449,8,111,42,0,4,'2018-02-06 14:23:33','2018-02-06 14:23:33','c9a34f3e-0e98-48c8-8aa6-70344b8448ff'),(450,8,111,43,0,5,'2018-02-06 14:23:33','2018-02-06 14:23:33','d29a872b-b7f4-4207-b131-5d4f8e675b14'),(451,8,111,44,0,6,'2018-02-06 14:23:33','2018-02-06 14:23:33','34402a08-075a-4231-821e-0fcfd93a41df'),(452,8,111,45,0,7,'2018-02-06 14:23:33','2018-02-06 14:23:33','9585dadd-a3b9-4c89-ad55-ffeaf2398e1b'),(453,11,112,14,0,1,'2018-02-08 19:35:22','2018-02-08 19:35:22','02879642-7a52-4016-92ae-dd86fe476e77'),(454,11,112,15,1,2,'2018-02-08 19:35:22','2018-02-08 19:35:22','c6349584-942c-49eb-ad8b-ddad337381cf'),(455,12,113,16,0,1,'2018-02-08 19:35:22','2018-02-08 19:35:22','ea460f3b-ca41-4600-a993-e71810c497fb'),(456,12,113,17,1,2,'2018-02-08 19:35:22','2018-02-08 19:35:22','2f2678ea-6a7e-4052-93ea-6616a6f60d05'),(457,12,113,18,1,3,'2018-02-08 19:35:22','2018-02-08 19:35:22','8d671941-9ee1-4740-ba6d-270c814cb2a1'),(458,14,114,23,0,1,'2018-02-08 19:35:22','2018-02-08 19:35:22','10fb85e4-f260-4cad-a228-6ba5f9da7746'),(459,14,114,24,1,2,'2018-02-08 19:35:22','2018-02-08 19:35:22','91667229-3579-4d41-8b69-e941381faf90'),(460,14,114,46,1,3,'2018-02-08 19:35:22','2018-02-08 19:35:22','e60b3c36-9cdd-4c10-8ef8-b5a1bba75b41'),(461,14,114,25,1,4,'2018-02-08 19:35:22','2018-02-08 19:35:22','1e31daee-ba4e-4377-8159-3254bf3ede68'),(462,15,115,26,0,1,'2018-02-08 19:35:22','2018-02-08 19:35:22','aa9b2538-16ca-4fad-a3f9-8ca9133614bf'),(463,15,115,27,1,2,'2018-02-08 19:35:22','2018-02-08 19:35:22','f5c4c51f-485e-40e0-b056-9246f39699b9'),(464,15,115,47,0,3,'2018-02-08 19:35:22','2018-02-08 19:35:22','b56db7d4-eeb4-482a-860b-4da136f3d613'),(465,15,115,28,1,4,'2018-02-08 19:35:22','2018-02-08 19:35:22','dcc2e397-35f5-4dc6-9ee1-65a8c7450962'),(466,16,116,29,0,1,'2018-02-08 19:35:23','2018-02-08 19:35:23','129e7290-4918-4b70-8489-ed24ddc2f843'),(467,16,116,30,1,2,'2018-02-08 19:35:23','2018-02-08 19:35:23','33f41537-b715-4b54-ab63-7c1b79f43533'),(468,16,116,31,1,3,'2018-02-08 19:35:23','2018-02-08 19:35:23','c065b3f3-fa17-4383-a71a-5660887ab727'),(469,16,116,32,0,4,'2018-02-08 19:35:23','2018-02-08 19:35:23','dd2fdad3-4a21-402b-8694-24dfa837a3ed'),(470,17,117,33,0,1,'2018-02-08 19:35:23','2018-02-08 19:35:23','0069a024-dc14-4485-971c-b43522c66604'),(471,17,117,34,1,2,'2018-02-08 19:35:23','2018-02-08 19:35:23','fc404bff-0c36-4773-996d-5c65522de9f8'),(472,18,118,35,0,1,'2018-02-08 19:35:23','2018-02-08 19:35:23','1938842f-c997-4ea4-9a24-383c697cc85d'),(473,18,118,36,0,2,'2018-02-08 19:35:23','2018-02-08 19:35:23','f5546079-0685-4003-806d-a3778db5473f'),(474,18,118,38,1,3,'2018-02-08 19:35:23','2018-02-08 19:35:23','d82fbff3-abe7-4f36-bc81-f712656db7c6'),(475,6,119,65,0,1,'2018-02-08 19:36:23','2018-02-08 19:36:23','b84595e9-aabc-4d34-98aa-6568ee0bc6bb');
/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouts`
--

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayouts` VALUES (2,'craft\\elements\\Asset','2018-01-16 22:11:14','2018-01-16 22:11:14','de763855-6652-40e7-a14a-311417ca2d41'),(3,'craft\\elements\\Entry','2018-01-31 19:49:43','2018-02-04 17:59:16','d076b5fb-86ae-4ca5-9a46-a9146d0aa724'),(4,'craft\\elements\\Entry','2018-01-31 19:51:47','2018-02-04 17:59:28','d20835c1-2f59-4ee5-b54d-788dc9d4205d'),(5,'craft\\elements\\Entry','2018-01-31 19:52:25','2018-02-04 17:59:39','2d846778-5b1a-417f-974c-9cf135d5493e'),(6,'craft\\elements\\Category','2018-01-31 19:53:07','2018-02-08 19:36:23','6890171e-e900-455f-9fa7-5bdf37b57e09'),(8,'craft\\elements\\Entry','2018-02-02 05:31:09','2018-02-06 14:23:33','e20267cc-14f4-404a-8584-47f2d9632f91'),(9,'craft\\elements\\Entry','2018-02-02 05:34:35','2018-02-05 06:23:40','8de5acbb-9542-411b-a05d-37bfd2da5cae'),(10,'craft\\elements\\Entry','2018-02-02 05:34:50','2018-02-05 06:25:18','4e5979ac-1357-4a9f-82a0-518c1c980b52'),(11,'craft\\elements\\MatrixBlock','2018-02-02 06:41:11','2018-02-08 19:35:22','fe2c269e-89ba-4c9d-ac5f-0f838b2feb0a'),(12,'craft\\elements\\MatrixBlock','2018-02-02 06:41:11','2018-02-08 19:35:22','49e26187-fbb5-4dfa-bb12-84da586a1fa8'),(14,'craft\\elements\\MatrixBlock','2018-02-02 06:41:12','2018-02-08 19:35:22','096b5368-187c-4cd6-b902-b1b49cf655c7'),(15,'craft\\elements\\MatrixBlock','2018-02-02 06:41:12','2018-02-08 19:35:22','6fc702e7-b87f-4bdb-ac4e-32313f70cfc6'),(16,'craft\\elements\\MatrixBlock','2018-02-02 06:41:12','2018-02-08 19:35:23','6cb110a9-f0e7-44b2-9c12-d87b89912a8f'),(17,'craft\\elements\\MatrixBlock','2018-02-02 06:41:12','2018-02-08 19:35:23','1c5f2520-7bd1-40f4-a03e-5acbf1cf588e'),(18,'craft\\elements\\MatrixBlock','2018-02-02 06:41:12','2018-02-08 19:35:23','3cb15008-c34e-4c01-a542-0a152034242a'),(19,'craft\\elements\\Entry','2018-02-02 22:08:02','2018-02-04 22:13:31','ac958f47-de51-41e3-984f-6805af639de4'),(20,'craft\\elements\\Entry','2018-02-02 22:10:38','2018-02-04 22:07:57','1a8ec962-5e1a-4f63-9419-4a15ee59deea'),(21,'craft\\elements\\Category','2018-02-02 22:17:15','2018-02-02 22:17:15','4c2cbd8a-4b55-44af-b01d-e7c4a67e9af7'),(22,'craft\\elements\\Entry','2018-02-02 22:22:44','2018-02-02 22:23:45','e744b3df-827b-46ec-b7e0-fe4738064897'),(23,'craft\\elements\\Entry','2018-02-04 22:10:01','2018-02-04 22:10:31','86bcae7c-d21c-4701-ac07-b3365f0ec05a'),(24,'craft\\elements\\Entry','2018-02-04 22:14:34','2018-02-05 06:23:04','9cf50bf1-ba63-4ee8-a245-f5178587bf11'),(25,'craft\\elements\\Entry','2018-02-04 23:02:31','2018-02-04 23:03:09','b6393a40-7fb4-4baa-b883-52d02bac97ee'),(26,'craft\\elements\\Entry','2018-02-04 23:03:59','2018-02-05 06:22:06','fcafbf82-4515-43af-a24a-7f217a658441'),(27,'craft\\elements\\Entry','2018-02-04 23:08:53','2018-02-05 06:25:56','ea944f54-0a0b-4e11-8d1c-ea74cbdd2e20'),(28,'craft\\elements\\Entry','2018-02-05 06:20:14','2018-02-05 06:25:26','53a19581-50e6-4ccd-8371-183e0b95c440'),(29,'craft\\elements\\Entry','2018-02-05 06:20:40','2018-02-05 06:26:25','7e0a24cd-8e6d-48c0-8404-10b93f7f1df3'),(30,'craft\\elements\\Entry','2018-02-05 06:21:29','2018-02-05 06:22:38','0552ae81-bc51-4d11-b923-4b4dd7e4a932'),(31,'craft\\elements\\Entry','2018-02-05 19:14:26','2018-02-05 19:15:01','526d5de5-d527-4c83-a427-cd04ea5d1700');
/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouttabs`
--

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayouttabs` VALUES (49,22,'Blog',1,'2018-02-02 22:23:45','2018-02-02 22:23:45','0aa33455-4a0d-4230-bc78-d7f775c9b2ed'),(50,22,'SEO',2,'2018-02-02 22:23:45','2018-02-02 22:23:45','3a616b9d-5838-4026-b697-ddc3e2c36812'),(60,3,'Resources',1,'2018-02-04 17:59:16','2018-02-04 17:59:16','058732c9-098b-4bc4-8642-c2dd9cc6fc0f'),(61,3,'SEO',2,'2018-02-04 17:59:16','2018-02-04 17:59:16','8498307b-d777-4283-a20f-7ec4475741cf'),(62,4,'Resources',1,'2018-02-04 17:59:28','2018-02-04 17:59:28','e37d7f00-cdf0-41ef-a13b-9deab51d8040'),(63,4,'SEO',2,'2018-02-04 17:59:28','2018-02-04 17:59:28','bfbdf87b-875f-450b-844a-cc5b3572c928'),(64,5,'Resources',1,'2018-02-04 17:59:39','2018-02-04 17:59:39','0af4ac46-5b47-4648-b009-96795a60ceb1'),(65,5,'SEO',2,'2018-02-04 17:59:40','2018-02-04 17:59:40','cbd4447d-fdc4-4fc2-8ada-0e5e5294d948'),(68,20,'People',1,'2018-02-04 22:07:57','2018-02-04 22:07:57','af47a996-3f0f-4fdf-bdcb-16b9b45d88e7'),(69,20,'SEO',2,'2018-02-04 22:07:57','2018-02-04 22:07:57','6038b184-86fb-4867-bff2-cb9519e98c56'),(70,23,'Events',1,'2018-02-04 22:10:31','2018-02-04 22:10:31','1699a166-0126-4137-bc77-97c2b0150c36'),(71,23,'SEO',2,'2018-02-04 22:10:31','2018-02-04 22:10:31','e4bef85c-3b19-4642-ba45-32d41c8cbf32'),(74,19,'News',1,'2018-02-04 22:13:31','2018-02-04 22:13:31','f5674388-cb0a-4743-a1d4-8f9917c68b5d'),(75,19,'SEO',2,'2018-02-04 22:13:31','2018-02-04 22:13:31','a35e6275-5a47-43ab-b086-27659f96396e'),(78,25,'Landing Pages',1,'2018-02-04 23:03:09','2018-02-04 23:03:09','60576ca1-4a10-419a-b965-a14f7c852aa0'),(79,25,'SEO',2,'2018-02-04 23:03:09','2018-02-04 23:03:09','607bf244-6cc6-446a-b1ac-634b6e6703ab'),(86,26,'About Page',1,'2018-02-05 06:22:06','2018-02-05 06:22:06','50cda586-2664-4dbf-983b-7894f3a0b0b6'),(87,26,'SEO',2,'2018-02-05 06:22:06','2018-02-05 06:22:06','2d1071a1-b2e4-48cb-ae07-c41a7a32b524'),(88,30,'Blog Page',1,'2018-02-05 06:22:38','2018-02-05 06:22:38','46026357-d4e7-43e7-b9b4-f8f6f5f47a3a'),(89,30,'SEO',2,'2018-02-05 06:22:38','2018-02-05 06:22:38','88ec0c38-d1df-41dd-b746-fa6c96ab7b56'),(90,24,'Contact Page',1,'2018-02-05 06:23:04','2018-02-05 06:23:04','7a479b0b-e16f-4cba-be95-9f67473ac589'),(91,24,'SEO',2,'2018-02-05 06:23:04','2018-02-05 06:23:04','98bf6d9a-4d4b-4116-9bdc-3fa90d1049fe'),(92,9,'Error Page',1,'2018-02-05 06:23:40','2018-02-05 06:23:40','e0180c1f-e05c-4559-a9e8-976b0589e515'),(93,9,'SEO',2,'2018-02-05 06:23:40','2018-02-05 06:23:40','668c6c30-ca84-4a36-8f42-68a11481ddbd'),(98,10,'Page Not Found',1,'2018-02-05 06:25:18','2018-02-05 06:25:18','47cc9e41-cedd-437b-8e8b-c61eb0b3762b'),(99,10,'SEO',2,'2018-02-05 06:25:18','2018-02-05 06:25:18','8a06b836-dc4b-40b1-aaa2-7395b944c8b4'),(100,28,'News & Events Page',1,'2018-02-05 06:25:26','2018-02-05 06:25:26','1d571352-4627-497b-a1e8-8c9e4a03cbd7'),(101,28,'SEO',2,'2018-02-05 06:25:26','2018-02-05 06:25:26','0da3bfcc-9e7f-4da2-939d-9a9e0561eeeb'),(102,27,'Privacy Page',1,'2018-02-05 06:25:56','2018-02-05 06:25:56','3419b1cc-7616-4de2-8acd-9bd5379deb62'),(103,27,'SEO',2,'2018-02-05 06:25:56','2018-02-05 06:25:56','f7abeb02-0148-4fb0-baf0-a2df113c9988'),(104,29,'Resources Page',1,'2018-02-05 06:26:25','2018-02-05 06:26:25','7c273df0-6e1a-4473-8e53-0aab51f8880f'),(105,29,'SEO',2,'2018-02-05 06:26:25','2018-02-05 06:26:25','4eceb4de-8043-4e53-a66c-bd4332ee0028'),(107,31,'Page',1,'2018-02-05 19:15:01','2018-02-05 19:15:01','d1badec8-377e-4a88-b13d-dd29b01f14f1'),(108,31,'SEO',2,'2018-02-05 19:15:01','2018-02-05 19:15:01','2738d436-846f-4878-b738-bb42acb49dd4'),(110,8,'Homepage',1,'2018-02-06 14:23:33','2018-02-06 14:23:33','0c320a77-ba48-43df-a178-0f9f73909683'),(111,8,'SEO',2,'2018-02-06 14:23:33','2018-02-06 14:23:33','0b198189-df35-4d10-9d39-638fbf912879'),(112,11,'Content',1,'2018-02-08 19:35:22','2018-02-08 19:35:22','f869ae9a-cd84-4edc-b63b-53911df85698'),(113,12,'Content',1,'2018-02-08 19:35:22','2018-02-08 19:35:22','ec5f59e8-ceb2-4d32-b9bb-fdd7b97ba74b'),(114,14,'Content',1,'2018-02-08 19:35:22','2018-02-08 19:35:22','e949cc49-5981-48cd-970a-af544abae680'),(115,15,'Content',1,'2018-02-08 19:35:22','2018-02-08 19:35:22','296c5a63-bf7f-4583-bfb9-07d2d15d1724'),(116,16,'Content',1,'2018-02-08 19:35:23','2018-02-08 19:35:23','7ad3fa3e-0de0-4a30-8586-b0178679ba5f'),(117,17,'Content',1,'2018-02-08 19:35:23','2018-02-08 19:35:23','5e1dc5e7-12de-4d86-be6d-479f79f68c8f'),(118,18,'Content',1,'2018-02-08 19:35:23','2018-02-08 19:35:23','339db37b-267d-4764-8823-e318a4def681'),(119,6,'Resource Category',1,'2018-02-08 19:36:23','2018-02-08 19:36:23','ee3b9552-e54a-471c-b61b-897709193098');
/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fields` VALUES (4,2,'Featured Image','resourecFeaturedImage','global','This image will be shown in lists and other places this resource is featured.','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"folder:1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"\",\"allowedKinds\":null,\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"Add a featured image\",\"localizeRelations\":false}','2018-01-31 19:42:47','2018-01-31 19:43:49','0f8aa3f7-de9e-4beb-a7e9-e98793b3b60e'),(5,2,'Resource Categories','resourceCategories','global','','site',NULL,'craft\\fields\\Categories','{\"branchLimit\":\"\",\"sources\":\"*\",\"source\":\"group:1\",\"targetSiteId\":null,\"viewMode\":null,\"limit\":null,\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-01-31 19:43:33','2018-01-31 19:54:18','86444c22-bd97-4a40-9136-f5613c95ba48'),(6,2,'resourceURL','resourceUrl','global','URL for this resource.','none',NULL,'typedlinkfield\\fields\\LinkField','{\"allowCustomText\":\"1\",\"allowedLinkNames\":[\"url\",\"entry\"],\"allowTarget\":\"\",\"defaultText\":\"\",\"typeSettings\":{\"asset\":{\"sources\":\"*\"},\"category\":{\"sources\":\"*\"},\"entry\":{\"sources\":\"*\"}}}','2018-01-31 19:44:49','2018-01-31 19:44:49','93e2b1ce-6b60-40c8-ad40-4b1c92d2ecd1'),(7,2,'Resource File','resourceFile','global','Upload or select the file for this resource.','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"folder:1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"\",\"allowedKinds\":null,\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"1\",\"selectionLabel\":\"Add a file\",\"localizeRelations\":false}','2018-01-31 19:45:25','2018-01-31 19:46:35','7b6ea82f-c077-45d5-b8ba-35e53b7695b4'),(8,2,'File Download Call to Action','resourceFileCTA','global','Text shown on the Call to Action to download this file.','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-01-31 19:46:09','2018-01-31 19:46:09','8db154b4-31aa-4a46-bd7e-e040f96b91a8'),(9,2,'Embed','resourceEmbed','global','Paste code to embed a video or other widget here.','none',NULL,'luwes\\codemirror\\fields\\CodeMirrorField','[]','2018-01-31 19:48:46','2018-01-31 19:54:51','0610a849-e9bc-455c-86d5-ee8175b2ae9a'),(10,2,'Resource Date','resourceDate','global','','none',NULL,'craft\\fields\\Date','{\"showDate\":true,\"showTime\":false,\"minuteIncrement\":\"30\"}','2018-01-31 19:49:25','2018-01-31 19:49:25','d5e98a9a-c478-4cf5-8c85-1083950e2e9f'),(11,1,'Structured Content','structuredContent','global','blockContent','site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"localizeBlocks\":false}','2018-01-31 19:58:30','2018-02-08 19:35:22','7ccca481-afc6-4d2d-a691-46d51885c73e'),(14,NULL,'Section Title','sectionTitle','matrixBlockType:1','Optional title for this section.','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-02-02 06:41:11','2018-02-08 19:35:22','f4709cc7-103f-4722-860c-463eb0524b7b'),(15,NULL,'Content','blockContent','matrixBlockType:1','','none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Standard.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"}','2018-02-02 06:41:11','2018-02-08 19:35:22','8cf354bc-58ad-42e1-aeb4-f6439b839750'),(16,NULL,'Section Title','sectionTitle','matrixBlockType:2','Optional title for this section.','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-02-02 06:41:11','2018-02-08 19:35:22','a52f1e8a-cba5-455a-ab66-c739b9463856'),(17,NULL,'Left Content','leftContent','matrixBlockType:2','','none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Standard.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"}','2018-02-02 06:41:11','2018-02-08 19:35:22','562f7fa1-cbca-4b54-afad-7d44b1be171a'),(18,NULL,'Right Content','rightContent','matrixBlockType:2','','none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Standard.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"}','2018-02-02 06:41:11','2018-02-08 19:35:22','670d63fe-1da6-4a38-b355-941b9c53c5d7'),(23,NULL,'Section Title','sectionTitle','matrixBlockType:4','Optional title for this section.','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-02-02 06:41:12','2018-02-08 19:35:22','44cce794-ef87-4267-b50d-b4234ba0bd59'),(24,NULL,'Image','image','matrixBlockType:4','','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"folder:1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"\",\"allowedKinds\":null,\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"Choose an image\",\"localizeRelations\":false}','2018-02-02 06:41:12','2018-02-08 19:35:22','7a63a845-8a3f-4576-948f-5e1699226882'),(25,NULL,'Content','blockContent','matrixBlockType:4','','none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Standard.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"}','2018-02-02 06:41:12','2018-02-08 19:35:22','f01c690c-38f2-4d42-8123-2f1ef7ab7a1e'),(26,NULL,'Section Title','sectionTitle','matrixBlockType:5','Optional title for this section.','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-02-02 06:41:12','2018-02-08 19:35:22','c1bad40b-bf3e-410f-9d20-499eeff520bf'),(27,NULL,'Video or Embed Code','videoOrEmbedCode','matrixBlockType:5','','none',NULL,'luwes\\codemirror\\fields\\CodeMirrorField','[]','2018-02-02 06:41:12','2018-02-08 19:35:22','8526fc89-e8e9-4565-bdf0-a16ed9a6bc69'),(28,NULL,'Content','blockContent','matrixBlockType:5','','none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Standard.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"}','2018-02-02 06:41:12','2018-02-08 19:35:22','f085c9a4-9812-4550-a6ac-84dfb0c4459d'),(29,NULL,'Section Title','sectionTitle','matrixBlockType:6','Optional title for this section.','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-02-02 06:41:12','2018-02-08 19:35:22','c04d3133-756c-44d2-ae47-41f5946dddaf'),(30,NULL,'Quote','quote','matrixBlockType:6','','none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Standard.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"}','2018-02-02 06:41:12','2018-02-08 19:35:22','c5eb763d-fb5a-4f00-8fc2-74e9b242860b'),(31,NULL,'Person','person','matrixBlockType:6','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-02-02 06:41:12','2018-02-08 19:35:22','832bda63-d7a5-494e-a960-dbc6d4f71755'),(32,NULL,'Job Title','jobTitle','matrixBlockType:6','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-02-02 06:41:12','2018-02-08 19:35:23','8b129965-072e-4380-bd83-2cc75fe7c989'),(33,NULL,'Section Title','sectionTitle','matrixBlockType:7','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-02-02 06:41:12','2018-02-08 19:35:23','3ebface3-3651-4864-b86f-2eaa76ff7b82'),(34,NULL,'HTML Widget or Embed','embed','matrixBlockType:7','','none',NULL,'luwes\\codemirror\\fields\\CodeMirrorField','[]','2018-02-02 06:41:12','2018-02-08 19:35:23','fd5e975b-61c7-46ca-9927-12fcb7d04fcd'),(35,NULL,'Section Title','sectionTitle','matrixBlockType:8','Optional title for this section.','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-02-02 06:41:12','2018-02-08 19:35:23','85c7e535-dbcd-4e5d-af41-3bf0b93d5c89'),(36,NULL,'Content','blockContent','matrixBlockType:8','','none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Standard.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"}','2018-02-02 06:41:12','2018-02-08 19:35:23','24bcd6a1-3fa6-4839-940a-af27d389740b'),(38,NULL,'Call to Action','cta','matrixBlockType:8','This is the link and label for the Call to Action button itself. If you don\'t specify link text, it will default to \"Learn More\".','none',NULL,'typedlinkfield\\fields\\LinkField','{\"allowCustomText\":\"1\",\"allowedLinkNames\":\"*\",\"allowTarget\":\"\",\"defaultText\":\"Learn More\",\"typeSettings\":{\"asset\":{\"sources\":\"*\"},\"category\":{\"sources\":\"*\"},\"entry\":{\"sources\":\"*\"}}}','2018-02-02 06:41:12','2018-02-08 19:35:23','245fe7e9-d7f5-4de8-8cb6-0ed50edddffb'),(39,3,'HTML Title Override','htmlTitleOverride','global','Title tags are often truncated around 60 characters, so when possible, try to keep them under that length.','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-02-02 06:46:17','2018-02-02 06:46:17','27247eb3-ce02-4776-a57d-c34c35c19127'),(40,3,'Meta Description','metaDescription','global','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-02-02 06:46:35','2018-02-02 06:46:35','71853a8b-b74d-4320-83d5-b8ef585bc335'),(41,3,'Open Graph Title','openGraphTitle','global','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-02-02 06:46:44','2018-02-02 06:46:44','e72e6691-b2c5-41b9-b75e-56b6a7200933'),(42,3,'Open Graph Description','openGraphDescription','global','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-02-02 06:46:51','2018-02-02 06:46:51','b1abef14-c4df-4e03-adf6-740fbfae5ddf'),(43,3,'Open Graph Image','openGraphImage','global','','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"folder:1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"\",\"allowedKinds\":null,\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"Choose an image\",\"localizeRelations\":false}','2018-02-02 06:47:10','2018-02-02 06:47:10','0ba5cfaa-93ea-41f9-8b0b-46c048b5b209'),(44,3,'Additional Header Code','headerCode','global','If you have any additional header tags or javascript that needs to be added, you can add it here.','none',NULL,'luwes\\codemirror\\fields\\CodeMirrorField','[]','2018-02-02 06:47:54','2018-02-02 06:49:39','d1edff97-994f-4f78-9318-6cdbbdfd446d'),(45,3,'Additional Footer Code','footerCode','global','If you have any additional javascript code that needs to be added, you can add it here.','none',NULL,'luwes\\codemirror\\fields\\CodeMirrorField','[]','2018-02-02 06:49:10','2018-02-02 06:49:10','e60a84f5-789c-489b-a95e-ae0419f4ae7d'),(46,NULL,'Image Position','position','matrixBlockType:4','','none',NULL,'rias\\positionfieldtype\\fields\\Position','{\"options\":{\"left\":\"1\",\"center\":\"\",\"right\":\"1\",\"full\":\"\",\"drop-left\":\"\",\"drop-right\":\"\"},\"default\":\"\"}','2018-02-02 22:00:48','2018-02-08 19:35:22','5f8ee8da-9277-4b2e-9482-9f78c77a131a'),(47,NULL,'Video Position','position','matrixBlockType:5','','none',NULL,'rias\\positionfieldtype\\fields\\Position','{\"options\":{\"left\":\"1\",\"center\":\"\",\"right\":\"1\",\"full\":\"\",\"drop-left\":\"\",\"drop-right\":\"\"},\"default\":\"\"}','2018-02-02 22:00:48','2018-02-08 19:35:22','a83d00fb-de79-47a0-bd4d-e2778c73ef0c'),(48,4,'Job Title','personJobTitle','global','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-02-02 22:03:25','2018-02-02 22:03:25','a3601ba7-e21f-4718-86f2-0c19eae0d32f'),(49,4,'Photo','personPhoto','global','','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"folder:1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"\",\"allowedKinds\":null,\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"Choose a photo\",\"localizeRelations\":false}','2018-02-02 22:03:44','2018-02-02 22:05:22','48df7913-438b-433b-96d3-163d33a83ea7'),(50,4,'Abstract','personAbstract','global','This is a short paragraph used to describe this person when not viewing their full bio.','none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Simple.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"}','2018-02-02 22:04:45','2018-02-02 22:14:38','c2fc9bf0-5ff5-4af8-ae54-5ca0a7ce5db4'),(51,4,'Bio','personBio','global','Full bio of this person.','none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Standard.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"}','2018-02-02 22:05:12','2018-02-02 22:15:19','a3f637cc-edb1-4bae-83f3-a40127804401'),(52,5,'Date','newsDate','global','Date of this article.','none',NULL,'craft\\fields\\Date','{\"showDate\":true,\"showTime\":false,\"minuteIncrement\":\"30\"}','2018-02-02 22:06:14','2018-02-02 22:06:14','26f42a7b-fe45-4cc5-9535-49a9e14a7446'),(54,6,'Blog Date','blogDate','global','','none',NULL,'craft\\fields\\Date','{\"showDate\":true,\"showTime\":false,\"minuteIncrement\":\"30\"}','2018-02-02 22:09:37','2018-02-02 22:09:37','c2b63486-bb0e-42d6-9986-12cead0acc47'),(55,6,'Featured Image','blogFeaturedImage','global','','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"folder:1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"\",\"allowedKinds\":null,\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"Choose an image\",\"localizeRelations\":false}','2018-02-02 22:10:05','2018-02-02 22:10:05','fe9f15e5-2b68-477e-af16-c6e83c83e642'),(56,6,'Author','blogAuthor','global','','site',NULL,'craft\\fields\\Entries','{\"sources\":[\"section:7\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":null,\"limit\":\"1\",\"selectionLabel\":\"Specify the author\",\"localizeRelations\":false}','2018-02-02 22:12:44','2018-02-02 22:12:56','b54bac54-a6a2-4e19-af8b-eead56deed68'),(57,6,'Abstract','blogAbstract','global','','none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Simple.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"}','2018-02-02 22:13:30','2018-02-02 22:14:54','2575b2df-9c7d-43dc-b00c-7c8b4a389b22'),(58,6,'Blog Categories','blogCategories','global','','site',NULL,'craft\\fields\\Categories','{\"branchLimit\":\"\",\"sources\":\"*\",\"source\":\"group:2\",\"targetSiteId\":null,\"viewMode\":null,\"limit\":null,\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-02-02 22:17:51','2018-02-02 22:17:51','a889cfc2-e16d-4719-88be-773bf11567f4'),(59,7,'Start Date','eventStartDate','global','','none',NULL,'craft\\fields\\Date','{\"showDate\":true,\"showTime\":false,\"minuteIncrement\":\"30\"}','2018-02-04 22:08:45','2018-02-04 22:08:45','c2f6ae57-a58a-4ddb-8776-b3510df685a6'),(60,7,'End Date','eventEndDate','global','','none',NULL,'craft\\fields\\Date','{\"showDate\":true,\"showTime\":false,\"minuteIncrement\":\"30\"}','2018-02-04 22:08:59','2018-02-04 22:08:59','cd059144-5cb6-46db-bcea-8d8e1d747107'),(61,7,'Abstract','eventAbstract','global','Short description of the event.','none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Simple.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"}','2018-02-04 22:09:35','2018-02-04 22:09:35','fcc7f6c3-97c3-4ab3-8555-f630f7deb9cb'),(64,7,'Location','eventLocation','global','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-02-08 18:46:35','2018-02-08 18:46:35','4f214271-7640-4763-948d-3eb791a16473'),(65,2,'Resource Category Icon','resourceCategoryIcon','global','','none',NULL,'plugins\\dolphiq\\iconpicker\\fields\\Iconpicker','{\"placeholder\":null,\"charLimit\":null,\"columnType\":\"string\",\"iconFont\":\"fa-regular-400-ttf\"}','2018-02-08 19:36:00','2018-02-08 19:36:00','05d5c19d-c542-4c08-ab17-d612274709a1');
/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `globalsets`
--

LOCK TABLES `globalsets` WRITE;
/*!40000 ALTER TABLE `globalsets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `globalsets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `info`
--

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `info` VALUES (1,'3.0.0-RC11','3.0.83',0,'America/Los_Angeles','Padstone',1,0,'i9g18CjGwlbp','2017-11-29 20:51:54','2018-03-14 19:10:47','c186921c-3ab0-4627-92da-ad0c58d9dd65');
/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocks`
--

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocktypes`
--

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixblocktypes` VALUES (1,11,11,'Rich Text','richText',1,'2018-02-02 06:41:11','2018-02-08 19:35:22','ddfe72db-cc91-496e-a097-1be94045f971'),(2,11,12,'Two Columns','twoColumns',2,'2018-02-02 06:41:11','2018-02-08 19:35:22','dc575719-2de8-473b-9872-9e294da811a2'),(4,11,14,'Image with Text','imageWithText',3,'2018-02-02 06:41:12','2018-02-08 19:35:22','318e27c6-9622-4e58-9013-b8731641271f'),(5,11,15,'Video with Text','videoWithText',4,'2018-02-02 06:41:12','2018-02-08 19:35:22','c5c9e5cd-cbe8-4b48-b85e-2dcccae569ba'),(6,11,16,'Testimonial','testimonial',5,'2018-02-02 06:41:12','2018-02-08 19:35:23','12dbddde-14fb-4b79-98fe-6c9bee0e3de8'),(7,11,17,'HTML Widget/Embed','htmlWidgetEmbed',6,'2018-02-02 06:41:12','2018-02-08 19:35:23','7f264ef3-9650-4cb3-9de7-cdc442a98a4d'),(8,11,18,'Call to Action','callToAction',7,'2018-02-02 06:41:12','2018-02-08 19:35:23','edc14065-98d5-402c-a1ed-a745b252ada4');
/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixcontent_structuredcontent`
--

LOCK TABLES `matrixcontent_structuredcontent` WRITE;
/*!40000 ALTER TABLE `matrixcontent_structuredcontent` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixcontent_structuredcontent` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `migrations` VALUES (1,NULL,'app','Install','2017-11-29 20:51:54','2017-11-29 20:51:54','2017-11-29 20:51:54','4c0144b5-4eba-4164-a048-5fd022c849ba'),(2,NULL,'app','m150403_183908_migrations_table_changes','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','0c856f6c-5ad1-4432-961a-16cb785a2914'),(3,NULL,'app','m150403_184247_plugins_table_changes','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','1649a572-0a85-4911-9557-48fd747434a0'),(4,NULL,'app','m150403_184533_field_version','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','aad44269-787f-4a31-83ef-1f867c194e24'),(5,NULL,'app','m150403_184729_type_columns','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','b34b2f3a-4209-4f92-8993-cd8fb1a65704'),(6,NULL,'app','m150403_185142_volumes','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','a5ac3a6d-4592-4b7f-bc4f-87f7ab45c2ee'),(7,NULL,'app','m150428_231346_userpreferences','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','885958c2-780e-4846-b7da-06a45b81ed8c'),(8,NULL,'app','m150519_150900_fieldversion_conversion','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','6c4bb4d2-0b69-4fe3-bfb0-2507c62bb2cf'),(9,NULL,'app','m150617_213829_update_email_settings','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','a38d2d7e-ec1f-4801-baf4-21888c88b335'),(10,NULL,'app','m150721_124739_templatecachequeries','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','c69141dc-ed73-464c-ac54-14e36f4744ba'),(11,NULL,'app','m150724_140822_adjust_quality_settings','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','5accb70b-cc0a-429a-9e60-1207a04c0421'),(12,NULL,'app','m150815_133521_last_login_attempt_ip','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','c36f3946-eee4-4fa2-b229-abee2e532ab1'),(13,NULL,'app','m151002_095935_volume_cache_settings','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','72f5e95f-b348-41e4-991c-40b5b6486aba'),(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','5fb5273e-dcbb-4319-a233-87f74ffce10d'),(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','73b3dc31-79e3-42e6-8a27-822b2298e20b'),(16,NULL,'app','m151209_000000_move_logo','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','1c65abf9-3717-4698-b8e9-62300deb3074'),(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','b25bd8ea-8c5d-46a5-b13e-f08b7537f85f'),(18,NULL,'app','m151215_000000_rename_asset_permissions','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','94244ace-5ff4-41d2-b931-826d8a7a6f7a'),(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','b942864d-7c53-4c0e-be95-d1e6733beeaa'),(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','f36ce568-0410-452e-9778-9f2ecd4a20d6'),(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','fc4e4992-7be0-4362-9952-edbf8e502a6c'),(22,NULL,'app','m160727_194637_column_cleanup','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','9afdba7b-686c-49f7-b91b-ec8778aed165'),(23,NULL,'app','m160804_110002_userphotos_to_assets','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','125c6ed6-3406-4cc9-ab37-00c99f9394f4'),(24,NULL,'app','m160807_144858_sites','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','6c2e1141-893d-46cb-a754-17576e54ac77'),(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','e08e3e30-74c9-489b-bf39-e4ba4e156c31'),(26,NULL,'app','m160830_000000_asset_index_uri_increase','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','16813e22-cced-4cd1-9a6f-e45a131838e5'),(27,NULL,'app','m160912_230520_require_entry_type_id','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','41c87eff-b531-43e6-9f74-33bbe76e6520'),(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','baec422e-c348-4995-aa21-71550cab83b4'),(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','daff915d-c527-4e63-b6e6-af46c80d1134'),(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','512f5985-9b88-49b5-9cd6-ec90a48fffd7'),(31,NULL,'app','m160925_113941_route_uri_parts','2017-11-29 20:51:55','2017-11-29 20:51:55','2017-11-29 20:51:55','5bc2a3d4-d087-4bbf-be99-72edce120e58'),(32,NULL,'app','m161006_205918_schemaVersion_not_null','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','0c9f016a-948e-4671-aefa-d5e1bf8ab9ad'),(33,NULL,'app','m161007_130653_update_email_settings','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','43fe3a64-84be-480e-a344-d3e233109f54'),(34,NULL,'app','m161013_175052_newParentId','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','f199c7d2-355d-4331-a2d1-19a56ceac0ae'),(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','825a4d69-a40d-451b-83e9-379deda15fa7'),(36,NULL,'app','m161021_182140_rename_get_help_widget','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','c58b30b8-414f-48a8-aba9-eb1c27ce22a4'),(37,NULL,'app','m161025_000000_fix_char_columns','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','07e69f84-000f-41e3-800e-448d264fd7ae'),(38,NULL,'app','m161029_124145_email_message_languages','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','b41aac1a-c872-4401-a702-6712687e3bd0'),(39,NULL,'app','m161108_000000_new_version_format','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','ee4b04cf-1b9c-47ff-8858-e381e6386c04'),(40,NULL,'app','m161109_000000_index_shuffle','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','e98c3cac-f1eb-4f3e-a9ac-16325d334724'),(41,NULL,'app','m161122_185500_no_craft_app','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','276fee4c-307f-4055-a1e7-94ba92afb806'),(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','780954fb-2ad6-4170-ba71-9952dbdc0cb0'),(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','82f7ffa2-b4c5-487a-907f-f6aae2941518'),(44,NULL,'app','m170114_161144_udates_permission','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','a48198e5-892b-4996-ba3b-d5818bb6e5c1'),(45,NULL,'app','m170120_000000_schema_cleanup','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','ebb67ae1-5076-414c-baa7-2ee4ca7bc7a9'),(46,NULL,'app','m170126_000000_assets_focal_point','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','26fe98a3-7c39-4f9a-8ce6-9db61ddfdc62'),(47,NULL,'app','m170206_142126_system_name','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','cb5e45b1-5bcc-4ced-8b80-d94aacd71311'),(48,NULL,'app','m170217_044740_category_branch_limits','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','24e74405-0487-483a-9930-c5ee851fec82'),(49,NULL,'app','m170217_120224_asset_indexing_columns','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','1ab95a58-c49b-40bc-9488-0221a8cf6f23'),(50,NULL,'app','m170223_224012_plain_text_settings','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','a2e6f352-4d90-40b4-9124-def460a02e73'),(51,NULL,'app','m170227_120814_focal_point_percentage','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','86459327-7db0-4233-9a40-75f5d87f9964'),(52,NULL,'app','m170228_171113_system_messages','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','3ef159c8-3b24-497d-afc8-c0cef89e82d2'),(53,NULL,'app','m170303_140500_asset_field_source_settings','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','7f666940-4b39-4d26-ad12-277da3827ef3'),(54,NULL,'app','m170306_150500_asset_temporary_uploads','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','60e890f6-e6ab-4981-b4b0-6482aff99d00'),(55,NULL,'app','m170414_162429_rich_text_config_setting','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','bda8409d-2c0e-40f8-b69f-923d0387c284'),(56,NULL,'app','m170523_190652_element_field_layout_ids','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','a9164e02-4421-4b77-bfc2-f99398c8e402'),(57,NULL,'app','m170612_000000_route_index_shuffle','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','01e61c30-c1d8-4014-8868-3edc6758dec4'),(58,NULL,'app','m170620_203910_no_disabled_plugins','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','3d2a5964-3a99-40f9-958f-079a4e763eef'),(59,NULL,'app','m170621_195237_format_plugin_handles','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','cfc3d47e-ef55-4152-aa87-207383e8f75f'),(60,NULL,'app','m170630_161028_deprecation_changes','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','ee3cc4a4-f252-4a56-8093-ddd235ce93fd'),(61,NULL,'app','m170703_181539_plugins_table_tweaks','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','542b6c13-fe93-4971-ae5c-752ebccecf58'),(62,NULL,'app','m170704_134916_sites_tables','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','34fa7ecf-d2e4-48b6-b411-e99be7326174'),(63,NULL,'app','m170706_183216_rename_sequences','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','b40dc2ab-f66b-402d-834b-dca3fc94c9da'),(64,NULL,'app','m170707_094758_delete_compiled_traits','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','ba1b2995-6477-42f6-8eab-21d7f00eab8e'),(65,NULL,'app','m170707_131841_fix_db_routes','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','78520ecd-4112-4a10-85bb-caa32813bc90'),(66,NULL,'app','m170731_190138_drop_asset_packagist','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','c1e69b9b-97a6-4089-9a98-ee1aef0e9e2c'),(67,NULL,'app','m170809_223338_oauth_tokens_table','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','3216578e-fc16-488e-aba8-72738efa8e9a'),(68,NULL,'app','m170810_201318_create_queue_table','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','0cfc14a2-32ce-4600-bcb1-b9c3a2642bd0'),(69,NULL,'app','m170816_133741_delete_compiled_behaviors','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','1fae8a6b-d446-466b-b523-94cfc61c470c'),(70,NULL,'app','m170821_180624_deprecation_line_nullable','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','334cce3c-40d9-4621-9e32-eeb141685e63'),(71,NULL,'app','m170903_192801_longblob_for_queue_jobs','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','fb578b9b-5838-48c4-a3ce-ca18162b6a81'),(72,NULL,'app','m170914_204621_asset_cache_shuffle','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','5ada5eba-fae7-4a44-8a06-303dd2a4a400'),(73,NULL,'app','m171107_000000_assign_group_permissions','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','df41d8d7-107c-43f9-883f-696e212d4015'),(74,NULL,'app','m171117_000001_templatecache_index_tune','2017-11-29 20:51:56','2017-11-29 20:51:56','2017-11-29 20:51:56','92b1ea02-afeb-4593-a53d-fb80f67b8a7e'),(75,NULL,'app','m171011_214115_site_groups','2018-01-16 22:09:00','2018-01-16 22:09:00','2018-01-16 22:09:00','387a2f96-b745-4544-897b-8169705297f0'),(76,NULL,'app','m171012_151440_primary_site','2018-01-16 22:09:00','2018-01-16 22:09:00','2018-01-16 22:09:00','948a2dcf-db34-4aa9-a2e3-745410307de3'),(77,NULL,'app','m171013_142500_transform_interlace','2018-01-16 22:09:00','2018-01-16 22:09:00','2018-01-16 22:09:00','38fbdd3c-b2da-4a0f-89bb-3c0946d73a8f'),(78,NULL,'app','m171016_092553_drop_position_select','2018-01-16 22:09:00','2018-01-16 22:09:00','2018-01-16 22:09:00','dedd66cb-9911-4462-8953-d36c2ab531b5'),(79,NULL,'app','m171016_221244_less_strict_translation_method','2018-01-16 22:09:00','2018-01-16 22:09:00','2018-01-16 22:09:00','25cf1322-ddd0-44e2-8b99-8f385461a59f'),(80,NULL,'app','m171126_105927_disabled_plugins','2018-01-16 22:09:00','2018-01-16 22:09:00','2018-01-16 22:09:00','6b01c813-fa99-4cad-8530-2983067f973d'),(81,NULL,'app','m171130_214407_craftidtokens_table','2018-01-16 22:09:00','2018-01-16 22:09:00','2018-01-16 22:09:00','ed4e0e78-7f63-46c7-891e-129828165c52'),(82,NULL,'app','m171202_004225_update_email_settings','2018-01-16 22:09:00','2018-01-16 22:09:00','2018-01-16 22:09:00','93ecd31b-c3a9-4dd4-9d5e-cef3e865ad6c'),(83,NULL,'app','m171204_000001_templatecache_index_tune_deux','2018-01-16 22:09:00','2018-01-16 22:09:00','2018-01-16 22:09:00','3580b1fd-1e74-455c-9f14-83719b370b93'),(84,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2018-01-16 22:09:00','2018-01-16 22:09:00','2018-01-16 22:09:00','a9f54878-a80e-4010-bb54-7efd4511aa10'),(85,NULL,'app','m171210_142046_fix_db_routes','2018-01-16 22:09:00','2018-01-16 22:09:00','2018-01-16 22:09:00','f3dccaec-fd5a-4ca3-9071-73eb2c2703a0'),(86,NULL,'app','m171218_143135_longtext_query_column','2018-01-16 22:09:00','2018-01-16 22:09:00','2018-01-16 22:09:00','a79f4420-7899-4683-93cc-a498af2a1f04'),(87,NULL,'app','m171231_055546_environment_variables_to_aliases','2018-01-16 22:09:00','2018-01-16 22:09:00','2018-01-16 22:09:00','40fb909c-5cef-451e-b47a-8580501919b5'),(88,4,'plugin','Install','2018-01-16 22:36:57','2018-01-16 22:36:57','2018-01-16 22:36:57','603703ec-0c96-4f1d-bf46-6ddf24170e54'),(89,4,'plugin','m170602_080218_redirect_1_0_1','2018-01-16 22:36:57','2018-01-16 22:36:57','2018-01-16 22:36:57','1c4686e9-e003-493b-a71c-910ed6215945'),(90,4,'plugin','m170707_211256_count_fix','2018-01-16 22:36:57','2018-01-16 22:36:57','2018-01-16 22:36:57','1ac1c38b-c661-48ed-a941-c44145cc0adc'),(91,4,'plugin','m171003_120604_createmultisiteurls','2018-01-16 22:36:57','2018-01-16 22:36:57','2018-01-16 22:36:57','2eaff970-f50e-43e3-988c-cb719a33f7bf'),(92,4,'plugin','m180104_143118_c_redirects_catch_all_urls','2018-01-16 22:36:57','2018-01-16 22:36:57','2018-01-16 22:36:57','9d09cc55-f044-49a4-a896-e8a4b84d7ce0'),(94,13,'plugin','Install','2018-01-17 16:26:09','2018-01-17 16:26:09','2018-01-17 16:26:09','fdde63d4-f74a-4b41-b0e4-b59bf5e530ae'),(95,NULL,'app','m180113_153740_drop_users_archived_column','2018-01-26 14:22:14','2018-01-26 14:22:14','2018-01-26 14:22:14','2fd3db1f-ce99-409d-8f09-9c04e5c097bf'),(96,NULL,'app','m180122_213433_propagate_entries_setting','2018-01-26 14:22:14','2018-01-26 14:22:14','2018-01-26 14:22:14','63598990-f5cd-4f33-a23d-caa054a9f8bb'),(97,NULL,'app','m180124_230459_fix_propagate_entries_values','2018-01-26 14:22:14','2018-01-26 14:22:14','2018-01-26 14:22:14','e99c2bfa-358b-4936-a324-a399d92d9211'),(98,NULL,'app','m180128_235202_set_tag_slugs','2018-02-02 05:03:51','2018-02-02 05:03:51','2018-02-02 05:03:51','b4cb3181-cd6a-4329-a3ef-71ecdfc12048'),(99,NULL,'app','m180202_185551_fix_focal_points','2018-03-14 19:05:27','2018-03-14 19:05:27','2018-03-14 19:05:27','197d1adb-9ddc-4361-bcb7-75a297717cf4'),(100,NULL,'app','m180217_172123_tiny_ints','2018-03-14 19:09:30','2018-03-14 19:09:30','2018-03-14 19:09:30','c17e6a2a-5ae4-4fc8-8cab-f2cf3c15cd65');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `plugins` VALUES (1,'ckeditor','dev-master','1.0.0',NULL,'unknown',NULL,'2018-01-16 22:09:12','2018-01-16 22:09:12','2018-01-16 22:22:04','923b4d94-d4f3-4da5-88d8-c7e0d2e8475b',1),(2,'expanded-singles','1.0.3','1.0.0',NULL,'unknown','{\"expandSingles\":\"1\",\"redirectToEntry\":\"1\"}','2018-01-16 22:36:52','2018-01-16 22:36:52','2018-03-14 19:21:42','0d83ae9a-c05e-4793-bed4-4167f6ef0eb2',1),(3,'mix','1.4.2','1.0.0',NULL,'unknown',NULL,'2018-01-16 22:36:54','2018-01-16 22:36:54','2018-03-14 19:21:42','93dd15c5-c642-4523-b304-e1ebd14adc88',1),(4,'redirect','1.0.15','1.0.4',NULL,'unknown',NULL,'2018-01-16 22:36:57','2018-01-16 22:36:57','2018-03-14 19:21:42','12346350-4291-4a6f-9309-97b6fd3ecd99',1),(5,'typedlinkfield','1.0.4','1.0.0',NULL,'unknown',NULL,'2018-01-16 22:36:59','2018-01-16 22:36:59','2018-03-14 19:21:42','4920e50c-9797-4903-9bcd-26383cc1cc58',1),(6,'code-mirror','1.0.0','1.0.0',NULL,'unknown',NULL,'2018-01-16 23:10:45','2018-01-16 23:10:45','2018-03-14 19:21:42','505bc3be-c4db-47b5-b1f3-effe1acb0f05',1),(7,'admin-bar','3.1.5','3.1.0',NULL,'unknown','{\"customLinks\":[{\"linkLabel\":\"foo\",\"linkUrl\":\"fooo\",\"adminOnly\":\"\"}],\"highlightColor\":\"#D85B4B\",\"bgColor\":\"#000000\",\"textColor\":\"#FFFFFF\",\"additionalLinks\":[],\"cacheBar\":true,\"displayGreeting\":true,\"displayDashboardLink\":true,\"displayDefaultEditSection\":true,\"displaySettingsLink\":true,\"displayLogout\":true,\"enableMobileMenu\":true,\"scrollLinks\":true,\"displayEditDate\":true,\"displayEditAuthor\":true,\"displayRevisionNote\":true}','2018-01-17 16:25:50','2018-01-17 16:25:50','2018-03-14 19:21:42','2529b9bd-ed93-471d-9b8e-fae4516a3424',1),(8,'contact-form','2.1.1','1.0.0',NULL,'unknown',NULL,'2018-01-17 16:25:53','2018-01-17 16:25:53','2018-03-14 19:21:42','1dd4fba6-e0b2-49cb-b384-846c50f78e11',1),(9,'contact-form-honeypot','1.0.2','1.0.0',NULL,'unknown',NULL,'2018-01-17 16:25:55','2018-01-17 16:25:55','2018-03-14 19:21:42','59720d43-ca69-43da-8472-caca0b4b99bf',1),(11,'inlin','2.0.0','2.0.0',NULL,'unknown',NULL,'2018-01-17 16:26:03','2018-01-17 16:26:03','2018-03-14 19:21:42','63726fc3-339c-4be0-9bc0-ca0340bcc846',1),(13,'redactor','1.0.1','1.0.0',NULL,'unknown',NULL,'2018-01-17 16:26:09','2018-01-17 16:26:09','2018-03-14 19:21:42','2f1227f3-32d4-4b05-80ea-7959eea1c8a7',1),(14,'dolphiq-iconpicker','1.0.4','1.0.0',NULL,'unknown',NULL,'2018-02-02 05:14:04','2018-02-02 05:14:04','2018-03-14 19:21:42','2e967d7c-9837-4f0d-b788-7cff22fbaa34',1),(15,'position-fieldtype','1.0.10','1.0.0',NULL,'unknown',NULL,'2018-02-02 21:59:02','2018-02-02 21:59:02','2018-03-14 19:21:42','15913215-e2a9-4833-8e0f-831aff194c03',1);
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `queue`
--

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `relations`
--

LOCK TABLES `relations` WRITE;
/*!40000 ALTER TABLE `relations` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `relations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `routes`
--

LOCK TABLES `routes` WRITE;
/*!40000 ALTER TABLE `routes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `routes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `searchindex`
--

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `searchindex` VALUES (1,'username',0,1,' imarc '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(1,'email',0,1,' info imarc com '),(1,'slug',0,1,''),(17,'field',11,1,''),(16,'field',44,1,''),(16,'field',39,1,''),(16,'field',11,1,''),(16,'field',45,1,''),(15,'field',11,1,''),(16,'field',41,1,''),(5,'slug',0,1,' white papers '),(5,'title',0,1,' white papers '),(6,'slug',0,1,' videos '),(6,'title',0,1,' videos '),(7,'slug',0,1,' case studies '),(7,'title',0,1,' case studies '),(8,'slug',0,1,' webinars '),(8,'title',0,1,' webinars '),(9,'slug',0,1,' reports '),(9,'title',0,1,' reports '),(16,'field',42,1,''),(17,'field',41,1,''),(17,'field',42,1,''),(17,'field',43,1,''),(17,'field',40,1,''),(17,'field',39,1,''),(16,'field',40,1,''),(15,'slug',0,1,' homepage '),(15,'title',0,1,' homepage '),(16,'slug',0,1,' error page '),(16,'title',0,1,' error page '),(17,'slug',0,1,' page not found '),(17,'title',0,1,' page not found '),(17,'field',44,1,''),(16,'field',43,1,''),(15,'field',39,1,''),(15,'field',40,1,''),(15,'field',41,1,''),(15,'field',42,1,''),(15,'field',43,1,''),(15,'field',44,1,''),(15,'field',45,1,''),(17,'field',45,1,''),(18,'slug',0,1,' culture '),(18,'title',0,1,' culture '),(19,'slug',0,1,' hiring '),(19,'title',0,1,' hiring '),(20,'slug',0,1,' announcement '),(20,'title',0,1,' announcement '),(21,'slug',0,1,' press release '),(21,'title',0,1,' press release '),(22,'slug',0,1,' contact '),(22,'title',0,1,' contact page '),(23,'slug',0,1,' about '),(23,'title',0,1,' about page '),(24,'slug',0,1,' privacy page '),(24,'title',0,1,' privacy page '),(25,'slug',0,1,' news events page '),(25,'title',0,1,' news events page '),(26,'slug',0,1,' resources page '),(26,'title',0,1,' resources page '),(27,'slug',0,1,' blog page '),(27,'title',0,1,' blog page '),(23,'field',11,1,''),(23,'field',39,1,''),(23,'field',40,1,''),(23,'field',41,1,''),(23,'field',42,1,''),(23,'field',43,1,''),(23,'field',44,1,''),(23,'field',45,1,''),(27,'field',11,1,''),(27,'field',39,1,''),(27,'field',40,1,''),(27,'field',41,1,''),(27,'field',42,1,''),(27,'field',43,1,''),(27,'field',44,1,''),(27,'field',45,1,''),(22,'field',11,1,''),(22,'field',39,1,''),(22,'field',40,1,''),(22,'field',41,1,''),(22,'field',42,1,''),(22,'field',43,1,''),(22,'field',44,1,''),(22,'field',45,1,''),(25,'field',11,1,''),(25,'field',39,1,''),(25,'field',40,1,''),(25,'field',41,1,''),(25,'field',42,1,''),(25,'field',43,1,''),(25,'field',44,1,''),(25,'field',45,1,''),(24,'field',11,1,''),(24,'field',39,1,''),(24,'field',40,1,''),(24,'field',41,1,''),(24,'field',42,1,''),(24,'field',43,1,''),(24,'field',44,1,''),(24,'field',45,1,''),(26,'field',11,1,''),(26,'field',39,1,''),(26,'field',40,1,''),(26,'field',41,1,''),(26,'field',42,1,''),(26,'field',43,1,''),(26,'field',44,1,''),(26,'field',45,1,''),(15,'field',63,1,' cheesecake testing ');
/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections` VALUES (2,1,'Resources','resources','structure',1,'2018-01-31 19:49:43','2018-01-31 19:49:43','31726602-42e3-461e-ad79-08d69e6e899a',1),(3,NULL,'Homepage','homepage','single',1,'2018-02-02 05:31:09','2018-02-04 23:16:23','804ebac0-45d8-49c0-9e1f-418cc9c708e7',1),(4,NULL,'Error Page','errorPage','single',1,'2018-02-02 05:34:35','2018-02-04 23:16:11','6e318b58-9c19-4a89-aece-8db4a7b52124',1),(5,NULL,'Page Not Found','notFoundPage','single',1,'2018-02-02 05:34:50','2018-02-04 23:16:35','aa4b309e-df7a-47cf-9aa5-25285f46796f',1),(6,NULL,'News Articles','news','channel',1,'2018-02-02 22:08:02','2018-02-04 23:04:30','550e9481-b606-4b2b-83e1-9a895a224d38',1),(7,3,'People','people','structure',1,'2018-02-02 22:10:38','2018-02-02 22:10:38','c87b5acc-afe1-4ddf-b73c-b449c9f29c2d',1),(8,NULL,'Blog Articles','blog','channel',1,'2018-02-02 22:22:44','2018-02-04 23:04:22','fdc8d709-53c4-4104-ba7b-f424bad5b7fc',1),(9,NULL,'Events','events','channel',1,'2018-02-04 22:10:01','2018-02-04 22:10:01','7b352338-e4c1-4527-8c7b-dd3ae5e9d28f',1),(10,NULL,'Contact Page','contactPage','single',1,'2018-02-04 22:14:34','2018-02-04 23:15:53','548dacf3-a377-4ba7-9bc4-d9102a1fc455',1),(11,5,'Landing Pages','landingPages','structure',1,'2018-02-04 23:02:31','2018-02-05 14:39:58','16f0db7d-a9b8-4569-8198-d836625cea77',1),(12,NULL,'About Page','aboutPage','single',1,'2018-02-04 23:03:59','2018-02-04 23:16:02','ebac57bc-baaf-4975-bf81-a0f4c66bad4d',1),(13,NULL,'Privacy Page','privacyPage','single',1,'2018-02-04 23:08:53','2018-02-04 23:16:39','698462dc-1720-42e6-a09e-9e59bce0aa23',1),(14,NULL,'News & Events Page','newsEventsPage','single',1,'2018-02-05 06:20:14','2018-02-05 06:20:54','ca363472-ca75-4a5e-9e46-dc48bfec0b5d',1),(15,NULL,'Resources Page','resourcesPage','single',1,'2018-02-05 06:20:40','2018-02-05 06:20:40','20423d03-2767-4e23-8ba6-41dc15391050',1),(16,NULL,'Blog Page','blogPage','single',1,'2018-02-05 06:21:29','2018-02-05 06:21:29','1e6d0ae4-0c2d-4c61-aa0e-f67a0d64d0be',1),(17,6,'About Pages','aboutPages','structure',1,'2018-02-05 19:14:26','2018-02-05 19:14:37','3375cf3e-4d50-4b42-b4ab-d8ad7e40cdfb',1);
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections_sites`
--

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections_sites` VALUES (2,2,1,1,1,'resources/{slug}','resources/_entry','2018-01-31 19:49:43','2018-01-31 19:49:43','8b79f25d-8445-48a7-be1a-71186f3c8866'),(3,3,1,1,1,'homepage','_index','2018-02-02 05:31:09','2018-02-04 23:16:23','e213bd1a-861a-4660-911c-a4de9b22dc31'),(4,4,1,1,1,'error-page','_error','2018-02-02 05:34:35','2018-02-04 23:16:11','3afa4602-cccf-4792-b6bc-7c8a2a862085'),(5,5,1,1,1,'page-not-found','_404','2018-02-02 05:34:50','2018-02-04 23:16:35','2918dfa6-b002-4580-88db-59652bfa379e'),(6,6,1,1,1,'news/{slug}','news/_entry','2018-02-02 22:08:02','2018-02-04 23:04:30','8cb5a00e-052a-420a-924b-bfc86845e325'),(7,7,1,1,1,'people/{slug}','people/_entry','2018-02-02 22:10:38','2018-02-02 22:10:38','f356a9c5-f987-4cfd-a6db-ce900345e7f1'),(8,8,1,1,1,'blog/{slug}','blog/_entry','2018-02-02 22:22:44','2018-02-04 23:04:22','a9a9a3f3-7275-44f5-9917-2bc700118f8a'),(9,9,1,1,1,'events/{slug}','events/_entry','2018-02-04 22:10:01','2018-02-04 22:10:01','5759ee52-1058-435c-a79b-f30752ecac01'),(10,10,1,1,1,'contact','_contact','2018-02-04 22:14:34','2018-02-04 23:15:53','7c0c2dbb-0889-40fe-a725-326e4630cf41'),(11,11,1,1,1,'{slug}','pages/_{type}','2018-02-04 23:02:31','2018-02-05 14:39:58','4aabd6b2-6431-4236-8c1d-75821d56f2d0'),(12,12,1,1,1,'about','_about','2018-02-04 23:03:59','2018-02-04 23:16:02','3985bb76-af9f-4f82-bdcb-876df24c709d'),(13,13,1,1,1,'privacy','_privacy','2018-02-04 23:08:53','2018-02-04 23:16:39','455c7250-60a4-44ca-9737-ff05679e14f7'),(14,14,1,1,1,'news','_news','2018-02-05 06:20:14','2018-02-05 06:20:54','24d9b977-d03d-4afe-a2d9-959173a4b563'),(15,15,1,1,1,'resources','_resources','2018-02-05 06:20:40','2018-02-05 06:20:40','59b5b039-2a60-4b7a-9dc9-5497c51e5914'),(16,16,1,1,1,'blog','_blog','2018-02-05 06:21:29','2018-02-05 06:21:29','2a7563e6-ff82-460d-af89-2526fb421cde'),(17,17,1,1,1,'about/{slug}','about-pages/_entry','2018-02-05 19:14:26','2018-02-05 19:14:37','e93ea479-e8bf-4ee4-9f89-bc374ccc5eaa');
/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `shunnedmessages`
--

LOCK TABLES `shunnedmessages` WRITE;
/*!40000 ALTER TABLE `shunnedmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sitegroups`
--

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sitegroups` VALUES (1,'Padstone','2018-01-16 22:09:00','2018-01-16 22:09:00','a20a79e6-31e4-4179-833c-e756db8c0d15');
/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sites` VALUES (1,'Padstone','default','en-US',1,'http://dev.padstone.imarc.com/',1,'2017-11-29 20:51:54','2018-01-16 22:09:00','5a949caa-356a-45ea-b408-2b267055c99c',1,1);
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structureelements`
--

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `structureelements` VALUES (1,2,NULL,1,1,12,0,'2018-01-31 19:53:20','2018-01-31 19:54:00','9fc1377e-f891-43e0-a4c8-dc1d82039f3b'),(2,2,5,1,10,11,1,'2018-01-31 19:53:20','2018-01-31 19:54:00','49374a75-0159-44b4-8750-5d35b5ee1576'),(3,2,6,1,6,7,1,'2018-01-31 19:53:25','2018-01-31 19:54:00','7cfc0d0f-330d-49f8-aa11-2396a010ddf3'),(4,2,7,1,2,3,1,'2018-01-31 19:53:36','2018-01-31 19:53:59','0e82030a-d1e7-479e-b7ed-a78e3f87b4d2'),(5,2,8,1,8,9,1,'2018-01-31 19:53:45','2018-01-31 19:54:00','091c5d87-ce5b-4b9c-89ed-f9bdfe16dc51'),(6,2,9,1,4,5,1,'2018-01-31 19:53:51','2018-01-31 19:54:00','78f81f07-eb73-4647-9cea-3f50bb75ba05'),(7,4,NULL,7,1,10,0,'2018-02-04 18:18:49','2018-02-04 22:11:36','a0fcc4ff-3f74-4c00-b36f-e2cf74dff431'),(8,4,18,7,2,3,1,'2018-02-04 18:18:49','2018-02-04 18:18:49','3d03a2bb-27a0-4b1a-815d-28c151eb15c5'),(9,4,19,7,4,5,1,'2018-02-04 18:18:57','2018-02-04 18:18:57','8168fae9-088e-4c61-8231-7cca8e2db837'),(10,4,20,7,6,7,1,'2018-02-04 22:11:29','2018-02-04 22:11:29','ce2dbc1c-8f58-400d-8a4b-9b99d3cd7feb'),(11,4,21,7,8,9,1,'2018-02-04 22:11:36','2018-02-04 22:11:36','eae33fde-e06c-497c-a2e7-262280b84bc0');
/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structures`
--

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `structures` VALUES (1,NULL,'2018-01-31 19:49:43','2018-01-31 19:49:43','160e63e2-a512-4ade-9f18-2171d2cd84eb'),(2,NULL,'2018-01-31 19:53:07','2018-02-08 19:36:23','a05bccd3-a5b7-4519-a8de-a9fd24a1f6fe'),(3,NULL,'2018-02-02 22:10:38','2018-02-02 22:10:38','4b707a60-93c9-4e86-a44c-587eb894590e'),(4,NULL,'2018-02-02 22:17:15','2018-02-02 22:17:15','7500937b-aa4b-4094-9a13-5480a3ca0589'),(5,NULL,'2018-02-04 23:02:31','2018-02-05 14:39:58','6934792a-730e-492e-9701-92209d98f59b'),(6,NULL,'2018-02-05 19:14:26','2018-02-05 19:14:37','bdbf4600-d3a2-4085-9cec-643027e88562');
/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `systemmessages`
--

LOCK TABLES `systemmessages` WRITE;
/*!40000 ALTER TABLE `systemmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `systemmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `systemsettings`
--

LOCK TABLES `systemsettings` WRITE;
/*!40000 ALTER TABLE `systemsettings` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `systemsettings` VALUES (1,'email','{\"fromEmail\":\"kevin@imarc.com\",\"fromName\":\"Padstone\",\"transportType\":\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"}','2017-11-29 20:51:54','2017-11-29 20:51:54','a92c6d4d-5d2a-4536-879f-ac163fc2e404');
/*!40000 ALTER TABLE `systemsettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `taggroups`
--

LOCK TABLES `taggroups` WRITE;
/*!40000 ALTER TABLE `taggroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `taggroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `templatecachequeries`
--

LOCK TABLES `templatecachequeries` WRITE;
/*!40000 ALTER TABLE `templatecachequeries` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `templatecachequeries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups`
--

LOCK TABLES `usergroups` WRITE;
/*!40000 ALTER TABLE `usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups_users`
--

LOCK TABLES `usergroups_users` WRITE;
/*!40000 ALTER TABLE `usergroups_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions`
--

LOCK TABLES `userpermissions` WRITE;
/*!40000 ALTER TABLE `userpermissions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_usergroups`
--

LOCK TABLES `userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `userpermissions_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_users`
--

LOCK TABLES `userpermissions_users` WRITE;
/*!40000 ALTER TABLE `userpermissions_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpreferences`
--

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `userpreferences` VALUES (1,'{\"language\":\"en-US\",\"weekStartDay\":\"0\",\"enableDebugToolbarForSite\":false,\"enableDebugToolbarForCp\":false}');
/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `users` VALUES (1,'imarc',NULL,'','','info@imarc.com','$2y$13$odEDJQWA/kxckuLIHUUvy.DZJQVVKZ4qecDxPNs3TxJURPnRp14wq',1,0,0,0,0,'2018-03-14 19:02:20','172.28.0.1',NULL,NULL,'2018-02-04 17:51:50',NULL,NULL,NULL,NULL,0,'2017-11-29 20:51:54','2017-11-29 20:51:54','2018-03-14 19:02:20','c8ab3617-b18a-4315-9fad-7cb1b47eec98');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumefolders`
--

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `volumefolders` VALUES (1,NULL,1,'Images','','2018-01-16 22:11:14','2018-01-16 22:11:14','af5b4b2e-1abb-467d-b30c-d58da9025050'),(2,NULL,NULL,'Temporary source',NULL,'2018-01-16 22:11:17','2018-01-16 22:11:17','960569f6-1f3b-4db7-b909-17f3d3921edc'),(3,2,NULL,'user_1','user_1/','2018-01-16 22:11:17','2018-01-16 22:11:17','44837918-0dab-4015-be86-d68ab61ba5dc');
/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `volumes` VALUES (1,2,'Images','images','craft\\volumes\\Local',1,'/images','{\"path\":\"@webroot/images\"}',1,'2018-01-16 22:11:14','2018-01-16 22:11:14','09773b73-a304-4513-84fd-c4d5d4dd953a');
/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,0,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2017-11-29 20:53:35','2017-11-29 20:53:35','7e22f562-2a45-45f7-a62e-3e492314081a'),(2,1,'craft\\widgets\\CraftSupport',2,0,'[]',1,'2017-11-29 20:53:35','2017-11-29 20:53:35','8bd0b7af-802e-4498-8f82-beb68d0c859c'),(3,1,'craft\\widgets\\Updates',3,0,'[]',1,'2017-11-29 20:53:35','2017-11-29 20:53:35','11fe287a-de57-4152-9435-539874e9b589'),(4,1,'craft\\widgets\\Feed',4,0,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2017-11-29 20:53:35','2017-11-29 20:53:35','c16bd6cd-84c0-4866-aec9-bd4385c90d98');
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping routines for database 'dev_padstone_imarc_com'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-03-14 19:22:29
