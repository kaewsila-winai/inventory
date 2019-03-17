-- phpMyAdmin SQL Dump
-- version 4.6.6
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 13, 2019 at 09:36 AM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.0.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";




-- --------------------------------------------------------
--
-- Table structure for table `{prefix}_language`
--

CREATE TABLE `{prefix}_language` (
  `id` int(11) NOT NULL,
  `key` text COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `owner` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `js` tinyint(1) NOT NULL,
  `th` text COLLATE utf8_unicode_ci,
  `en` text COLLATE utf8_unicode_ci
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `{prefix}_category`
--

CREATE TABLE `{prefix}_category` (
  `id` int(11) UNSIGNED NOT NULL,
  `type` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `category_id` int(11) NOT NULL,
  `topic` varchar(128) CHARACTER SET utf8 NOT NULL,
  `color` varchar(16) CHARACTER SET utf8 DEFAULT NULL,
  `published` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `{prefix}_category`
--

INSERT INTO `{prefix}_category` (`id`, `type`, `category_id`, `topic`, `color`, `published`) VALUES
(1, 'repairstatus', 1, 'แจ้งซ่อม', '#660000', 1),
(2, 'repairstatus', 2, 'กำลังดำเนินการ', '#120eeb', 1),
(3, 'repairstatus', 3, 'รออะไหล่', '#d940ff', 1),
(4, 'repairstatus', 4, 'ซ่อมสำเร็จ', '#06d628', 1),
(5, 'repairstatus', 5, 'ซ่อมไม่สำเร็จ', '#FF0000', 1),
(6, 'repairstatus', 6, 'ยกเลิกการซ่อม', '#FF6F00', 1),
(7, 'repairstatus', 7, 'ส่งมอบเรียบร้อย', '#000000', 1),
(8, 'model_id', 2, 'Asus', '', 1),
(9, 'type_id', 3, 'โปรเจ็คเตอร์', '', 1),
(10, 'type_id', 2, 'เครื่องพิมพ์', '', 1),
(11, 'model_id', 3, 'Cannon', '', 1),
(12, 'category_id', 1, 'เครื่องใช้ไฟฟ้า', '', 1),
(13, 'category_id', 2, 'วัสดุสำนักงาน', '', 1),
(14, 'model_id', 1, 'Apple', '', 1),
(15, 'type_id', 1, 'เครื่องคอมพิวเตอร์', '', 1),
(16, 'model_id', 4, 'ACER', '', 1),
(17, 'type_id', 4, 'จอมอนิเตอร์', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `{prefix}_inventory`
--

CREATE TABLE `{prefix}_inventory` (
  `id` int(11) UNSIGNED NOT NULL,
  `equipment` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `serial` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `type_id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Dumping data for table `{prefix}_inventory`
--

INSERT INTO `{prefix}_inventory` (`id`, `equipment`, `serial`, `create_date`, `type_id`, `model_id`, `category_id`) VALUES
(1, 'จอมอนิเตอร์ ACER S220HQLEBD', '1108-365D', '0000-00-00 00:00:00', 4, 4, 1),
(2, 'ASUS A550JX', '0000-0001', '0000-00-00 00:00:00', 1, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `{prefix}_repair`
--

CREATE TABLE `{prefix}_repair` (
  `id` int(11) UNSIGNED NOT NULL,
  `customer_id` int(11) NOT NULL,
  `inventory_id` int(11) NOT NULL,
  `job_id` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `job_description` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `appointment_date` date DEFAULT NULL,
  `appraiser` decimal(10,2) NOT NULL,
  `repair_no` varchar(50) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `{prefix}_repair_status`
--

CREATE TABLE `{prefix}_repair_status` (
  `id` int(11) NOT NULL,
  `repair_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `operator_id` int(11) NOT NULL,
  `comment` varchar(1000) NOT NULL,
  `member_id` int(11) NOT NULL,
  `create_date` datetime NOT NULL,
  `cost` decimal(10,2) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `{prefix}_user`
--

CREATE TABLE `{prefix}_user` (
  `id` int(11) UNSIGNED NOT NULL,
  `username` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `salt` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0,
  `permission` text COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `sex` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_card` varchar(13) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `provinceID` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `province` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zipcode` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `visited` int(11) UNSIGNED DEFAULT '0',
  `lastvisited` int(11) DEFAULT 0,
  `session_id` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ip` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `social` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `{prefix}_user`
--

INSERT INTO `{prefix}_user` (`id`, `username`, `salt`, `password`, `token`, `status`, `permission`, `name`, `sex`, `id_card`, `address`, `phone`, `provinceID`, `zipcode`, `visited`, `lastvisited`, `session_id`, `ip`, `create_date`, `active`, `social`) VALUES
(1, 'admin@localhost', '5c218d7d9ea4b', '6a397c750a3046e8b9873e9b7dd517bd070ba79c', NULL, 1, ',can_config,can_manage_room,can_approve_room,', 'แอดมิน', 'm', '', '1 หมู่ 1 ตำบล ลาดหญ้า อำเภอ เมือง', '08080808', '102', '71190', 0, 0, '', '::1', NOW(), 1, 0),
(2, 'demo@localhost', '5c13b4c610781', 'd61303ebed15f6448dd3ebadd7e416b5350b4d1d', NULL, 0, '', 'ตัวอย่าง', 'f', '', '', '0123456788', '102', '', 0, 0, '', '::1', NOW(), 1, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `{prefix}_category`
--
ALTER TABLE `{prefix}_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `{prefix}_inventory`
--
ALTER TABLE `{prefix}_inventory`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `{prefix}_language`
--
ALTER TABLE `{prefix}_language`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `{prefix}_repair`
--
ALTER TABLE `{prefix}_repair`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `job_id` (`job_id`);

--
-- Indexes for table `{prefix}_repair_status`
--
ALTER TABLE `{prefix}_repair_status`
  ADD PRIMARY KEY (`id`),
  ADD KEY `repair_id` (`repair_id`);

--
-- Indexes for table `{prefix}_user`
--
ALTER TABLE `{prefix}_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `{prefix}_category`
--
ALTER TABLE `{prefix}_category`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `{prefix}_inventory`
--
ALTER TABLE `{prefix}_inventory`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `{prefix}_language`
--
ALTER TABLE `{prefix}_language`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `{prefix}_repair`
--
ALTER TABLE `{prefix}_repair`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `{prefix}_repair_status`
--
ALTER TABLE `{prefix}_repair_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `{prefix}_user`
--
ALTER TABLE `{prefix}_user`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;