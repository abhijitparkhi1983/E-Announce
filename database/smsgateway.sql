-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 20, 2022 at 07:22 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smsgateway`
--

-- --------------------------------------------------------

--
-- Table structure for table `blacklist`
--

CREATE TABLE `blacklist` (
  `ID` int(11) NOT NULL,
  `number` varchar(16) NOT NULL,
  `userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `ID` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `number` varchar(255) NOT NULL,
  `subscribed` tinyint(1) NOT NULL DEFAULT 1,
  `contactsListID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `contactslist`
--

CREATE TABLE `contactslist` (
  `ID` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `device`
--

CREATE TABLE `device` (
  `ID` int(11) NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `model` varchar(255) NOT NULL,
  `androidVersion` varchar(255) DEFAULT NULL,
  `appVersion` varchar(255) DEFAULT NULL,
  `userID` int(11) NOT NULL,
  `androidID` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  `sharedToAll` tinyint(1) NOT NULL DEFAULT 0,
  `useOwnerSettings` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `device`
--

INSERT INTO `device` (`ID`, `token`, `model`, `androidVersion`, `appVersion`, `userID`, `androidID`, `enabled`, `sharedToAll`, `useOwnerSettings`) VALUES
(1, NULL, 'vivo 1811', '8.1.0', '9.0.2', 1, 'e10e38d2b88c096a', 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `deviceuser`
--

CREATE TABLE `deviceuser` (
  `ID` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `deviceID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `deviceuser`
--

INSERT INTO `deviceuser` (`ID`, `name`, `deviceID`, `userID`, `active`) VALUES
(1, NULL, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `job`
--

CREATE TABLE `job` (
  `ID` int(11) NOT NULL,
  `functionName` varchar(255) NOT NULL,
  `arguments` text NOT NULL,
  `lockName` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE `message` (
  `ID` int(11) NOT NULL,
  `number` varchar(16) NOT NULL,
  `message` text NOT NULL,
  `schedule` bigint(20) DEFAULT NULL,
  `sentDate` datetime NOT NULL,
  `deliveredDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `resultCode` int(11) DEFAULT NULL,
  `errorCode` int(11) DEFAULT NULL,
  `retries` int(11) NOT NULL DEFAULT 0,
  `userID` int(11) NOT NULL,
  `deviceID` int(11) DEFAULT NULL,
  `simSlot` int(11) DEFAULT NULL,
  `groupID` varchar(255) DEFAULT NULL,
  `type` enum('sms','mms') NOT NULL DEFAULT 'sms',
  `attachments` text DEFAULT NULL,
  `prioritize` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `ID` int(11) NOT NULL,
  `status` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL,
  `transactionFee` int(11) NOT NULL,
  `currency` varchar(255) NOT NULL,
  `dateAdded` datetime NOT NULL,
  `userID` int(11) NOT NULL,
  `subscriptionID` int(11) NOT NULL,
  `transactionID` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `plan`
--

CREATE TABLE `plan` (
  `ID` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `credits` int(11) DEFAULT NULL,
  `devices` int(11) DEFAULT NULL,
  `contacts` int(11) DEFAULT NULL,
  `price` int(11) NOT NULL,
  `currency` varchar(255) NOT NULL,
  `frequency` int(11) NOT NULL,
  `frequencyUnit` varchar(255) NOT NULL,
  `totalCycles` int(11) NOT NULL DEFAULT 0,
  `paypalPlanID` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `response`
--

CREATE TABLE `response` (
  `ID` int(11) NOT NULL,
  `message` text NOT NULL,
  `response` text NOT NULL,
  `matchType` tinyint(1) NOT NULL DEFAULT 0,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `setting`
--

CREATE TABLE `setting` (
  `ID` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `setting`
--

INSERT INTO `setting` (`ID`, `name`, `value`) VALUES
(1, 'application_title', 'E-Announce'),
(2, 'application_description', 'Use Your Phone as SMS Gateway'),
(3, 'default_language', 'english'),
(4, 'skin', 'blue'),
(5, 'application_url', 'https://rbsoft.org/downloads/sms-gateway/sms-gateway.apk'),
(6, 'unsubscribe_url', 'http://192.168.254.114/SMS.Gateway.Package/unsubscribe.php'),
(7, 'get_credits_url', 'https://rbsoft.org/downloads/sms-gateway/index.html#section-pricing'),
(8, 'company_name', 'E-Announce'),
(9, 'company_url', 'https://github.com/cepeprecious/E-Announce.git'),
(10, 'from_email_name', ''),
(11, 'from_email_address', ''),
(12, 'smtp_enabled', '0'),
(13, 'register_email_subject', '%app% Admin Panel | Registration Information'),
(14, 'register_email_body', '<p>Hi %user%,</p>\r\n\r\n<p>Welcome to the %app% Admin Panel.</p>\r\n\r\n<p>Your registration has been confirmed and you now have access to %app% Admin Panel.</p>\r\n\r\n<p>\r\nYour Login:<br>\r\nServer: <a href=\"%server%\">%server%</a><br>\r\nEmail: %userEmail%<br>\r\nPassword: %password%<br>\r\n</p>\r\n\r\n<p>You need to download the android app from <a href=\"%appUrl%\">here</a> and enter the above information to get started. If you don\'t know how to sideload apps then you can follow the <a href=\"https://android.gadgethacks.com/how-to/android-basics-enable-unknown-sources-sideload-apps-0161947/\">guide to sideloading apps</a>.</p>\r\n\r\n<p>You can sign in using credentials provided above or you can use the \"SIGN IN USING QR CODE\" button and scan the QR code in the attachment to sign in automatically.</p>\r\n\r\n<p>You have %credits%. You can send messages using %devices%. You can store %contacts%. Your credits are valid until %expiryDate%. If you like to change any of these limits then please contact <a href=\"mailto:%adminEmail%\">%adminEmail%</a>.</p>\r\n\r\n<p>\r\nRegards,<br>\r\n%admin%\r\n</p>'),
(15, 'reset_password_email_subject', '%app% Admin Panel | Reset Password'),
(16, 'reset_password_email_body', '<p>Hi %user%,</p>\r\n    \r\n<p>Your password has been reset successfully. You can log in to %app% Admin Panel using the following credentials.</p>\r\n    \r\n<p>\r\nYour Login:<br>\r\nServer: <a href=\"%server%\">%server%</a><br>       \r\nEmail: %userEmail%<br>\r\nPassword: %password%<br>\r\n</p>\r\n\r\n<p>If you have any questions, please contact <a href=\"mailto:%adminEmail%\">%adminEmail%</a>.</p>\r\n    \r\n<p>\r\nRegards,<br>\r\n%admin%<br>\r\n</p>'),
(17, 'reset_password_link_email_subject', '%app% Admin Panel | Password Reset Link'),
(18, 'reset_password_link_email_body', '<p>Hi %user%,</p>\r\n        \r\n<p>Please use the following link to reset your password. This link will expire after 24 hours.</p>\r\n\r\n<h2><a href=\"%server%/reset-password.php?email=%userEmail%&amp;code=%code%\">Click here to reset your password</a></h2>\r\n        \r\n<p>If you have any questions, please contact <a href=\"mailto:%adminEmail%\">%adminEmail%</a>.</p>\r\n        \r\n<p>\r\nRegards,<br>\r\n%admin%<br>\r\n</p>'),
(19, 'edit_user_subject', '%app% | Updated Limits'),
(20, 'edit_user_email_body', '<p>Hi %user%,</p>\r\n\r\n<p>You have now %credits%. You can send messages using %devices%. You can store %contacts%. Your credits are valid until %expiryDate%.</p>\r\n    \r\n<p>If you have any questions, please contact <a href=\"mailto:%adminEmail%\">%adminEmail%</a>.</p>\r\n    \r\n<p>\r\nRegards,<br>\r\n%admin%<br>\r\n</p>'),
(21, 'registration_enabled', '1'),
(22, 'default_delay', '2'),
(23, 'default_delivery_reports_enabled', '0'),
(24, 'default_use_progressive_queue', '1'),
(25, 'default_auto_retry_enabled', '0'),
(26, 'default_credits', '200'),
(27, 'default_devices_limit', '2'),
(28, 'default_contacts_limit', '200'),
(29, 'default_expire_interval', ''),
(30, 'recaptcha_enabled', '0'),
(31, 'max_retries', '1'),
(32, 'retry_time_interval', ''),
(33, 'footer_text_enabled', '0'),
(34, 'pusher_enabled', '0'),
(35, 'paypal_enabled', '0'),
(36, 'logo_src', 'uploads/4205999.png');

-- --------------------------------------------------------

--
-- Table structure for table `sim`
--

CREATE TABLE `sim` (
  `ID` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  `carrier` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `iccID` varchar(255) DEFAULT NULL,
  `slot` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `deviceID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sim`
--

INSERT INTO `sim` (`ID`, `name`, `number`, `carrier`, `country`, `iccID`, `slot`, `enabled`, `deviceID`) VALUES
(1, 'SIM1', '', 'TM', 'ph', '89634172232116983264', 0, 1, 1),
(2, 'SIM2', '639466590733', 'TNT', 'ph', '89630318255270227213', 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `subscription`
--

CREATE TABLE `subscription` (
  `ID` int(11) NOT NULL,
  `subscribedDate` datetime NOT NULL,
  `expiryDate` datetime NOT NULL,
  `cyclesCompleted` int(11) NOT NULL,
  `status` varchar(255) NOT NULL,
  `paymentMethod` varchar(255) NOT NULL,
  `subscriptionID` varchar(255) DEFAULT NULL,
  `planID` int(11) NOT NULL,
  `userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `template`
--

CREATE TABLE `template` (
  `ID` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `template`
--

INSERT INTO `template` (`ID`, `name`, `message`, `userID`) VALUES
(1, 'Greetings', 'Hello, Good Day!', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `ID` int(11) NOT NULL,
  `name` varchar(70) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `apiKey` char(40) NOT NULL,
  `isAdmin` tinyint(1) NOT NULL DEFAULT 0,
  `primaryDeviceID` int(11) DEFAULT 0,
  `dateAdded` datetime NOT NULL,
  `lastLogin` datetime DEFAULT NULL,
  `delay` varchar(7) NOT NULL DEFAULT '2',
  `webHook` varchar(255) DEFAULT NULL,
  `devicesLimit` int(11) DEFAULT NULL,
  `contactsLimit` int(11) DEFAULT NULL,
  `credits` int(11) DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `timeZone` varchar(255) NOT NULL DEFAULT 'Europe/Berlin',
  `reportDelivery` tinyint(1) NOT NULL DEFAULT 0,
  `autoRetry` tinyint(1) NOT NULL DEFAULT 0,
  `smsToEmail` tinyint(1) NOT NULL DEFAULT 0,
  `useProgressiveQueue` tinyint(1) NOT NULL DEFAULT 1,
  `receivedSmsEmail` varchar(255) DEFAULT NULL,
  `sleepTime` varchar(255) DEFAULT NULL,
  `language` varchar(255) NOT NULL DEFAULT 'english'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`ID`, `name`, `email`, `password`, `apiKey`, `isAdmin`, `primaryDeviceID`, `dateAdded`, `lastLogin`, `delay`, `webHook`, `devicesLimit`, `contactsLimit`, `credits`, `expiryDate`, `timeZone`, `reportDelivery`, `autoRetry`, `smsToEmail`, `useProgressiveQueue`, `receivedSmsEmail`, `sleepTime`, `language`) VALUES
(1, 'Precious Cepe', 'cepeprecious00@gmail.com', '$2y$12$D/T6bBfMtIAyNt07u6tUbu1l3eFLAJQRahWvt8JpMqNead9tiIaWC', '77a2053e6588f400382051ca3a99383ec39e5f20', 1, 0, '2022-09-13 03:13:11', '2022-09-20 07:22:12', '2', NULL, NULL, NULL, NULL, NULL, 'Europe/Berlin', 0, 0, 0, 1, NULL, NULL, 'english');

-- --------------------------------------------------------

--
-- Table structure for table `ussd`
--

CREATE TABLE `ussd` (
  `ID` int(11) NOT NULL,
  `request` varchar(255) NOT NULL,
  `response` text DEFAULT NULL,
  `userID` int(11) NOT NULL,
  `deviceID` int(11) DEFAULT NULL,
  `simSlot` int(11) DEFAULT NULL,
  `sentDate` datetime NOT NULL,
  `responseDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blacklist`
--
ALTER TABLE `blacklist`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `numberUserID` (`number`,`userID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `contactsListID` (`contactsListID`);

--
-- Indexes for table `contactslist`
--
ALTER TABLE `contactslist`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `device`
--
ALTER TABLE `device`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `androidUserID` (`androidID`,`userID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `deviceuser`
--
ALTER TABLE `deviceuser`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `deviceUserID` (`deviceID`,`userID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `job`
--
ALTER TABLE `job`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `userID` (`userID`),
  ADD KEY `deviceID` (`deviceID`),
  ADD KEY `groupID_index` (`groupID`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `transactionID` (`transactionID`),
  ADD KEY `userID` (`userID`),
  ADD KEY `subscriptionID` (`subscriptionID`);

--
-- Indexes for table `plan`
--
ALTER TABLE `plan`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `paypalPlanID` (`paypalPlanID`);

--
-- Indexes for table `response`
--
ALTER TABLE `response`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `setting`
--
ALTER TABLE `setting`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `sim`
--
ALTER TABLE `sim`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `deviceID` (`deviceID`);

--
-- Indexes for table `subscription`
--
ALTER TABLE `subscription`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `subscriptionID` (`subscriptionID`),
  ADD KEY `planID` (`planID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `template`
--
ALTER TABLE `template`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `apiKey` (`apiKey`);

--
-- Indexes for table `ussd`
--
ALTER TABLE `ussd`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `userID` (`userID`),
  ADD KEY `deviceID` (`deviceID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `blacklist`
--
ALTER TABLE `blacklist`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contactslist`
--
ALTER TABLE `contactslist`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `device`
--
ALTER TABLE `device`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `deviceuser`
--
ALTER TABLE `deviceuser`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `job`
--
ALTER TABLE `job`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `message`
--
ALTER TABLE `message`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `plan`
--
ALTER TABLE `plan`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `response`
--
ALTER TABLE `response`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `setting`
--
ALTER TABLE `setting`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `sim`
--
ALTER TABLE `sim`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `subscription`
--
ALTER TABLE `subscription`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `template`
--
ALTER TABLE `template`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ussd`
--
ALTER TABLE `ussd`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `blacklist`
--
ALTER TABLE `blacklist`
  ADD CONSTRAINT `blacklist_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`ID`) ON DELETE CASCADE;

--
-- Constraints for table `contact`
--
ALTER TABLE `contact`
  ADD CONSTRAINT `contact_ibfk_1` FOREIGN KEY (`contactsListID`) REFERENCES `contactslist` (`ID`) ON DELETE CASCADE;

--
-- Constraints for table `contactslist`
--
ALTER TABLE `contactslist`
  ADD CONSTRAINT `contactslist_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`ID`) ON DELETE CASCADE;

--
-- Constraints for table `device`
--
ALTER TABLE `device`
  ADD CONSTRAINT `device_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`ID`) ON DELETE CASCADE;

--
-- Constraints for table `deviceuser`
--
ALTER TABLE `deviceuser`
  ADD CONSTRAINT `deviceuser_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `deviceuser_ibfk_2` FOREIGN KEY (`deviceID`) REFERENCES `device` (`ID`) ON DELETE CASCADE;

--
-- Constraints for table `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `message_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `message_ibfk_2` FOREIGN KEY (`deviceID`) REFERENCES `device` (`ID`) ON DELETE SET NULL;

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`subscriptionID`) REFERENCES `subscription` (`ID`) ON DELETE CASCADE;

--
-- Constraints for table `response`
--
ALTER TABLE `response`
  ADD CONSTRAINT `response_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`ID`) ON DELETE CASCADE;

--
-- Constraints for table `sim`
--
ALTER TABLE `sim`
  ADD CONSTRAINT `sim_ibfk_1` FOREIGN KEY (`deviceID`) REFERENCES `device` (`ID`) ON DELETE CASCADE;

--
-- Constraints for table `subscription`
--
ALTER TABLE `subscription`
  ADD CONSTRAINT `subscription_ibfk_1` FOREIGN KEY (`planID`) REFERENCES `plan` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `subscription_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `user` (`ID`) ON DELETE CASCADE;

--
-- Constraints for table `template`
--
ALTER TABLE `template`
  ADD CONSTRAINT `template_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`ID`) ON DELETE CASCADE;

--
-- Constraints for table `ussd`
--
ALTER TABLE `ussd`
  ADD CONSTRAINT `ussd_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `ussd_ibfk_2` FOREIGN KEY (`deviceID`) REFERENCES `device` (`ID`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
