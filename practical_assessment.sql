-- MySQL dump 10.13  Distrib 8.0.36, for macos14 (arm64)
--
-- Host: localhost    Database: practical_assessment
-- ------------------------------------------------------
-- Server version	8.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `attribute_values`
--

DROP TABLE IF EXISTS `attribute_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attribute_values` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `attribute_id` bigint unsigned NOT NULL,
  `entity_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity_id` bigint unsigned NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_attribute_value` (`attribute_id`,`entity_type`,`entity_id`),
  KEY `attribute_values_entity_type_entity_id_index` (`entity_type`,`entity_id`),
  CONSTRAINT `attribute_values_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute_values`
--

LOCK TABLES `attribute_values` WRITE;
/*!40000 ALTER TABLE `attribute_values` DISABLE KEYS */;
INSERT INTO `attribute_values` VALUES (1,8,'App\\Models\\Project',6,'IT','2025-03-07 00:11:51','2025-03-07 00:11:51'),(2,2,'App\\Models\\Project',6,'2025-03-07','2025-03-07 00:13:39','2025-03-07 00:18:59'),(6,8,'App\\Models\\Project',11,'CS','2025-03-07 00:39:16','2025-03-07 00:39:16'),(7,4,'App\\Models\\Project',6,'1100','2025-03-07 02:36:05','2025-03-07 02:36:05');
/*!40000 ALTER TABLE `attribute_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attributes`
--

DROP TABLE IF EXISTS `attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attributes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('text','date','number','select') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attributes`
--

LOCK TABLES `attributes` WRITE;
/*!40000 ALTER TABLE `attributes` DISABLE KEYS */;
INSERT INTO `attributes` VALUES (2,'start_date','date','2025-03-06 23:57:32','2025-03-06 23:57:32'),(3,'end_date','date','2025-03-06 23:57:32','2025-03-06 23:57:32'),(4,'budget','number','2025-03-06 23:57:32','2025-03-06 23:57:32'),(5,'priority','select','2025-03-06 23:57:32','2025-03-06 23:57:32'),(6,'client','text','2025-03-06 23:57:32','2025-03-06 23:57:32'),(7,'location','text','2025-03-06 23:57:32','2025-03-06 23:57:32'),(8,'department','text','2025-03-07 00:03:10','2025-03-07 00:03:10');
/*!40000 ALTER TABLE `attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (14,'0001_01_01_000000_create_users_table',1),(15,'0001_01_01_000001_create_cache_table',1),(16,'0001_01_01_000002_create_jobs_table',1),(17,'2025_03_07_005919_create_projects_table',1),(18,'2025_03_07_005942_create_project_user_table',1),(19,'2025_03_07_005946_create_timesheets_table',1),(20,'2025_03_07_014134_create_personal_access_tokens_table',1),(21,'2025_03_07_014607_create_oauth_auth_codes_table',1),(22,'2025_03_07_014608_create_oauth_access_tokens_table',1),(23,'2025_03_07_014609_create_oauth_refresh_tokens_table',1),(24,'2025_03_07_014610_create_oauth_clients_table',1),(25,'2025_03_07_014611_create_oauth_personal_access_clients_table',1),(26,'2025_03_08_000000_add_creator_id_to_users_table',1),(27,'2025_03_09_000000_add_creator_id_to_projects_table',2),(28,'2025_03_10_000000_create_attributes_table',3),(29,'2025_03_10_000001_create_attribute_values_table',3);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_access_tokens`
--

DROP TABLE IF EXISTS `oauth_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `client_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_access_tokens`
--

LOCK TABLES `oauth_access_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
INSERT INTO `oauth_access_tokens` VALUES ('a2070265961fc4b7e21ea183f2b126cc34d9c9f6a9366d3f07ab6c5ada93a00ffe531db01f2fa026',1,'9e5f1a2f-a618-401c-bb46-c52e35fecda9','AuthToken','[]',0,'2025-03-06 21:03:32','2025-03-06 21:03:32','2026-03-07 02:03:32');
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_auth_codes`
--

DROP TABLE IF EXISTS `oauth_auth_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `client_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_auth_codes_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_auth_codes`
--

LOCK TABLES `oauth_auth_codes` WRITE;
/*!40000 ALTER TABLE `oauth_auth_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_auth_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_clients`
--

DROP TABLE IF EXISTS `oauth_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_clients` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_clients`
--

LOCK TABLES `oauth_clients` WRITE;
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
INSERT INTO `oauth_clients` VALUES ('9e5f1a2f-a618-401c-bb46-c52e35fecda9',NULL,'practical_assessment','QN6fAVLn2fX4vEw1Cirani01NZojeuvdjDAqgadP',NULL,'http://localhost',1,0,0,'2025-03-06 21:03:04','2025-03-06 21:03:04');
/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_personal_access_clients`
--

DROP TABLE IF EXISTS `oauth_personal_access_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `client_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_personal_access_clients`
--

LOCK TABLES `oauth_personal_access_clients` WRITE;
/*!40000 ALTER TABLE `oauth_personal_access_clients` DISABLE KEYS */;
INSERT INTO `oauth_personal_access_clients` VALUES (1,'9e5f1a2f-a618-401c-bb46-c52e35fecda9','2025-03-06 21:03:04','2025-03-06 21:03:04');
/*!40000 ALTER TABLE `oauth_personal_access_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_refresh_tokens`
--

DROP TABLE IF EXISTS `oauth_refresh_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_refresh_tokens`
--

LOCK TABLES `oauth_refresh_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_refresh_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_user`
--

DROP TABLE IF EXISTS `project_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_user` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `project_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_user_user_id_project_id_unique` (`user_id`,`project_id`),
  KEY `project_user_project_id_foreign` (`project_id`),
  CONSTRAINT `project_user_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `project_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_user`
--

LOCK TABLES `project_user` WRITE;
/*!40000 ALTER TABLE `project_user` DISABLE KEYS */;
INSERT INTO `project_user` VALUES (1,1,1,NULL,NULL),(2,1,5,NULL,NULL),(3,2,1,NULL,NULL),(4,2,3,NULL,NULL),(5,2,5,NULL,NULL),(6,3,1,NULL,NULL),(7,3,5,NULL,NULL),(8,4,1,NULL,NULL),(9,4,2,NULL,NULL),(10,4,5,NULL,NULL),(11,5,2,NULL,NULL),(12,5,4,NULL,NULL),(13,5,5,NULL,NULL),(14,6,1,NULL,NULL),(15,6,3,NULL,NULL),(16,6,5,NULL,NULL),(17,7,2,NULL,NULL),(18,7,4,NULL,NULL),(19,7,5,NULL,NULL),(20,8,3,NULL,NULL),(21,9,1,NULL,NULL),(22,9,3,NULL,NULL),(23,9,5,NULL,NULL),(24,10,5,NULL,NULL),(25,2,6,NULL,NULL);
/*!40000 ALTER TABLE `project_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('active','inactive','completed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `creator_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `projects_creator_id_foreign` (`creator_id`),
  CONSTRAINT `projects_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,'Website Redesign','active','2025-03-06 21:01:56','2025-03-06 21:01:56',NULL),(2,'Mobile App Development','active','2025-03-06 21:01:56','2025-03-06 21:01:56',NULL),(3,'Database Migration','completed','2025-03-06 21:01:56','2025-03-06 21:01:56',NULL),(4,'API Integration','active','2025-03-06 21:01:56','2025-03-06 21:01:56',NULL),(5,'Legacy System Maintenance','inactive','2025-03-06 21:01:56','2025-03-06 21:01:56',NULL),(6,'P1','active','2025-03-06 21:32:17','2025-03-06 21:35:45',1),(11,'P3','active','2025-03-07 00:39:16','2025-03-07 00:39:16',1);
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('1UcuGeQOtcDDOdefQdYTGNBaFGdJai5YOztrgvPm',NULL,'127.0.0.1','PostmanRuntime/7.43.0','YTozOntzOjY6Il90b2tlbiI7czo0MDoiSHBCU2R4VDdFNzRYUEVzb0ZCd2V2cmowS3BNb3R6a1RnYmZySE9nSyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1741316161),('nznADD6PqWgFnFLmRpt6MyKH5TzeVqYrYw8pEb0a',NULL,'127.0.0.1','PostmanRuntime/7.43.0','YTozOntzOjY6Il90b2tlbiI7czo0MDoieXZBV0hWcHhobk9nTm95ZjhsWTR4QmdKOGRQUVg1ZUxlcjRJZDliUyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1741323741),('qOj2aRVhROsqmqH1fcQ3OlWr9k4fCOfP6WFZQk5h',NULL,'127.0.0.1','PostmanRuntime/7.43.0','YTozOntzOjY6Il90b2tlbiI7czo0MDoiSGFFS1hvaUZDZ05URzRSbGl5Y2VEME04SHhVZzl5MTJVUUMzOTA4YiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1741332889);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timesheets`
--

DROP TABLE IF EXISTS `timesheets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `timesheets` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `task_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `hours` decimal(5,2) NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `project_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `timesheets_user_id_foreign` (`user_id`),
  KEY `timesheets_project_id_foreign` (`project_id`),
  CONSTRAINT `timesheets_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `timesheets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timesheets`
--

LOCK TABLES `timesheets` WRITE;
/*!40000 ALTER TABLE `timesheets` DISABLE KEYS */;
INSERT INTO `timesheets` VALUES (1,'Development','2025-02-13',3.00,3,5,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(2,'Design','2025-03-07',3.50,4,2,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(3,'Planning','2025-02-10',2.00,6,1,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(4,'Meeting','2025-02-13',7.00,3,5,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(5,'Planning','2025-02-14',6.50,3,5,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(6,'Development','2025-03-03',3.00,7,4,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(7,'Development','2025-02-14',4.50,5,4,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(8,'Planning','2025-03-04',3.00,10,5,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(9,'Documentation','2025-02-12',3.50,7,4,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(10,'Development','2025-02-08',6.00,1,5,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(11,'Planning','2025-02-14',4.50,10,5,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(12,'Deployment','2025-02-14',8.00,8,3,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(13,'Testing','2025-02-19',6.00,2,5,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(14,'Meeting','2025-02-06',7.50,9,3,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(15,'Development','2025-03-03',3.00,2,1,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(16,'Documentation','2025-02-09',3.00,2,5,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(17,'Bug fixing','2025-02-10',8.50,2,1,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(18,'Deployment','2025-02-28',1.00,2,5,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(19,'Planning','2025-02-24',6.50,8,3,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(20,'Development','2025-03-06',2.00,2,3,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(21,'Development','2025-03-04',7.50,9,1,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(22,'Documentation','2025-02-18',8.00,7,5,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(23,'Documentation','2025-03-06',3.00,10,5,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(24,'Research','2025-02-17',3.50,3,1,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(25,'Testing','2025-02-21',5.50,3,5,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(26,'Documentation','2025-03-01',2.00,1,1,'2025-03-06 21:01:56','2025-03-06 21:59:13'),(27,'Deployment','2025-02-23',8.00,2,5,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(28,'Planning','2025-02-08',6.00,9,5,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(29,'Testing','2025-02-21',7.00,2,5,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(30,'Design','2025-02-09',4.50,2,1,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(31,'Development','2025-03-05',5.50,3,1,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(32,'Bug fixing','2025-03-06',2.50,9,3,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(33,'Research','2025-02-08',7.00,4,2,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(34,'Code review','2025-02-10',3.50,7,5,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(35,'Research','2025-02-18',3.50,1,1,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(36,'Planning','2025-03-01',7.00,10,5,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(37,'Testing','2025-02-26',7.00,7,4,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(38,'Deployment','2025-02-14',2.00,8,3,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(39,'Deployment','2025-02-17',4.50,9,3,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(40,'Research','2025-02-16',3.00,10,5,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(41,'Code review','2025-03-01',6.00,10,5,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(42,'Deployment','2025-02-13',8.50,4,1,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(43,'Deployment','2025-02-25',1.00,7,2,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(44,'Testing','2025-03-05',7.00,3,1,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(45,'Code review','2025-03-05',3.00,6,1,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(46,'Planning','2025-02-18',8.50,4,5,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(47,'Development','2025-02-16',4.00,2,3,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(48,'Testing','2025-03-06',1.50,2,3,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(49,'Testing','2025-02-15',1.00,8,3,'2025-03-06 21:01:56','2025-03-06 21:01:56'),(50,'Testing','2025-02-12',8.00,6,3,'2025-03-06 21:01:56','2025-03-06 21:01:56');
/*!40000 ALTER TABLE `timesheets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `creator_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_creator_id_foreign` (`creator_id`),
  CONSTRAINT `users_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin','User','admin@example.com','2025-03-06 21:01:55','$2y$12$7WWBGMM9VuAH5Jn1Bc.vtOSjlebksQn7ARv276Ue.SrojNyEtEV8m','W2yoQUfHWb','2025-03-06 21:01:55','2025-03-06 21:01:55',NULL),(2,'John','Doe','john@example.com','2025-03-06 21:01:55','$2y$12$xbdBdYlK6l2TmVEz8isVwOTErE2mcEvX2I0loHRtAmnJvfUcJzCKe','Rx4AZhlx0x','2025-03-06 21:01:55','2025-03-06 21:01:55',NULL),(3,'Jane','Smith','jane@example.com','2025-03-06 21:01:55','$2y$12$j.QZIBrBB72d1ZZ.5ztfhew/n1f3I/iUfhJAnLIH/IbMqev4GINUC','muMKvtZP3w','2025-03-06 21:01:55','2025-03-06 21:01:55',NULL),(4,'Sierra','Prohaska','garrison61@example.org','2025-03-06 21:01:55','$2y$12$iDpxQuZ.mfPu7dXJupc7GOTK7OIcGDnQCnm34yRBAewQVATASw4PC','nDEJxnEwaL','2025-03-06 21:01:56','2025-03-06 21:01:56',NULL),(5,'Jarrell','Hayes','tfay@example.org','2025-03-06 21:01:56','$2y$12$iDpxQuZ.mfPu7dXJupc7GOTK7OIcGDnQCnm34yRBAewQVATASw4PC','VNVIq6ucwn','2025-03-06 21:01:56','2025-03-06 21:01:56',NULL),(6,'Alva','Johnson','senger.verdie@example.com','2025-03-06 21:01:56','$2y$12$iDpxQuZ.mfPu7dXJupc7GOTK7OIcGDnQCnm34yRBAewQVATASw4PC','x06WbHE1V5','2025-03-06 21:01:56','2025-03-06 21:01:56',NULL),(7,'Kristin','Wolff','qsawayn@example.net','2025-03-06 21:01:56','$2y$12$iDpxQuZ.mfPu7dXJupc7GOTK7OIcGDnQCnm34yRBAewQVATASw4PC','zgJMwO9IFV','2025-03-06 21:01:56','2025-03-06 21:01:56',NULL),(8,'Okey','Upton','wwuckert@example.org','2025-03-06 21:01:56','$2y$12$iDpxQuZ.mfPu7dXJupc7GOTK7OIcGDnQCnm34yRBAewQVATASw4PC','QIvwpHvfyw','2025-03-06 21:01:56','2025-03-06 21:01:56',NULL),(9,'Concepcion','Littel','raynor.jordon@example.com','2025-03-06 21:01:56','$2y$12$iDpxQuZ.mfPu7dXJupc7GOTK7OIcGDnQCnm34yRBAewQVATASw4PC','b6WKCPwXbV','2025-03-06 21:01:56','2025-03-06 21:01:56',NULL),(10,'Alphonso','Bailey','montana76@example.org','2025-03-06 21:01:56','$2y$12$iDpxQuZ.mfPu7dXJupc7GOTK7OIcGDnQCnm34yRBAewQVATASw4PC','UpH5lF4P0E','2025-03-06 21:01:56','2025-03-06 21:01:56',NULL),(11,'shan','ali','shan.ali7722@gmail.com',NULL,'$2y$12$9KnXoFlmFW6UwM4t3pgNQubsXI3aOt1taUCpeTVsQ8wYBOeGS.QMe',NULL,'2025-03-06 21:06:34','2025-03-06 21:06:34',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-07 19:33:47
