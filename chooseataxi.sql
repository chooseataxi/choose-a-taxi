-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 17, 2026 at 11:00 PM
-- Server version: 10.11.10-MariaDB-log
-- PHP Version: 8.3.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `chooseataxi`
--

-- --------------------------------------------------------

--
-- Table structure for table `accepted_bookings`
--

CREATE TABLE `accepted_bookings` (
  `id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `driver_id` int(11) DEFAULT NULL,
  `vehicle_id` int(11) DEFAULT NULL,
  `status` enum('Pending','Accepted','In-Progress','Completed','Cancelled') DEFAULT 'Pending',
  `total_fare` decimal(10,2) DEFAULT NULL,
  `commission` decimal(10,2) DEFAULT NULL,
  `payment_status` enum('Pending','Paid') DEFAULT 'Pending',
  `razorpay_order_id` varchar(255) DEFAULT NULL,
  `razorpay_payment_id` varchar(255) DEFAULT NULL,
  `razorpay_signature` varchar(255) DEFAULT NULL,
  `accepted_at` timestamp NULL DEFAULT current_timestamp(),
  `trip_status` enum('Pending','OnWayToPickup','Arrived','Started','Completed') DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `accepted_bookings`
--

INSERT INTO `accepted_bookings` (`id`, `booking_id`, `partner_id`, `driver_id`, `vehicle_id`, `status`, `total_fare`, `commission`, `payment_status`, `razorpay_order_id`, `razorpay_payment_id`, `razorpay_signature`, `accepted_at`, `trip_status`) VALUES
(20, 2627637, 4, 3, NULL, 'Accepted', 100.00, 20.00, 'Paid', NULL, NULL, NULL, '2026-04-22 16:58:35', 'Completed'),
(21, 2627639, 14, 7, NULL, 'Accepted', 100.00, 20.00, 'Paid', NULL, NULL, NULL, '2026-04-24 15:50:35', 'Completed'),
(23, 2627647, 14, 7, NULL, 'Accepted', 1000.00, 200.00, 'Paid', NULL, NULL, NULL, '2026-04-26 07:12:14', 'Completed'),
(33, 2627691, 21, 28, NULL, 'Accepted', 2000.00, 200.00, 'Paid', 'order_SmlCgxE80740Ai', 'pay_SmlDTA9g5rbZ5U', 'da5b7bbc35c97ba5989b13b9c0b0a729013d5d2bffd8e15dc7cf60ac0b8dda83', '2026-05-08 05:50:51', 'Pending'),
(36, 2627695, 21, 28, NULL, 'Accepted', 5800.00, 300.00, 'Paid', 'order_Sn80025Iwz5SWk', 'pay_Sn807Zh6iYVgNA', 'bd06684bc9a2b2c56695816f90233d8a6aed05d036fd7addaeb122d7616bf623', '2026-05-09 04:08:21', 'Pending'),
(37, 2627661, 85, 32, NULL, 'Accepted', 7700.00, 500.00, 'Paid', NULL, NULL, NULL, '2026-05-09 05:09:28', 'Pending'),
(38, 2627697, 21, 28, NULL, 'Cancelled', 4000.00, 500.00, 'Paid', 'order_Sn9EvP56dmqVej', 'pay_Sn9EzqmXbY4xez', '04979dde68160f3ffa2aa9f62a5b265ae67b038fd8fbf70d61b52c2047669bcb', '2026-05-09 05:20:57', 'Pending'),
(58, 2627746, 4, 1, NULL, 'Accepted', 3000.00, 50.00, 'Paid', NULL, NULL, NULL, '2026-05-12 13:20:03', 'Pending'),
(60, 2627751, 28, 48, NULL, 'Accepted', 5500.00, 500.00, 'Paid', NULL, NULL, NULL, '2026-05-12 15:39:49', 'Pending'),
(63, 2627780, 29, 50, NULL, 'Accepted', 4000.00, 400.00, 'Paid', 'order_SpTDoJqOaGc0xU', 'pay_SpTE6LpO43lDbZ', '67c529c1a3566ff38bfb5059455e461d4b81fca42a2162c3b220f895a991834c', '2026-05-15 02:12:00', 'Pending'),
(65, 2627777, 277, 63, NULL, 'Accepted', 6500.00, 500.00, 'Paid', NULL, NULL, NULL, '2026-05-15 10:09:47', 'Pending'),
(66, 2627714, 29, 50, NULL, 'Accepted', 4000.00, 200.00, 'Paid', NULL, NULL, NULL, '2026-05-15 11:19:18', 'Pending'),
(67, 2627787, 313, 65, NULL, 'Accepted', 4000.00, 500.00, 'Paid', 'order_Sph8SKZUYTYgZo', 'pay_Sph8cQloi3FnJI', '5b1befaf6a1d4334e514db39213ada1e4e99c2a5865855663d9a87f259ef8439', '2026-05-15 15:48:34', 'Pending'),
(69, 2627795, 50, 41, NULL, 'Accepted', 5000.00, 200.00, 'Paid', NULL, NULL, NULL, '2026-05-16 09:41:07', 'Pending'),
(70, 2627803, 29, 50, NULL, 'Accepted', 3500.00, 300.00, 'Paid', NULL, NULL, NULL, '2026-05-16 15:36:27', 'Pending'),
(71, 2627827, 277, 60, NULL, 'Accepted', 3200.00, 200.00, 'Paid', 'order_SrCBLaI2EMXUG3', 'pay_SrCBXCFPx6ZIbv', '945ee4f8723ce67a67bbee88357d7c79c6013d575c969caebac32df4797fc17f', '2026-05-19 10:50:02', 'Pending'),
(72, 2627830, 29, 50, NULL, 'Cancelled', 5500.00, 500.00, 'Paid', 'order_SrJcqcYvp3PKCa', 'pay_SrJd5cYkq9Hmdx', 'e6fb9db054f3b899974d8792904bd4f3aeca07b6975c59fce21d74b414b93286', '2026-05-19 18:06:43', 'Pending'),
(73, 2627822, 377, 78, NULL, 'Accepted', 3000.00, 200.00, 'Paid', NULL, NULL, NULL, '2026-05-20 06:34:05', 'Pending'),
(74, 2627841, 29, 50, NULL, 'Accepted', 4150.00, 150.00, 'Paid', NULL, NULL, NULL, '2026-05-21 11:45:25', 'Pending'),
(76, 2627851, 28, 47, NULL, 'Accepted', 4000.00, 800.00, 'Paid', NULL, NULL, NULL, '2026-05-21 14:35:05', 'Pending'),
(77, 2627875, 28, 48, NULL, 'Accepted', 11000.00, 200.00, 'Paid', NULL, NULL, NULL, '2026-06-06 12:27:34', 'Pending'),
(78, 2627891, 65, 68, NULL, 'Accepted', 1780.00, 80.00, 'Paid', NULL, NULL, NULL, '2026-06-09 03:48:06', 'Pending'),
(79, 2627879, 65, 68, NULL, 'Accepted', 1780.00, 80.00, 'Paid', 'order_SzOFmESCHX090O', 'pay_SzOGDKFjJzRRPD', '78afdc24a2c50bbbd7c8a89ac48688c2df7da1c2d3aa6ce786a0a5f0b4f2467f', '2026-06-09 03:50:42', 'Pending'),
(80, 2627920, 28, 47, NULL, 'Accepted', 16200.00, 1000.00, 'Paid', NULL, NULL, NULL, '2026-06-17 10:52:03', 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `mobile`, `profile_picture`, `password`, `created_at`) VALUES
(1, 'choose a taxi', 'admin@chooseataxi.com', '9870315440', './assets/profile_pics/admin_1_1776327240.png', '$2y$10$JBCUg4dEOf4nPzxVN5J74exxcwmOFUstik721VNmNoFnMuQxrAIE.', '2026-03-29 10:42:18');

-- --------------------------------------------------------

--
-- Table structure for table `app_notices`
--

CREATE TABLE `app_notices` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `app_notices`
--

INSERT INTO `app_notices` (`id`, `title`, `content`, `status`, `created_at`) VALUES
(1, 'Important Update For All Partners ', 'Our Application is under development mode so please have patince for the next update to do something great into the mobile application. \r\nits a good news for all the partners to do something good. ', 'inactive', '2026-05-08 20:55:06'),
(2, 'महत्वपूर्ण सूचना सभी पार्टनर्स के लिए 🚀', 'हम आप सभी पार्टनर्स को यह बताना चाहते हैं कि हमारी मोबाइल एप्लिकेशन इस समय Development Mode में है और टीम लगातार नए फीचर्स, बेहतर डिज़ाइन और शानदार सर्विसेस पर काम कर रही है। आने वाले अपडेट्स में आपको कई नए बदलाव और सुविधाएँ देखने को मिलेंगी, जो आपके काम को पहले से ज्यादा आसान, तेज और प्रोफेशनल बनाएंगी।\r\n\r\nइसलिए आप सभी से निवेदन है कि अगले अपडेट तक थोड़ा धैर्य और सहयोग बनाए रखें। हमारी पूरी कोशिश है कि हम आपके लिए एक ऐसा प्लेटफॉर्म तैयार करें जो भविष्य में आपके बिजनेस और ग्रोथ के लिए बहुत फायदेमंद साबित हो।\r\n\r\nयह सभी पार्टनर्स के लिए एक बहुत अच्छी खबर है क्योंकि आने वाले समय में एप्लिकेशन में कई ऐसे फीचर्स जोड़े जाएंगे जिनसे आपकी कमाई, कार्य क्षमता और यूज़र एक्सपीरियंस पहले से कहीं बेहतर होगा।\r\n\r\nहम आपके भरोसे और सपोर्ट के लिए दिल से धन्यवाद करते हैं।\r\nसाथ मिलकर हम कुछ बड़ा और बेहतर बनाने की दिशा में आगे बढ़ रहे हैं। 🚀✨\r\n', 'inactive', '2026-05-08 20:56:29'),
(3, 'जरूरी सूचना ', 'सभी पार्टनर्स अपनी प्रोफाइल को कंप्लीट करके रखें | पार्टनर आईडी में अपनी कैब और ड्राइवर जरूर ऐड करें । बिना कैब और ड्राइवर के आप कोई भी बुकिंग एक्सेप्ट नहीं कर पाएगे ।\r\n\r\n              🙏 धन्यवाद 🙏', 'active', '2026-06-13 18:45:25');

-- --------------------------------------------------------

--
-- Table structure for table `booking_chats`
--

CREATE TABLE `booking_chats` (
  `id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `type` varchar(50) DEFAULT 'text',
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`payload`)),
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `is_read` tinyint(1) DEFAULT 0,
  `quote_status` varchar(20) DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `booking_chats`
--

INSERT INTO `booking_chats` (`id`, `booking_id`, `sender_id`, `receiver_id`, `message`, `type`, `payload`, `created_at`, `is_read`, `quote_status`) VALUES
(124, 2627619, 4, 12, 'hii mohan', 'text', NULL, '2026-04-12 08:36:32', 0, 'active'),
(182, 2627637, 4, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":3,\"driver_name\":\"MOHAMMED YOUNUS\",\"driver_phone\":\"8059982049\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_4_1775329589.jpg\",\"vehicle_id\":5,\"vehicle_model\":\"TATA SIGNA 5530.S BSVI 4X2\",\"vehicle_rc\":\"HR68C5759\",\"vehicle_image\":\"uploads/vehicles/HR68C5759_front_image_1776877390.jpg\"}', '2026-04-22 17:03:21', 1, 'active'),
(184, 2627639, 14, 4, 'hii', 'text', NULL, '2026-04-24 12:41:21', 1, 'active'),
(185, 2627639, 4, 14, 'Proposed Fare: ₹1000 | Commission: ₹200', 'quote_request', '{\"fare\":\"1000\",\"comm\":\"200\"}', '2026-04-24 12:41:48', 1, 'active'),
(186, 2627639, 4, 14, 'Proposed Fare: ₹1000 | Commission: ₹150', 'quote_request', '{\"fare\":\"1000\",\"comm\":\"150\"}', '2026-04-24 12:42:37', 1, 'active'),
(187, 2627639, 4, 14, 'Proposed Fare: ₹1000 | Commission: ₹150', 'quote_request', '{\"fare\":\"1000\",\"comm\":\"150\"}', '2026-04-24 12:42:53', 1, 'active'),
(188, 2627639, 4, 14, 'Proposed Fare: ₹100 | Commission: ₹20', 'quote_request', '{\"fare\":\"100\",\"comm\":\"20\"}', '2026-04-24 12:53:19', 1, 'active'),
(189, 2627639, 4, 14, 'Proposed Fare: ₹500 | Commission: ₹100', 'quote_request', '{\"fare\":\"500\",\"comm\":\"100\"}', '2026-04-24 13:33:35', 1, 'active'),
(190, 2627639, 4, 14, 'Proposed Fare: ₹100 | Commission: ₹20', 'quote_request', '{\"fare\":\"100\",\"comm\":\"20\"}', '2026-04-24 13:34:51', 1, 'active'),
(191, 2627639, 4, 14, 'Proposed Fare: ₹100 | Commission: ₹30', 'quote_request', '{\"fare\":\"100\",\"comm\":\"30\"}', '2026-04-24 13:35:04', 1, 'active'),
(192, 2627639, 4, 14, 'Proposed Fare: ₹400 | Commission: ₹500', 'quote_request', '{\"fare\":\"400\",\"comm\":\"500\"}', '2026-04-24 13:35:25', 1, 'active'),
(193, 2627639, 4, 14, 'Proposed Fare: ₹100 | Commission: ₹20', 'quote_request', '{\"fare\":\"100\",\"comm\":\"20\"}', '2026-04-24 13:35:40', 1, 'active'),
(194, 2627639, 4, 14, 'Proposed Fare: ₹100 | Commission: ₹20', 'quote_request', '{\"fare\":\"100\",\"comm\":\"20\"}', '2026-04-24 13:49:41', 1, 'active'),
(209, 2627647, 14, 4, 'Driver is on the way to Pickup point. Track live here: https://chooseataxi.com/driver-location/track_trip.php?booking_id=2627647', 'tracking_link', NULL, '2026-04-26 11:16:18', 1, 'active'),
(214, 2627647, 14, 4, 'Driver is on the way to Pickup point. Track live here: https://chooseataxi.com/driver-location/track_trip.php?booking_id=2627647', 'tracking_link', NULL, '2026-04-27 19:06:11', 1, 'active'),
(216, 2627653, 4, 14, 'hii', 'text', NULL, '2026-04-27 19:29:47', 1, 'active'),
(217, 2627653, 4, 14, 'hello manish', 'text', NULL, '2026-04-27 19:29:58', 1, 'active'),
(218, 2627653, 14, 4, 'hii', 'text', NULL, '2026-04-27 19:30:17', 1, 'active'),
(219, 2627653, 14, 4, 'can you test the notifications', 'text', NULL, '2026-04-27 19:30:39', 1, 'active'),
(220, 2627653, 14, 4, 'Proposed Fare: ₹100 | Commission: ₹80', 'quote_request', '{\"fare\":\"100\",\"comm\":\"80\"}', '2026-04-27 19:30:59', 1, 'active'),
(221, 2627653, 14, 4, 'hii', 'text', NULL, '2026-04-27 19:31:33', 1, 'active'),
(222, 2627653, 14, 4, 'hello', 'text', NULL, '2026-04-27 19:31:47', 1, 'active'),
(223, 2627653, 14, 4, 'hello', 'text', NULL, '2026-04-27 19:32:06', 1, 'active'),
(224, 2627653, 13, 14, 'hy', 'text', NULL, '2026-04-28 02:58:26', 1, 'active'),
(229, 2627660, 23, 14, 'km limit', 'text', NULL, '2026-05-05 14:09:24', 1, 'active'),
(230, 2627660, 14, 23, 'limit nhi h sir fix h jo bhi h likha huaa h', 'text', NULL, '2026-05-05 18:02:52', 0, 'active'),
(231, 2627667, 21, 14, 'Proposed Fare: ₹2700.00 | Commission: ₹700.00', 'quote_request', '{\"fare\":\"2700.00\",\"comm\":\"700.00\"}', '2026-05-05 19:14:27', 1, 'active'),
(232, 2627667, 21, 14, 'Proposed Fare: ₹2700.00 | Commission: ₹700.00', 'quote_request', '{\"fare\":\"2700.00\",\"comm\":\"700.00\"}', '2026-05-05 19:14:33', 1, 'active'),
(233, 2627667, 21, 14, 'Proposed Fare: ₹2700.00 | Commission: ₹700.00', 'quote_request', '{\"fare\":\"2700.00\",\"comm\":\"700.00\"}', '2026-05-05 19:14:35', 1, 'active'),
(234, 2627667, 21, 14, 'Proposed Fare: ₹2700.00 | Commission: ₹700.00', 'quote_request', '{\"fare\":\"2700.00\",\"comm\":\"700.00\"}', '2026-05-05 19:14:37', 1, 'active'),
(235, 2627667, 21, 14, 'Proposed Fare: ₹2700.00 | Commission: ₹700.00', 'quote_request', '{\"fare\":\"2700.00\",\"comm\":\"700.00\"}', '2026-05-05 19:14:38', 1, 'active'),
(236, 2627667, 21, 14, 'Proposed Fare: ₹2700.00 | Commission: ₹200', 'quote_request', '{\"fare\":\"2700.00\",\"comm\":\"200\"}', '2026-05-05 19:23:45', 1, 'active'),
(237, 2627667, 21, 14, 'Proposed Fare: ₹2700.00 | Commission: ₹200.00', 'quote_request', '{\"fare\":\"2700.00\",\"comm\":\"200.00\"}', '2026-05-05 19:23:57', 1, 'active'),
(238, 2627667, 21, 14, 'Proposed Fare: ₹2700.00 | Commission: ₹200.00', 'quote_request', '{\"fare\":\"2700.00\",\"comm\":\"200.00\"}', '2026-05-05 19:23:59', 1, 'active'),
(239, 2627667, 21, 14, 'Proposed Fare: ₹2700.00 | Commission: ₹200.00', 'quote_request', '{\"fare\":\"2700.00\",\"comm\":\"200.00\"}', '2026-05-05 19:24:00', 1, 'active'),
(240, 2627667, 21, 14, 'Proposed Fare: ₹2700.00 | Commission: ₹200.00', 'quote_request', '{\"fare\":\"2700.00\",\"comm\":\"200.00\"}', '2026-05-05 19:24:01', 1, 'active'),
(241, 2627667, 21, 14, 'Proposed Fare: ₹2700.00 | Commission: ₹200.00', 'quote_request', '{\"fare\":\"2700.00\",\"comm\":\"200.00\"}', '2026-05-05 19:24:03', 1, 'active'),
(242, 2627667, 21, 14, 'Proposed Fare: ₹2700.00 | Commission: ₹200.00', 'quote_request', '{\"fare\":\"2700.00\",\"comm\":\"200.00\"}', '2026-05-05 19:24:05', 1, 'active'),
(243, 2627667, 21, 14, 'Proposed Fare: ₹2700.00 | Commission: ₹200.00', 'quote_request', '{\"fare\":\"2700.00\",\"comm\":\"200.00\"}', '2026-05-05 19:24:08', 1, 'active'),
(244, 2627667, 14, 21, 'sir abhi thoda sa kaam pending h kal tak sahi ho jayega', 'text', NULL, '2026-05-05 19:24:46', 0, 'active'),
(245, 2627673, 25, 13, '3500', 'text', NULL, '2026-05-06 12:01:19', 1, 'active'),
(246, 2627679, 13, 14, 'hello', 'text', NULL, '2026-05-07 05:12:08', 1, 'active'),
(247, 2627664, 13, 14, 'hy', 'text', NULL, '2026-05-07 16:46:59', 1, 'active'),
(248, 2627664, 13, 14, 'hello', 'text', NULL, '2026-05-07 16:47:26', 1, 'active'),
(249, 2627662, 13, 14, 'hello', 'text', NULL, '2026-05-07 16:47:35', 1, 'active'),
(250, 2627664, 4, 14, 'hello', 'text', NULL, '2026-05-07 17:29:14', 1, 'active'),
(251, 2627664, 4, 14, 'helo', 'text', NULL, '2026-05-07 17:31:24', 1, 'active'),
(252, 2627664, 14, 4, 'hello', 'text', NULL, '2026-05-07 17:32:17', 1, 'active'),
(253, 2627664, 14, 4, 'hii', 'text', NULL, '2026-05-07 17:33:26', 1, 'active'),
(254, 2627664, 4, 14, 'hii', 'text', NULL, '2026-05-07 17:33:59', 1, 'active'),
(255, 2627664, 4, 14, 'hello', 'text', NULL, '2026-05-07 17:34:06', 1, 'active'),
(256, 2627664, 4, 14, 'hello', 'text', NULL, '2026-05-07 17:37:12', 1, 'active'),
(257, 2627664, 4, 14, 'hii', 'text', NULL, '2026-05-07 17:38:36', 1, 'active'),
(258, 2627664, 4, 14, 'hello', 'text', NULL, '2026-05-07 17:38:59', 1, 'active'),
(259, 2627664, 4, 14, 'hii', 'text', NULL, '2026-05-07 17:48:12', 1, 'active'),
(260, 2627664, 14, 4, 'hii', 'text', NULL, '2026-05-07 17:48:21', 1, 'active'),
(261, 2627664, 14, 4, 'Proposed Fare: ₹2700 | Commission: ₹700', 'quote_request', '{\"fare\":\"2700\",\"comm\":\"700\"}', '2026-05-07 17:48:24', 1, 'active'),
(262, 2627664, 14, 4, 'hii', 'text', NULL, '2026-05-07 17:49:39', 1, 'active'),
(263, 2627664, 14, 4, 'Proposed Fare: ₹2700 | Commission: ₹500', 'quote_request', '{\"fare\":\"2700\",\"comm\":\"500\"}', '2026-05-07 17:49:57', 1, 'active'),
(264, 2627664, 4, 14, 'hello', 'text', NULL, '2026-05-07 17:50:10', 1, 'active'),
(265, 2627664, 4, 14, 'hii', 'text', NULL, '2026-05-07 18:28:31', 1, 'active'),
(266, 2627664, 14, 4, 'hello', 'text', NULL, '2026-05-07 18:29:50', 1, 'active'),
(267, 2627664, 14, 4, 'hii', 'text', NULL, '2026-05-07 18:30:14', 1, 'active'),
(268, 2627664, 14, 4, 'Proposed Fare: ₹2700 | Commission: ₹500', 'quote_request', '{\"fare\":\"2700\",\"comm\":\"500\"}', '2026-05-07 18:30:22', 1, 'active'),
(269, 2627664, 4, 14, 'hii', 'text', NULL, '2026-05-07 18:30:36', 1, 'active'),
(270, 2627664, 4, 14, 'hii', 'text', NULL, '2026-05-07 18:33:18', 1, 'active'),
(271, 2627664, 4, 14, 'hii', 'text', NULL, '2026-05-07 18:33:38', 1, 'active'),
(272, 2627664, 14, 4, 'hello', 'text', NULL, '2026-05-07 18:33:52', 1, 'active'),
(273, 2627664, 4, 14, 'hello', 'text', NULL, '2026-05-07 18:34:12', 1, 'active'),
(274, 2627664, 4, 14, 'helli', 'text', NULL, '2026-05-07 18:34:21', 1, 'active'),
(275, 2627664, 4, 14, 'hello', 'text', NULL, '2026-05-07 18:34:31', 1, 'active'),
(276, 2627664, 4, 14, 'hii', 'text', NULL, '2026-05-07 18:40:19', 1, 'active'),
(277, 2627664, 14, 4, 'hii', 'text', NULL, '2026-05-07 18:40:47', 1, 'active'),
(278, 2627662, 14, 13, 'hii', 'text', NULL, '2026-05-07 18:40:58', 1, 'active'),
(279, 2627662, 14, 13, 'hello', 'text', NULL, '2026-05-07 18:41:08', 1, 'active'),
(280, 2627664, 14, 4, 'hello', 'text', NULL, '2026-05-07 18:41:12', 1, 'active'),
(281, 2627664, 14, 4, 'hello', 'text', NULL, '2026-05-07 18:43:18', 1, 'active'),
(282, 2627664, 4, 14, 'hii', 'text', NULL, '2026-05-07 18:43:48', 1, 'active'),
(283, 2627664, 4, 14, 'hello', 'text', NULL, '2026-05-07 18:49:06', 1, 'active'),
(284, 2627664, 14, 4, 'hii', 'text', NULL, '2026-05-07 18:49:22', 1, 'active'),
(285, 2627664, 4, 14, 'hii', 'text', NULL, '2026-05-07 18:56:18', 1, 'active'),
(286, 2627664, 14, 4, 'hii', 'text', NULL, '2026-05-07 18:56:57', 1, 'active'),
(287, 2627664, 4, 14, 'hello', 'text', NULL, '2026-05-07 18:57:06', 1, 'active'),
(288, 2627682, 4, 13, 'hii', 'text', NULL, '2026-05-07 19:00:04', 1, 'active'),
(289, 2627682, 13, 4, 'hello', 'text', NULL, '2026-05-07 19:00:20', 1, 'active'),
(290, 2627682, 4, 13, 'hii', 'text', NULL, '2026-05-07 19:00:43', 1, 'active'),
(291, 2627682, 13, 4, 'hii', 'text', NULL, '2026-05-07 19:02:39', 1, 'active'),
(292, 2627682, 4, 13, 'hii', 'text', NULL, '2026-05-07 19:02:53', 1, 'active'),
(293, 2627685, 13, 14, 'hii', 'text', NULL, '2026-05-07 19:05:50', 1, 'active'),
(294, 2627685, 14, 13, 'hello', 'text', NULL, '2026-05-07 19:06:15', 1, 'active'),
(295, 2627682, 13, 4, 'hii', 'text', NULL, '2026-05-07 19:06:46', 1, 'active'),
(296, 2627685, 13, 14, 'hii', 'text', NULL, '2026-05-07 19:06:53', 1, 'active'),
(297, 2627685, 13, 14, 'hii', 'text', NULL, '2026-05-07 19:12:13', 1, 'active'),
(298, 2627685, 13, 14, 'hello', 'text', NULL, '2026-05-07 19:12:43', 1, 'active'),
(299, 2627685, 14, 13, 'hii', 'text', NULL, '2026-05-07 19:13:08', 1, 'active'),
(300, 2627685, 14, 13, 'hii', 'text', NULL, '2026-05-07 19:25:22', 1, 'active'),
(301, 2627662, 13, 14, 'hii', 'text', NULL, '2026-05-07 19:26:17', 1, 'active'),
(302, 2627664, 4, 14, 'hii', 'text', NULL, '2026-05-07 19:26:58', 1, 'active'),
(303, 2627664, 14, 4, 'hello', 'text', NULL, '2026-05-07 19:27:22', 1, 'active'),
(304, 2627664, 14, 4, 'hii', 'text', NULL, '2026-05-07 19:54:33', 1, 'active'),
(305, 2627664, 4, 14, 'hii', 'text', NULL, '2026-05-07 19:54:51', 1, 'active'),
(306, 2627664, 4, 14, 'hii', 'text', NULL, '2026-05-07 19:55:23', 1, 'active'),
(307, 2627664, 14, 4, 'hello', 'text', NULL, '2026-05-07 20:06:38', 1, 'active'),
(308, 2627664, 4, 14, 'hii', 'text', NULL, '2026-05-07 20:06:59', 1, 'active'),
(309, 2627664, 4, 14, 'hii', 'text', NULL, '2026-05-07 20:07:08', 1, 'active'),
(310, 2627664, 4, 14, 'hello', 'text', NULL, '2026-05-07 20:07:16', 1, 'active'),
(311, 2627664, 14, 4, 'hii', 'text', NULL, '2026-05-07 20:07:30', 1, 'active'),
(312, 2627664, 4, 14, 'hii', 'text', NULL, '2026-05-07 20:07:35', 1, 'active'),
(313, 2627664, 4, 14, 'hii', 'text', NULL, '2026-05-07 20:07:58', 1, 'active'),
(314, 2627664, 14, 4, 'hii', 'text', NULL, '2026-05-07 20:17:59', 1, 'active'),
(315, 2627664, 4, 14, 'hii', 'text', NULL, '2026-05-07 20:18:18', 1, 'active'),
(324, 2627664, 14, 4, 'hello', 'text', NULL, '2026-05-07 20:54:20', 1, 'active'),
(327, 2627691, 13, 21, '3 pm Tak niklega customer', 'text', NULL, '2026-05-08 05:53:07', 0, 'active'),
(328, 2627682, 94, 13, 'sar apna contact number de do', 'text', NULL, '2026-05-08 12:44:34', 1, 'active'),
(331, 2627661, 85, 14, 'hlo sir', 'text', NULL, '2026-05-08 18:00:17', 1, 'active'),
(332, 2627695, 95, 13, 'ok done ✅', 'text', NULL, '2026-05-08 18:02:33', 1, 'active'),
(333, 2627695, 95, 13, 'car number DL1ZD8581', 'text', NULL, '2026-05-08 18:02:44', 1, 'active'),
(334, 2627695, 95, 13, 'DEZIRE', 'text', NULL, '2026-05-08 18:02:48', 1, 'active'),
(335, 2627695, 95, 13, '7053932219', 'text', NULL, '2026-05-08 18:03:02', 1, 'active'),
(336, 2627695, 13, 95, 'Proposed Fare: ₹5800 | Commission: ₹300', 'quote_request', '{\"fare\":\"5800\",\"comm\":\"300\"}', '2026-05-08 18:10:45', 1, 'active'),
(337, 2627693, 14, 13, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"7\",\"driver_name\":\"MANISH  KUMAR\",\"driver_phone\":\"8058602516\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_14_1776008819.jpg\",\"vehicle_id\":\"4\",\"vehicle_model\":\"TOUR S STD(O) CNG\",\"vehicle_rc\":\"RJ53TA0074\",\"vehicle_image\":\"uploads/vehicles/RJ53TA0074_front_image_1776008737.jpg\",\"vehicle_images\":[\"uploads/vehicles/RJ53TA0074_front_image_1776008737.jpg\",\"uploads/vehicles/RJ53TA0074_back_image_1776008737.jpg\"]}', '2026-05-08 19:48:32', 1, 'active'),
(338, 2627695, 14, 13, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"7\",\"driver_name\":\"MANISH  KUMAR\",\"driver_phone\":\"8058602516\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_14_1776008819.jpg\",\"vehicle_id\":\"4\",\"vehicle_model\":\"TOUR S STD(O) CNG\",\"vehicle_rc\":\"RJ53TA0074\",\"vehicle_image\":\"uploads/vehicles/RJ53TA0074_front_image_1776008737.jpg\",\"vehicle_images\":[\"uploads/vehicles/RJ53TA0074_front_image_1776008737.jpg\",\"uploads/vehicles/RJ53TA0074_back_image_1776008737.jpg\"]}', '2026-05-08 20:01:27', 1, 'active'),
(339, 2627661, 14, 85, 'ha ji sir', 'text', NULL, '2026-05-08 23:34:34', 1, 'active'),
(340, 2627661, 14, 85, 'btaiye', 'text', NULL, '2026-05-08 23:34:52', 1, 'active'),
(341, 2627661, 85, 14, 'sir je booking confirm hai', 'text', NULL, '2026-05-09 02:48:26', 1, 'active'),
(342, 2627661, 85, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"32\",\"driver_name\":\"ANIKET  BAWA\",\"driver_phone\":\"6239589593\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_85_1778263099.jpg\",\"vehicle_id\":\"17\",\"vehicle_model\":\"XCENT VTVT PRIME T CNG\",\"vehicle_rc\":\"PB01C2250\",\"vehicle_image\":\"uploads/vehicles/PB01C2250_front_image_1778262963.jpg\",\"vehicle_images\":[\"uploads/vehicles/PB01C2250_front_image_1778262963.jpg\",\"uploads/vehicles/PB01C2250_back_image_1778262963.jpg\"]}', '2026-05-09 02:48:32', 1, 'active'),
(343, 2627697, 31, 41, 'dost yah booking aapane Dali hai', 'text', NULL, '2026-05-09 02:54:39', 0, 'active'),
(344, 2627697, 31, 41, 'yah mujhe chahie', 'text', NULL, '2026-05-09 02:54:54', 0, 'active'),
(345, 2627697, 31, 41, 'aap ek bar call kar lo', 'text', NULL, '2026-05-09 02:55:05', 0, 'active'),
(346, 2627697, 31, 41, 'apna number send kar do main baat kar leta Hun', 'text', NULL, '2026-05-09 02:55:21', 0, 'active'),
(347, 2627697, 31, 41, 'please call me', 'text', NULL, '2026-05-09 02:55:36', 0, 'active'),
(348, 2627697, 31, 41, 'my phone number 7292071900 7428731900', 'text', NULL, '2026-05-09 02:56:38', 0, 'active'),
(349, 2627661, 14, 85, 'Proposed Fare: ₹7700 | Commission: ₹500', 'quote_request', '{\"fare\":\"7700\",\"comm\":\"500\"}', '2026-05-09 02:57:24', 1, 'active'),
(352, 2627697, 31, 41, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"35\",\"driver_name\":\"AMAR  KUMAR\",\"driver_phone\":\"7428731900\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_31_1778296806.jpg\",\"vehicle_id\":\"24\",\"vehicle_model\":\"TOUR M CNG\",\"vehicle_rc\":\"DL1ZD2704\",\"vehicle_image\":\"uploads/vehicles/DL1ZD2704_front_image_1778297028.jpg\",\"vehicle_images\":[\"uploads/vehicles/DL1ZD2704_front_image_1778297028.jpg\",\"uploads/vehicles/DL1ZD2704_back_image_1778297028.jpg\"]}', '2026-05-09 04:21:47', 0, 'active'),
(388, 2627703, 41, 14, '400000', 'text', NULL, '2026-05-09 22:28:24', 1, 'active'),
(389, 2627668, 23, 14, '35000', 'text', NULL, '2026-05-10 02:15:43', 1, 'active'),
(390, 2627668, 23, 14, '7din ka h bahi ji', 'text', NULL, '2026-05-10 02:15:52', 1, 'active'),
(391, 2627703, 14, 41, 'soja', 'text', NULL, '2026-05-10 03:44:01', 0, 'active'),
(392, 2627668, 148, 14, 'hlo', 'text', NULL, '2026-05-10 04:31:02', 1, 'active'),
(393, 2627668, 14, 148, 'yes', 'text', NULL, '2026-05-10 05:09:02', 0, 'active'),
(396, 2627703, 167, 14, 'rate kay ha', 'text', NULL, '2026-05-10 07:03:54', 1, 'active'),
(399, 2627668, 170, 14, 'sir kia carens hai chalegi', 'text', NULL, '2026-05-10 10:06:22', 1, 'active'),
(400, 2627668, 14, 170, 'no', 'text', NULL, '2026-05-10 10:22:43', 0, 'active'),
(401, 2627668, 14, 170, 'only Innova crysta', 'text', NULL, '2026-05-10 10:23:18', 0, 'active'),
(432, 2627663, 4, 14, 'hii manish', 'text', NULL, '2026-05-10 14:21:44', 1, 'active'),
(433, 2627663, 14, 4, 'hello', 'text', NULL, '2026-05-10 14:21:55', 1, 'active'),
(434, 2627663, 14, 4, 'can you hear me', 'text', NULL, '2026-05-10 14:22:12', 1, 'active'),
(435, 2627663, 4, 14, 'yes', 'text', NULL, '2026-05-10 14:22:46', 1, 'active'),
(436, 2627663, 14, 4, 'Proposed Fare: ₹4000 | Commission: ₹400', 'quote_request', '{\"fare\":\"4000\",\"comm\":\"400\"}', '2026-05-10 14:22:55', 1, 'active'),
(440, 2627663, 13, 14, 'hy', 'text', NULL, '2026-05-10 15:03:41', 1, 'active'),
(441, 2627704, 13, 14, 'hello a', 'text', NULL, '2026-05-10 15:04:08', 1, 'active'),
(453, 2627704, 13, 14, 'hello', 'text', NULL, '2026-05-10 17:03:15', 1, 'active'),
(454, 2627704, 14, 13, 'hello', 'text', NULL, '2026-05-10 17:04:09', 1, 'active'),
(455, 2627704, 14, 13, 'Proposed Fare: ₹4000 | Commission: ₹50', 'quote_request', '{\"fare\":\"4000\",\"comm\":\"50\"}', '2026-05-10 17:04:51', 1, 'active'),
(458, 2627731, 14, 14, 'hii', 'text', NULL, '2026-05-10 17:44:27', 1, 'active'),
(459, 2627731, 14, 14, 'hello', 'text', NULL, '2026-05-10 17:44:43', 1, 'active'),
(460, 2627731, 14, 14, 'hii', 'text', NULL, '2026-05-10 17:56:24', 1, 'active'),
(461, 2627731, 14, 14, 'hello', 'text', NULL, '2026-05-10 17:57:31', 1, 'active'),
(462, 2627731, 14, 14, 'hello', 'text', NULL, '2026-05-10 18:06:36', 1, 'active'),
(463, 2627731, 14, 14, 'hello', 'text', NULL, '2026-05-10 18:07:05', 1, 'active'),
(464, 2627731, 14, 14, 'hii', 'text', NULL, '2026-05-10 18:22:09', 1, 'active'),
(483, 2627704, 14, 13, 'hello', 'text', NULL, '2026-05-10 19:21:46', 1, 'active'),
(484, 2627704, 13, 14, 'ok', 'text', NULL, '2026-05-10 19:22:10', 1, 'active'),
(487, 2627663, 40, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"39\",\"driver_name\":\"JAGJIT SINGH\",\"driver_phone\":\"9817217571\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_40_1778396716.jpg\",\"vehicle_id\":\"33\",\"vehicle_model\":\"ERTIGA VXI CNG\",\"vehicle_rc\":\"HR57B5977\",\"vehicle_image\":\"uploads/vehicles/HR57B5977_front_image_1778396790.jpg\",\"vehicle_images\":[\"uploads/vehicles/HR57B5977_front_image_1778396790.jpg\",\"uploads/vehicles/HR57B5977_back_image_1778396790.jpg\"]}', '2026-05-11 11:15:00', 1, 'active'),
(488, 2627663, 40, 14, 'call me', 'text', NULL, '2026-05-11 11:15:08', 1, 'active'),
(489, 2627663, 14, 40, 'sir 20 mint pahle lag gyi h gadi', 'text', NULL, '2026-05-11 11:15:37', 0, 'active'),
(490, 2627663, 14, 40, 'kisi ka response hi nhi aya', 'text', NULL, '2026-05-11 11:15:49', 0, 'active'),
(491, 2627737, 188, 14, '5', 'text', NULL, '2026-05-11 16:06:28', 1, 'active'),
(492, 2627737, 188, 14, 'Best price', 'text', NULL, '2026-05-11 16:06:43', 1, 'active'),
(493, 2627737, 14, 188, 'kya 5', 'text', NULL, '2026-05-11 16:06:44', 0, 'active'),
(494, 2627737, 188, 14, 'rupiya', 'text', NULL, '2026-05-11 16:06:52', 1, 'active'),
(495, 2627737, 14, 188, 'ok done', 'text', NULL, '2026-05-11 16:06:57', 0, 'active'),
(496, 2627737, 14, 188, 'gadi bhej de', 'text', NULL, '2026-05-11 16:07:01', 0, 'active'),
(497, 2627737, 14, 188, 'Kolkata', 'text', NULL, '2026-05-11 16:07:11', 0, 'active'),
(498, 2627737, 14, 188, 'hello', 'text', NULL, '2026-05-11 16:08:36', 0, 'active'),
(526, 2627745, 14, 4, 'hii', 'text', NULL, '2026-05-11 19:59:21', 1, 'active'),
(527, 2627745, 4, 14, 'Proposed Fare: ₹10 | Commission: ₹2', 'quote_request', '{\"fare\":\"10\",\"comm\":\"2\"}', '2026-05-11 19:59:41', 1, 'active'),
(528, 2627745, 116, 4, 'hii', 'text', NULL, '2026-05-11 20:00:13', 1, 'active'),
(529, 2627745, 4, 116, 'Proposed Fare: ₹10 | Commission: ₹5', 'quote_request', '{\"fare\":\"10\",\"comm\":\"5\"}', '2026-05-11 20:00:31', 1, 'active'),
(532, 2627746, 14, 13, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"7\",\"driver_name\":\"MANISH  KUMAR\",\"driver_phone\":\"8058602516\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_14_1776008819.jpg\",\"vehicle_id\":\"4\",\"vehicle_model\":\"TOUR S STD(O) CNG\",\"vehicle_rc\":\"RJ53TA0074\",\"vehicle_image\":\"uploads/vehicles/RJ53TA0074_front_image_1776008737.jpg\",\"vehicle_images\":[\"uploads/vehicles/RJ53TA0074_front_image_1776008737.jpg\",\"uploads/vehicles/RJ53TA0074_back_image_1776008737.jpg\"]}', '2026-05-12 04:44:24', 1, 'active'),
(533, 2627746, 14, 13, 'hello', 'text', NULL, '2026-05-12 04:44:57', 1, 'active'),
(534, 2627746, 14, 13, 'ok', 'text', NULL, '2026-05-12 04:45:05', 1, 'active'),
(535, 2627746, 14, 13, 'ok', 'text', NULL, '2026-05-12 04:45:09', 1, 'active'),
(536, 2627746, 14, 13, 'yes', 'text', NULL, '2026-05-12 04:45:15', 1, 'active'),
(537, 2627746, 13, 14, 'Proposed Fare: ₹3000 | Commission: ₹400', 'quote_request', '{\"fare\":\"3000\",\"comm\":\"400\"}', '2026-05-12 04:46:16', 1, 'active'),
(538, 2627746, 4, 13, 'hii', 'text', NULL, '2026-05-12 05:34:04', 1, 'active'),
(539, 2627746, 4, 13, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"1\",\"driver_name\":\"ROSHAN LAL JAT\",\"driver_phone\":\"N/A\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_4_1775329343.jpg\",\"vehicle_id\":\"15\",\"vehicle_model\":\"INNOVA HYCROSS HYBRID VX(8S)\",\"vehicle_rc\":\"HR55BC1321\",\"vehicle_image\":\"uploads/vehicles/HR55BC1321_front_image_1778186580.jpg\",\"vehicle_images\":[\"uploads/vehicles/HR55BC1321_front_image_1778186580.jpg\",\"uploads/vehicles/HR55BC1321_back_image_1778186580.jpg\"]}', '2026-05-12 05:34:08', 1, 'active'),
(540, 2627746, 13, 4, 'Proposed Fare: ₹3000 | Commission: ₹50', 'quote_request', '{\"fare\":\"3000\",\"comm\":\"50\"}', '2026-05-12 05:34:39', 1, 'active'),
(541, 2627746, 4, 13, 'I am sharing my live tracking link soon.', 'text', NULL, '2026-05-12 05:35:19', 1, 'active'),
(544, 2627746, 4, 13, 'hii', 'text', NULL, '2026-05-12 08:37:53', 1, 'active'),
(545, 2627746, 4, 13, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"1\",\"driver_name\":\"ROSHAN LAL JAT\",\"driver_phone\":\"N/A\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_4_1775329343.jpg\",\"vehicle_id\":\"15\",\"vehicle_model\":\"INNOVA HYCROSS HYBRID VX(8S)\",\"vehicle_rc\":\"HR55BC1321\",\"vehicle_image\":\"uploads/vehicles/HR55BC1321_front_image_1778186580.jpg\",\"vehicle_images\":[\"uploads/vehicles/HR55BC1321_front_image_1778186580.jpg\",\"uploads/vehicles/HR55BC1321_back_image_1778186580.jpg\"]}', '2026-05-12 08:38:27', 1, 'active'),
(546, 2627747, 187, 14, 'hi', 'text', NULL, '2026-05-12 09:03:38', 1, 'active'),
(547, 2627747, 187, 14, 'ji', 'text', NULL, '2026-05-12 09:03:40', 1, 'active'),
(548, 2627747, 14, 187, 'yes', 'text', NULL, '2026-05-12 09:03:49', 0, 'active'),
(549, 2627704, 225, 14, 'hi', 'text', NULL, '2026-05-12 10:44:19', 1, 'active'),
(550, 2627668, 225, 14, 'ertiga h new 2026', 'text', NULL, '2026-05-12 10:45:29', 1, 'active'),
(552, 2627704, 14, 225, 'yes', 'text', NULL, '2026-05-12 11:22:25', 1, 'active'),
(553, 2627668, 14, 225, 'sir ji booking Innova Crysta ki h ertiga ki nhi', 'text', NULL, '2026-05-12 11:23:01', 1, 'active'),
(554, 2627746, 21, 13, '3500', 'text', NULL, '2026-05-12 12:59:05', 1, 'active'),
(555, 2627746, 21, 13, '3500', 'text', NULL, '2026-05-12 12:59:08', 1, 'active'),
(556, 2627751, 28, 14, 'accept to nahi ho raha hai', 'text', NULL, '2026-05-12 15:23:36', 1, 'active'),
(557, 2627751, 28, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"48\",\"driver_name\":\"MUKESH KUMAR MANDAL\",\"driver_phone\":\"8920297134\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_28_1778585772.jpg\",\"vehicle_id\":\"42\",\"vehicle_model\":\"TOUR M CNG\",\"vehicle_rc\":\"DL1ZD9277\",\"vehicle_image\":\"uploads/vehicles/DL1ZD9277_front_image_1778585367.jpg\",\"vehicle_images\":[\"uploads/vehicles/DL1ZD9277_front_image_1778585367.jpg\",\"uploads/vehicles/DL1ZD9277_back_image_1778585367.jpg\"]}', '2026-05-12 15:27:49', 1, 'active'),
(558, 2627751, 29, 14, 'how to accept', 'text', NULL, '2026-05-12 15:30:13', 1, 'active'),
(559, 2627751, 14, 29, 'Proposed Fare: ₹5500 | Commission: ₹500', 'quote_request', '{\"fare\":\"5500\",\"comm\":\"500\"}', '2026-05-12 15:31:44', 1, 'active'),
(560, 2627751, 14, 28, 'Proposed Fare: ₹5500 | Commission: ₹500', 'quote_request', '{\"fare\":\"5500\",\"comm\":\"500\"}', '2026-05-12 15:33:53', 1, 'active'),
(561, 2627751, 160, 14, 'bhai kam se kam rate to theek karo yaar parking aur toll donon incluid Hai 5000 mein aadami isase jyada 500 rupaye uthakar Le jaega yaar vah badhiya rahega', 'text', NULL, '2026-05-12 15:35:29', 1, 'active'),
(563, 2627751, 4, 14, 'hii', 'text', NULL, '2026-05-12 15:39:47', 1, 'active'),
(564, 2627751, 4, 14, 'hii', 'text', NULL, '2026-05-12 15:41:09', 1, 'active'),
(570, 2627748, 129, 14, '1500', 'text', NULL, '2026-05-12 17:40:23', 1, 'active'),
(574, 2627748, 95, 14, '20000 done', 'text', NULL, '2026-05-13 01:19:47', 1, 'active'),
(575, 2627755, 14, 13, 'hello', 'text', NULL, '2026-05-13 18:28:40', 1, 'active'),
(576, 2627755, 14, 13, 'hello', 'text', NULL, '2026-05-13 18:28:58', 1, 'active'),
(577, 2627755, 13, 14, 'hello', 'text', NULL, '2026-05-13 18:29:29', 1, 'active'),
(578, 2627755, 13, 14, 'hello', 'text', NULL, '2026-05-13 18:29:42', 1, 'active'),
(579, 2627748, 106, 14, 'hi', 'text', NULL, '2026-05-14 04:37:11', 1, 'active'),
(580, 2627748, 14, 106, 'yes', 'text', NULL, '2026-05-14 04:46:01', 0, 'active'),
(581, 2627765, 40, 14, 'without carrier hai', 'text', NULL, '2026-05-14 05:52:34', 1, 'active'),
(582, 2627765, 40, 14, 'air', 'text', NULL, '2026-05-14 05:52:37', 1, 'active'),
(583, 2627765, 40, 14, 'sir', 'text', NULL, '2026-05-14 05:52:43', 1, 'active'),
(584, 2627765, 14, 40, 'nhi', 'text', NULL, '2026-05-14 05:52:55', 0, 'active'),
(585, 2627765, 14, 40, 'luggage h customer k pas', 'text', NULL, '2026-05-14 05:53:02', 0, 'active'),
(589, 2627763, 13, 14, 'hello', 'text', NULL, '2026-05-14 06:04:05', 1, 'active'),
(596, 2627771, 71, 14, 'ok', 'text', NULL, '2026-05-14 08:57:34', 1, 'active'),
(597, 2627771, 71, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"53\",\"driver_name\":\"RAHUL  YADAV\",\"driver_phone\":\"9599306497\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_71_1778749175.jpg\",\"vehicle_id\":\"51\",\"vehicle_model\":\"PRIME SD 1.2 MT CNG\",\"vehicle_rc\":\"DL1ZD9974\",\"vehicle_image\":\"uploads/vehicles/DL1ZD9974_front_image_1778748782.jpg\",\"vehicle_images\":[\"uploads/vehicles/DL1ZD9974_front_image_1778748782.jpg\",\"uploads/vehicles/DL1ZD9974_back_image_1778748782.jpg\"]}', '2026-05-14 08:59:46', 1, 'active'),
(598, 2627771, 14, 71, 'cariar h', 'text', NULL, '2026-05-14 09:00:54', 0, 'active'),
(599, 2627771, 14, 71, 'sir', 'text', NULL, '2026-05-14 09:00:56', 0, 'active'),
(600, 2627771, 195, 14, 'hii', 'text', NULL, '2026-05-14 09:05:39', 1, 'active'),
(601, 2627771, 14, 195, 'yes', 'text', NULL, '2026-05-14 09:05:52', 1, 'active'),
(602, 2627771, 195, 14, 'night me dizair khali h noida me bhai sab nikalna yarr', 'text', NULL, '2026-05-14 09:06:21', 1, 'active'),
(603, 2627771, 195, 14, 'usko', 'text', NULL, '2026-05-14 09:06:22', 1, 'active'),
(604, 2627771, 195, 14, 'number send kr do apne m message kr dunga', 'text', NULL, '2026-05-14 09:06:40', 1, 'active'),
(605, 2627771, 14, 195, 'jo bhi hmari booking hoti h hm app me hi dal dete h', 'text', NULL, '2026-05-14 09:07:36', 1, 'active'),
(607, 2627767, 252, 14, 'Hi', 'text', NULL, '2026-05-14 09:33:17', 1, 'active'),
(608, 2627767, 252, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"54\",\"driver_name\":\"ANKUR  SINGH\",\"driver_phone\":\"9540173746\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_252_1778750657.jpg\",\"vehicle_id\":\"52\",\"vehicle_model\":\"CARENS D1.5 IMT MDRIVE7\",\"vehicle_rc\":\"HR55AR6271\",\"vehicle_image\":\"uploads/vehicles/HR55AR6271_front_image_1778750783.jpg\",\"vehicle_images\":[\"uploads/vehicles/HR55AR6271_front_image_1778750783.jpg\",\"uploads/vehicles/HR55AR6271_back_image_1778750783.jpg\"]}', '2026-05-14 09:33:41', 1, 'active'),
(609, 2627767, 14, 252, 'ha ji', 'text', NULL, '2026-05-14 09:34:04', 1, 'active'),
(610, 2627767, 14, 252, 'Proposed Fare: ₹3000 | Commission: ₹400', 'quote_request', '{\"fare\":\"3000\",\"comm\":\"400\"}', '2026-05-14 09:34:30', 1, 'active'),
(611, 2627765, 252, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"54\",\"driver_name\":\"ANKUR  SINGH\",\"driver_phone\":\"9540173746\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_252_1778750657.jpg\",\"vehicle_id\":\"53\",\"vehicle_model\":\"TOYOTA RUMION S CNG [MT]\",\"vehicle_rc\":\"UP75CT5879\",\"vehicle_image\":\"uploads/vehicles/UP75CT5879_front_image_1778752508.png\",\"vehicle_images\":[\"uploads/vehicles/UP75CT5879_front_image_1778752508.png\",\"uploads/vehicles/UP75CT5879_back_image_1778752508.png\"]}', '2026-05-14 09:58:44', 1, 'active'),
(612, 2627773, 21, 14, 'kam hai bhai rate', 'text', NULL, '2026-05-14 10:28:42', 1, 'active'),
(613, 2627773, 21, 14, '2800 hona chahiye', 'text', NULL, '2026-05-14 10:29:10', 1, 'active'),
(614, 2627773, 195, 14, 'lag gyyi kya bhai', 'text', NULL, '2026-05-14 11:40:27', 1, 'active'),
(615, 2627773, 195, 14, 'ye', 'text', NULL, '2026-05-14 11:40:28', 1, 'active'),
(616, 2627773, 14, 195, 'available h', 'text', NULL, '2026-05-14 11:41:20', 1, 'active'),
(617, 2627773, 21, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"28\",\"driver_name\":\"SALMAN\",\"driver_phone\":\"7827156364\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_21_1778087490.jpg\",\"vehicle_id\":\"11\",\"vehicle_model\":\"AURA 1.2MT CNG S\",\"vehicle_rc\":\"UP14ST4009\",\"vehicle_image\":\"uploads/vehicles/UP14ST4009_front_image_1778087314.jpg\",\"vehicle_images\":[\"uploads/vehicles/UP14ST4009_front_image_1778087314.jpg\",\"uploads/vehicles/UP14ST4009_back_image_1778087314.jpg\"]}', '2026-05-14 11:48:37', 1, 'active'),
(619, 2627704, 225, 14, '7906222214', 'text', NULL, '2026-05-14 12:18:26', 1, 'active'),
(621, 2627748, 149, 14, 'hi', 'text', NULL, '2026-05-14 14:41:25', 1, 'active'),
(622, 2627748, 149, 14, '8810584922', 'text', NULL, '2026-05-14 14:41:38', 1, 'active'),
(623, 2627748, 14, 149, 'ha ji', 'text', NULL, '2026-05-14 15:01:20', 0, 'active'),
(624, 2627776, 250, 14, 'hi', 'text', NULL, '2026-05-14 15:50:07', 1, 'active'),
(625, 2627777, 21, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"28\",\"driver_name\":\"SALMAN\",\"driver_phone\":\"7827156364\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_21_1778087490.jpg\",\"vehicle_id\":\"11\",\"vehicle_model\":\"AURA 1.2MT CNG S\",\"vehicle_rc\":\"UP14ST4009\",\"vehicle_image\":\"uploads/vehicles/UP14ST4009_front_image_1778087314.jpg\",\"vehicle_images\":[\"uploads/vehicles/UP14ST4009_front_image_1778087314.jpg\",\"uploads/vehicles/UP14ST4009_back_image_1778087314.jpg\"]}', '2026-05-14 15:57:18', 1, 'active'),
(626, 2627777, 21, 14, 'I am sharing my live tracking link soon.', 'text', NULL, '2026-05-14 15:57:49', 1, 'active'),
(627, 2627777, 21, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"28\",\"driver_name\":\"SALMAN\",\"driver_phone\":\"7827156364\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_21_1778087490.jpg\",\"vehicle_id\":\"11\",\"vehicle_model\":\"AURA 1.2MT CNG S\",\"vehicle_rc\":\"UP14ST4009\",\"vehicle_image\":\"uploads/vehicles/UP14ST4009_front_image_1778087314.jpg\",\"vehicle_images\":[\"uploads/vehicles/UP14ST4009_front_image_1778087314.jpg\",\"uploads/vehicles/UP14ST4009_back_image_1778087314.jpg\"]}', '2026-05-14 15:58:08', 1, 'active'),
(628, 2627773, 281, 14, 'hi', 'text', NULL, '2026-05-14 16:02:19', 1, 'active'),
(629, 2627773, 14, 281, 'yes', 'text', NULL, '2026-05-14 16:02:36', 1, 'active'),
(630, 2627776, 14, 250, 'yes', 'text', NULL, '2026-05-14 16:02:46', 0, 'active'),
(631, 2627773, 281, 14, 'bhai sahi h kya ye aap abhi download Kiya cahk kar rha tha', 'text', NULL, '2026-05-14 16:03:59', 1, 'active'),
(632, 2627773, 14, 281, 'bilkul ok h payment sirf app me kijiye', 'text', NULL, '2026-05-14 16:04:20', 1, 'active'),
(633, 2627773, 14, 281, 'kisi ko persnal pr nhi', 'text', NULL, '2026-05-14 16:04:33', 1, 'active'),
(634, 2627773, 281, 14, 'ok bro texi  sanchalak ki jaise h kya', 'text', NULL, '2026-05-14 16:06:17', 1, 'active'),
(635, 2627773, 14, 281, 'yes', 'text', NULL, '2026-05-14 16:09:40', 0, 'active'),
(636, 2627780, 29, 14, 'hello', 'text', NULL, '2026-05-15 01:57:44', 1, 'active'),
(637, 2627780, 29, 14, 'we want to accept booking', 'text', NULL, '2026-05-15 01:57:55', 1, 'active'),
(638, 2627780, 29, 14, 'Driver Ajay Kumar\nvehical RJ 01 TA 5304', 'text', NULL, '2026-05-15 01:58:54', 1, 'active'),
(639, 2627780, 29, 14, 'Ertiga', 'text', NULL, '2026-05-15 01:59:02', 1, 'active'),
(640, 2627780, 14, 29, 'Proposed Fare: ₹4000 | Commission: ₹400', 'quote_request', '{\"fare\":\"4000\",\"comm\":\"400\"}', '2026-05-15 02:02:19', 1, 'paid'),
(641, 2627780, 29, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"50\",\"driver_name\":\"AJAY  KUMAR\",\"driver_phone\":\"8505905903\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_29_1778601771.jpg\",\"vehicle_id\":\"9\",\"vehicle_model\":\"ERTIGA VXI (O) CNG\",\"vehicle_rc\":\"RJ01TA5304\",\"vehicle_image\":\"uploads/vehicles/RJ01TA5304_front_image_1778068849.jpg\",\"vehicle_images\":[\"uploads/vehicles/RJ01TA5304_front_image_1778068849.jpg\",\"uploads/vehicles/RJ01TA5304_back_image_1778068849.jpg\"]}', '2026-05-15 02:11:09', 1, 'active'),
(642, 2627714, 29, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"50\",\"driver_name\":\"AJAY  KUMAR\",\"driver_phone\":\"8505905903\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_29_1778601771.jpg\",\"vehicle_id\":\"9\",\"vehicle_model\":\"ERTIGA VXI (O) CNG\",\"vehicle_rc\":\"RJ01TA5304\",\"vehicle_image\":\"uploads/vehicles/RJ01TA5304_front_image_1778068849.jpg\",\"vehicle_images\":[\"uploads/vehicles/RJ01TA5304_front_image_1778068849.jpg\",\"uploads/vehicles/RJ01TA5304_back_image_1778068849.jpg\"]}', '2026-05-15 02:13:47', 1, 'active'),
(643, 2627668, 176, 14, 'mil jayegi ji', 'text', NULL, '2026-05-15 02:29:12', 1, 'active'),
(644, 2627668, 14, 176, 'Proposed Fare: ₹33000 | Commission: ₹500', 'quote_request', '{\"fare\":\"33000\",\"comm\":\"500\"}', '2026-05-15 02:29:54', 1, 'active'),
(645, 2627704, 88, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"61\",\"driver_name\":\"GULFAN\",\"driver_phone\":\"8813036801\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_88_1778825616.jpg\",\"vehicle_id\":\"62\",\"vehicle_model\":\"ERTIGA VXI (O) CNG\",\"vehicle_rc\":\"HR58E1326\",\"vehicle_image\":\"uploads/vehicles/HR58E1326_front_image_1778824769.jpg\",\"vehicle_images\":[\"uploads/vehicles/HR58E1326_front_image_1778824769.jpg\",\"uploads/vehicles/HR58E1326_back_image_1778824769.jpg\"]}', '2026-05-15 06:14:05', 1, 'active'),
(655, 2627704, 14, 88, 'Proposed Fare: ₹4000 | Commission: ₹150', 'quote_request', '{\"fare\":\"4000\",\"comm\":\"150\"}', '2026-05-15 07:44:58', 0, 'active'),
(663, 2627783, 28, 13, 'private car bhej sakte hai', 'text', NULL, '2026-05-15 08:24:11', 1, 'active'),
(664, 2627783, 13, 28, 'no', 'text', NULL, '2026-05-15 08:24:27', 1, 'active'),
(665, 2627783, 13, 28, 'sir', 'text', NULL, '2026-05-15 08:24:29', 1, 'active'),
(666, 2627783, 13, 28, 'only taxi', 'text', NULL, '2026-05-15 08:24:35', 1, 'active'),
(667, 2627777, 277, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"63\",\"driver_name\":\"JASBIR SINGH DHANOA\",\"driver_phone\":\"8544810908\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_277_1778839509.jpg\",\"vehicle_id\":\"65\",\"vehicle_model\":\"AURA 1.2MT CNG S\",\"vehicle_rc\":\"PB01F5300\",\"vehicle_image\":\"uploads/vehicles/PB01F5300_front_image_1778839397.jpg\",\"vehicle_images\":[\"uploads/vehicles/PB01F5300_front_image_1778839397.jpg\",\"uploads/vehicles/PB01F5300_back_image_1778839397.jpg\"]}', '2026-05-15 10:05:48', 1, 'active'),
(668, 2627777, 14, 277, 'Proposed Fare: ₹6500 | Commission: ₹500', 'quote_request', '{\"fare\":\"6500\",\"comm\":\"500\"}', '2026-05-15 10:06:19', 1, 'paid'),
(669, 2627777, 277, 14, 'plz confirm this duty', 'text', NULL, '2026-05-15 10:06:19', 1, 'active'),
(670, 2627777, 277, 14, 'ok', 'text', NULL, '2026-05-15 10:06:41', 1, 'active'),
(671, 2627780, 14, 29, 'customer number \n8109999484', 'text', NULL, '2026-05-15 10:40:00', 1, 'active'),
(672, 2627668, 36, 14, 'batao main Laga dun', 'text', NULL, '2026-05-15 10:52:11', 1, 'active'),
(673, 2627668, 14, 36, 'apne abhi tk apni I\'d nhi bnai h', 'text', NULL, '2026-05-15 10:54:26', 0, 'active'),
(674, 2627668, 14, 36, 'app ko logout krke apni id complete krlo or gadi & driver add kr lijiye', 'text', NULL, '2026-05-15 11:01:28', 0, 'active'),
(675, 2627780, 29, 14, 'driver Ajay\nnum 8505905903', 'text', NULL, '2026-05-15 11:03:02', 1, 'active'),
(676, 2627780, 29, 14, 'he will call client in some time', 'text', NULL, '2026-05-15 11:03:12', 1, 'active'),
(677, 2627780, 14, 29, 'ok', 'text', NULL, '2026-05-15 11:09:13', 1, 'active'),
(678, 2627714, 14, 29, 'Proposed Fare: ₹4000 | Commission: ₹200', 'quote_request', '{\"fare\":\"4000\",\"comm\":\"200\"}', '2026-05-15 11:18:21', 1, 'paid'),
(679, 2627787, 25, 14, '3800', 'text', NULL, '2026-05-15 12:27:50', 1, 'active'),
(680, 2627787, 25, 14, 'karva do', 'text', NULL, '2026-05-15 12:28:00', 1, 'active'),
(681, 2627782, 135, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"64\",\"driver_name\":\"SATYA  KISHOR\",\"driver_phone\":\"6306573008\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_135_1778848649.jpg\",\"vehicle_id\":\"66\",\"vehicle_model\":\"SWIFT DZIRE LXI\",\"vehicle_rc\":\"HR55AB9798\",\"vehicle_image\":\"uploads/vehicles/HR55AB9798_front_image_1778848971.jpg\",\"vehicle_images\":[\"uploads/vehicles/HR55AB9798_front_image_1778848971.jpg\",\"uploads/vehicles/HR55AB9798_back_image_1778848971.jpg\"]}', '2026-05-15 12:43:23', 1, 'active'),
(682, 2627782, 14, 135, '?', 'text', NULL, '2026-05-15 12:55:48', 0, 'active'),
(683, 2627787, 14, 25, 'rate yahi h', 'text', NULL, '2026-05-15 12:56:04', 0, 'active'),
(684, 2627787, 313, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"65\",\"driver_name\":\"GAUTAM SINGH\",\"driver_phone\":\"9810260519\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_313_1778859651.jpg\",\"vehicle_id\":\"67\",\"vehicle_model\":\"TOUR S CNG\",\"vehicle_rc\":\"DL1ZD7312\",\"vehicle_image\":\"uploads/vehicles/DL1ZD7312_front_image_1778859760.jpg\",\"vehicle_images\":[\"uploads/vehicles/DL1ZD7312_front_image_1778859760.jpg\",\"uploads/vehicles/DL1ZD7312_back_image_1778859760.jpg\"]}', '2026-05-15 15:43:25', 1, 'active'),
(685, 2627787, 14, 313, 'Proposed Fare: ₹4000 | Commission: ₹500', 'quote_request', '{\"fare\":\"4000\",\"comm\":\"500\"}', '2026-05-15 15:43:44', 1, 'paid'),
(686, 2627787, 313, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"65\",\"driver_name\":\"GAUTAM SINGH\",\"driver_phone\":\"9810260519\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_313_1778859651.jpg\",\"vehicle_id\":\"67\",\"vehicle_model\":\"TOUR S CNG\",\"vehicle_rc\":\"DL1ZD7312\",\"vehicle_image\":\"uploads/vehicles/DL1ZD7312_front_image_1778859760.jpg\",\"vehicle_images\":[\"uploads/vehicles/DL1ZD7312_front_image_1778859760.jpg\",\"uploads/vehicles/DL1ZD7312_back_image_1778859760.jpg\"]}', '2026-05-15 15:44:48', 1, 'active'),
(687, 2627787, 313, 14, 'customer location mobile no', 'text', NULL, '2026-05-15 15:49:25', 1, 'active'),
(688, 2627787, 14, 313, 'wait', 'text', NULL, '2026-05-15 15:49:40', 1, 'active'),
(689, 2627787, 14, 313, 'customer number \n+91 93111 21611', 'text', NULL, '2026-05-15 15:50:55', 1, 'active'),
(690, 2627787, 313, 14, 'details bhej do', 'text', NULL, '2026-05-15 15:55:31', 1, 'active'),
(691, 2627787, 14, 313, 'customer number send kr to diye sir apko location mnga Krna ap sector 31 h gurgaon', 'text', NULL, '2026-05-15 16:06:01', 1, 'active'),
(693, 2627765, 95, 14, 'hlo', 'text', NULL, '2026-05-16 01:38:17', 1, 'active'),
(694, 2627765, 95, 14, 'bhai', 'text', NULL, '2026-05-16 01:38:19', 1, 'active'),
(695, 2627765, 95, 14, 'give me your number', 'text', NULL, '2026-05-16 01:38:28', 1, 'active'),
(696, 2627765, 14, 95, 'why', 'text', NULL, '2026-05-16 01:44:15', 1, 'active'),
(697, 2627765, 95, 14, 'gaadi mil jayegi aapo zero commission par abhi', 'text', NULL, '2026-05-16 01:47:09', 1, 'active'),
(698, 2627765, 95, 14, 'kia carens 7seater me', 'text', NULL, '2026-05-16 01:47:24', 1, 'active'),
(699, 2627765, 95, 14, '16000 fix', 'text', NULL, '2026-05-16 01:47:35', 1, 'active'),
(700, 2627765, 95, 14, 'agar agree ho to done ✅ karie 7053932219', 'text', NULL, '2026-05-16 01:48:04', 1, 'active'),
(701, 2627796, 95, 14, 'km limit or timeing Hour Rs', 'text', NULL, '2026-05-16 06:23:58', 1, 'active'),
(702, 2627796, 95, 14, '?', 'text', NULL, '2026-05-16 06:24:02', 1, 'active'),
(703, 2627795, 95, 14, 'km limit extra toll tax', 'text', NULL, '2026-05-16 06:24:52', 1, 'active'),
(704, 2627795, 95, 14, 'night', 'text', NULL, '2026-05-16 06:24:57', 1, 'active'),
(705, 2627797, 95, 14, 'price', 'text', NULL, '2026-05-16 06:25:14', 1, 'active'),
(706, 2627797, 14, 95, 'jab apke pas ertiga nhi to Bina wjah kyu msg krte ho', 'text', NULL, '2026-05-16 06:27:03', 1, 'active'),
(707, 2627796, 14, 95, '8500 all including', 'text', NULL, '2026-05-16 06:27:26', 1, 'active'),
(708, 2627797, 95, 14, 'bhai he but mension nahi kiya hu pese achhe mile tab na', 'text', NULL, '2026-05-16 06:28:34', 1, 'active'),
(709, 2627796, 95, 14, 'bahar kahi nahi jayega na only gurgaon me rehga na', 'text', NULL, '2026-05-16 06:29:30', 1, 'active'),
(710, 2627796, 95, 14, 'night nahi he', 'text', NULL, '2026-05-16 06:29:36', 1, 'active'),
(711, 2627796, 95, 14, 'sath me toll hona chahiye or km extra', 'text', NULL, '2026-05-16 06:31:04', 1, 'active'),
(712, 2627796, 276, 14, 'kya duty h ye', 'text', NULL, '2026-05-16 06:57:14', 1, 'active'),
(713, 2627797, 160, 14, '5500 per day', 'text', NULL, '2026-05-16 07:01:48', 1, 'active'),
(714, 2627797, 160, 14, '9718770501', 'text', NULL, '2026-05-16 07:01:56', 1, 'active'),
(715, 2627796, 14, 276, 'lga di h bahr se', 'text', NULL, '2026-05-16 07:21:44', 1, 'active'),
(716, 2627795, 294, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"66\",\"driver_name\":\"RINKU  KUMAR\",\"driver_phone\":\"9711459781\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_294_1778912366.jpg\",\"vehicle_id\":\"70\",\"vehicle_model\":\"AURA 1.2MT CNG S\",\"vehicle_rc\":\"UP14RT8731\",\"vehicle_image\":\"uploads/vehicles/UP14RT8731_front_image_1778916747.jpg\",\"vehicle_images\":[\"uploads/vehicles/UP14RT8731_front_image_1778916747.jpg\",\"uploads/vehicles/UP14RT8731_back_image_1778916747.jpg\"]}', '2026-05-16 07:37:05', 1, 'active'),
(717, 2627795, 14, 294, 'Proposed Fare: ₹5000 | Commission: ₹200', 'quote_request', '{\"fare\":\"5000\",\"comm\":\"200\"}', '2026-05-16 07:37:29', 0, 'expired'),
(718, 2627795, 21, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"28\",\"driver_name\":\"SALMAN\",\"driver_phone\":\"7827156364\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_21_1778087490.jpg\",\"vehicle_id\":\"71\",\"vehicle_model\":\"AURA 1.2MT CNG S\",\"vehicle_rc\":\"UP14RT8489\",\"vehicle_image\":\"uploads/vehicles/UP14RT8489_front_image_1778919765.jpg\",\"vehicle_images\":[\"uploads/vehicles/UP14RT8489_front_image_1778919765.jpg\",\"uploads/vehicles/UP14RT8489_back_image_1778919765.jpg\"]}', '2026-05-16 08:23:00', 1, 'active'),
(719, 2627795, 50, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"41\",\"driver_name\":\"RAMAVATAR  SAINI\",\"driver_phone\":\"9783074132\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_50_1778409011.jpg\",\"vehicle_id\":\"37\",\"vehicle_model\":\"ERTIGA VXI (O) CNG\",\"vehicle_rc\":\"HR66C4142\",\"vehicle_image\":\"uploads/vehicles/HR66C4142_front_image_1778409310.jpg\",\"vehicle_images\":[\"uploads/vehicles/HR66C4142_front_image_1778409310.jpg\",\"uploads/vehicles/HR66C4142_back_image_1778409310.jpg\"]}', '2026-05-16 09:07:32', 1, 'active'),
(720, 2627795, 14, 50, 'ertiga ka pdta nhi aayega', 'text', NULL, '2026-05-16 09:08:55', 1, 'active'),
(722, 2627795, 50, 14, 'swift Dzire 24', 'text', NULL, '2026-05-16 09:15:24', 1, 'active'),
(723, 2627795, 50, 14, 'h', 'text', NULL, '2026-05-16 09:15:25', 1, 'active'),
(743, 2627803, 29, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"50\",\"driver_name\":\"AJAY  KUMAR\",\"driver_phone\":\"8505905903\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_29_1778601771.jpg\",\"vehicle_id\":\"9\",\"vehicle_model\":\"ERTIGA VXI (O) CNG\",\"vehicle_rc\":\"RJ01TA5304\",\"vehicle_image\":\"uploads/vehicles/RJ01TA5304_front_image_1778068849.jpg\",\"vehicle_images\":[\"uploads/vehicles/RJ01TA5304_front_image_1778068849.jpg\",\"uploads/vehicles/RJ01TA5304_back_image_1778068849.jpg\"]}', '2026-05-16 15:36:21', 1, 'active'),
(744, 2627803, 29, 14, 'Client number please', 'text', NULL, '2026-05-17 01:27:13', 1, 'active'),
(745, 2627755, 21, 13, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"28\",\"driver_name\":\"SALMAN\",\"driver_phone\":\"7827156364\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_21_1778087490.jpg\",\"vehicle_id\":\"11\",\"vehicle_model\":\"AURA 1.2MT CNG S\",\"vehicle_rc\":\"UP14ST4009\",\"vehicle_image\":\"uploads/vehicles/UP14ST4009_front_image_1778087314.jpg\",\"vehicle_images\":[\"uploads/vehicles/UP14ST4009_front_image_1778087314.jpg\",\"uploads/vehicles/UP14ST4009_back_image_1778087314.jpg\"]}', '2026-05-17 02:09:32', 1, 'active'),
(746, 2627803, 14, 29, '6371506683', 'text', NULL, '2026-05-17 02:45:57', 0, 'active'),
(747, 2627755, 13, 21, 'Proposed Fare: ₹1000 | Commission: ₹50', 'quote_request', '{\"fare\":\"1000\",\"comm\":\"50\"}', '2026-05-17 03:01:02', 0, 'active'),
(748, 2627782, 336, 14, 'aaj ki duty hai kya', 'text', NULL, '2026-05-17 07:43:04', 1, 'active'),
(749, 2627782, 336, 14, 'link Dal do', 'text', NULL, '2026-05-17 07:43:09', 1, 'active'),
(750, 2627782, 14, 336, 'sir date likhi hui h 5 tarik ki h next month me', 'text', NULL, '2026-05-17 07:43:45', 1, 'active'),
(751, 2627782, 336, 14, 'ok sir', 'text', NULL, '2026-05-17 07:44:23', 1, 'active'),
(752, 2627788, 21, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"28\",\"driver_name\":\"SALMAN\",\"driver_phone\":\"7827156364\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_21_1778087490.jpg\",\"vehicle_id\":\"11\",\"vehicle_model\":\"AURA 1.2MT CNG S\",\"vehicle_rc\":\"UP14ST4009\",\"vehicle_image\":\"uploads/vehicles/UP14ST4009_front_image_1778087314.jpg\",\"vehicle_images\":[\"uploads/vehicles/UP14ST4009_front_image_1778087314.jpg\",\"uploads/vehicles/UP14ST4009_back_image_1778087314.jpg\"]}', '2026-05-17 13:47:47', 1, 'active'),
(753, 2627788, 14, 21, 'Proposed Fare: ₹2500 | Commission: ₹500', 'quote_request', '{\"fare\":\"2500\",\"comm\":\"500\"}', '2026-05-17 13:48:11', 1, 'active'),
(754, 2627771, 71, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"53\",\"driver_name\":\"RAHUL  YADAV\",\"driver_phone\":\"9599306497\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_71_1778749175.jpg\",\"vehicle_id\":\"51\",\"vehicle_model\":\"PRIME SD 1.2 MT CNG\",\"vehicle_rc\":\"DL1ZD9974\",\"vehicle_image\":\"uploads/vehicles/DL1ZD9974_front_image_1778748782.jpg\",\"vehicle_images\":[\"uploads/vehicles/DL1ZD9974_front_image_1778748782.jpg\",\"uploads/vehicles/DL1ZD9974_back_image_1778748782.jpg\"]}', '2026-05-17 17:50:45', 1, 'active'),
(755, 2627771, 71, 14, 'with career neat nd clean car', 'text', NULL, '2026-05-17 17:51:41', 1, 'active'),
(756, 2627771, 71, 14, '9599306497 call me if confirm', 'text', NULL, '2026-05-17 17:53:01', 1, 'active'),
(757, 2627788, 57, 14, 'hii', 'text', NULL, '2026-05-18 00:12:11', 1, 'active'),
(758, 2627788, 14, 57, 'yes', 'text', NULL, '2026-05-18 00:41:29', 0, 'active'),
(759, 2627771, 21, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"28\",\"driver_name\":\"SALMAN\",\"driver_phone\":\"7827156364\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_21_1778087490.jpg\",\"vehicle_id\":\"11\",\"vehicle_model\":\"AURA 1.2MT CNG S\",\"vehicle_rc\":\"UP14ST4009\",\"vehicle_image\":\"uploads/vehicles/UP14ST4009_front_image_1778087314.jpg\",\"vehicle_images\":[\"uploads/vehicles/UP14ST4009_front_image_1778087314.jpg\",\"uploads/vehicles/UP14ST4009_back_image_1778087314.jpg\"]}', '2026-05-18 01:53:31', 1, 'active');
INSERT INTO `booking_chats` (`id`, `booking_id`, `sender_id`, `receiver_id`, `message`, `type`, `payload`, `created_at`, `is_read`, `quote_status`) VALUES
(760, 2627771, 21, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"28\",\"driver_name\":\"SALMAN\",\"driver_phone\":\"7827156364\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_21_1778087490.jpg\",\"vehicle_id\":\"11\",\"vehicle_model\":\"AURA 1.2MT CNG S\",\"vehicle_rc\":\"UP14ST4009\",\"vehicle_image\":\"uploads/vehicles/UP14ST4009_front_image_1778087314.jpg\",\"vehicle_images\":[\"uploads/vehicles/UP14ST4009_front_image_1778087314.jpg\",\"uploads/vehicles/UP14ST4009_back_image_1778087314.jpg\"]}', '2026-05-18 01:53:34', 1, 'active'),
(761, 2627788, 53, 14, 'Aaj Subah Ki Hai Ya Sham ke ho to bolo main Lekar a Jaunga', 'text', NULL, '2026-05-18 02:30:52', 1, 'active'),
(762, 2627788, 14, 53, 'abhi ka h sir', 'text', NULL, '2026-05-18 02:37:47', 0, 'active'),
(763, 2627782, 212, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"74\",\"driver_name\":\"ANAS  WARSI\",\"driver_phone\":\"9654730050\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_212_1779066587.jpg\",\"vehicle_id\":\"68\",\"vehicle_model\":\"TOUR S CNG\",\"vehicle_rc\":\"UP25FT9896\",\"vehicle_image\":\"uploads/vehicles/UP25FT9896_front_image_1778909938.jpg\",\"vehicle_images\":[\"uploads/vehicles/UP25FT9896_front_image_1778909938.jpg\",\"uploads/vehicles/UP25FT9896_back_image_1778909938.jpg\"]}', '2026-05-18 07:07:33', 1, 'active'),
(764, 2627782, 14, 212, 'Proposed Fare: ₹6000 | Commission: ₹300', 'quote_request', '{\"fare\":\"6000\",\"comm\":\"300\"}', '2026-05-18 08:24:30', 0, 'active'),
(765, 2627820, 276, 14, 'no bhejo', 'text', NULL, '2026-05-18 17:06:53', 1, 'active'),
(766, 2627820, 14, 276, 'btaiye sir kya puchna h', 'text', NULL, '2026-05-18 17:07:17', 0, 'active'),
(767, 2627820, 276, 14, 'kuch badh jayga kya', 'text', NULL, '2026-05-18 17:07:34', 1, 'active'),
(768, 2627820, 14, 276, 'nhi sir rate galt nhi h', 'text', NULL, '2026-05-18 17:07:45', 0, 'active'),
(769, 2627820, 14, 276, 'log 4500 dalte h delhi to mussoorie', 'text', NULL, '2026-05-18 17:08:00', 0, 'active'),
(770, 2627820, 29, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"50\",\"driver_name\":\"AJAY  KUMAR\",\"driver_phone\":\"8505905903\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_29_1778601771.jpg\",\"vehicle_id\":\"9\",\"vehicle_model\":\"ERTIGA VXI (O) CNG\",\"vehicle_rc\":\"RJ01TA5304\",\"vehicle_image\":\"uploads/vehicles/RJ01TA5304_front_image_1778068849.jpg\",\"vehicle_images\":[\"uploads/vehicles/RJ01TA5304_front_image_1778068849.jpg\",\"uploads/vehicles/RJ01TA5304_back_image_1778068849.jpg\"]}', '2026-05-18 17:45:59', 1, 'active'),
(771, 2627820, 14, 29, 'sir ji lga di h 15 mint pahle hi', 'text', NULL, '2026-05-18 17:46:30', 0, 'active'),
(772, 2627820, 14, 29, 'accept mt kro', 'text', NULL, '2026-05-18 17:46:35', 0, 'active'),
(773, 2627820, 29, 14, 'ok sir', 'text', NULL, '2026-05-18 17:46:42', 1, 'active'),
(774, 2627820, 14, 29, 'delete kr rha hoo', 'text', NULL, '2026-05-18 17:46:46', 0, 'active'),
(775, 2627820, 14, 29, 'kafi time se pdi thi kisi ne accept nhi ki', 'text', NULL, '2026-05-18 17:47:05', 0, 'active'),
(776, 2627756, 24, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"9\",\"driver_name\":\"AKHILESH KUMAR PATEL\",\"driver_phone\":\"9643324332\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_24_1778050020.jpg\",\"vehicle_id\":\"6\",\"vehicle_model\":\"INNOVA CRYSTA 2.4G (GX+, MT)\",\"vehicle_rc\":\"HR55BB0491\",\"vehicle_image\":\"uploads/vehicles/HR55BB0491_front_image_1778049818.jpg\",\"vehicle_images\":[\"uploads/vehicles/HR55BB0491_front_image_1778049818.jpg\",\"uploads/vehicles/HR55BB0491_back_image_1778049818.jpg\"]}', '2026-05-18 18:09:53', 1, 'active'),
(777, 2627756, 24, 14, 'koi km limit nahi hai kya', 'text', NULL, '2026-05-18 18:10:06', 1, 'active'),
(780, 2627756, 14, 24, 'no', 'text', NULL, '2026-05-18 18:43:55', 0, 'active'),
(781, 2627822, 95, 14, 'toll to alag se hona chahiye tha bhai', 'text', NULL, '2026-05-19 00:16:05', 1, 'active'),
(782, 2627822, 95, 14, '3500 fix ho', 'text', NULL, '2026-05-19 00:16:34', 1, 'active'),
(783, 2627821, 95, 13, 'km limit?', 'text', NULL, '2026-05-19 00:28:14', 1, 'active'),
(784, 2627821, 95, 13, 'Rs', 'text', NULL, '2026-05-19 00:28:19', 1, 'active'),
(785, 2627821, 13, 95, 'upr dikh na rhe k bhai sahb 4000 mote mote aksharo me', 'text', NULL, '2026-05-19 01:53:59', 1, 'active'),
(786, 2627825, 294, 13, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"66\",\"driver_name\":\"RINKU  KUMAR\",\"driver_phone\":\"9711459781\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_294_1778912366.jpg\",\"vehicle_id\":\"70\",\"vehicle_model\":\"AURA 1.2MT CNG S\",\"vehicle_rc\":\"UP14RT8731\",\"vehicle_image\":\"uploads/vehicles/UP14RT8731_front_image_1778916747.jpg\",\"vehicle_images\":[\"uploads/vehicles/UP14RT8731_front_image_1778916747.jpg\",\"uploads/vehicles/UP14RT8731_back_image_1778916747.jpg\"]}', '2026-05-19 04:33:40', 1, 'active'),
(787, 2627825, 13, 294, 'cariar h sir ?', 'text', NULL, '2026-05-19 04:39:39', 0, 'active'),
(788, 2627825, 95, 13, 'km limit', 'text', NULL, '2026-05-19 05:09:05', 1, 'active'),
(789, 2627825, 21, 13, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"28\",\"driver_name\":\"SALMAN\",\"driver_phone\":\"7827156364\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_21_1778087490.jpg\",\"vehicle_id\":\"11\",\"vehicle_model\":\"AURA 1.2MT CNG S\",\"vehicle_rc\":\"UP14ST4009\",\"vehicle_image\":\"uploads/vehicles/UP14ST4009_front_image_1778087314.jpg\",\"vehicle_images\":[\"uploads/vehicles/UP14ST4009_front_image_1778087314.jpg\",\"uploads/vehicles/UP14ST4009_back_image_1778087314.jpg\"]}', '2026-05-19 05:25:53', 1, 'active'),
(790, 2627812, 85, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"32\",\"driver_name\":\"ANIKET  BAWA\",\"driver_phone\":\"6239589593\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_85_1778263099.jpg\",\"vehicle_id\":\"17\",\"vehicle_model\":\"XCENT VTVT PRIME T CNG\",\"vehicle_rc\":\"PB01C2250\",\"vehicle_image\":\"uploads/vehicles/PB01C2250_front_image_1778262963.jpg\",\"vehicle_images\":[\"uploads/vehicles/PB01C2250_front_image_1778262963.jpg\",\"uploads/vehicles/PB01C2250_back_image_1778262963.jpg\"]}', '2026-05-19 05:50:14', 1, 'active'),
(791, 2627812, 85, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"32\",\"driver_name\":\"ANIKET  BAWA\",\"driver_phone\":\"6239589593\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_85_1778263099.jpg\",\"vehicle_id\":\"17\",\"vehicle_model\":\"XCENT VTVT PRIME T CNG\",\"vehicle_rc\":\"PB01C2250\",\"vehicle_image\":\"uploads/vehicles/PB01C2250_front_image_1778262963.jpg\",\"vehicle_images\":[\"uploads/vehicles/PB01C2250_front_image_1778262963.jpg\",\"uploads/vehicles/PB01C2250_back_image_1778262963.jpg\"]}', '2026-05-19 05:50:38', 1, 'active'),
(792, 2627812, 14, 85, 'Proposed Fare: ₹1400 | Commission: ₹100', 'quote_request', '{\"fare\":\"1400\",\"comm\":\"100\"}', '2026-05-19 05:52:52', 1, 'active'),
(793, 2627825, 21, 13, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"28\",\"driver_name\":\"SALMAN\",\"driver_phone\":\"7827156364\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_21_1778087490.jpg\",\"vehicle_id\":\"11\",\"vehicle_model\":\"AURA 1.2MT CNG S\",\"vehicle_rc\":\"UP14ST4009\",\"vehicle_image\":\"uploads/vehicles/UP14ST4009_front_image_1778087314.jpg\",\"vehicle_images\":[\"uploads/vehicles/UP14ST4009_front_image_1778087314.jpg\",\"uploads/vehicles/UP14ST4009_back_image_1778087314.jpg\"]}', '2026-05-19 07:19:45', 1, 'active'),
(794, 2627827, 277, 14, 'hello', 'text', NULL, '2026-05-19 10:31:13', 1, 'active'),
(795, 2627827, 277, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"60\",\"driver_name\":\"LOVELEEN KUMAR\",\"driver_phone\":\"7298040005\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_277_1778776880.jpg\",\"vehicle_id\":\"60\",\"vehicle_model\":\"AURA 1.2MT CNG SX\",\"vehicle_rc\":\"PB01E9809\",\"vehicle_image\":\"uploads/vehicles/PB01E9809_front_image_1778774037.jpg\",\"vehicle_images\":[\"uploads/vehicles/PB01E9809_front_image_1778774037.jpg\",\"uploads/vehicles/PB01E9809_back_image_1778774037.jpg\"]}', '2026-05-19 10:31:28', 1, 'active'),
(796, 2627827, 277, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"60\",\"driver_name\":\"LOVELEEN KUMAR\",\"driver_phone\":\"7298040005\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_277_1778776880.jpg\",\"vehicle_id\":\"60\",\"vehicle_model\":\"AURA 1.2MT CNG SX\",\"vehicle_rc\":\"PB01E9809\",\"vehicle_image\":\"uploads/vehicles/PB01E9809_front_image_1778774037.jpg\",\"vehicle_images\":[\"uploads/vehicles/PB01E9809_front_image_1778774037.jpg\",\"uploads/vehicles/PB01E9809_back_image_1778774037.jpg\"]}', '2026-05-19 10:48:54', 1, 'active'),
(797, 2627830, 28, 13, 'hi', 'text', NULL, '2026-05-19 17:55:55', 1, 'active'),
(798, 2627830, 29, 13, 'hello', 'text', NULL, '2026-05-19 17:57:54', 1, 'active'),
(799, 2627830, 28, 13, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"48\",\"driver_name\":\"MUKESH KUMAR MANDAL\",\"driver_phone\":\"8920297134\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_28_1778585772.jpg\",\"vehicle_id\":\"42\",\"vehicle_model\":\"TOUR M CNG\",\"vehicle_rc\":\"DL1ZD9277\",\"vehicle_image\":\"uploads/vehicles/DL1ZD9277_front_image_1778585367.jpg\",\"vehicle_images\":[\"uploads/vehicles/DL1ZD9277_front_image_1778585367.jpg\",\"uploads/vehicles/DL1ZD9277_back_image_1778585367.jpg\"]}', '2026-05-19 17:58:27', 1, 'active'),
(800, 2627830, 29, 13, 'hello', 'text', NULL, '2026-05-19 17:58:35', 1, 'active'),
(801, 2627830, 29, 13, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"50\",\"driver_name\":\"AJAY  KUMAR\",\"driver_phone\":\"8505905903\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_29_1778601771.jpg\",\"vehicle_id\":\"9\",\"vehicle_model\":\"ERTIGA VXI (O) CNG\",\"vehicle_rc\":\"RJ01TA5304\",\"vehicle_image\":\"uploads/vehicles/RJ01TA5304_front_image_1778068849.jpg\",\"vehicle_images\":[\"uploads/vehicles/RJ01TA5304_front_image_1778068849.jpg\",\"uploads/vehicles/RJ01TA5304_back_image_1778068849.jpg\"]}', '2026-05-19 18:05:48', 1, 'active'),
(802, 2627822, 377, 14, 'hii', 'text', NULL, '2026-05-20 06:20:11', 1, 'active'),
(803, 2627822, 377, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"78\",\"driver_name\":\"AMAR  RAY\",\"driver_phone\":\"9319039790\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_377_1779255831.jpg\",\"vehicle_id\":\"97\",\"vehicle_model\":\"TOUR S CNG\",\"vehicle_rc\":\"HR55AW4413\",\"vehicle_image\":\"uploads/vehicles/HR55AW4413_front_image_1779256731.jpg\",\"vehicle_images\":[\"uploads/vehicles/HR55AW4413_front_image_1779256731.jpg\",\"uploads/vehicles/HR55AW4413_back_image_1779256731.jpg\"]}', '2026-05-20 06:20:32', 1, 'active'),
(804, 2627822, 14, 377, 'Proposed Fare: ₹3000 | Commission: ₹200', 'quote_request', '{\"fare\":\"3000\",\"comm\":\"200\"}', '2026-05-20 06:20:45', 1, 'paid'),
(805, 2627822, 377, 14, 'okay wait', 'text', NULL, '2026-05-20 06:21:55', 1, 'active'),
(806, 2627834, 14, 14, 'hello', 'text', NULL, '2026-05-20 07:48:20', 1, 'active'),
(807, 2627834, 14, 14, 'hello', 'text', NULL, '2026-05-20 07:48:48', 1, 'active'),
(808, 2627834, 14, 14, 'hy', 'text', NULL, '2026-05-20 07:48:58', 1, 'active'),
(812, 2627833, 316, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"80\",\"driver_name\":\"MOHAMMAD SHOAIB\",\"driver_phone\":\"9690109085\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_316_1779280990.jpg\",\"vehicle_id\":\"100\",\"vehicle_model\":\"TOUR S CNG\",\"vehicle_rc\":\"UK07TE3227\",\"vehicle_image\":\"uploads/vehicles/UK07TE3227_front_image_1779281122.jpg\",\"vehicle_images\":[\"uploads/vehicles/UK07TE3227_front_image_1779281122.jpg\",\"uploads/vehicles/UK07TE3227_back_image_1779281122.jpg\"]}', '2026-05-20 12:46:30', 1, 'active'),
(813, 2627833, 14, 316, 'Proposed Fare: ₹4800 | Commission: ₹800', 'quote_request', '{\"fare\":\"4800\",\"comm\":\"800\"}', '2026-05-20 12:49:30', 1, 'active'),
(814, 2627816, 312, 14, 'hi', 'text', NULL, '2026-05-20 13:29:15', 1, 'active'),
(815, 2627816, 312, 14, 'hi', 'text', NULL, '2026-05-20 13:29:42', 1, 'active'),
(816, 2627816, 14, 312, 'ha ji', 'text', NULL, '2026-05-20 13:29:59', 1, 'active'),
(817, 2627816, 312, 14, 'drop ke liye msg kiya hai', 'text', NULL, '2026-05-20 13:30:52', 1, 'active'),
(818, 2627816, 14, 312, 'shere cab & driver details', 'text', NULL, '2026-05-20 13:31:59', 1, 'active'),
(819, 2627816, 312, 14, 'private number car available hai', 'text', NULL, '2026-05-20 13:33:30', 1, 'active'),
(820, 2627816, 14, 312, 'nhi only taxi allowed h', 'text', NULL, '2026-05-20 13:34:14', 1, 'active'),
(821, 2627845, 21, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"28\",\"driver_name\":\"SALMAN\",\"driver_phone\":\"7827156364\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_21_1778087490.jpg\",\"vehicle_id\":\"11\",\"vehicle_model\":\"AURA 1.2MT CNG S\",\"vehicle_rc\":\"UP14ST4009\",\"vehicle_image\":\"uploads/vehicles/UP14ST4009_front_image_1778087314.jpg\",\"vehicle_images\":[\"uploads/vehicles/UP14ST4009_front_image_1778087314.jpg\",\"uploads/vehicles/UP14ST4009_back_image_1778087314.jpg\"]}', '2026-05-21 01:33:32', 1, 'active'),
(822, 2627845, 279, 14, '4500', 'text', NULL, '2026-05-21 03:09:51', 1, 'active'),
(823, 2627828, 345, 13, 'done', 'text', NULL, '2026-05-21 04:59:21', 1, 'active'),
(824, 2627828, 13, 345, 'Proposed Fare: ₹3500 | Commission: ₹100', 'quote_request', '{\"fare\":\"3500\",\"comm\":\"100\"}', '2026-05-21 05:10:45', 0, 'active'),
(825, 2627845, 391, 14, 'duty done', 'text', NULL, '2026-05-21 05:31:35', 1, 'active'),
(826, 2627845, 391, 14, 'name Pushpendra \ngadi no. hr38aa5143', 'text', NULL, '2026-05-21 05:32:25', 1, 'active'),
(827, 2627845, 391, 14, 'Swift Dzire good condition \nwith carriel', 'text', NULL, '2026-05-21 05:34:52', 1, 'active'),
(843, 2627845, 14, 391, 'apni I\'d me add kr lijiye sir gadi & driver ab to ye gadi bahr se lga di thi kyoki customer jaldi aa gye the 12 bje hi airport se sidhe chale gye', 'text', NULL, '2026-05-21 09:27:20', 0, 'active'),
(845, 2627840, 29, 14, 'hello sir', 'text', NULL, '2026-05-21 10:03:18', 1, 'active'),
(846, 2627849, 369, 14, '17500 9967167232', 'text', NULL, '2026-05-21 10:25:38', 1, 'active'),
(847, 2627849, 369, 14, 'call me', 'text', NULL, '2026-05-21 10:38:15', 1, 'active'),
(848, 2627849, 94, 14, '9711471253', 'text', NULL, '2026-05-21 11:30:52', 1, 'active'),
(849, 2627849, 94, 14, 'call me sir', 'text', NULL, '2026-05-21 11:30:58', 1, 'active'),
(850, 2627841, 29, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"50\",\"driver_name\":\"AJAY  KUMAR\",\"driver_phone\":\"8505905903\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_29_1778601771.jpg\",\"vehicle_id\":\"9\",\"vehicle_model\":\"ERTIGA VXI (O) CNG\",\"vehicle_rc\":\"RJ01TA5304\",\"vehicle_image\":\"uploads/vehicles/RJ01TA5304_front_image_1778068849.jpg\",\"vehicle_images\":[\"uploads/vehicles/RJ01TA5304_front_image_1778068849.jpg\",\"uploads/vehicles/RJ01TA5304_back_image_1778068849.jpg\"]}', '2026-05-21 11:44:52', 1, 'active'),
(851, 2627842, 29, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"50\",\"driver_name\":\"AJAY  KUMAR\",\"driver_phone\":\"8505905903\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_29_1778601771.jpg\",\"vehicle_id\":\"9\",\"vehicle_model\":\"ERTIGA VXI (O) CNG\",\"vehicle_rc\":\"RJ01TA5304\",\"vehicle_image\":\"uploads/vehicles/RJ01TA5304_front_image_1778068849.jpg\",\"vehicle_images\":[\"uploads/vehicles/RJ01TA5304_front_image_1778068849.jpg\",\"uploads/vehicles/RJ01TA5304_back_image_1778068849.jpg\"]}', '2026-05-21 11:49:29', 1, 'active'),
(852, 2627851, 28, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"48\",\"driver_name\":\"MUKESH KUMAR MANDAL\",\"driver_phone\":\"8920297134\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_28_1778585772.jpg\",\"vehicle_id\":\"42\",\"vehicle_model\":\"TOUR M CNG\",\"vehicle_rc\":\"DL1ZD9277\",\"vehicle_image\":\"uploads/vehicles/DL1ZD9277_front_image_1778585367.jpg\",\"vehicle_images\":[\"uploads/vehicles/DL1ZD9277_front_image_1778585367.jpg\",\"uploads/vehicles/DL1ZD9277_back_image_1778585367.jpg\"]}', '2026-05-21 13:55:43', 1, 'active'),
(853, 2627851, 28, 14, 'duty confirmed karna hai', 'text', NULL, '2026-05-21 13:59:00', 1, 'active'),
(854, 2627849, 14, 369, '8058602516', 'text', NULL, '2026-05-21 14:15:49', 0, 'active'),
(855, 2627849, 14, 94, '8058602516', 'text', NULL, '2026-05-21 14:16:01', 1, 'active'),
(856, 2627851, 14, 28, 'Proposed Fare: ₹4000 | Commission: ₹800', 'quote_request', '{\"fare\":\"4000\",\"comm\":\"800\"}', '2026-05-21 14:16:16', 1, 'paid'),
(857, 2627849, 14, 369, 'rate is fix', 'text', NULL, '2026-05-21 14:16:48', 0, 'active'),
(858, 2627849, 14, 94, 'Proposed Fare: ₹16000 | Commission: ₹1000', 'quote_request', '{\"fare\":\"16000\",\"comm\":\"1000\"}', '2026-05-21 14:18:15', 1, 'active'),
(859, 2627851, 345, 14, 'Done 95555', 'text', NULL, '2026-05-21 14:23:32', 1, 'active'),
(860, 2627851, 28, 14, '9818928592\n\nRAJ KUMAR', 'text', NULL, '2026-05-21 14:37:28', 1, 'active'),
(861, 2627851, 14, 345, 'already done other partner', 'text', NULL, '2026-05-21 14:42:27', 0, 'active'),
(862, 2627851, 14, 345, 'sir ap app ko logout krke login kijiye apne documents upload nhi h abhi or apni gadi or driver bhi add kr dijiye', 'text', NULL, '2026-05-21 14:43:24', 0, 'active'),
(863, 2627851, 28, 14, 'number share kar dijiye', 'text', NULL, '2026-05-21 15:29:18', 1, 'active'),
(864, 2627668, 23, 14, '38000', 'text', NULL, '2026-05-21 15:52:43', 1, 'active'),
(865, 2627851, 14, 28, 'driver ko mil jayega', 'text', NULL, '2026-05-21 16:05:47', 1, 'active'),
(866, 2627755, 13, 14, 'hello', 'text', NULL, '2026-05-21 16:08:10', 1, 'active'),
(867, 2627851, 28, 14, '9818928592\n\nRAJ KUMAR\n\nisse call kijiyega', 'text', NULL, '2026-05-21 16:11:49', 1, 'active'),
(868, 2627849, 14, 94, 'kr rhe ho payment?', 'text', NULL, '2026-05-21 16:12:07', 1, 'active'),
(869, 2627851, 14, 28, 'ok', 'text', NULL, '2026-05-21 16:12:21', 1, 'active'),
(870, 2627849, 225, 14, 'hi', 'text', NULL, '2026-05-21 17:41:45', 1, 'active'),
(871, 2627849, 4, 14, 'hii', 'text', NULL, '2026-05-21 17:59:17', 1, 'active'),
(872, 2627849, 14, 225, 'ha ji', 'text', NULL, '2026-05-21 17:59:39', 1, 'active'),
(873, 2627849, 14, 4, 'hello', 'text', NULL, '2026-05-21 17:59:45', 1, 'active'),
(874, 2627841, 14, 29, 'driver kon rhega sir', 'text', NULL, '2026-05-22 04:26:33', 1, 'active'),
(875, 2627841, 29, 14, 'Ajay 8505905903', 'text', NULL, '2026-05-22 04:36:42', 1, 'active'),
(876, 2627841, 29, 14, 'Raat ki booking hai na', 'text', NULL, '2026-05-22 04:36:50', 1, 'active'),
(877, 2627841, 29, 14, '11:30 pm', 'text', NULL, '2026-05-22 04:36:57', 1, 'active'),
(878, 2627841, 14, 29, 'ha ji', 'text', NULL, '2026-05-22 04:37:35', 1, 'active'),
(879, 2627841, 29, 14, 'Main abhi 3 hours call nahi utha paunga just to inform you', 'text', NULL, '2026-05-22 04:37:37', 1, 'active'),
(880, 2627841, 29, 14, 'aap jab bhi mile client ka detail bhej dena thanks sir', 'text', NULL, '2026-05-22 04:37:59', 1, 'active'),
(881, 2627841, 14, 29, 'ok ji', 'text', NULL, '2026-05-22 04:40:06', 1, 'active'),
(882, 2627841, 14, 29, 'customer number \n\n+91 99299 59814', 'text', NULL, '2026-05-22 04:47:48', 1, 'active'),
(883, 2627849, 279, 14, 'laga do bhai', 'text', NULL, '2026-05-22 06:03:47', 1, 'active'),
(884, 2627849, 14, 279, 'Proposed Fare: ₹16000 | Commission: ₹1000', 'quote_request', '{\"fare\":\"16000\",\"comm\":\"1000\"}', '2026-05-22 06:04:07', 0, 'expired'),
(885, 2627849, 279, 14, 'pay nhi ho rha bhai', 'text', NULL, '2026-05-22 06:04:49', 1, 'active'),
(886, 2627849, 279, 14, 'call me', 'text', NULL, '2026-05-22 06:04:58', 1, 'active'),
(887, 2627849, 279, 14, '8930809999', 'text', NULL, '2026-05-22 06:05:06', 1, 'active'),
(888, 2627849, 14, 279, 'wait', 'text', NULL, '2026-05-22 06:05:21', 0, 'active'),
(889, 2627847, 26, 14, '3500 me ho to bta dena', 'text', NULL, '2026-05-22 06:47:48', 1, 'active'),
(890, 2627847, 14, 26, '3200 ho sakta h last', 'text', NULL, '2026-05-22 07:10:56', 0, 'active'),
(891, 2627833, 257, 14, 'bhai etna phle duty dal di h sir bad m duty censal to nhi hogy', 'text', NULL, '2026-05-22 09:47:39', 1, 'active'),
(892, 2627833, 14, 257, 'cancle kyu hogi', 'text', NULL, '2026-05-22 09:48:06', 0, 'active'),
(893, 2627833, 14, 257, 'koi emergency aa jaye wo alag baat h baki 100% to confirm hi h', 'text', NULL, '2026-05-22 09:48:36', 0, 'active'),
(894, 2627849, 50, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"41\",\"driver_name\":\"RAMAVATAR  SAINI\",\"driver_phone\":\"9783074132\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_50_1778409011.jpg\",\"vehicle_id\":\"37\",\"vehicle_model\":\"ERTIGA VXI (O) CNG\",\"vehicle_rc\":\"HR66C4142\",\"vehicle_image\":\"uploads/vehicles/HR66C4142_front_image_1778409310.jpg\",\"vehicle_images\":[\"uploads/vehicles/HR66C4142_front_image_1778409310.jpg\",\"uploads/vehicles/HR66C4142_back_image_1778409310.jpg\"]}', '2026-05-22 10:43:21', 1, 'active'),
(895, 2627849, 50, 14, '17000', 'text', NULL, '2026-05-22 10:43:26', 1, 'active'),
(896, 2627849, 50, 14, 'bhai return nhi h', 'text', NULL, '2026-05-22 10:43:38', 1, 'active'),
(897, 2627849, 50, 14, 'or dog 🐕 ke baal kabhi bhi clean nhi hote', 'text', NULL, '2026-05-22 10:44:16', 1, 'active'),
(898, 2627849, 50, 14, 'ahemdabad gujarat se kam nahi nikalata', 'text', NULL, '2026-05-22 10:45:02', 1, 'active'),
(899, 2627849, 50, 14, 'bhilwara tk khali aayegi', 'text', NULL, '2026-05-22 10:45:14', 1, 'active'),
(900, 2627849, 50, 14, 'bhai', 'text', NULL, '2026-05-22 10:45:18', 1, 'active'),
(901, 2627849, 14, 279, 'Proposed Fare: ₹16000 | Commission: ₹1000', 'quote_request', '{\"fare\":\"16000\",\"comm\":\"1000\"}', '2026-05-22 11:26:56', 0, 'active'),
(902, 2627840, 257, 14, 'Rishikesh mein drop kahan per hai', 'text', NULL, '2026-05-22 13:30:07', 1, 'active'),
(903, 2627840, 14, 257, 'tapovan hotel', 'text', NULL, '2026-05-22 13:30:58', 0, 'active'),
(904, 2627857, 13, 14, 'hello', 'text', NULL, '2026-05-22 15:29:08', 1, 'active'),
(905, 2627857, 14, 13, 'yes', 'text', NULL, '2026-05-22 15:30:28', 1, 'active'),
(906, 2627857, 14, 13, 'ok', 'text', NULL, '2026-05-22 15:30:50', 1, 'active'),
(907, 2627857, 14, 13, 'Proposed Fare: ₹1000 | Commission: ₹200', 'quote_request', '{\"fare\":\"1000\",\"comm\":\"200\"}', '2026-05-22 15:31:12', 1, 'active'),
(908, 2627858, 409, 14, 'hi', 'text', NULL, '2026-05-23 07:05:02', 1, 'active'),
(909, 2627843, 409, 14, '4500', 'text', NULL, '2026-05-23 07:05:20', 1, 'active'),
(910, 2627843, 409, 14, 'I am sharing my live tracking link soon.', 'text', NULL, '2026-05-23 07:05:22', 1, 'active'),
(911, 2627858, 14, 409, 'ha ji', 'text', NULL, '2026-05-23 07:05:41', 1, 'active'),
(912, 2627843, 409, 14, ',4500', 'text', NULL, '2026-05-23 07:05:50', 1, 'active'),
(913, 2627843, 409, 14, 'krwa do', 'text', NULL, '2026-05-23 07:05:54', 1, 'active'),
(914, 2627843, 14, 409, '4000', 'text', NULL, '2026-05-23 07:06:00', 1, 'active'),
(915, 2627860, 290, 14, 'hi', 'text', NULL, '2026-05-23 09:18:05', 1, 'active'),
(916, 2627860, 290, 14, 'अमाउंट क्याहै', 'text', NULL, '2026-05-23 09:18:23', 1, 'active'),
(917, 2627860, 14, 290, 'ap btaiye customer ko rate diya nhi h abhi iska', 'text', NULL, '2026-05-23 09:52:36', 0, 'active'),
(918, 2627668, 14, 23, '37000', 'text', NULL, '2026-05-23 09:53:05', 0, 'active'),
(919, 2627668, 14, 23, 'last', 'text', NULL, '2026-05-23 09:53:09', 0, 'active'),
(920, 2627859, 377, 14, 'hii', 'text', NULL, '2026-05-23 10:43:15', 1, 'active'),
(921, 2627859, 377, 14, 'jaana hai only bhai ya aana bhi hai', 'text', NULL, '2026-05-23 10:43:46', 1, 'active'),
(922, 2627859, 14, 377, 'only drop', 'text', NULL, '2026-05-23 10:44:05', 1, 'active'),
(923, 2627668, 23, 14, '37000', 'text', NULL, '2026-05-23 11:04:41', 1, 'active'),
(924, 2627668, 23, 14, 'disejal  92 h', 'text', NULL, '2026-05-23 11:04:56', 1, 'active'),
(925, 2627668, 14, 23, '37000 hi to bta rha hoo ji', 'text', NULL, '2026-05-23 11:05:28', 0, 'active'),
(926, 2627859, 410, 14, 'Ashish Dixit', 'text', NULL, '2026-05-23 11:47:40', 1, 'active'),
(927, 2627859, 410, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"86\",\"driver_name\":\"ASHISH DIXIT\",\"driver_phone\":\"9540350401\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_410_1779521282.jpg\",\"vehicle_id\":\"110\",\"vehicle_model\":\"TOUR S CNG\",\"vehicle_rc\":\"UP80KT8624\",\"vehicle_image\":\"uploads/vehicles/UP80KT8624_front_image_1779520414.jpg\",\"vehicle_images\":[\"uploads/vehicles/UP80KT8624_front_image_1779520414.jpg\",\"uploads/vehicles/UP80KT8624_back_image_1779520414.jpg\"]}', '2026-05-23 11:48:09', 1, 'active'),
(928, 2627660, 36, 14, 'main Laga dun', 'text', NULL, '2026-05-23 16:28:57', 1, 'active'),
(929, 2627668, 36, 14, 'main Laga Dunga', 'text', NULL, '2026-05-23 16:36:50', 1, 'active'),
(930, 2627668, 14, 36, 'Proposed Fare: ₹35500 | Commission: ₹500', 'quote_request', '{\"fare\":\"35500\",\"comm\":\"500\"}', '2026-05-23 16:38:34', 0, 'active'),
(931, 2627863, 95, 14, 'pickup curent kitne time ka he', 'text', NULL, '2026-05-24 08:39:12', 1, 'active'),
(932, 2627863, 95, 14, 'manish ji', 'text', NULL, '2026-05-24 08:39:31', 1, 'active'),
(933, 2627863, 14, 95, 'likha to hota h time', 'text', NULL, '2026-05-24 09:14:26', 1, 'active'),
(934, 2627863, 95, 14, 'mujhe mil jayegi abhi duty ye puchha maine', 'text', NULL, '2026-05-24 09:15:45', 1, 'active'),
(935, 2627863, 14, 95, 'nhi lga di just group se', 'text', NULL, '2026-05-24 09:18:31', 1, 'active'),
(936, 2627813, 378, 13, 'kya payment hai bhai', 'text', NULL, '2026-05-24 09:54:44', 1, 'active'),
(937, 2627813, 13, 378, 'ap. bta dijiye', 'text', NULL, '2026-05-24 10:00:24', 1, 'active'),
(938, 2627813, 378, 13, 'ap hi bata do', 'text', NULL, '2026-05-24 10:01:41', 1, 'active'),
(939, 2627813, 378, 13, 'bhai', 'text', NULL, '2026-05-24 10:01:44', 1, 'active'),
(940, 2627813, 378, 13, '10000', 'text', NULL, '2026-05-24 10:03:35', 1, 'active'),
(941, 2627865, 176, 13, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"38\",\"driver_name\":\"RAJ  KUMAR\",\"driver_phone\":\"8755089487\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_176_1778396656.jpg\",\"vehicle_id\":\"32\",\"vehicle_model\":\"TOYOTA RUMION S CNG [MT]\",\"vehicle_rc\":\"HR38AL6467\",\"vehicle_image\":\"uploads/vehicles/HR38AL6467_front_image_1778396730.jpg\",\"vehicle_images\":[\"uploads/vehicles/HR38AL6467_front_image_1778396730.jpg\",\"uploads/vehicles/HR38AL6467_back_image_1778396730.jpg\"]}', '2026-05-24 11:21:48', 1, 'active'),
(942, 2627865, 13, 176, 'Proposed Fare: ₹7500 | Commission: ₹50', 'quote_request', '{\"fare\":\"7500\",\"comm\":\"50\"}', '2026-05-24 11:31:03', 0, 'active'),
(943, 2627859, 359, 14, 'hi sir', 'text', NULL, '2026-05-24 12:05:06', 1, 'active'),
(944, 2627859, 359, 14, '9528824577', 'text', NULL, '2026-05-24 12:05:16', 1, 'active'),
(945, 2627859, 359, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"88\",\"driver_name\":\"JEEVAN  KUMAR\",\"driver_phone\":\"7668104085\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_359_1779624276.jpg\",\"vehicle_id\":\"112\",\"vehicle_model\":\"TOUR S CNG\",\"vehicle_rc\":\"UP84BT1186\",\"vehicle_image\":\"uploads/vehicles/UP84BT1186_front_image_1779624171.jpg\",\"vehicle_images\":[\"uploads/vehicles/UP84BT1186_front_image_1779624171.jpg\",\"uploads/vehicles/UP84BT1186_back_image_1779624171.jpg\"]}', '2026-05-24 12:05:40', 1, 'active'),
(946, 2627859, 359, 14, 'sir call mi arjent', 'text', NULL, '2026-05-24 12:06:34', 1, 'active'),
(947, 2627859, 359, 14, 'sir call mi', 'text', NULL, '2026-05-24 12:07:28', 1, 'active'),
(948, 2627865, 129, 13, '9000', 'text', NULL, '2026-05-24 13:02:16', 1, 'active'),
(949, 2627859, 129, 14, '6500', 'text', NULL, '2026-05-24 13:02:52', 1, 'active'),
(950, 2627837, 129, 14, '6500', 'text', NULL, '2026-05-24 13:03:54', 1, 'active'),
(951, 2627859, 14, 359, '8058602516', 'text', NULL, '2026-05-24 13:18:43', 0, 'active'),
(952, 2627874, 83, 13, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"43\",\"driver_name\":\"BIJENDER SINGH\",\"driver_phone\":\"7015085106\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_83_1778418787.jpg\",\"vehicle_id\":\"40\",\"vehicle_model\":\"ERTIGA VXI CNG\",\"vehicle_rc\":\"HR841384\",\"vehicle_image\":\"uploads/vehicles/HR841384_front_image_1778419294.jpg\",\"vehicle_images\":[\"uploads/vehicles/HR841384_front_image_1778419294.jpg\",\"uploads/vehicles/HR841384_back_image_1778419294.jpg\"]}', '2026-06-05 13:13:59', 1, 'active'),
(953, 2627874, 83, 13, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"43\",\"driver_name\":\"BIJENDER SINGH\",\"driver_phone\":\"7015085106\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_83_1778418787.jpg\",\"vehicle_id\":\"40\",\"vehicle_model\":\"ERTIGA VXI CNG\",\"vehicle_rc\":\"HR841384\",\"vehicle_image\":\"uploads/vehicles/HR841384_front_image_1778419294.jpg\",\"vehicle_images\":[\"uploads/vehicles/HR841384_front_image_1778419294.jpg\",\"uploads/vehicles/HR841384_back_image_1778419294.jpg\"]}', '2026-06-05 13:14:09', 1, 'active'),
(954, 2627874, 83, 13, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"43\",\"driver_name\":\"BIJENDER SINGH\",\"driver_phone\":\"7015085106\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_83_1778418787.jpg\",\"vehicle_id\":\"40\",\"vehicle_model\":\"ERTIGA VXI CNG\",\"vehicle_rc\":\"HR841384\",\"vehicle_image\":\"uploads/vehicles/HR841384_front_image_1778419294.jpg\",\"vehicle_images\":[\"uploads/vehicles/HR841384_front_image_1778419294.jpg\",\"uploads/vehicles/HR841384_back_image_1778419294.jpg\"]}', '2026-06-05 13:15:48', 1, 'active'),
(955, 2627874, 83, 13, '24000 Rs.', 'text', NULL, '2026-06-05 13:16:11', 1, 'active'),
(956, 2627874, 83, 13, 'parking extra', 'text', NULL, '2026-06-05 13:16:30', 1, 'active'),
(957, 2627874, 83, 13, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"43\",\"driver_name\":\"BIJENDER SINGH\",\"driver_phone\":\"7015085106\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_83_1778418787.jpg\",\"vehicle_id\":\"40\",\"vehicle_model\":\"ERTIGA VXI CNG\",\"vehicle_rc\":\"HR841384\",\"vehicle_image\":\"uploads/vehicles/HR841384_front_image_1778419294.jpg\",\"vehicle_images\":[\"uploads/vehicles/HR841384_front_image_1778419294.jpg\",\"uploads/vehicles/HR841384_back_image_1778419294.jpg\"]}', '2026-06-05 13:19:40', 1, 'active'),
(958, 2627874, 83, 13, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"43\",\"driver_name\":\"BIJENDER SINGH\",\"driver_phone\":\"7015085106\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_83_1778418787.jpg\",\"vehicle_id\":\"40\",\"vehicle_model\":\"ERTIGA VXI CNG\",\"vehicle_rc\":\"HR841384\",\"vehicle_image\":\"uploads/vehicles/HR841384_front_image_1778419294.jpg\",\"vehicle_images\":[\"uploads/vehicles/HR841384_front_image_1778419294.jpg\",\"uploads/vehicles/HR841384_back_image_1778419294.jpg\"]}', '2026-06-05 13:25:40', 1, 'active'),
(959, 2627874, 13, 83, 'Proposed Fare: ₹23500 | Commission: ₹500', 'quote_request', '{\"fare\":\"23500\",\"comm\":\"500\"}', '2026-06-05 14:51:45', 0, 'active'),
(960, 2627874, 13, 83, '23000+ parking', 'text', NULL, '2026-06-05 14:53:13', 0, 'active'),
(961, 2627874, 83, 13, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"43\",\"driver_name\":\"BIJENDER SINGH\",\"driver_phone\":\"7015085106\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_83_1778418787.jpg\",\"vehicle_id\":\"40\",\"vehicle_model\":\"ERTIGA VXI CNG\",\"vehicle_rc\":\"HR841384\",\"vehicle_image\":\"uploads/vehicles/HR841384_front_image_1778419294.jpg\",\"vehicle_images\":[\"uploads/vehicles/HR841384_front_image_1778419294.jpg\",\"uploads/vehicles/HR841384_back_image_1778419294.jpg\"]}', '2026-06-05 15:55:55', 1, 'active'),
(962, 2627874, 14, 13, 'hello', 'text', NULL, '2026-06-05 17:39:37', 1, 'active'),
(963, 2627874, 14, 13, 'hello', 'text', NULL, '2026-06-05 17:39:47', 1, 'active'),
(964, 2627782, 4, 14, 'hello', 'text', NULL, '2026-06-05 17:40:00', 1, 'active'),
(965, 2627782, 95, 14, '10000', 'text', NULL, '2026-06-05 17:48:00', 1, 'active'),
(966, 2627874, 4, 13, 'hello', 'text', NULL, '2026-06-05 19:13:01', 1, 'active'),
(967, 2627877, 4, 14, 'hii', 'text', NULL, '2026-06-05 19:13:12', 1, 'active'),
(968, 2627879, 4, 14, 'hii', 'text', NULL, '2026-06-05 19:13:26', 1, 'active'),
(969, 2627873, 53, 14, '6500', 'text', NULL, '2026-06-06 04:48:39', 1, 'active'),
(970, 2627873, 53, 14, 'Badi gadi de dunga', 'text', NULL, '2026-06-06 04:48:52', 1, 'active'),
(971, 2627873, 14, 53, 'customer ko chahiye hi choti gadi to badi gadi ka mujhe thodi na baithke jana h', 'text', NULL, '2026-06-06 06:01:07', 0, 'active'),
(972, 2627881, 420, 14, '3000', 'text', NULL, '2026-06-06 08:41:11', 1, 'active'),
(973, 2627875, 28, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"48\",\"driver_name\":\"MUKESH KUMAR MANDAL\",\"driver_phone\":\"8920297134\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_28_1778585772.jpg\",\"vehicle_id\":\"42\",\"vehicle_model\":\"TOUR M CNG\",\"vehicle_rc\":\"DL1ZD9277\",\"vehicle_image\":\"uploads/vehicles/DL1ZD9277_front_image_1778585367.jpg\",\"vehicle_images\":[\"uploads/vehicles/DL1ZD9277_front_image_1778585367.jpg\",\"uploads/vehicles/DL1ZD9277_back_image_1778585367.jpg\"]}', '2026-06-06 12:23:02', 1, 'active'),
(974, 2627879, 487, 14, 'Bhai ye bhi koi rate h', 'text', NULL, '2026-06-07 03:22:04', 1, 'active'),
(975, 2627885, 21, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"28\",\"driver_name\":\"SALMAN\",\"driver_phone\":\"7827156364\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_21_1778087490.jpg\",\"vehicle_id\":\"71\",\"vehicle_model\":\"AURA 1.2MT CNG S\",\"vehicle_rc\":\"UP14RT8489\",\"vehicle_image\":\"uploads/vehicles/UP14RT8489_front_image_1778919765.jpg\",\"vehicle_images\":[\"uploads/vehicles/UP14RT8489_front_image_1778919765.jpg\",\"uploads/vehicles/UP14RT8489_back_image_1778919765.jpg\"]}', '2026-06-07 16:35:40', 1, 'active'),
(976, 2627887, 359, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"88\",\"driver_name\":\"JEEVAN  KUMAR\",\"driver_phone\":\"7668104085\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_359_1779624276.jpg\",\"vehicle_id\":\"112\",\"vehicle_model\":\"TOUR S CNG\",\"vehicle_rc\":\"UP84BT1186\",\"vehicle_image\":\"uploads/vehicles/UP84BT1186_front_image_1779624171.jpg\",\"vehicle_images\":[\"uploads/vehicles/UP84BT1186_front_image_1779624171.jpg\",\"uploads/vehicles/UP84BT1186_back_image_1779624171.jpg\"]}', '2026-06-07 19:31:00', 1, 'active'),
(977, 2627887, 359, 14, 'hi', 'text', NULL, '2026-06-08 01:35:49', 1, 'active'),
(978, 2627887, 14, 359, 'ha ji', 'text', NULL, '2026-06-08 02:06:20', 0, 'active'),
(979, 2627892, 412, 14, 'hii', 'text', NULL, '2026-06-08 18:27:41', 1, 'active'),
(980, 2627892, 14, 412, 'ha ji', 'text', NULL, '2026-06-08 19:31:10', 0, 'active'),
(981, 2627893, 423, 13, 'hi', 'text', NULL, '2026-06-09 01:24:11', 1, 'active'),
(982, 2627893, 423, 13, 'hi', 'text', NULL, '2026-06-09 01:24:15', 1, 'active'),
(983, 2627893, 423, 13, '9041993780', 'text', NULL, '2026-06-09 01:24:50', 1, 'active'),
(984, 2627894, 359, 13, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"76\",\"driver_name\":\"SATENDRA\",\"driver_phone\":\"9528824577\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_359_1779118910.jpg\",\"vehicle_id\":\"82\",\"vehicle_model\":\"PRIME SD 1.2 MT CNG\",\"vehicle_rc\":\"UP84BT5903\",\"vehicle_image\":\"uploads/vehicles/UP84BT5903_front_image_1779118797.jpg\",\"vehicle_images\":[\"uploads/vehicles/UP84BT5903_front_image_1779118797.jpg\",\"uploads/vehicles/UP84BT5903_back_image_1779118797.jpg\"]}', '2026-06-09 02:15:48', 1, 'active'),
(985, 2627891, 65, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"68\",\"driver_name\":\"RAJPAL\",\"driver_phone\":\"918958028605\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_65_1778932382.jpg\",\"vehicle_id\":\"72\",\"vehicle_model\":\"DZIRE VXI CNG\",\"vehicle_rc\":\"UP85DT4657\",\"vehicle_image\":\"uploads/vehicles/UP85DT4657_front_image_1778932191.jpg\",\"vehicle_images\":[\"uploads/vehicles/UP85DT4657_front_image_1778932191.jpg\",\"uploads/vehicles/UP85DT4657_back_image_1778932191.jpg\"]}', '2026-06-09 03:47:36', 1, 'active'),
(986, 2627879, 65, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"68\",\"driver_name\":\"RAJPAL\",\"driver_phone\":\"918958028605\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_65_1778932382.jpg\",\"vehicle_id\":\"72\",\"vehicle_model\":\"DZIRE VXI CNG\",\"vehicle_rc\":\"UP85DT4657\",\"vehicle_image\":\"uploads/vehicles/UP85DT4657_front_image_1778932191.jpg\",\"vehicle_images\":[\"uploads/vehicles/UP85DT4657_front_image_1778932191.jpg\",\"uploads/vehicles/UP85DT4657_back_image_1778932191.jpg\"]}', '2026-06-09 03:49:23', 1, 'active'),
(987, 2627893, 13, 423, 'ha hu', 'text', NULL, '2026-06-09 05:14:08', 0, 'active'),
(988, 2627893, 13, 423, 'ji', 'text', NULL, '2026-06-09 05:14:10', 0, 'active'),
(989, 2627893, 13, 423, 'btaiye', 'text', NULL, '2026-06-09 05:14:12', 0, 'active'),
(990, 2627894, 13, 359, 'Proposed Fare: ₹1772 | Commission: ₹122', 'quote_request', '{\"fare\":\"1772\",\"comm\":\"122\"}', '2026-06-09 05:14:20', 0, 'active'),
(991, 2627888, 40, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"39\",\"driver_name\":\"JAGJIT SINGH\",\"driver_phone\":\"9817217571\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_40_1778396716.jpg\",\"vehicle_id\":\"33\",\"vehicle_model\":\"ERTIGA VXI CNG\",\"vehicle_rc\":\"HR57B5977\",\"vehicle_image\":\"uploads/vehicles/HR57B5977_front_image_1778396790.jpg\",\"vehicle_images\":[\"uploads/vehicles/HR57B5977_front_image_1778396790.jpg\",\"uploads/vehicles/HR57B5977_back_image_1778396790.jpg\"]}', '2026-06-09 12:31:05', 1, 'active'),
(992, 2627888, 14, 40, 'Proposed Fare: ₹4020 | Commission: ₹520', 'quote_request', '{\"fare\":\"4020\",\"comm\":\"520\"}', '2026-06-09 12:31:36', 0, 'active'),
(993, 2627894, 21, 13, 'thodi to sharm kar lo customer se rate to sahi le liya karo petrol aur CNG ke rate dekh rahe ho kya aaj a rahe hain', 'text', NULL, '2026-06-09 14:07:57', 1, 'active'),
(994, 2627894, 21, 13, 'lekin apni commission tumhen Puri leni hai', 'text', NULL, '2026-06-09 14:08:11', 1, 'active'),
(995, 2627894, 13, 21, 'tumhe kya dikkat h tumhare sath jabardsti ki h Jane k liye jisko jana hoga wo chala jayega', 'text', NULL, '2026-06-09 14:26:31', 0, 'active'),
(996, 2627894, 13, 21, '1500 me or app me dalte h unse bolo Jake', 'text', NULL, '2026-06-09 14:27:06', 0, 'active'),
(997, 2627881, 420, 14, '3000', 'text', NULL, '2026-06-09 20:09:02', 1, 'active'),
(998, 2627881, 14, 420, 'rate is fix', 'text', NULL, '2026-06-09 20:09:34', 1, 'active'),
(999, 2627854, 85, 14, 'old innova', 'text', NULL, '2026-06-10 16:02:56', 1, 'active'),
(1000, 2627854, 85, 14, '?', 'text', NULL, '2026-06-10 16:02:58', 1, 'active'),
(1001, 2627854, 14, 85, 'no', 'text', NULL, '2026-06-10 16:03:16', 1, 'active'),
(1004, 2627899, 467, 14, 'hey', 'text', NULL, '2026-06-11 12:38:06', 1, 'active'),
(1005, 2627899, 14, 467, 'ha ji', 'text', NULL, '2026-06-11 13:04:48', 0, 'active'),
(1006, 2627891, 65, 14, 'Radhe Radhe ji customer ka number bhej do', 'text', NULL, '2026-06-12 09:57:14', 1, 'active'),
(1007, 2627891, 65, 14, 'subah 4:00 baje ka pickup hai Delhi se Vrindavan', 'text', NULL, '2026-06-12 09:57:23', 1, 'active'),
(1008, 2627891, 14, 65, 'cab & driver details?', 'text', NULL, '2026-06-12 09:57:37', 0, 'active'),
(1009, 2627891, 65, 14, 'yahi rahegi', 'text', NULL, '2026-06-12 09:58:08', 1, 'active'),
(1010, 2627891, 14, 65, '+91-9971347985', 'text', NULL, '2026-06-12 10:02:48', 0, 'active'),
(1011, 2627901, 467, 14, 'hi', 'text', NULL, '2026-06-12 12:42:38', 1, 'active'),
(1012, 2627901, 14, 467, 'ha ji', 'text', NULL, '2026-06-12 13:03:10', 0, 'active'),
(1013, 2627891, 65, 14, 'hi', 'text', NULL, '2026-06-12 13:03:23', 1, 'active'),
(1014, 2627891, 14, 65, '9971347985', 'text', NULL, '2026-06-12 13:03:54', 0, 'active'),
(1015, 2627897, 53, 13, '11200', 'text', NULL, '2026-06-12 13:29:59', 1, 'active'),
(1016, 2627897, 53, 13, 'ok', 'text', NULL, '2026-06-12 13:30:02', 1, 'active'),
(1017, 2627904, 95, 14, '9000', 'text', NULL, '2026-06-12 14:58:19', 1, 'active'),
(1018, 2627904, 95, 14, 'aap batao kya denge aap all included', 'text', NULL, '2026-06-12 15:00:39', 1, 'active'),
(1019, 2627904, 95, 14, 'me', 'text', NULL, '2026-06-12 15:00:42', 1, 'active'),
(1020, 2627905, 232, 14, 'tol parking extra', 'text', NULL, '2026-06-12 15:35:21', 1, 'active'),
(1021, 2627905, 232, 14, '9317193225\ncall me 🤙', 'text', NULL, '2026-06-12 15:35:47', 1, 'active'),
(1022, 2627905, 14, 232, 'app se accept kr lijiye', 'text', NULL, '2026-06-12 16:10:06', 0, 'active'),
(1023, 2627904, 20, 14, '9718 746 877 call me', 'text', NULL, '2026-06-12 17:07:11', 1, 'active'),
(1024, 2627902, 13, 14, 'hello', 'text', NULL, '2026-06-12 20:24:54', 1, 'active'),
(1025, 2627902, 4, 14, 'hlo', 'text', NULL, '2026-06-12 20:25:04', 1, 'active'),
(1026, 2627902, 14, 4, 'hello', 'text', NULL, '2026-06-12 20:25:38', 0, 'active'),
(1027, 2627881, 420, 14, 'bhai tumhre alawa is app par koi duty nahi daalta h', 'text', NULL, '2026-06-13 12:33:05', 1, 'active'),
(1028, 2627906, 145, 14, 'hello', 'text', NULL, '2026-06-13 15:05:24', 1, 'active'),
(1029, 2627906, 145, 14, 'innova crysta available', 'text', NULL, '2026-06-13 15:05:40', 1, 'active'),
(1030, 2627881, 14, 420, 'hme apna kam Krna h jise dalni h wo dal sakta h kisi k sath jabardasti nhi h', 'text', NULL, '2026-06-13 15:38:49', 1, 'active'),
(1031, 2627906, 14, 145, 'Proposed Fare: ₹4085 | Commission: ₹585', 'quote_request', '{\"fare\":\"4085\",\"comm\":\"585\"}', '2026-06-13 15:38:59', 1, 'active'),
(1032, 2627911, 341, 14, 'please contact number', 'text', NULL, '2026-06-14 07:55:33', 1, 'active'),
(1033, 2627911, 341, 14, '9717404686', 'text', NULL, '2026-06-14 07:56:01', 1, 'active'),
(1034, 2627911, 341, 14, 'please contact number', 'text', NULL, '2026-06-14 07:56:14', 1, 'active'),
(1035, 2627911, 14, 341, 'Proposed Fare: ₹3800 | Commission: ₹300', 'quote_request', '{\"fare\":\"3800\",\"comm\":\"300\"}', '2026-06-14 10:25:31', 0, 'active'),
(1036, 2627911, 14, 341, '8058602516', 'text', NULL, '2026-06-14 10:25:46', 0, 'active'),
(1042, 2627888, 341, 14, 'Manoj Bhai koi Aligarh ki Aaye to please mere number per sampark kar dena 9821447 146', 'text', NULL, '2026-06-15 11:01:57', 1, 'active'),
(1043, 2627888, 341, 14, 'Noida Ghaziabad Delhi se', 'text', NULL, '2026-06-15 11:02:04', 1, 'active'),
(1044, 2627917, 20, 14, '9718746877 call me', 'text', NULL, '2026-06-15 16:11:54', 1, 'active'),
(1045, 2627917, 14, 20, 'Proposed Fare: ₹1800 | Commission: ₹150', 'quote_request', '{\"fare\":\"1800\",\"comm\":\"150\"}', '2026-06-15 16:51:54', 1, 'active'),
(1046, 2627888, 96, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"75\",\"driver_name\":\"VIKKAS  GUPTA\",\"driver_phone\":\"7982179332\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_96_1779107441.jpg\",\"vehicle_id\":\"81\",\"vehicle_model\":\"ERTIGA VXI (O) CNG\",\"vehicle_rc\":\"UK07TE1580\",\"vehicle_image\":\"uploads/vehicles/UK07TE1580_front_image_1779107348.jpg\",\"vehicle_images\":[\"uploads/vehicles/UK07TE1580_front_image_1779107348.jpg\",\"uploads/vehicles/UK07TE1580_back_image_1779107348.jpg\"]}', '2026-06-16 08:31:00', 1, 'active'),
(1047, 2627920, 28, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"47\",\"driver_name\":\"RAJ KUMAR\",\"driver_phone\":\"9818928592\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_28_1778585632.jpg\",\"vehicle_id\":\"42\",\"vehicle_model\":\"TOUR M CNG\",\"vehicle_rc\":\"DL1ZD9277\",\"vehicle_image\":\"uploads/vehicles/DL1ZD9277_front_image_1778585367.jpg\",\"vehicle_images\":[\"uploads/vehicles/DL1ZD9277_front_image_1778585367.jpg\",\"uploads/vehicles/DL1ZD9277_back_image_1778585367.jpg\"]}', '2026-06-17 07:47:14', 1, 'active'),
(1048, 2627920, 58, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"113\",\"driver_name\":\"SANDEEP YADAV\",\"driver_phone\":\"8930361411\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_58_1781683529.jpg\",\"vehicle_id\":\"126\",\"vehicle_model\":\"TOYOTA RUMION S CNG [MT]\",\"vehicle_rc\":\"HR47H3593\",\"vehicle_image\":\"uploads/vehicles/HR47H3593_front_image_1781683422.jpg\",\"vehicle_images\":[\"uploads/vehicles/HR47H3593_front_image_1781683422.jpg\",\"uploads/vehicles/HR47H3593_back_image_1781683422.jpg\"]}', '2026-06-17 08:06:51', 1, 'active'),
(1049, 2627920, 58, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"113\",\"driver_name\":\"SANDEEP YADAV\",\"driver_phone\":\"8930361411\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_58_1781683529.jpg\",\"vehicle_id\":\"126\",\"vehicle_model\":\"TOYOTA RUMION S CNG [MT]\",\"vehicle_rc\":\"HR47H3593\",\"vehicle_image\":\"uploads/vehicles/HR47H3593_front_image_1781683422.jpg\",\"vehicle_images\":[\"uploads/vehicles/HR47H3593_front_image_1781683422.jpg\",\"uploads/vehicles/HR47H3593_back_image_1781683422.jpg\"]}', '2026-06-17 08:07:01', 1, 'active'),
(1050, 2627920, 58, 14, 'hlo', 'text', NULL, '2026-06-17 08:07:59', 1, 'active'),
(1051, 2627920, 14, 58, 'yes', 'text', NULL, '2026-06-17 08:13:24', 1, 'active'),
(1052, 2627920, 471, 14, 'hlo bai ji rate mai kuj or barh sakta hai', 'text', NULL, '2026-06-17 08:27:01', 1, 'active'),
(1053, 2627920, 471, 14, 'bai ji rate torha or barh sakta hai', 'text', NULL, '2026-06-17 08:27:29', 1, 'active'),
(1054, 2627920, 28, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"47\",\"driver_name\":\"RAJ KUMAR\",\"driver_phone\":\"9818928592\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_28_1778585632.jpg\",\"vehicle_id\":\"42\",\"vehicle_model\":\"TOUR M CNG\",\"vehicle_rc\":\"DL1ZD9277\",\"vehicle_image\":\"uploads/vehicles/DL1ZD9277_front_image_1778585367.jpg\",\"vehicle_images\":[\"uploads/vehicles/DL1ZD9277_front_image_1778585367.jpg\",\"uploads/vehicles/DL1ZD9277_back_image_1778585367.jpg\"]}', '2026-06-17 09:01:32', 1, 'active'),
(1055, 2627920, 28, 14, 'hi', 'text', NULL, '2026-06-17 09:20:54', 1, 'active'),
(1056, 2627920, 28, 14, 'accept booking', 'text', NULL, '2026-06-17 09:21:09', 1, 'active'),
(1057, 2627920, 30, 14, '16000', 'text', NULL, '2026-06-17 10:00:22', 1, 'active'),
(1058, 2627920, 30, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"97\",\"driver_name\":\"MONU SHARMA\",\"driver_phone\":\"9910289441\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_30_1781418882.jpg\",\"vehicle_id\":\"120\",\"vehicle_model\":\"TOUR M CNG\",\"vehicle_rc\":\"HR38AC4502\",\"vehicle_image\":\"uploads/vehicles/HR38AC4502_front_image_1781418839.jpg\",\"vehicle_images\":[\"uploads/vehicles/HR38AC4502_front_image_1781418839.jpg\",\"uploads/vehicles/HR38AC4502_back_image_1781418839.jpg\"]}', '2026-06-17 10:00:25', 1, 'active'),
(1059, 2627920, 28, 14, 'Shared Driver & Vehicle Details', 'full_details', '{\"driver_id\":\"47\",\"driver_name\":\"RAJ KUMAR\",\"driver_phone\":\"9818928592\",\"driver_image\":\"https://chooseataxi.com/uploads/drivers/driver_28_1778585632.jpg\",\"vehicle_id\":\"127\",\"vehicle_model\":\"TOUR M CNG\",\"vehicle_rc\":\"DL1ZD9277\",\"vehicle_image\":\"uploads/vehicles/DL1ZD9277_front_image_1781690515.jpg\",\"vehicle_images\":[\"uploads/vehicles/DL1ZD9277_front_image_1781690515.jpg\",\"uploads/vehicles/DL1ZD9277_back_image_1781690515.jpg\"]}', '2026-06-17 10:02:12', 1, 'active'),
(1060, 2627920, 28, 14, 'booking confirmed kijiyega', 'text', NULL, '2026-06-17 10:04:46', 1, 'active'),
(1061, 2627920, 14, 471, 'nhi sir', 'text', NULL, '2026-06-17 10:40:28', 0, 'active'),
(1062, 2627920, 14, 28, '2024+ model cab chahiye sir', 'text', NULL, '2026-06-17 10:40:45', 1, 'active'),
(1063, 2627920, 28, 14, 'model 2025 hai', 'text', NULL, '2026-06-17 10:41:15', 1, 'active'),
(1064, 2627920, 28, 14, 'JUN 2025 MODEL HAI', 'text', NULL, '2026-06-17 10:42:16', 1, 'active'),
(1065, 2627920, 14, 28, 'wo hi gadi h jo lagi thi ?', 'text', NULL, '2026-06-17 10:44:21', 1, 'active'),
(1066, 2627920, 28, 14, 'ji', 'text', NULL, '2026-06-17 10:44:32', 1, 'active'),
(1067, 2627920, 28, 14, 'DL1ZD9277', 'text', NULL, '2026-06-17 10:44:39', 1, 'active'),
(1068, 2627920, 28, 14, 'wo light me laga tha change ho gaya hai', 'text', NULL, '2026-06-17 10:48:29', 1, 'active'),
(1069, 2627920, 14, 28, 'Proposed Fare: ₹16200 | Commission: ₹1000', 'quote_request', '{\"fare\":\"16200\",\"comm\":\"1000\"}', '2026-06-17 10:50:03', 1, 'paid'),
(1070, 2627920, 14, 28, 'cariar h na', 'text', NULL, '2026-06-17 10:54:11', 0, 'active'),
(1071, 2627920, 14, 28, 'gadi par', 'text', NULL, '2026-06-17 10:54:18', 0, 'active'),
(1072, 2627920, 28, 14, 'carrier hai', 'text', NULL, '2026-06-17 10:54:25', 1, 'active'),
(1073, 2627920, 14, 28, 'ok', 'text', NULL, '2026-06-17 10:54:44', 0, 'active'),
(1074, 2627920, 14, 30, 'already done', 'text', NULL, '2026-06-17 10:57:43', 0, 'active');

-- --------------------------------------------------------

--
-- Table structure for table `cars`
--

CREATE TABLE `cars` (
  `id` int(11) NOT NULL,
  `brand_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `city_id` int(11) DEFAULT NULL,
  `drop_city_id` int(11) DEFAULT NULL,
  `trip_type_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `model` varchar(100) DEFAULT NULL,
  `base_fare` decimal(10,2) DEFAULT 0.00,
  `min_km` int(11) DEFAULT 0,
  `extra_km_price` decimal(10,2) DEFAULT 0.00,
  `display_extra_km_price` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `youtube_url` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `seo_title` varchar(255) DEFAULT NULL,
  `seo_description` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `include_toll` enum('Included','Excluded') DEFAULT 'Included',
  `include_tax` enum('Included','Excluded') DEFAULT 'Included',
  `include_driver_allowance` enum('Included','Excluded') DEFAULT 'Included',
  `include_night_charges` enum('Included','Excluded') DEFAULT 'Included',
  `include_parking` enum('Included','Excluded') DEFAULT 'Included',
  `terms_conditions` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cars`
--

INSERT INTO `cars` (`id`, `brand_id`, `type_id`, `city_id`, `drop_city_id`, `trip_type_id`, `name`, `model`, `base_fare`, `min_km`, `extra_km_price`, `display_extra_km_price`, `description`, `youtube_url`, `image`, `seo_title`, `seo_description`, `meta_keywords`, `status`, `created_at`, `include_toll`, `include_tax`, `include_driver_allowance`, `include_night_charges`, `include_parking`, `terms_conditions`) VALUES
(16, 1, 7, NULL, NULL, 1, 'Hatchback', NULL, 1278.00, 19, 14.00, NULL, 'Your Trip has a KM limit. If you usage extra km you will be charged for the extra KM.\r\nYour cab can be a CNG vehicle. The driver may need to fill CNG once or more during your trip.\r\nAirport Entry/Parking charge is extra, if applicable is not included in the fare \r\nYour trip includes one pick up and one drop. It does not include within city travel.\r\nIf your Trip is Hill area, cab AC will be switched off.', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-05-06 16:15:59', 'Included', 'Included', 'Included', 'Included', 'Excluded', NULL),
(17, 1, 9, NULL, NULL, 1, 'Ertiga', NULL, 1896.00, 25, 18.00, NULL, 'Your Trip has a KM limit. If you usage extra km you will be charged for the extra KM.\r\nYour cab can be a CNG vehicle. The driver may need to fill CNG once or more during your trip.\r\nAirport Entry/Parking charge is extra, if applicable is not included in the fare \r\nYour trip includes one pick up and one drop. It does not include within city travel.\r\nIf your Trip is Hill area, cab AC will be switched off.', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-05-06 16:24:42', 'Included', 'Included', 'Included', 'Included', 'Excluded', NULL),
(18, 1, 7, NULL, NULL, 2, 'Hatchback', NULL, 2865.00, 250, 13.00, NULL, 'Your Trip has a KM and Hours limit. If your usage extra these limits, you will be charged for the extra KM and Hours used.\r\nAirport Entry/Parking charge is extra, if applicable is not included in the fare\r\nAll toll fees, parking charges, MCD, state tax etc. if applicable will be charged extra and need to be pay as per actuals.\r\nIf Running cab 10:00 PM to 06:00 AM on any of the nights, an  Night allowance will be applicable and is to be paid to the driver.\r\nPlease add your all trip plan cities you plan to visit. Adding city to the runnig trip may not be possible.\r\nIf your Trip is Hill area, cab AC will be switched off.\r\nYour cab can be a CNG vehicle. The driver may need to fill CNG once or more during your trip.', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-05-06 16:30:53', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', NULL),
(19, 1, 8, NULL, NULL, 1, 'Sedan', NULL, 1396.00, 20, 15.00, NULL, 'Your Trip has a KM limit. If you usage extra km you will be charged for the extra KM.\r\nYour cab can be a CNG vehicle. The driver may need to fill CNG once or more during your trip.\r\nAirport Entry/Parking charge is extra, if applicable is not included in the fare \r\nYour trip includes one pick up and one drop. It does not include within city travel.\r\nIf your Trip is Hill area, cab AC will be switched off.', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-05-06 16:42:11', 'Included', 'Included', 'Included', 'Included', 'Excluded', NULL),
(20, 1, 11, NULL, NULL, 1, 'Innova Crysta', NULL, 2991.00, 25, 30.00, '45', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-05-06 16:46:51', 'Included', 'Included', 'Included', 'Included', 'Excluded', '<p>Your Trip has a KM limit. If you usage extra km you will be charged for the extra KM.<br />\r\nYour cab can be a CNG vehicle. The driver may need to fill CNG once or more during your trip.<br />\r\nAirport Entry/Parking charge is extra, if applicable is not included in the fare&nbsp;<br />\r\nYour trip includes one pick up and one drop. It does not include within city travel.<br />\r\nIf your Trip is Hill area, cab AC will be switched off.</p>\r\n'),
(21, 1, 8, NULL, NULL, 2, 'Sedan', NULL, 2937.50, 250, 14.00, NULL, 'Your Trip has a KM and Hours limit. If your usage extra these limits, you will be charged for the extra KM and Hours used.\r\nAirport Entry/Parking charge is extra, if applicable is not included in the fare\r\nAll toll fees, parking charges, MCD, state tax etc. if applicable will be charged extra and need to be pay as per actuals.\r\nIf Running cab 10:00 PM to 06:00 AM on any of the nights, an  Night allowance will be applicable and is to be paid to the driver.\r\nPlease add your all trip plan cities you plan to visit. Adding city to the runnig trip may not be possible.\r\nIf your Trip is Hill area, cab AC will be switched off.\r\nYour cab can be a CNG vehicle. The driver may need to fill CNG once or more during your trip.', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-05-06 17:00:24', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', NULL),
(22, 1, 9, NULL, NULL, 2, 'Ertiga', NULL, 3762.50, 250, 16.00, NULL, 'Your Trip has a KM and Hours limit. If your usage extra these limits, you will be charged for the extra KM and Hours used.\r\nAirport Entry/Parking charge is extra, if applicable is not included in the fare\r\nAll toll fees, parking charges, MCD, state tax etc. if applicable will be charged extra and need to be pay as per actuals.\r\nIf Running cab 10:00 PM to 06:00 AM on any of the nights, an  Night allowance will be applicable and is to be paid to the driver.\r\nPlease add your all trip plan cities you plan to visit. Adding city to the runnig trip may not be possible.\r\nIf your Trip is Hill area, cab AC will be switched off.\r\nYour cab can be a CNG vehicle. The driver may need to fill CNG once or more during your trip.', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-05-06 17:22:16', 'Excluded', 'Excluded', 'Included', 'Included', 'Excluded', NULL),
(23, 1, 11, NULL, NULL, 2, 'Innova Crysta', NULL, 5375.00, 250, 23.00, NULL, 'Your Trip has a KM and Hours limit. If your usage extra these limits, you will be charged for the extra KM and Hours used.\r\nAirport Entry/Parking charge is extra, if applicable is not included in the fare\r\nAll toll fees, parking charges, MCD, state tax etc. if applicable will be charged extra and need to be pay as per actuals.\r\nIf Running cab 10:00 PM to 06:00 AM on any of the nights, an  Night allowance will be applicable and is to be paid to the driver.\r\nPlease add your all trip plan cities you plan to visit. Adding city to the runnig trip may not be possible.\r\nIf your Trip is Hill area, cab AC will be switched off.\r\nYour cab can be a CNG vehicle. The driver may need to fill CNG once or more during your trip.', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-05-06 17:43:44', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', NULL),
(24, 1, 12, NULL, NULL, 2, 'Tempoo Traveller', NULL, 8750.00, 250, 34.00, NULL, 'Your Trip has a KM and Hours limit. If your usage extra these limits, you will be charged for the extra KM and Hours used.\r\nAirport Entry/Parking charge is extra, if applicable is not included in the fare\r\nAll toll fees, parking charges, MCD, state tax etc. if applicable will be charged extra and need to be pay as per actuals.\r\nIf Running cab 10:00 PM to 06:00 AM on any of the nights, an  Night allowance will be applicable and is to be paid to the driver.\r\nPlease add your all trip plan cities you plan to visit. Adding city to the runnig trip may not be possible.\r\nIf your Trip is Hill area, cab AC will be switched off.\r\nYour cab can be a CNG vehicle. The driver may need to fill CNG once or more during your trip.', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-05-06 17:45:03', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', NULL),
(27, 1, 7, 33, 3, 1, 'Hatchback', NULL, 2000.00, 200, 200.00, '20', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-06 11:00:23', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(28, 1, 8, 33, 3, 1, 'Sedan', NULL, 1029.00, 10, 192.00, '10', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-06 11:00:27', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(29, 1, 9, 33, 3, 1, 'Ertiga', NULL, 2200.00, 200, 20.00, '12', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-06 11:00:27', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(30, 1, 11, 33, 3, 1, 'Innova Crysta', NULL, 2890.00, 290, 90.00, '19', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-06 11:00:27', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(31, 1, 12, 33, 3, 1, 'Tempoo Traveller', NULL, 1920.00, 19, 10.00, '19', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-06 11:00:27', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(32, 1, 13, 33, 3, 1, 'Innova Hycross ', NULL, 1900.00, 190, 190.00, '18', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-06 11:00:27', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(33, 1, 14, 33, 3, 1, 'Kia Carance ', NULL, 1920.00, 192, 102.00, '10', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-06 11:00:27', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(34, 1, 9, 33, NULL, 5, '2hrs/40kms ', NULL, 2000.00, 20, 14.00, '12', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-06 16:38:06', 'Excluded', 'Included', 'Included', 'Included', 'Included', ''),
(35, 1, 7, 6, NULL, 5, '1hr /10kms', NULL, 648.00, 10, 12.00, '12', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 10:19:20', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(36, 1, 8, 6, NULL, 5, '1hr /10kms', NULL, 676.00, 10, 14.00, '14', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 10:19:20', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(37, 1, 9, 6, NULL, 5, '1hr /10kms', NULL, 838.00, 10, 16.00, '15', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 10:19:20', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(38, 1, 11, 6, NULL, 5, '1hr /10kms', NULL, 2147.00, 10, 28.00, '28', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 10:19:20', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(39, 1, 12, 6, NULL, 5, '1hr /10kms', NULL, 5289.00, 10, 40.00, '40', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 10:19:20', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(40, 1, 13, 6, NULL, 5, '1hr /10kms', NULL, 2364.00, 10, 30.00, '30', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 10:19:20', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(41, 1, 7, 6, NULL, 5, '2hrs/20kms', NULL, 787.00, 2020, 12.00, '12', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:15:41', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(42, 1, 8, 6, NULL, 5, '2hrs/20kms', NULL, 826.00, 20, 14.00, '14', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:15:41', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(43, 1, 9, 6, NULL, 5, '2hrs/20kms', NULL, 1083.00, 20, 15.00, '15', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:15:41', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(44, 1, 11, 6, NULL, 5, '2hrs/20kms', NULL, 2428.00, 20, 28.00, '28', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:15:41', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(45, 1, 12, 6, NULL, 5, '2hrs/20kms', NULL, 5543.00, 20, 40.00, '40', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:15:41', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(46, 1, 13, 6, NULL, 5, '2hrs/20kms', NULL, 2713.00, 20, 30.00, '30', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:15:41', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(47, 1, 7, 6, NULL, 5, '3hrs/30km', NULL, 936.00, 30, 12.00, '12', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:28:08', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(48, 1, 8, 6, NULL, 5, '3hrs/30km', NULL, 1189.00, 30, 14.00, '14', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:28:08', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(49, 1, 9, 6, NULL, 5, '3hrs/30km', NULL, 1392.00, 30, 15.00, '15', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:28:08', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(50, 1, 11, 6, NULL, 5, '3hrs/30km', NULL, 2586.00, 30, 28.00, '28', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:28:08', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(51, 1, 12, 6, NULL, 5, '3hrs/30km', NULL, 5867.00, 30, 40.00, '40', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:28:08', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(52, 1, 13, 6, NULL, 5, '3hrs/30km', NULL, 2941.00, 30, 30.00, '30', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:28:08', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(53, 1, 7, 6, NULL, 5, '4hrs/40km', NULL, 1196.00, 40, 12.00, '12', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:32:34', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(54, 1, 8, 6, NULL, 5, '4hrs/40km', NULL, 1326.00, 40, 14.00, '14', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:32:34', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(55, 1, 9, 6, NULL, 5, '4hrs/40km', NULL, 1674.00, 40, 15.00, '15', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:32:34', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(56, 1, 11, 6, NULL, 5, '4hrs/40km', NULL, 2835.00, 40, 28.00, '28', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:32:34', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(57, 1, 12, 6, NULL, 5, '4hrs/40km', NULL, 6017.00, 40, 40.00, '40', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:32:34', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(58, 1, 13, 6, NULL, 5, '4hrs/40km', NULL, 3058.00, 40, 30.00, '30', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:32:34', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(59, 1, 7, 6, NULL, 5, '5hrs/50kms', NULL, 1428.00, 50, 12.00, '12', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:41:35', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(60, 1, 8, 6, NULL, 5, '5hrs/50kms', NULL, 1527.00, 50, 14.00, '14', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:41:35', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(61, 1, 9, 6, NULL, 5, '5hrs/50kms', NULL, 1879.00, 50, 15.00, '15', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:41:35', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(62, 1, 11, 6, NULL, 5, '5hrs/50kms', NULL, 2981.00, 50, 28.00, '28', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:41:35', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(63, 1, 12, 6, NULL, 5, '5hrs/50kms', NULL, 6223.00, 50, 40.00, '40', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:41:35', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(64, 1, 13, 6, NULL, 5, '5hrs/50kms', NULL, 3216.00, 50, 30.00, '30', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:41:35', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(65, 1, 7, 6, NULL, 5, '6hrs/60kms', NULL, 1563.00, 60, 12.00, '12', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:45:39', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(66, 1, 8, 6, NULL, 5, '6hrs/60kms', NULL, 1677.00, 60, 14.00, '14', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:45:39', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(67, 1, 9, 6, NULL, 5, '6hrs/60kms', NULL, 2058.00, 60, 15.00, '15', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:45:39', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(68, 1, 11, 6, NULL, 5, '6hrs/60kms', NULL, 3019.00, 60, 28.00, '28', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:45:39', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(69, 1, 12, 6, NULL, 5, '6hrs/60kms', NULL, 6582.00, 60, 40.00, '40', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:45:39', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(70, 1, 13, 6, NULL, 5, '6hrs/60kms', NULL, 3428.00, 60, 30.00, '30', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:45:39', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(71, 1, 7, 6, NULL, 5, '7hrs/70kms', NULL, 1689.00, 70, 12.00, '12', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:49:14', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(72, 1, 8, 6, NULL, 5, '7hrs/70kms', NULL, 1758.00, 70, 14.00, '14', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:49:14', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(73, 1, 9, 6, NULL, 5, '7hrs/70kms', NULL, 2192.00, 70, 15.00, '15', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:49:14', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(74, 1, 11, 6, NULL, 5, '7hrs/70kms', NULL, 3073.00, 70, 28.00, '28', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:49:14', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(75, 1, 12, 6, NULL, 5, '7hrs/70kms', NULL, 6854.00, 70, 40.00, '40', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:49:14', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(76, 1, 13, 6, NULL, 5, '7hrs/70kms', NULL, 3506.00, 70, 30.00, '30', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:49:14', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(77, 1, 7, 6, NULL, 5, '8hrs/80kms', NULL, 1784.00, 80, 12.00, '12', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:52:36', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(78, 1, 8, 6, NULL, 5, '8hrs/80kms', NULL, 1831.00, 80, 14.00, '14', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:52:36', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(79, 1, 9, 6, NULL, 5, '8hrs/80kms', NULL, 2356.00, 80, 15.00, '15', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:52:36', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(80, 1, 11, 6, NULL, 5, '8hrs/80kms', NULL, 3225.00, 80, 28.00, '28', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:52:36', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(81, 1, 12, 6, NULL, 5, '8hrs/80kms', NULL, 7209.00, 80, 40.00, '40', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:52:36', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(82, 1, 13, 6, NULL, 5, '8hrs/80kms', NULL, 3767.00, 80, 30.00, '30', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:52:36', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(83, 1, 7, 6, NULL, 5, '9hrs/90kms', NULL, 1842.00, 90, 12.00, '12', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:55:56', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(84, 1, 8, 6, NULL, 5, '9hrs/90kms', NULL, 1965.00, 90, 14.00, '14', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:55:56', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(85, 1, 9, 6, NULL, 5, '9hrs/90kms', NULL, 2538.00, 90, 15.00, '15', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:55:56', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(86, 1, 11, 6, NULL, 5, '9hrs/90kms', NULL, 3429.00, 90, 28.00, '28', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:55:56', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(87, 1, 12, 6, NULL, 5, '9hrs/90kms', NULL, 7433.00, 90, 40.00, '40', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:55:56', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(88, 1, 13, 6, NULL, 5, '9hrs/90kms', NULL, 3846.00, 90, 30.00, '30', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 18:55:56', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(89, 1, 7, 6, NULL, 5, '10hrs/100kms', NULL, 1986.00, 100, 12.00, '12', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:01:16', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(90, 1, 8, 6, NULL, 5, '10hrs/100kms', NULL, 2093.00, 100, 14.00, '14', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:01:16', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(91, 1, 9, 6, NULL, 5, '10hrs/100kms', NULL, 2689.00, 100, 15.00, '15', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:01:16', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(92, 1, 11, 6, NULL, 5, '10hrs/100kms', NULL, 3847.00, 100, 28.00, '28', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:01:16', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(93, 1, 12, 6, NULL, 5, '10hrs/100kms', NULL, 7739.00, 100, 40.00, '40', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:01:16', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(94, 1, 13, 6, NULL, 5, '10hrs/100kms', NULL, 4276.00, 100, 30.00, '30', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:01:16', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(95, 1, 7, 6, NULL, 5, '11hrs/110kms', NULL, 2092.00, 110, 12.00, '12', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:05:09', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(96, 1, 8, 6, NULL, 5, '11hrs/110kms', NULL, 2187.00, 110, 14.00, '14', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:05:09', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(97, 1, 9, 6, NULL, 5, '11hrs/110kms', NULL, 2874.00, 110, 15.00, '15', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:05:09', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(98, 1, 11, 6, NULL, 5, '11hrs/110kms', NULL, 4276.00, 110, 28.00, '28', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:05:09', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(99, 1, 12, 6, NULL, 5, '11hrs/110kms', NULL, 8259.00, 110, 40.00, '40', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:05:09', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(100, 1, 13, 6, NULL, 5, '11hrs/110kms', NULL, 4868.00, 110, 30.00, '30', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:05:09', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(101, 1, 7, 6, NULL, 5, '12hrs/120Kms ', NULL, 2264.00, 120, 12.00, '12', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:09:09', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(102, 1, 8, 6, NULL, 5, '12hrs/120Kms ', NULL, 2375.00, 120, 14.00, '14', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:09:09', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(103, 1, 9, 6, NULL, 5, '12hrs/120Kms ', NULL, 3048.00, 120, 15.00, '15', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:09:09', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(104, 1, 11, 6, NULL, 5, '12hrs/120Kms ', NULL, 4583.00, 120, 28.00, '28', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:09:09', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(105, 1, 12, 6, NULL, 5, '12hrs/120Kms ', NULL, 8751.00, 120, 40.00, '40', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:09:09', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(106, 1, 13, 6, NULL, 5, '12hrs/120Kms ', NULL, 5031.00, 120, 30.00, '30', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:09:09', 'Excluded', 'Excluded', 'Included', 'Excluded', 'Excluded', ''),
(107, 1, 7, 6, 31, 1, 'Hatchback', NULL, 2186.00, 0, 11.00, '11', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:18:17', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(108, 1, 8, 6, 31, 1, 'Sedan', NULL, 2284.00, 0, 12.00, '12', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:18:17', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(109, 1, 9, 6, 31, 1, 'Ertiga', NULL, 2889.00, 0, 15.00, '15', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:18:17', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(110, 1, 11, 6, 31, 1, 'Innova Crysta', NULL, 4776.00, 0, 26.00, '26', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:18:17', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(111, 1, 12, 6, 31, 1, 'Tempoo Traveller', NULL, 13666.00, 0, 36.00, '36', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:18:17', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(112, 1, 13, 6, 31, 1, 'Innova Hycross ', NULL, 6047.00, 0, 28.00, '28', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:18:17', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(113, 1, 14, 6, 31, 1, 'Kia Carance ', NULL, 3593.00, 0, 17.00, '17', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:18:17', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(114, 1, 7, 6, 32, 1, 'Hatchback', NULL, 2316.00, 0, 11.00, '11', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:27:05', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(115, 1, 8, 6, 32, 1, 'Sedan', NULL, 2439.00, 0, 12.00, '12', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:27:05', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(116, 1, 9, 6, 32, 1, 'Ertiga', NULL, 2934.00, 0, 15.00, '15', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:27:05', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(117, 1, 11, 6, 32, 1, 'Innova Crysta', NULL, 4682.00, 0, 26.00, '26', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:27:05', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(118, 1, 12, 6, 32, 1, 'Tempoo Traveller', NULL, 13811.00, 0, 36.00, '36', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:27:05', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(119, 1, 13, 6, 32, 1, 'Innova Hycross ', NULL, 6248.00, 0, 28.00, '28', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:27:05', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(120, 1, 14, 6, 32, 1, 'Kia Carance ', NULL, 3765.00, 0, 17.00, '17', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:27:05', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(121, 1, 7, 6, 33, 1, 'Hatchback', NULL, 2459.00, 0, 11.00, '11', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:34:20', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(122, 1, 8, 6, 33, 1, 'Sedan', NULL, 2592.00, 0, 12.00, '12', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:34:20', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(123, 1, 9, 6, 33, 1, 'Ertiga', NULL, 3453.00, 0, 15.00, '15', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:34:20', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(124, 1, 11, 6, 33, 1, 'Innova Crysta', NULL, 5378.00, 0, 26.00, '26', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:34:20', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(125, 1, 12, 6, 33, 1, 'Tempoo Traveller', NULL, 15756.00, 0, 36.00, '36', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:34:20', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(126, 1, 13, 6, 33, 1, 'Innova Hycross ', NULL, 6887.00, 0, 28.00, '28', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:34:20', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(127, 1, 14, 6, 33, 1, 'Kia Carance ', NULL, 4273.00, 0, 17.00, '17', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:34:20', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(128, 1, 7, 6, 45, 1, 'Hatchback', NULL, 2362.00, 0, 11.00, '11', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:40:13', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(129, 1, 8, 6, 45, 1, 'Sedan', NULL, 2487.00, 0, 12.00, '12', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:40:13', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(130, 1, 9, 6, 45, 1, 'Ertiga', NULL, 3248.00, 0, 15.00, '15', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:40:13', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(131, 1, 11, 6, 45, 1, 'Innova Crysta', NULL, 5236.00, 0, 26.00, '26', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:40:13', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(132, 1, 12, 6, 45, 1, 'Tempoo Traveller', NULL, 14847.00, 0, 36.00, '36', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:40:13', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(133, 1, 13, 6, 45, 1, 'Innova Hycross ', NULL, 6318.00, 0, 28.00, '28', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:40:13', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(134, 1, 14, 6, 45, 1, 'Kia Carance ', NULL, 3853.00, 0, 17.00, '17', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:40:13', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(135, 1, 7, 6, 44, 1, 'Hatchback', NULL, 2353.00, 0, 11.00, '11', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:47:06', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(136, 1, 8, 6, 44, 1, 'Sedan', NULL, 2413.00, 0, 12.00, '12', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:47:06', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(137, 1, 9, 6, 44, 1, 'Ertiga', NULL, 3062.00, 0, 15.00, '15', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:47:06', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(138, 1, 11, 6, 44, 1, 'Innova Crysta', NULL, 5874.00, 0, 26.00, '26', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:47:06', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(139, 1, 12, 6, 44, 1, 'Tempoo Traveller', NULL, 14688.00, 0, 36.00, '36', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:47:06', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(140, 1, 13, 6, 44, 1, 'Innova Hycross ', NULL, 6849.00, 0, 28.00, '28', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:47:06', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(141, 1, 14, 6, 44, 1, 'Kia Carance ', NULL, 3728.00, 0, 17.00, '17', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:47:06', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(142, 1, 7, 6, 65, 1, 'Hatchback', NULL, 2463.00, 0, 11.00, '11', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:56:47', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(143, 1, 8, 6, 65, 1, 'Sedan', NULL, 2542.00, 0, 12.00, '12', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:56:47', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(144, 1, 9, 6, 65, 1, 'Ertiga', NULL, 3217.00, 0, 15.00, '15', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:56:47', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(145, 1, 11, 6, 65, 1, 'Innova Crysta', NULL, 5274.00, 0, 26.00, '26', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:56:47', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(146, 1, 12, 6, 65, 1, 'Tempoo Traveller', NULL, 14893.00, 0, 36.00, '36', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:56:47', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(147, 1, 13, 6, 65, 1, 'Innova Hycross ', NULL, 6831.00, 0, 28.00, '28', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:56:47', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(148, 1, 14, 6, 65, 1, 'Kia Carance ', NULL, 3782.00, 0, 17.00, '17', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 19:56:47', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(149, 1, 7, 6, 66, 1, 'Hatchback', NULL, 3216.00, 0, 11.00, '11', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 20:08:03', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(150, 1, 8, 6, 66, 1, 'Sedan', NULL, 3358.00, 0, 12.00, '12', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 20:08:03', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(151, 1, 9, 6, 66, 1, 'Ertiga', NULL, 4074.00, 360, 14.00, '14', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 20:08:03', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(152, 1, 11, 6, 66, 1, 'Innova Crysta', NULL, 5567.00, 0, 26.00, '26', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 20:08:03', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(153, 1, 12, 6, 66, 1, 'Tempoo Traveller', NULL, 19427.00, 0, 36.00, '36', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 20:08:03', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(154, 1, 13, 6, 66, 1, 'Innova Hycross ', NULL, 9423.00, 0, 28.00, '28', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 20:08:03', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(155, 1, 14, 6, 66, 1, 'Kia Carance ', NULL, 4719.00, 0, 17.00, '17', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 20:08:03', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(156, 1, 7, 6, 67, 1, 'Hatchback', NULL, 3279.00, 0, 11.00, '11', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 20:11:56', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(157, 1, 8, 6, 67, 1, 'Sedan', NULL, 3356.00, 0, 12.00, '12', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 20:11:56', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(158, 1, 9, 6, 67, 1, 'Ertiga', NULL, 4234.00, 0, 14.00, '14', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 20:11:56', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(159, 1, 11, 6, 67, 1, 'Innova Crysta', NULL, 5692.00, 0, 26.00, '26', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 20:11:56', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(160, 1, 12, 6, 67, 1, 'Tempoo Traveller', NULL, 18428.00, 0, 36.00, '36', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 20:11:56', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(161, 1, 13, 6, 67, 1, 'Innova Hycross ', NULL, 9678.00, 0, 28.00, '28', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 20:11:56', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(162, 1, 14, 6, 67, 1, 'Kia Carance ', NULL, 4782.00, 0, 17.00, '17', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 20:11:56', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(163, 1, 7, 6, 68, 1, 'Hatchback', NULL, 2293.00, 0, 11.00, '11', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 20:22:14', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(164, 1, 8, 6, 68, 1, 'Sedan', NULL, 2376.00, 0, 12.00, '12', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 20:22:14', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(165, 1, 9, 6, 68, 1, 'Ertiga', NULL, 2896.00, 0, 14.00, '14', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 20:22:14', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(166, 1, 11, 6, 68, 1, 'Innova Crysta', NULL, 4759.00, 0, 26.00, '26', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 20:22:14', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(167, 1, 12, 6, 68, 1, 'Tempoo Traveller', NULL, 10365.00, 0, 36.00, '36', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 20:22:14', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(168, 1, 13, 6, 68, 1, 'Innova Hycross ', NULL, 6028.00, 0, 28.00, '28', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 20:22:14', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(169, 1, 14, 6, 68, 1, 'Kia Carance ', NULL, 3624.00, 0, 17.00, '17', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 20:22:14', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(170, 1, 7, 6, 69, 1, 'Hatchback', NULL, 2979.00, 0, 11.00, '11', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 20:30:16', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(171, 1, 8, 6, 69, 1, 'Sedan', NULL, 3093.00, 0, 12.00, '12', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 20:30:16', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(172, 1, 9, 6, 69, 1, 'Ertiga', NULL, 3647.00, 0, 14.00, '14', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 20:30:16', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(173, 1, 11, 6, 69, 1, 'Innova Crysta', NULL, 5281.00, 0, 26.00, '26', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 20:30:16', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(174, 1, 12, 6, 69, 1, 'Tempoo Traveller', NULL, 11952.00, 0, 36.00, '36', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 20:30:16', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(175, 1, 13, 6, 69, 1, 'Innova Hycross ', NULL, 7294.00, 0, 28.00, '28', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 20:30:16', 'Included', 'Included', 'Included', 'Included', 'Excluded', ''),
(176, 1, 14, 6, 69, 1, 'Kia Carance ', NULL, 4068.00, 0, 17.00, '17', '', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-08 20:30:16', 'Included', 'Included', 'Included', 'Included', 'Excluded', '');

-- --------------------------------------------------------

--
-- Table structure for table `car_brands`
--

CREATE TABLE `car_brands` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `tagline` varchar(255) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `seo_title` varchar(255) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL,
  `seo_schema` longtext DEFAULT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `car_brands`
--

INSERT INTO `car_brands` (`id`, `name`, `logo`, `tagline`, `description`, `seo_title`, `meta_description`, `meta_keywords`, `seo_schema`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Honda', './assets/car_brands/brand_1775041816.png', 'Honda Cars', '', 'Honda - Premium Taxi Services | Choose A Taxi', 'Experience the best travel with Honda. Honda Cars. Book your ride now for a comfort and safe journey with Choose A Taxi.', 'Honda, taxi service, car rental, Honda cab, book taxi online', '{\n    \"@context\": \"https://schema.org\",\n    \"@type\": \"Brand\",\n    \"name\": \"Honda\",\n    \"description\": \"Honda Cars\",\n    \"url\": \"https://chooseataxi.com/brands/honda\"\n}', 'Active', '2026-04-01 11:10:16', '2026-04-01 11:10:16');

-- --------------------------------------------------------

--
-- Table structure for table `car_types`
--

CREATE TABLE `car_types` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `passengers` int(11) DEFAULT 4,
  `luggage` int(11) DEFAULT 2,
  `image` varchar(255) DEFAULT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `car_types`
--

INSERT INTO `car_types` (`id`, `name`, `passengers`, `luggage`, `image`, `status`, `created_at`, `updated_at`) VALUES
(7, 'Hatchback', 3, 2, 'assets/car_types/car_type_1775239429.png', 'Active', '2026-04-03 18:03:49', '2026-04-03 18:03:49'),
(8, 'Sedan', 4, 3, 'assets/car_types/car_type_1775239887.png', 'Active', '2026-04-03 18:11:27', '2026-04-03 18:11:27'),
(9, 'Ertiga', 6, 5, 'assets/car_types/car_type_1775239973.jpg', 'Active', '2026-04-03 18:12:53', '2026-04-03 18:12:53'),
(11, 'Innova Crysta', 6, 5, 'assets/car_types/car_type_1775240773.jpg', 'Active', '2026-04-03 18:26:13', '2026-04-03 18:26:13'),
(12, 'Tempoo Traveller', 12, 8, 'assets/car_types/car_type_1775240945.jpeg', 'Active', '2026-04-03 18:29:05', '2026-04-03 18:29:05'),
(13, 'Innova Hycross ', 6, 5, 'assets/car_types/car_type_1775322458.png', 'Active', '2026-04-04 17:07:38', '2026-04-04 17:07:38'),
(14, 'Kia Carance ', 6, 4, 'assets/car_types/car_type_1776258519.png', 'Active', '2026-04-15 13:08:39', '2026-04-15 13:08:39');

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `id` int(11) NOT NULL,
  `state_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cities`
--

INSERT INTO `cities` (`id`, `state_id`, `name`, `status`, `created_at`) VALUES
(1, 1, 'Jind', 'Active', '2026-05-22 07:06:26'),
(2, 1, 'Kaithal', 'Active', '2026-05-24 18:52:13'),
(3, 1, 'Ambala', 'Active', '2026-05-24 18:52:27'),
(4, 1, 'chandigarh', 'Active', '2026-05-24 18:52:49'),
(5, 7, 'noida', 'Active', '2026-05-25 09:21:18'),
(6, 5, 'delhi', 'Active', '2026-05-25 09:21:40'),
(7, 1, 'gurugram', 'Active', '2026-05-25 09:22:04'),
(8, 1, 'gurgaon', 'Active', '2026-05-25 09:22:20'),
(9, 1, 'manesar', 'Active', '2026-05-25 09:22:35'),
(10, 1, 'rohtak', 'Active', '2026-05-25 09:22:51'),
(11, 1, 'hisar', 'Active', '2026-05-25 09:23:04'),
(12, 1, 'rewari', 'Active', '2026-05-25 09:23:21'),
(13, 1, 'sirsa', 'Active', '2026-05-25 09:23:45'),
(14, 1, 'sonipat', 'Active', '2026-05-25 09:24:44'),
(15, 1, 'jhajjar', 'Active', '2026-05-25 09:25:02'),
(16, 1, 'panipat', 'Active', '2026-05-25 09:25:25'),
(17, 1, 'kurukshetra', 'Active', '2026-05-25 09:25:42'),
(18, 1, 'karnal', 'Active', '2026-05-25 09:25:54'),
(20, 1, 'narnaul', 'Active', '2026-05-25 09:26:29'),
(21, 1, 'bhiwani', 'Active', '2026-05-25 09:26:47'),
(22, 1, 'bahadurgarh', 'Active', '2026-05-25 09:27:33'),
(23, 7, 'noida', 'Active', '2026-05-25 09:28:08'),
(24, 7, 'greater Noida', 'Active', '2026-05-25 09:28:26'),
(25, 7, 'meerut', 'Active', '2026-05-25 09:28:42'),
(26, 7, 'muzaffarnagar', 'Active', '2026-05-25 09:29:24'),
(27, 7, 'hapur', 'Active', '2026-05-25 09:29:37'),
(28, 7, 'garh mukteshwar', 'Active', '2026-05-25 09:30:23'),
(29, 7, 'khurja', 'Active', '2026-05-25 09:30:47'),
(30, 7, 'aligarh', 'Active', '2026-05-25 09:31:04'),
(31, 7, 'Vrindavan', 'Active', '2026-05-25 09:31:25'),
(32, 7, 'mathura', 'Active', '2026-05-25 09:31:49'),
(33, 7, 'agra', 'Active', '2026-05-25 09:32:03'),
(34, 7, 'palwal', 'Active', '2026-05-25 09:32:31'),
(35, 7, 'tundla', 'Active', '2026-05-25 09:33:00'),
(36, 7, 'firozabad', 'Active', '2026-05-25 09:33:21'),
(37, 7, 'shikohabad', 'Active', '2026-05-25 09:34:12'),
(38, 7, 'etawah', 'Active', '2026-05-25 09:35:05'),
(39, 7, 'mainpuri', 'Active', '2026-05-25 09:36:59'),
(40, 7, 'kannauj', 'Active', '2026-05-25 09:37:33'),
(41, 7, 'kanpur', 'Active', '2026-05-25 09:37:55'),
(42, 7, 'lucknow', 'Active', '2026-05-25 09:38:41'),
(43, 7, 'prayagraj', 'Active', '2026-05-25 09:39:29'),
(44, 7, 'barsana', 'Active', '2026-05-25 09:39:47'),
(45, 7, 'goverdhan', 'Active', '2026-05-25 09:40:14'),
(46, 7, 'shahjahanpur', 'Active', '2026-05-25 09:41:41'),
(47, 7, 'bareilly', 'Active', '2026-05-25 09:42:27'),
(48, 7, 'aonla', 'Active', '2026-05-25 09:43:01'),
(49, 7, 'budaun', 'Active', '2026-05-25 09:43:32'),
(50, 7, 'amroha', 'Active', '2026-05-25 09:44:10'),
(51, 7, 'Moradabad', 'Active', '2026-05-25 09:44:50'),
(52, 7, 'rampur', 'Active', '2026-05-25 09:45:05'),
(53, 7, 'bijnor', 'Active', '2026-05-25 09:45:46'),
(54, 7, 'dhampur', 'Active', '2026-05-25 09:46:59'),
(55, 7, 'khatauli', 'Active', '2026-05-25 09:48:24'),
(56, 7, 'deoband', 'Active', '2026-05-25 09:49:12'),
(57, 7, 'saharanpur', 'Active', '2026-05-25 09:50:04'),
(58, 7, 'shamli', 'Active', '2026-05-25 09:50:47'),
(59, 7, 'gajraula', 'Active', '2026-05-25 09:51:33'),
(60, 7, 'pilibhit', 'Active', '2026-05-25 09:52:10'),
(61, 7, 'varanasi', 'Active', '2026-05-25 09:52:58'),
(62, 1, 'yamuna nagar', 'Active', '2026-05-25 09:54:37'),
(64, 1, 'pehowa', 'Active', '2026-05-25 09:56:46'),
(65, 7, 'gokul', 'Active', '2026-06-08 19:47:55'),
(66, 8, 'jaipur', 'Active', '2026-06-08 19:59:25'),
(67, 8, 'kukas', 'Active', '2026-06-08 20:00:11'),
(68, 8, 'neemrana', 'Active', '2026-06-08 20:13:33'),
(69, 8, 'kotputli', 'Active', '2026-06-08 20:14:06');

-- --------------------------------------------------------

--
-- Table structure for table `commission_requests`
--

CREATE TABLE `commission_requests` (
  `id` int(11) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `acceptance_id` int(11) NOT NULL,
  `raw_amount` decimal(10,2) NOT NULL,
  `service_charge` decimal(10,2) NOT NULL,
  `final_amount` decimal(10,2) NOT NULL,
  `status` enum('Processing','Approved','Rejected') DEFAULT 'Processing',
  `admin_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `commission_requests`
--

INSERT INTO `commission_requests` (`id`, `partner_id`, `booking_id`, `acceptance_id`, `raw_amount`, `service_charge`, `final_amount`, `status`, `admin_note`, `created_at`, `updated_at`) VALUES
(1, 4, 2627652, 26, 50.00, 1.50, 48.50, 'Rejected', 'Nill', '2026-04-30 09:11:02', '2026-05-05 20:17:14'),
(2, 4, 2627652, 27, 50.00, 1.50, 48.50, 'Processing', NULL, '2026-04-30 13:46:30', '2026-04-30 13:46:30'),
(3, 4, 2627652, 27, 50.00, 1.50, 48.50, 'Processing', NULL, '2026-05-01 08:55:40', '2026-05-01 08:55:40'),
(4, 4, 2627652, 27, 50.00, 1.50, 48.50, 'Processing', NULL, '2026-05-01 17:45:11', '2026-05-01 17:45:11');

-- --------------------------------------------------------

--
-- Table structure for table `drivers`
--

CREATE TABLE `drivers` (
  `id` int(11) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `login_otp` varchar(10) DEFAULT NULL,
  `license_number` varchar(50) NOT NULL,
  `dob` date NOT NULL,
  `doe` date DEFAULT NULL,
  `doi` date DEFAULT NULL,
  `gender` enum('M','F','X') DEFAULT NULL,
  `father_or_husband_name` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `permanent_address` text DEFAULT NULL,
  `profile_image_path` text DEFAULT NULL,
  `blood_group` varchar(10) DEFAULT NULL,
  `vehicle_classes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`vehicle_classes`)),
  `status` enum('Active','Inactive','Suspended') DEFAULT 'Active',
  `is_partner_self` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fcm_token` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `drivers`
--

INSERT INTO `drivers` (`id`, `partner_id`, `full_name`, `phone`, `login_otp`, `license_number`, `dob`, `doe`, `doi`, `gender`, `father_or_husband_name`, `state`, `permanent_address`, `profile_image_path`, `blood_group`, `vehicle_classes`, `status`, `is_partner_self`, `created_at`, `updated_at`, `fcm_token`) VALUES
(1, 4, 'ROSHAN LAL JAT', NULL, NULL, 'RJ3019980016207', '1976-12-23', '2026-12-22', '2014-02-10', 'X', 'MADHAV  LAL', 'Rajasthan', '492 MAYA BHAWAN, PUL KE PAAS THOKAR CHOURAHA, GIRWA,UDAIPUR,RJ', 'https://chooseataxi.com/uploads/drivers/driver_4_1775329343.jpg', NULL, '[\"TRANS\",\"MCWG\",\"LMV\"]', 'Active', 1, '2026-04-04 19:02:23', '2026-04-04 19:02:23', NULL),
(3, 4, 'MOHAMMED YOUNUS', '8059982049', NULL, 'KA4120190001732', '1998-10-24', '2039-01-22', '2019-01-23', 'X', 'ABDUL LATHEEF', 'Karnataka', 'KENGERI HOBLI DODDABASTHI ULLAL UPANAGAR, Bangalore North,Bangalore,KA', 'https://chooseataxi.com/uploads/drivers/driver_4_1775329589.jpg', NULL, '[\"LMV\",\"MCWG\"]', 'Active', 0, '2026-04-04 19:06:29', '2026-04-25 20:10:04', NULL),
(7, 14, 'MANISH  KUMAR', '8058602516', NULL, 'RJ0220180013281', '1999-02-09', '2038-09-12', '2018-09-13', 'X', 'FATE  SINGH', 'Rajasthan', 'JHOROLI, Jhadoli, Alwar,RJ', 'https://chooseataxi.com/uploads/drivers/driver_14_1776008819.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 1, '2026-04-12 15:46:59', '2026-05-08 20:24:04', NULL),
(9, 24, 'AKHILESH KUMAR PATEL', '9643324332', NULL, 'UP6620100004954', '1990-07-17', '2030-10-29', '2010-10-30', 'X', 'AWADH NARAYAN  PATEL', 'Uttar Pradesh', 'KHETALPUR, UCHETHA, AURAI,BHADOHI', 'https://chooseataxi.com/uploads/drivers/driver_24_1778050020.jpg', NULL, '[\"LMV\",\"TRANS\",\"MCWG\"]', 'Active', 0, '2026-05-06 06:47:00', '2026-05-06 06:47:00', NULL),
(10, 24, 'ATINDER PAL SINGH', '9899595000', NULL, 'RJ1320070077097', '1988-11-19', '2031-09-26', '2021-09-27', 'X', 'MANJIT  SINGH', 'Delhi', 'FLAT-A 6 UGF PLOT NO-518 TRANSFER GALI, VEDANSH APARTMENT, Neb sarai,South Delhi,DELHI', 'https://chooseataxi.com/uploads/drivers/driver_24_1778050217.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 1, '2026-05-06 06:50:17', '2026-05-06 06:50:17', NULL),
(11, 24, 'BIJENDER  KUMAR', '7351601405', NULL, 'UP1519940002509', '1974-04-04', '2030-09-19', '2020-09-20', 'X', 'RAM  SINGH', 'Uttar Pradesh', 'VPO-  BEHSUMA, MEERUT, MAWANA,MEERUT,UP', 'https://chooseataxi.com/uploads/drivers/driver_24_1778050363.jpg', NULL, '[\"TRANS\",\"LMV\"]', 'Active', 0, '2026-05-06 06:52:43', '2026-05-06 06:52:43', NULL),
(12, 24, 'JAIPAL VERMA', '9899534973', NULL, 'DL0420160406336', '1997-11-10', '2036-11-22', '2016-11-23', 'X', 'MAHESH CHAND', 'Delhi', 'R-808 CAMP NO -5 JWALA PURI, SUNDER VIHAR,DELHI', 'https://chooseataxi.com/uploads/drivers/driver_24_1778050458.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 0, '2026-05-06 06:54:18', '2026-05-06 06:54:18', NULL),
(13, 24, 'SONU  KUMAR', '9286928826', NULL, 'DL520070337064', '1986-04-01', '2027-05-25', '2007-05-26', 'X', 'LAXMI  CHAND', 'Uttar Pradesh', 'D-1080 GL-8, ASHOK NAGAR, VIJOLI,AGRA', 'https://chooseataxi.com/uploads/drivers/driver_24_1778050541.jpg', NULL, '[\"TRANS\",\"MCWG\",\"LMV\"]', 'Active', 0, '2026-05-06 06:55:41', '2026-05-06 06:55:41', NULL),
(14, 24, 'MUKESH  PATEL', '8780348064', NULL, 'GJ0520130008299', '1991-10-15', '2033-02-10', '2022-04-29', 'X', 'SHRIBEJNATHA', 'Gujarat', 'A-S, GREEN AVENUE FLATS, OPP. T,G, B RESTAURANT, SURAT CITY,SURAT', 'https://chooseataxi.com/uploads/drivers/driver_24_1778050640.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 0, '2026-05-06 06:57:20', '2026-05-06 06:57:20', NULL),
(15, 24, 'RAM  SINGH', '9601134904', NULL, 'UP7020130023608', '1990-04-15', '2033-07-19', '2013-07-20', 'X', 'PREM BAHADUR  SINGH', 'Uttar Pradesh', 'BELA CHAUHAN, BHARATGANJ, MANDA, MEJA,PRAYAGRAJ,UP', 'https://chooseataxi.com/uploads/drivers/driver_24_1778050868.jpg', NULL, '[\"TRANS\",\"MCWG\",\"LMV\"]', 'Active', 0, '2026-05-06 07:01:08', '2026-05-06 07:01:08', NULL),
(16, 24, 'PREMLAL  MANJHI', '8448045286', NULL, 'JH1720160012562', '1991-03-10', '2036-09-16', '2016-09-17', 'X', 'JADU MANJHI', 'Jharkhand', 'AT-GHAT PAHARPUR,PO-MOHANPUR, PS-GODDA,DIST-GODDA,JHARKHAND, GODDA', 'https://chooseataxi.com/uploads/drivers/driver_24_1778050982.jpg', NULL, '[\"LMV\",\"MCWG\"]', 'Active', 0, '2026-05-06 07:03:02', '2026-05-06 07:03:02', NULL),
(17, 24, 'SUNIL KUMAR YADAV', '7844930800', NULL, 'UP6620200004485', '2000-07-08', '2040-07-07', '2020-07-17', 'X', 'SHYAMLAL  YADAV', 'Uttar Pradesh', '', 'https://chooseataxi.com/uploads/drivers/driver_24_1778051410.jpg', NULL, '[\"LMV\",\"MCWG\"]', 'Active', 0, '2026-05-06 07:10:10', '2026-05-06 07:10:10', NULL),
(18, 24, 'RAMESH KUMAR CHAUHAN', '6387887940', NULL, 'UP6620220005117', '2000-03-05', '2040-03-04', '2022-05-21', 'X', 'RAM DHANI CHAUHAN', 'Uttar Pradesh', '', 'https://chooseataxi.com/uploads/drivers/driver_24_1778051897.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 0, '2026-05-06 07:18:17', '2026-05-06 07:18:17', NULL),
(19, 24, 'JASWANT  SINGH', '8756308721', NULL, 'UP7020110021045', '1992-02-05', '2031-07-06', '2011-07-07', 'X', 'RAM CHANDRA', 'Uttar Pradesh', '207,GOVINDPUR TEWAROU, MANDAWARA, Allahabad,UP', 'https://chooseataxi.com/uploads/drivers/driver_24_1778052282.jpg', NULL, '[\"LMV\",\"MCWG\"]', 'Active', 0, '2026-05-06 07:24:42', '2026-05-06 07:24:42', NULL),
(20, 24, 'DEEPAK', '9068171064', NULL, 'UP8520210000764', '2000-07-05', '2040-07-04', '2021-01-11', 'X', 'JAY  RAM', 'Uttar Pradesh', 'KAMAI, Kamai, Chhata,Mathura,UP', 'https://chooseataxi.com/uploads/drivers/driver_24_1778052356.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 0, '2026-05-06 07:25:56', '2026-05-06 07:25:56', NULL),
(21, 24, 'GAJENDRA', '8290858132', NULL, 'RJ0520180012920', '1999-07-10', '2038-09-10', '2018-09-11', 'X', 'LAL  SINGH', 'Rajasthan', 'NAGLA TERHIYA, Sewar Khurd, Bharatpur,RJ', 'https://chooseataxi.com/uploads/drivers/driver_24_1778052458.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 0, '2026-05-06 07:27:38', '2026-05-06 07:27:38', NULL),
(22, 24, 'VIDHAN SINGH', '9696321725', NULL, 'UP7220230023075', '2000-01-06', '2040-01-05', '2023-11-06', 'X', 'SURENDRA BAHADUR SINGH', 'Uttar Pradesh', '', 'https://chooseataxi.com/uploads/drivers/driver_24_1778052526.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 0, '2026-05-06 07:28:46', '2026-05-06 07:28:46', NULL),
(23, 24, 'RAVI  KUMAR', '8287684918', NULL, 'HR2220230005375', '1999-12-30', '2039-12-29', '2023-11-28', 'X', 'RAM  SAWROOP', 'Haryana', 'SHAKTI NAGAR, FATEHABAD (M CL), FATEHABAD,HR', 'https://chooseataxi.com/uploads/drivers/driver_24_1778052997.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 0, '2026-05-06 07:36:37', '2026-05-06 07:36:37', NULL),
(24, 24, 'SATYAM  SINGH', '9616504801', NULL, 'UP7020240019268', '2003-08-29', '2043-08-28', '2024-04-05', 'X', 'PREM BAHADUR  SINGH', 'Uttar Pradesh', 'ITIHA, IBRAHIMPUR, Handia,Prayagraj,UP', 'https://chooseataxi.com/uploads/drivers/driver_24_1778053183.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 0, '2026-05-06 07:39:43', '2026-05-06 07:39:43', NULL),
(25, 24, 'CHANDAN KUMAR', '9910506830', NULL, 'UP1620160019056', '1993-01-01', '2036-08-11', '2016-08-12', 'X', 'MANJU DEVI', 'Uttar Pradesh', 'CHAJARSI COLONY, SEC-63, NOIDA, G B NAGAR, 9910506830', 'https://chooseataxi.com/uploads/drivers/driver_24_1778053443.jpg', NULL, '[\"LMV\"]', 'Active', 0, '2026-05-06 07:44:03', '2026-05-06 07:44:03', NULL),
(26, 24, 'SHIVAM', '9217948007', NULL, 'DL320190003912', '1998-02-16', '2039-05-01', '2019-05-02', 'X', 'BALBIR', 'Delhi', 'H NO-43/2, INDIRA ENCLAVE, Neb sarai,South Delhi,DELHI', 'https://chooseataxi.com/uploads/drivers/driver_24_1778054090.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 0, '2026-05-06 07:54:50', '2026-05-06 07:54:50', NULL),
(27, 67, 'MAROOF ALI', '8882911218', NULL, 'HR0620190006460', '1990-07-21', '2039-07-18', '2019-07-19', 'X', 'MAHBOOB', 'Haryana', 'H NO 3543, JAGDISH NAGAR BABAIL ROAD, PANIPAT,HR', 'https://chooseataxi.com/uploads/drivers/driver_67_1778076744.jpg', NULL, '[\"MCWG\",\"TRCTOR\",\"LMV\"]', 'Active', 1, '2026-05-06 14:12:24', '2026-05-06 14:12:24', NULL),
(28, 21, 'SALMAN', '7827156364', NULL, 'UP8320190008367', '2000-01-01', '2039-12-31', '2019-09-05', 'X', 'AVRAR  AHMAD', 'Uttar Pradesh', '824 GALI NO 13 KASHAMIRI GATE, FIROZABAD (NPP), FIROZABAD,UP', 'https://chooseataxi.com/uploads/drivers/driver_21_1778087490.jpg', NULL, '[\"LMV\",\"MCWOG\"]', 'Active', 0, '2026-05-06 17:11:30', '2026-05-06 17:11:30', NULL),
(29, 72, 'BALESHWAR  SHARMA', '7503999212', NULL, 'UP1420080011331', '1981-01-17', '2028-08-18', '2008-08-19', 'X', 'DINESH  KUMAR', 'Uttar Pradesh', 'B-356 BLOCK-B UTTRANCHAL VIHAR, LONI DEHAT, GHAZIABAD', 'https://chooseataxi.com/uploads/drivers/driver_72_1778131273.jpg', NULL, '[\"LMV\",\"TRANS\",\"MCWG\"]', 'Active', 1, '2026-05-07 05:21:13', '2026-05-07 05:21:13', NULL),
(30, 75, 'MOSEEM RAO', '9812802192', NULL, 'HR7120160043698', '1992-04-15', '2036-03-10', '2016-03-11', 'X', 'IRFAN RAO', 'Haryana', '#  5/309 PATHANA MOHALLA, CHHACHHRAULI, DISTT. YAMUNA NAGAR', 'https://chooseataxi.com/uploads/drivers/driver_75_1778137253.jpg', NULL, '[\"LMV\",\"MCWG\",\"TRCTOR\"]', 'Active', 1, '2026-05-07 07:00:53', '2026-05-07 07:00:53', NULL),
(31, 117, 'ANWAR  KHAN', '9311251979', NULL, 'UP1320020056870', '1981-05-01', '2031-09-03', '2021-09-04', 'X', 'NAVI  KHAN', 'Uttar Pradesh', 'H.NO -55 KOURALI, POST  DARIYAPUR, BULANDSHAHR', 'https://chooseataxi.com/uploads/drivers/driver_117_1778206187.jpg', NULL, '[\"LMV\",\"TRANS\",\"MCWG\"]', 'Active', 1, '2026-05-08 02:09:47', '2026-05-08 02:09:59', NULL),
(32, 85, 'ANIKET  BAWA', '6239589593', NULL, 'JK0820250002114', '2001-10-03', '2041-10-02', '2025-06-16', 'X', 'SUNIT  KUMAR', 'Jammu and Kashmir', '', 'https://chooseataxi.com/uploads/drivers/driver_85_1778263099.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 1, '2026-05-08 17:58:19', '2026-05-08 17:58:19', NULL),
(33, 95, 'RAMJAN', '7053932219', NULL, 'UP3620260001525', '1998-02-02', '2038-02-01', '2026-01-21', 'X', 'AKHTAR  HUSSAIN', 'Uttar Pradesh', '', 'https://chooseataxi.com/uploads/drivers/driver_95_1778287667.jpg', NULL, '[\"LMV\",\"MCWG\"]', 'Active', 1, '2026-05-09 00:47:47', '2026-05-09 00:47:47', NULL),
(34, 101, 'SHYAM  SUNDAR', '9410041244', NULL, 'UP8519946070105', '1972-01-01', '2031-12-31', '2022-06-25', 'X', 'BHAJAN  LAL', 'Uttar Pradesh', '01, OM NAGAR JANM BHOOMI LINK ROAD KRISHNA NAGAR, MATHURA BANGAR MATHURA', 'https://chooseataxi.com/uploads/drivers/driver_101_1778289824.jpg', NULL, '[\"LMV\"]', 'Active', 1, '2026-05-09 01:23:44', '2026-05-09 01:23:44', NULL),
(35, 31, 'AMAR  KUMAR', '7428731900', NULL, 'DL1319930011420', '1973-08-19', '2033-08-18', '2023-08-23', 'X', '......SHIV  CHARAN', 'Delhi', '21 NEW LAYAL PUR COLONY RAM MANDIR, KRISHNA NAGAR,EAST DELHI', 'https://chooseataxi.com/uploads/drivers/driver_31_1778296806.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 1, '2026-05-09 03:20:06', '2026-05-09 03:20:06', NULL),
(36, 151, 'HARISH CHANDRA  SINGH', '9717755106', NULL, 'MP20 20060097080', '1986-06-30', '2035-12-07', '2015-12-08', 'X', 'J S MEHR', 'Madhya Pradesh', 'PROFESSORS CLY, D BLOCK, PACHPEDI, JABALPUR', 'https://chooseataxi.com/uploads/drivers/driver_151_1778328233.jpg', NULL, '[\"TRANS\",\"LMV\"]', 'Active', 1, '2026-05-09 12:03:53', '2026-05-09 12:03:53', NULL),
(37, 107, 'GULSHAN  KUMAR', '8433432542', '8471', 'UK1920220005021', '1992-06-01', '2032-10-02', '2022-10-03', 'X', 'HARISH  CHANDRA', 'Uttarakhand', '', 'https://chooseataxi.com/uploads/drivers/driver_107_1778333888.jpg', NULL, '[\"LMV\",\"MCWG\"]', 'Active', 1, '2026-05-09 13:38:08', '2026-06-11 08:32:36', NULL),
(38, 176, 'RAJ  KUMAR', '8755089487', NULL, 'UP8520170017820', '1998-07-07', '2037-12-05', '2017-12-06', 'X', 'FAURAN  SINGH', 'Uttar Pradesh', 'SADDIKPUR, BAJNA NAUJHEEL, MATHURA', 'https://chooseataxi.com/uploads/drivers/driver_176_1778396656.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 1, '2026-05-10 07:04:16', '2026-05-10 07:04:16', NULL),
(39, 40, 'JAGJIT SINGH', '9817217571', NULL, 'HR2520150036390', '1988-10-15', '2035-02-15', '2015-02-16', 'X', 'RAJINDER SINGH', 'Haryana', 'VILL.GIDDAR KHERA, TEH.DABWALI, GIDDAR KHERA(287),SIRSA', 'https://chooseataxi.com/uploads/drivers/driver_40_1778396716.jpg', NULL, '[\"MCWG\",\"LMV\",\"TRANS\"]', 'Active', 1, '2026-05-10 07:05:16', '2026-05-10 07:05:16', NULL),
(40, 175, 'SANDEEP  KUMAR', '9198929585', NULL, 'UP2720130000833', '1990-04-20', '2033-01-22', '2013-01-23', 'X', 'VEERENDRA  KUMAR', 'Uttar Pradesh', 'KURSANDA, P/S.SINDHOLI, SHAHJAHANPUR', 'https://chooseataxi.com/uploads/drivers/driver_175_1778404023.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 1, '2026-05-10 09:07:03', '2026-05-10 09:07:03', NULL),
(41, 50, 'RAMAVATAR  SAINI', '9783074132', NULL, 'RJ0220150019449', '1991-04-10', '2035-09-15', '2015-09-16', 'X', 'UMARAV  SAINI', 'Rajasthan', 'VILL - AJEEJAPUR, TEH- MUNDAWAR, ALWAR , RAJ', 'https://chooseataxi.com/uploads/drivers/driver_50_1778409011.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 1, '2026-05-10 10:30:11', '2026-05-10 10:30:11', NULL),
(42, 50, 'MAHENDRA KUMAR SAINI', '8890850954', NULL, 'RJ0220090230693', '1990-05-10', '2029-09-01', '2009-09-02', 'X', 'RAMJI LAL SAINI', 'Rajasthan', '0, 0, AZIZPUR,ALWAR,RJ', 'https://chooseataxi.com/uploads/drivers/driver_50_1778409190.jpg', NULL, '[\"LMV\",\"MCWG\"]', 'Active', 1, '2026-05-10 10:33:10', '2026-05-10 10:33:10', NULL),
(43, 83, 'BIJENDER SINGH', '7015085106', NULL, 'HR1920120055141', '1982-03-01', '2032-02-28', '2012-06-15', 'X', 'SATBIR SINGH', 'Haryana', 'R/O- W.NO-01, NR. TEJAB FACTORY, CHARKHI DADRI, DADRI,BHIWANI', 'https://chooseataxi.com/uploads/drivers/driver_83_1778418787.jpg', NULL, '[\"LMV\",\"MCWG\",\"TRCTOR\"]', 'Active', 1, '2026-05-10 13:13:07', '2026-05-10 13:13:07', NULL),
(44, 168, 'SHUBHAM KUMAR NOGIA', '9166709370', NULL, 'RJ14C20170000839', '1998-01-15', '2037-01-22', '2017-01-23', 'X', 'MANOHAR LAL NOGIA', 'Rajasthan', '337 SHREE RAM TEEL RAJEEV NAGAR, LANKAPURI SHASTRI NAGAR, JAIPUR', 'https://chooseataxi.com/uploads/drivers/driver_168_1778432462.jpg', NULL, '[\"LMV\",\"MCWG\"]', 'Active', 1, '2026-05-10 17:01:02', '2026-05-10 17:01:02', NULL),
(45, 113, 'RAJ KUMAR', '9812668865', NULL, 'HR-3220130043147', '1987-01-08', '2033-11-13', '2013-11-14', 'X', 'RAM NARAIAN', 'Haryana', 'VPO MOHANGARH (136), TEH UCHANA DISTT JIND, 9812668865', 'https://chooseataxi.com/uploads/drivers/driver_113_1778531783.jpg', NULL, '[\"MCWG\",\"TRANS\",\"LMV\"]', 'Active', 1, '2026-05-11 20:36:23', '2026-05-11 20:36:23', NULL),
(46, 225, 'ANKUR  RAJAURIYA', '7906222214', NULL, 'UP8320230008300', '1997-01-14', '2037-01-13', '2023-07-11', 'X', 'DHARMENDRA', 'Uttar Pradesh', 'Shikohabad, Shikohabad, Galamai  Firozabad Uttar Pradesh', 'https://chooseataxi.com/uploads/drivers/driver_225_1778582575.jpg', NULL, '[\"TRANS\",\"LMV\",\"MCWG\"]', 'Active', 1, '2026-05-12 10:42:55', '2026-05-12 10:42:55', NULL),
(47, 28, 'RAJ KUMAR', '9818928592', NULL, 'DL0719930052004', '1970-01-01', '2029-12-31', '2024-05-30', 'X', 'SH B LAL', 'Delhi', 'D-347 ST NO-12, LAXMI NAGAR, DELHI', 'https://chooseataxi.com/uploads/drivers/driver_28_1778585632.jpg', NULL, '[\"LMV\"]', 'Active', 0, '2026-05-12 11:33:52', '2026-05-12 11:33:52', NULL),
(50, 29, 'AJAY  KUMAR', '8505905903', NULL, 'DL0520039098351', '1981-08-05', '2032-10-19', '2022-10-20', 'X', 'SH LAKHMI CHAND', 'Delhi', '187 G NO 6, MANDOLI EXTN, DELHI', 'https://chooseataxi.com/uploads/drivers/driver_29_1778601771.jpg', NULL, '[\"LMV\",\"MCWG\"]', 'Active', 0, '2026-05-12 16:02:51', '2026-05-12 16:02:51', NULL),
(51, 102, 'NISHIN SHARMA', '9896300562', NULL, 'HR0720110057083', '1990-10-24', '2031-11-14', '2011-11-15', 'X', 'BALVINDER KUMAR', 'Haryana', 'H NO. 1310/1/12, SHANTI NAGAR, KURUKSHETRA', 'https://chooseataxi.com/uploads/drivers/driver_102_1778738214.jpg', NULL, '[\"LMV\",\"MCWG\"]', 'Active', 1, '2026-05-14 05:56:54', '2026-05-14 05:56:54', NULL),
(52, 162, 'AMIT KUMAR', '9315325877', NULL, 'HR06 20160000235', '1998-08-26', '2036-11-27', '2016-11-28', 'X', 'SUBHASH CHAND', 'Haryana', '1062 NEAR PARSHURAM MANDIR, WADHAWA RAM COLONY, Panipat (M Cl + OG),Panipat,HR', 'https://chooseataxi.com/uploads/drivers/driver_162_1778747541.jpg', NULL, '[\"LMV\",\"MCWG\"]', 'Active', 1, '2026-05-14 08:32:21', '2026-05-14 08:32:21', NULL),
(53, 71, 'RAHUL  YADAV', '9599306497', NULL, 'DL120250035776', '1998-07-08', '2038-07-07', '2025-03-21', 'X', 'SHIV KUMAR YADAV', 'Delhi', '22, Road No 77, Rajiv Gandhi Camp  West Punjabi Bagh Punjabi Bagh, Punjabi Bagh Punjabi Bagh West Delhi Delhi', 'https://chooseataxi.com/uploads/drivers/driver_71_1778749175.jpg', NULL, '[\"LMV\"]', 'Active', 1, '2026-05-14 08:59:35', '2026-05-14 08:59:35', NULL),
(54, 252, 'ANKUR  SINGH', '9540173746', NULL, 'UP9220140008118', '1995-10-10', '2034-10-21', '2014-10-22', 'X', 'KUNVAR  SINGH', 'Uttar Pradesh', 'KHEDA MUSTAKIL, JALAUN, KHEDA MUSTAKIL,JALAUN', 'https://chooseataxi.com/uploads/drivers/driver_252_1778750657.jpg', NULL, '[\"MCWG\",\"LMV\",\"TRANS\"]', 'Active', 1, '2026-05-14 09:24:17', '2026-05-14 09:24:49', NULL),
(55, 264, 'GURDEEP SINGH', '8837632229', NULL, 'P B 1020150331034', '1992-06-02', '2035-02-24', '2015-02-25', 'X', 'JAGDISH SINGH', 'Punjab', 'HN-6911 STNO 12 NEW JANTA NGR LDH, Ludhiana (East),Ludhiana,PB', 'https://chooseataxi.com/uploads/drivers/driver_264_1778760292.jpg', NULL, '[\"LMV\",\"MCWG\"]', 'Active', 1, '2026-05-14 12:04:52', '2026-05-14 12:04:52', NULL),
(56, 257, 'GOVIND TIWARI', '8700219533', NULL, 'UP1420220033739', '1986-01-01', '2032-07-05', '2022-07-06', 'X', 'DORI LAL TIWARI', 'Uttar Pradesh', '47 GALI NO-2 SHINGAR VIHAR NEAR MANGAL BAZAR, KHORA COLONY PS SHIPRA SUN CITY, Ghaziabad,UP', 'https://chooseataxi.com/uploads/drivers/driver_257_1778764902.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 1, '2026-05-14 13:21:42', '2026-05-14 13:21:42', NULL),
(57, 106, 'SONU  RATHOUR', '9634347223', NULL, 'UK0620210003476', '2000-03-03', '2040-03-02', '2021-04-15', 'X', 'FAKIRI  CHANDRA', 'Uttarakhand', '', 'https://chooseataxi.com/uploads/drivers/driver_106_1778771506.jpg', NULL, '[\"LMV\",\"MCWG\"]', 'Active', 1, '2026-05-14 15:11:46', '2026-05-14 15:11:46', NULL),
(58, 106, 'RAMBABU  RATHORE', '7830437900', NULL, 'UK0620210009179', '1996-01-01', '2035-12-31', '2021-11-16', 'X', 'FAKIR CHANDRA  RATHORE', 'Uttarakhand', 'WARD NO 2 RAJA COLONY GOL MADAINYA, RUDRAPUR, UDHAM SINGH NAGAR,UK', 'https://chooseataxi.com/uploads/drivers/driver_106_1778771581.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 1, '2026-05-14 15:13:01', '2026-05-14 15:13:01', NULL),
(59, 271, 'SHAILENDRA SINGH', '7229989923', NULL, 'RJ1120210005224', '2003-06-05', '2043-06-04', '2021-08-31', 'X', 'SAUDAN SINGH', 'Rajasthan', 'NAGLA MAU TEH. BASERI DHOLPUR RAJASTHAN, Nagla Mau, Baseri,Dhaulpur,RJ', 'https://chooseataxi.com/uploads/drivers/driver_271_1778774427.jpg', NULL, '[\"LMV\",\"MCWG\"]', 'Active', 1, '2026-05-14 16:00:27', '2026-05-14 16:00:27', NULL),
(60, 277, 'LOVELEEN KUMAR', '7298040005', NULL, 'PB1020230006638', '1984-09-15', '2033-06-21', '2023-06-22', 'X', 'ASHOK KUMAR', 'Punjab', 'House No 1085/1, Street No 1 Near Baba Peer Manohar Nagar, Ludhiana  Ludhiana Punjab', 'https://chooseataxi.com/uploads/drivers/driver_277_1778776880.jpg', NULL, '[\"LMV\",\"MCWG\"]', 'Active', 1, '2026-05-14 16:41:20', '2026-05-14 16:41:20', NULL),
(61, 88, 'GULFAN', '8813036801', NULL, 'HR7120180002833', '1994-01-29', '2038-11-04', '2018-11-05', 'X', 'ANIL', 'Haryana', 'VPO CHHACHHRAULI, TEH CHHACHHRAULI, YAMUNANAGAR,HR', 'https://chooseataxi.com/uploads/drivers/driver_88_1778825616.jpg', NULL, '[\"LMV\",\"MCWG\",\"TRCTOR\"]', 'Active', 1, '2026-05-15 06:13:36', '2026-05-15 06:13:36', NULL),
(63, 277, 'JASBIR SINGH DHANOA', '8544810908', NULL, 'PB2820150016762', '1987-10-30', '2035-02-26', '2015-02-27', 'X', 'JASWANT SINGH', 'Punjab', 'VILL. BINJOKI KHURD TEH. MALERKOTLA, DISTT. SANGRUR', 'https://chooseataxi.com/uploads/drivers/driver_277_1778839509.jpg', NULL, '[\"LMV\",\"MCWG\"]', 'Active', 0, '2026-05-15 10:05:09', '2026-05-15 10:05:09', NULL),
(64, 135, 'SATYA  KISHOR', '6306573008', NULL, 'UP3020230010867', '1993-02-10', '2033-07-06', '2023-07-07', 'X', 'RAVINDRA', 'Uttar Pradesh', '53, Village - Musepur, Manpur  Hardoi Uttar Pradesh', 'https://chooseataxi.com/uploads/drivers/driver_135_1778848649.jpg', NULL, '[\"LMV\",\"MCWG\"]', 'Active', 1, '2026-05-15 12:37:29', '2026-05-15 12:37:53', NULL),
(65, 313, 'GAUTAM SINGH', '9810260519', NULL, 'DL-0320100127371', '1983-07-13', '2030-02-22', '2010-02-23', 'X', 'GURMUKH', 'Delhi', '265  PREM NAGAR, BLOCK  J LAL KUAN, NEW DELHI', 'https://chooseataxi.com/uploads/drivers/driver_313_1778859651.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 1, '2026-05-15 15:40:51', '2026-05-15 15:40:51', NULL),
(66, 294, 'RINKU  KUMAR', '9711459781', NULL, 'UP8120150030749', '1997-07-01', '2035-12-18', '2015-12-19', 'X', 'VASUDEV', 'Uttar Pradesh', 'VILL+POST-NAHAL PS-ATRAULI, ALIGARH, ATRAULI,ALIGARH', 'https://chooseataxi.com/uploads/drivers/driver_294_1778912366.jpg', NULL, '[\"LMV\",\"TRANS\",\"MCWG\"]', 'Active', 1, '2026-05-16 06:19:26', '2026-05-16 06:19:26', NULL),
(67, 309, 'ABDUL REHAMAN  MIYAZ', '9008719860', NULL, 'KA1920170017401', '1999-09-18', '2037-11-09', '2017-11-10', 'X', 'SULAIMAN', 'Karnataka', '5-7AGB/1  N S ROAD, NADSAL VG HEJAMADI POST, UDUPI', 'https://chooseataxi.com/uploads/drivers/driver_309_1778915679.jpg', NULL, '[\"MCWG\",\"LMV\",\"TRANS\"]', 'Active', 1, '2026-05-16 07:14:39', '2026-05-16 07:14:39', NULL),
(68, 65, 'RAJPAL', '918958028605', NULL, 'UP8520110010866', '1992-08-12', '2031-08-04', '2011-08-05', 'X', 'HARI  SINGH', 'Uttar Pradesh', 'DIRAVALI CHATTA, BARSANA, CHHATA,MATHURA', 'https://chooseataxi.com/uploads/drivers/driver_65_1778932382.jpg', NULL, '[\"LMV\",\"MCWG\",\"TRANS\"]', 'Active', 1, '2026-05-16 11:53:02', '2026-05-16 11:53:02', NULL),
(69, 329, 'KISHOR  CHOPDE', '7415687799', NULL, 'MH3120090063690', '1981-08-26', '2031-03-07', '2021-03-08', 'X', 'NARAYANRAO', 'Maharashtra', '661, ASHIRWAD NAGAR, HUDKESHWAR ROAD, NAGPUR (URBAN),NAGPUR,MH', 'https://chooseataxi.com/uploads/drivers/driver_329_1778940114.jpg', NULL, '[\"LMV-TR\",\"MCWG\"]', 'Active', 1, '2026-05-16 14:01:54', '2026-05-16 14:01:54', NULL),
(70, 327, 'SHASHANK  PANDEY', '9335252452', NULL, 'UP5120150005074', '1990-07-15', '2035-05-13', '2015-05-14', 'X', 'CHANDRIKA PRASAD PANDEY', 'Uttar Pradesh', 'H.NO.956/7A CIVIL LINE, PO-GANDHI NAGAR,PS-KOTWALI, BASTI', 'https://chooseataxi.com/uploads/drivers/driver_327_1778944100.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 1, '2026-05-16 15:08:20', '2026-05-16 15:08:20', NULL),
(72, 343, 'KRISHNA  KUMAR', '8957715341', NULL, 'UP7820250016747', '2005-06-11', '2045-06-10', '2025-05-29', 'X', 'ARUN  KUMAR', 'Uttar Pradesh', 'kathogar, Kathongar, Kathogar Kanpur Kanpur Nagar Uttar Pradesh', 'https://chooseataxi.com/uploads/drivers/driver_343_1778996112.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 1, '2026-05-17 05:35:12', '2026-05-17 05:35:12', NULL),
(73, 314, 'GIRISH                   PANWAR', '8619095130', NULL, 'RJ1420040350366', '1985-08-12', '2034-06-13', '2024-06-14', 'X', 'KHEMA             RAM    PANWAR', 'Rajasthan', '5/446,  AGARWAL FARAM, MANSAROVER  JAIPUR, JAIPUR', 'https://chooseataxi.com/uploads/drivers/driver_314_1779064862.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 1, '2026-05-18 00:41:02', '2026-05-18 00:41:02', NULL),
(74, 212, 'ANAS  WARSI', '9654730050', NULL, 'DL1320150198695', '1997-08-03', '2035-10-13', '2015-10-14', 'X', 'SAJID HUSSAIN  WARSI', 'Delhi', '13 A GALI NO- 9 PARWANA ROAD, BRIJPURI, PREET VIHAR,EAST DELHI', 'https://chooseataxi.com/uploads/drivers/driver_212_1779066587.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 1, '2026-05-18 01:09:47', '2026-05-18 01:09:47', NULL),
(75, 96, 'VIKKAS  GUPTA', '7982179332', NULL, 'DL820190002203', '1979-08-14', '2029-08-13', '2019-02-18', 'X', 'JAG MOHAN GUPTA', 'Delhi', '88-89, NEAR VIKAS CABLE NEHAR ROAD, Haiderpur,North West Delh,DELHI', 'https://chooseataxi.com/uploads/drivers/driver_96_1779107441.jpg', NULL, '[\"LMV\"]', 'Active', 1, '2026-05-18 12:30:41', '2026-05-18 12:30:41', NULL),
(76, 359, 'SATENDRA', '9528824577', NULL, 'UP8420260001900', '2003-01-01', '2042-12-31', '2026-01-31', 'X', 'LALA  RAM', 'Uttar Pradesh', '00, NAGLA NINH LAKHANMAU, LAKHAN MAU  MAINPURI UTTAR PRADESH', 'https://chooseataxi.com/uploads/drivers/driver_359_1779118910.jpg', NULL, '[\"LMV\",\"MCWG\"]', 'Active', 0, '2026-05-18 15:41:50', '2026-05-18 15:41:50', NULL),
(77, 199, 'KAMRAN  HUSSAIN', '8178809087', NULL, 'UP3020140010655', '1991-02-01', '2034-11-12', '2014-11-13', 'X', 'SHAVAHAT  HUSSAIN', 'Uttar Pradesh', 'H.NO.02 MAHIBAG, SHAHABAD, Hardoi,UP', 'https://chooseataxi.com/uploads/drivers/driver_199_1779167164.jpg', NULL, '[\"LMV\",\"MCWG\"]', 'Active', 1, '2026-05-19 05:06:04', '2026-05-19 05:06:04', NULL),
(78, 377, 'AMAR  RAY', '9319039790', NULL, 'WB2020160119511', '1995-05-10', '2036-01-28', '2016-01-29', 'X', 'RAMSAGAR  RAY', 'West Bengal', '19 GARIAHAT  GOLPARK, KOLKATA', 'https://chooseataxi.com/uploads/drivers/driver_377_1779255831.jpg', NULL, '[\"LMV\",\"LMVCAB\"]', 'Active', 1, '2026-05-20 05:43:51', '2026-05-20 05:43:51', NULL),
(79, 281, 'ROSHAN LAL BAIRWA', '9784553157', NULL, 'RJ2920240008134', '1994-01-01', '2034-10-27', '2024-10-28', 'X', 'RAMPHOOL  BAIRWA', 'Rajasthan', '', 'https://chooseataxi.com/uploads/drivers/driver_281_1779262564.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 1, '2026-05-20 07:36:04', '2026-05-20 07:36:04', NULL),
(80, 316, 'MOHAMMAD SHOAIB', '9690109085', NULL, 'UP1120140020738', '1984-03-10', '2034-12-02', '2014-12-03', 'X', 'MOHAMMAD MURSALIN', 'Uttar Pradesh', 'VILL-CHHOLOLI, PO-TASIPUR, PS-NAGAL, SAHARANPUR', 'https://chooseataxi.com/uploads/drivers/driver_316_1779280990.jpg', NULL, '[\"MCWG\",\"TRANS\",\"LMV\"]', 'Active', 1, '2026-05-20 12:43:10', '2026-05-20 12:43:10', NULL),
(81, 312, 'PRITAM  SINGH', '9818367683', NULL, 'DL0320029193484', '1983-11-03', '2032-03-27', '2022-03-28', 'X', 'SH  KAMAL JIT SINGH', 'Delhi', 'RZI-2 TAMIL ENCLAVE, VIJAY ENCLAVE, PALAM VILLAGE,SOUTH WEST DELHI', 'https://chooseataxi.com/uploads/drivers/driver_312_1779283450.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 1, '2026-05-20 13:24:10', '2026-05-20 13:24:20', NULL),
(82, 391, 'PUSHPENDER', '9718808018', NULL, 'HR5120210030669', '1999-08-01', '2039-07-31', '2021-10-21', 'X', 'BHARAT  SINGH', 'Haryana', 'H NO-407 WARD NO-6, JAWAHAR COLONY SECTOR 22, FARIDABAD,HARYANA', 'https://chooseataxi.com/uploads/drivers/driver_391_1779341039.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 1, '2026-05-21 05:23:59', '2026-05-21 05:23:59', NULL),
(83, 392, 'ISMEET  SINGH', '70610158780.', NULL, 'BR3120250014488', '2003-09-13', '2043-09-12', '2025-09-03', 'X', 'HARJEET  SINGH', 'Bihar', 'GAURIYA MATH AZIZ ROAD, MITHAPUR PO G P O, Phulwari,Patna,BR', 'https://chooseataxi.com/uploads/drivers/driver_392_1779347726.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 1, '2026-05-21 07:15:26', '2026-05-21 07:15:26', NULL),
(84, 369, 'NARSI NARESH TILOR', '9967167232', NULL, 'MH0420220011085', '1990-05-12', '2032-02-16', '2022-02-17', 'X', 'RENU D SONI', 'Maharashtra', 'ROOM NO.502, SAI ANAND APT, ROAD NO.22, KISAN NAGAR NO.3  WAGLE ESTATE, Thane  Thane Maharashtra', 'https://chooseataxi.com/uploads/drivers/driver_369_1779360013.jpg', NULL, '[\"MCWG\",\"3W-CAB\",\"LMV-TR\"]', 'Active', 1, '2026-05-21 10:40:13', '2026-05-21 10:40:13', NULL),
(85, 337, 'DILSHAD KHAN', '+919690230182', NULL, 'UP20 20170016754', '1989-01-01', '2037-11-06', '2017-11-07', 'X', 'NASEEM KHAN', 'Uttar Pradesh', 'VILL-RASOOLPUR MUJAFFAR, PO-ISLAMABAD PS-BARHAPUR, BIJNOR', 'https://chooseataxi.com/uploads/drivers/driver_337_1779454389.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 1, '2026-05-22 12:53:09', '2026-05-22 12:53:09', NULL),
(86, 410, 'ASHISH DIXIT', '9540350401', NULL, 'UP3020150010188', '1991-10-03', '2035-08-17', '2015-08-18', 'X', 'SHRI KANT DIXIT', 'Uttar Pradesh', 'RAM NAGAR, SARAI RAGHAV PALI, HARDOI', 'https://chooseataxi.com/uploads/drivers/driver_410_1779521282.jpg', NULL, '[\"LMV\",\"MCWG\"]', 'Active', 1, '2026-05-23 07:28:02', '2026-05-23 07:28:16', NULL),
(87, 398, 'GANESH  SHUKLA', '9638809101', NULL, 'GJ0520040069171', '1976-11-20', '2031-01-29', '2021-01-30', 'X', 'CHHOTELAL', 'Gujarat', '350, VINAYAK NAGAR, BAMROLI, SURAT CITY,SURAT', 'https://chooseataxi.com/uploads/drivers/driver_398_1779545796.jpg', NULL, '[\"LMV\",\"MCWG\"]', 'Active', 1, '2026-05-23 14:16:36', '2026-05-23 14:16:36', NULL),
(88, 359, 'JEEVAN  KUMAR', '7668104085', NULL, 'UP7520220005492', '2002-03-09', '2042-03-08', '2022-06-10', 'X', 'SHIV KUMAR GAUTAM', 'Uttar Pradesh', 'NAGLA SUBHAN, POST GEENJA, Saifai,Etawah,UP', 'https://chooseataxi.com/uploads/drivers/driver_359_1779624276.jpg', NULL, '[\"LMV\",\"MCWG\"]', 'Active', 1, '2026-05-24 12:04:36', '2026-05-24 12:04:36', NULL),
(89, 464, 'HIMANSHU  KUMAR', '7505120407', NULL, 'UP8020210023073', '2003-08-03', '2043-08-02', '2021-09-09', 'X', 'GYANEDRA SINGH', 'Uttar Pradesh', '456 SARENDHI SARENDHI, AGRA,UP', 'https://chooseataxi.com/uploads/drivers/driver_464_1781350817.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 1, '2026-06-13 11:40:17', '2026-06-13 11:40:17', NULL),
(90, 464, 'YASH SINGH PARMAR', '7610230680', NULL, 'UP8020240009776', '2003-08-14', '2043-08-13', '2024-03-15', 'X', 'NAVAL SINGH PARMAR', 'Uttar Pradesh', '', 'https://chooseataxi.com/uploads/drivers/driver_464_1781350913.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 1, '2026-06-13 11:41:53', '2026-06-13 11:41:53', NULL),
(91, 447, 'LAXMI NARAYAN  MEENA', '7014137726', NULL, 'RJ2920160007649', '1990-06-04', '2036-06-07', '2021-03-30', 'X', 'RAMESH CHAND  MEENA', 'Rajasthan', 'PLOT NO 8 NARAYANI ENCLAVE, HEERAPURA AGRA ROAD LUNIYAWAS, JAIPUR', 'https://chooseataxi.com/uploads/drivers/driver_447_1781357085.jpg', NULL, '[\"LMV\",\"MCWG\"]', 'Active', 1, '2026-06-13 13:24:45', '2026-06-13 13:24:45', NULL),
(92, 442, 'RAJ KUMAR', '9256015077', NULL, 'PB6520080059715', '1974-01-01', '2033-12-31', '2024-02-13', 'X', 'RIHAN CHAND', 'Punjab', 'HOUSE NO 99 WARD NO 6 SINGHPURA, BAZIGAR BASTI ZIRAKPUR TEHSIL, DERA BASSI,SAS NAGAR MOHALI', 'https://chooseataxi.com/uploads/drivers/driver_442_1781374243.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 1, '2026-06-13 18:10:43', '2026-06-13 18:10:43', NULL),
(97, 30, 'MONU SHARMA', '9910289441', NULL, 'DL120220036896', '1992-07-10', '2032-07-09', '2022-05-10', 'X', 'JAG SWAROOP SHARMA', 'Delhi', 'HOUSE NO-A-74, GALI NO-1  PREM VIHAR NANGLI DAIRY, Nagafgarh  South West Delhi Delhi', 'https://chooseataxi.com/uploads/drivers/driver_30_1781418882.jpg', NULL, '[\"LMV\",\"MCWG\"]', 'Active', 1, '2026-06-14 06:34:42', '2026-06-14 06:34:42', NULL),
(110, 179, 'VIVEK KUMAR SINGH', '8398058388', NULL, 'UP6020030007454', '1982-08-08', '2033-07-11', '2023-07-12', 'X', 'DAULAT  SINGH', 'Uttar Pradesh', 'HARPUR BALLIA, PS KOTWALI, BALLIA,BALLIA,UP', 'https://chooseataxi.com/uploads/drivers/driver_179_1781521949.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 1, '2026-06-15 11:12:29', '2026-06-15 11:12:29', NULL),
(111, 509, 'SURAJ', '8115122262', NULL, 'UP45 202300 12444', '2002-07-12', '2042-07-11', '2023-12-06', 'X', 'RAKESH  KUMAR', 'Uttar Pradesh', '318, newada, Achhte  Ambedkar Nagar Uttar Pradesh', 'https://chooseataxi.com/uploads/drivers/driver_509_1781551095.jpg', NULL, '[\"LMV\",\"MCWG\"]', 'Active', 1, '2026-06-15 19:18:15', '2026-06-15 19:18:15', NULL),
(112, 471, 'TARSEM SINGH', '9988491852', NULL, 'PB7220160014447', '1995-06-07', '2036-03-02', '2016-03-03', 'X', 'JAGIR SINGH', 'Punjab', 'VIL SHERGARH, TEH PATRAN, SHERGARH (137),PATIALA', 'https://chooseataxi.com/uploads/drivers/driver_471_1781585831.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 1, '2026-06-16 04:57:11', '2026-06-16 04:57:11', NULL),
(113, 58, 'SANDEEP YADAV', '8930361411', NULL, 'HR-3620120065985', '1992-07-19', '2032-02-21', '2012-02-22', 'M', 'ANIL KUMAR', 'Haryana', 'GINDOKHAR REWARI GINDO KHAR (113),REWARI,HR', 'https://chooseataxi.com/uploads/drivers/driver_58_1781683529.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 1, '2026-06-17 08:05:29', '2026-06-17 08:05:29', NULL),
(114, 514, 'RAVI KUMAR', '8630239955', NULL, 'UP8320180003906', '1997-10-10', '2038-06-21', '2018-06-22', 'M', 'MOHAR SINGH', 'Uttar Pradesh', 'KAURARA ROAD SIRSAGANJ POST SIRSAGANJ SIRSAGANJ (NPP + OG) SHIKOHABAD,FIROZABAD,UP', 'https://chooseataxi.com/uploads/drivers/driver_514_1781693704.jpg', NULL, '[\"MCWG\",\"LMV\"]', 'Active', 0, '2026-06-17 10:55:04', '2026-06-17 10:55:04', NULL),
(115, 79, 'RAVINDER', '8168948146', NULL, 'HR1920180004487', '2000-04-08', '2038-09-26', '2018-09-27', 'M', 'JAI BHAGWAN', 'Haryana', 'PREM NAGAR CHARKHI DADRI (MC) CHARKHI DADRI,HR', 'https://chooseataxi.com/uploads/drivers/driver_79_1781693998.jpg', NULL, '[\"LMV\",\"MCWG\",\"TRANS\"]', 'Active', 1, '2026-06-17 10:59:58', '2026-06-17 10:59:58', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `driver_locations`
--

CREATE TABLE `driver_locations` (
  `id` int(11) NOT NULL,
  `driver_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  `last_updated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `driver_locations`
--

INSERT INTO `driver_locations` (`id`, `driver_id`, `booking_id`, `latitude`, `longitude`, `last_updated`) VALUES
(1, 3, 2627613, 29.38329280, 76.34162860, '2026-04-08 21:54:10'),
(2, 6, 2627614, 29.38335150, 76.34145470, '2026-04-10 08:25:33'),
(3, 6, 2627615, 28.29773580, 76.61091740, '2026-04-12 07:07:11'),
(4, 7, 2627622, 29.38356100, 76.34140820, '2026-04-24 15:53:32'),
(5, 3, 2627637, 29.38342830, 76.34153330, '2026-04-22 18:49:01'),
(6, 7, 2627639, 29.38340440, 76.34151390, '2026-04-24 16:57:30'),
(7, 7, 2627650, 29.38335660, 76.34142380, '2026-04-27 08:43:54'),
(8, 7, 2627647, 29.38342300, 76.34154960, '2026-04-26 13:08:25'),
(9, 7, 2627652, 29.38333540, 76.34151440, '2026-05-01 17:45:12');

-- --------------------------------------------------------

--
-- Table structure for table `driver_trip_logs`
--

CREATE TABLE `driver_trip_logs` (
  `id` int(11) NOT NULL,
  `acceptance_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `start_selfie` varchar(255) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `start_location` text DEFAULT NULL,
  `start_odometer_reading` int(11) DEFAULT NULL,
  `start_odometer_image` varchar(255) DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `end_location` text DEFAULT NULL,
  `end_odometer_reading` int(11) DEFAULT NULL,
  `end_odometer_image` varchar(255) DEFAULT NULL,
  `total_km` decimal(10,2) DEFAULT NULL,
  `collect_amount` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `driver_trip_logs`
--

INSERT INTO `driver_trip_logs` (`id`, `acceptance_id`, `booking_id`, `start_selfie`, `start_time`, `start_location`, `start_odometer_reading`, `start_odometer_image`, `end_time`, `end_location`, `end_odometer_reading`, `end_odometer_image`, `total_km`, `collect_amount`, `created_at`) VALUES
(1, 24, 2627650, 'uploads/trips/selfie_2627650_1777219352.jpg', '2026-04-26 21:32:32', '98MR+9GX, , Kandela, Haryana', 58000, 'uploads/trips/odo_start_2627650_1777219352.jpg', '2026-04-28 00:36:00', '98MR+9GX, , Kandela, Haryana', 500, 'uploads/trips/odo_end_2627650_1777316760.jpg', 50.00, 100.00, '2026-04-26 11:11:02'),
(2, 23, 2627647, 'uploads/trips/selfie_2627647_1777316873.jpg', '2026-04-28 00:37:53', '98MR+9GX, , Kandela, Haryana', 500, 'uploads/trips/odo_start_2627647_1777316873.jpg', '2026-04-28 00:38:24', '98MR+9GX, , Kandela, Haryana', 500, 'uploads/trips/odo_end_2627647_1777316904.jpg', 250.00, 800.00, '2026-04-26 11:23:42'),
(7, 25, 2627652, 'uploads/trips/selfie_2627652_1777317018.jpg', '2026-04-28 00:40:18', '98MR+9GX, , Kandela, Haryana', 800, 'uploads/trips/odo_start_2627652_1777317018.jpg', '2026-04-28 00:40:48', '98MR+9GX, , Kandela, Haryana', 800, 'uploads/trips/odo_end_2627652_1777317048.jpg', 250.00, 50.00, '2026-04-27 19:10:18'),
(8, 26, 2627652, 'uploads/trips/selfie_2627652_1777409228.jpg', '2026-04-29 02:17:08', '98MR+9GX, , Kandela, Haryana', 5800, 'uploads/trips/odo_start_2627652_1777409228.jpg', '2026-04-30 14:41:02', 'Location Unavailable', 5800, 'uploads/trips/odo_end_2627652_1777540262.jpg', 2500.00, 50.00, '2026-04-28 20:47:08'),
(9, 27, 2627652, 'uploads/trips/selfie_2627652_1777657458.jpg', '2026-05-01 23:14:18', '98MR+9GX, , Kandela, Haryana', 2500, 'uploads/trips/odo_start_2627652_1777657458.jpg', '2026-05-01 23:15:11', '98MR+9GX, , Kandela, Haryana', 500, 'uploads/trips/odo_end_2627652_1777657511.jpg', 50.00, 50.00, '2026-04-30 09:25:20');

-- --------------------------------------------------------

--
-- Table structure for table `hero_slides`
--

CREATE TABLE `hero_slides` (
  `id` int(11) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `link_url` varchar(255) DEFAULT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hero_slides`
--

INSERT INTO `hero_slides` (`id`, `image_path`, `title`, `link_url`, `status`, `created_at`) VALUES
(4, 'uploads/hero/hero_1778062664_8027.png', 'Cash Prizes', 'https://chooseataxi.com', 'Active', '2026-05-06 10:17:44'),
(8, 'uploads/hero/hero_1779384970_6092.png', 'Live location ', '', 'Active', '2026-05-21 17:36:10');

-- --------------------------------------------------------

--
-- Table structure for table `partners`
--

CREATE TABLE `partners` (
  `id` int(11) NOT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `mobile` varchar(15) NOT NULL,
  `login_otp` varchar(10) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `mobile_verified` tinyint(1) DEFAULT 0,
  `aadhaar_verified` tinyint(1) DEFAULT 0,
  `aadhaar_number` varchar(12) DEFAULT NULL,
  `surepass_client_id` varchar(100) DEFAULT NULL,
  `aadhaar_pdf_link` text DEFAULT NULL,
  `driving_license_link` varchar(255) DEFAULT NULL,
  `rc_book_link` varchar(255) DEFAULT NULL,
  `aadhaar_front_link` varchar(255) DEFAULT NULL,
  `aadhaar_back_link` varchar(255) DEFAULT NULL,
  `selfie_link` varchar(255) DEFAULT NULL,
  `roles` varchar(255) DEFAULT 'user',
  `status` enum('Pending','Active','Suspended') DEFAULT 'Pending',
  `manual_verification_status` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `aadhar_number` varchar(12) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `fcm_token` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `partners`
--

INSERT INTO `partners` (`id`, `full_name`, `email`, `mobile`, `login_otp`, `password`, `mobile_verified`, `aadhaar_verified`, `aadhaar_number`, `surepass_client_id`, `aadhaar_pdf_link`, `driving_license_link`, `rc_book_link`, `aadhaar_front_link`, `aadhaar_back_link`, `selfie_link`, `roles`, `status`, `manual_verification_status`, `created_at`, `updated_at`, `aadhar_number`, `city`, `fcm_token`) VALUES
(4, 'Rahul', 'rd5212452@gmail.com', '8059982049', NULL, '$2y$10$Iu0WEniXyBGi7mXYVpHIVOavcV4KcsgUizNJje/HbBOPu8AM3vihq', 1, 1, 'XXXXXXXX4572', NULL, 'https://aadhaar-kyc-docs.s3.amazonaws.com/rohit_0345/digilocker/digilocker_eLqRknDXSjtZyjkecrhO/ADHAR_1774963101652376.xsl?response-content-type=text%2Fxml&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAY5K3QRM5KVPBYKKE%2F20260331%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20260331T131821Z&X-Amz-Expires=600&X-Amz-SignedHeaders=host&X-Amz-Signature=b97e17b81340a22f5d08a7089fbc3bd6a5e71c681bec8fe3c769112a863adb7e', 'dl_4_1775151077.jpg', 'rc_4_1775151077.jpg', NULL, NULL, NULL, 'user,partner', 'Active', 'Approved', '2026-03-31 13:18:36', '2026-06-12 20:24:57', NULL, NULL, NULL),
(13, 'Dikshit', 'dikshit123@gmail.com', '8619144832', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_13_1775991102.jpg', 'adh_b_13_1775991102.jpg', 'selfie_13_1775991102.jpg', 'partner', '', 'Approved', '2026-04-12 10:41:44', '2026-05-14 09:48:03', NULL, NULL, NULL),
(14, 'Manish Kumar', 'manishnehra505@gmail.com', '8058602516', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_14_1775991836.jpg', 'adh_b_14_1775991836.jpg', 'selfie_14_1775991836.jpg', 'partner', 'Active', 'Approved', '2026-04-12 10:58:32', '2026-06-12 19:15:11', NULL, NULL, NULL),
(18, NULL, NULL, '8359995767', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-04-28 20:45:17', '2026-06-12 13:30:04', NULL, NULL, NULL),
(19, NULL, NULL, '7988029990', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-05 12:46:41', '2026-05-07 08:34:06', NULL, NULL, NULL),
(20, 'Birsing', 'birsingh1753@gmail.com', '9718746877', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_20_1777988989.jpg', 'adh_b_20_1777988989.jpg', 'selfie_20_1777988989.jpg', 'partner', 'Active', 'Approved', '2026-05-05 13:00:37', '2026-05-09 04:38:37', '761366524829', 'Gurgaon sector 52 Koyal Vihar', NULL),
(21, 'SALAMAN KHAN', 'salmankhan1796947@gmail.com', '7827156364', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_21_1777988048.jpg', 'adh_b_21_1777988048.jpg', 'selfie_21_1777988048.jpg', 'partner', 'Active', 'Approved', '2026-05-05 13:03:05', '2026-05-06 16:59:39', '739124412558', 'Ghaziabad', NULL),
(22, 'Ashok Kumar Thapliyal', 'thapliyal.ashokkumar@gmail.com', '8413835412', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_22_1777989469.jpg', 'adh_b_22_1777989469.jpg', 'selfie_22_1777989469.jpg', 'partner', 'Active', 'Approved', '2026-05-05 13:14:15', '2026-05-05 13:58:27', '314746497563', 'Delhi', NULL),
(23, 'Anmol yadav', 'aanmolyadav9@gmail.com', '9950841466', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_23_1777989070.jpg', 'adh_b_23_1777989070.jpg', 'selfie_23_1777989070.jpg', 'partner', 'Active', 'Approved', '2026-05-05 13:47:26', '2026-05-05 13:57:20', '796204154848', 'Gk1 delhi', NULL),
(24, 'ATINDER PAL SINGH', 'atinderpalsingh261@gmail.com', '9911187777', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_24_1777992278.jpg', 'adh_b_24_1777992278.jpg', 'selfie_24_1777992278.jpg', 'partner', 'Active', 'Approved', '2026-05-05 14:15:38', '2026-05-05 14:57:13', '897889291036', 'new delhi', NULL),
(25, 'ombir sharma', 'ombersharma4@gmail.com', '8816022884', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_25_1777993030.jpg', 'adh_b_25_1777993030.jpg', 'selfie_25_1777993030.jpg', 'partner', 'Active', 'Approved', '2026-05-05 14:50:51', '2026-05-22 21:40:47', '713085635013', 'gurugram', NULL),
(26, 'saurabh', 'saurabhthakur285@gmail.com', '9761846426', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_26_1777993086.jpg', 'adh_b_26_1777993086.jpg', 'selfie_26_1777993086.jpg', 'partner', 'Active', 'Approved', '2026-05-05 14:53:34', '2026-05-05 14:59:10', '498176783869', 'noida', NULL),
(27, 'Satish', 'MJETKING786@gmail.com', '9643915973', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_27_1778517508.jpg', 'adh_b_27_1778517508.jpg', 'selfie_27_1778517508.jpg', 'partner', 'Active', 'Approved', '2026-05-05 15:24:06', '2026-05-12 09:24:29', '543700973030', 'delhi', NULL),
(28, 'MOHAMMAD MURTAZA HASAN', '582ahe@gmail.com', '8700546822', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_28_1778584176.jpg', 'adh_b_28_1778584176.jpg', 'selfie_28_1778584176.jpg', 'partner', 'Active', 'Approved', '2026-05-05 15:25:39', '2026-05-12 14:06:56', '982870547087', 'delhi', NULL),
(29, 'Kapil chauhan', 'royaltours.chauhan@gmail.com', '8079053073', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_29_1777996044.jpg', 'adh_b_29_1777996044.jpg', 'selfie_29_1777996044.jpg', 'partner', 'Active', 'Approved', '2026-05-05 15:38:15', '2026-05-13 17:37:43', '784625002283', 'Delhi', NULL),
(30, 'MONU SHARMA', 'monus5684@gmail.com', '9910289441', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_30_1777997933.jpg', 'adh_b_30_1777997933.jpg', 'selfie_30_1777997933.jpg', 'partner', 'Active', 'Approved', '2026-05-05 16:16:12', '2026-05-05 16:27:40', '633680353515', 'Delhi', NULL),
(31, 'Amar', 'amarrajput1908@gmail.com', '7428731900', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_31_1777999222.png', 'adh_b_31_1777999222.png', 'selfie_31_1777999222.jpg', 'partner', 'Active', 'Approved', '2026-05-05 16:37:35', '2026-05-05 18:29:52', '800127239298', 'delhi', NULL),
(32, 'SALIM', 'kahanmaahi@gmail.com', '9927581785', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_32_1778001383.jpg', 'adh_b_32_1778001383.jpg', 'selfie_32_1778001383.jpg', 'partner', 'Active', 'Approved', '2026-05-05 17:13:57', '2026-05-05 18:28:39', '205465491258', 'Haldwani', NULL),
(34, 'DEEPAK Kumar rajbhar', 'dk883587@gmail.com', '9598359965', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_34_1778021768.jpg', 'adh_b_34_1778021768.jpg', 'selfie_34_1778021768.jpg', 'partner', 'Active', 'Approved', '2026-05-05 22:52:22', '2026-05-06 01:30:43', '331896783716', 'Noida', NULL),
(35, NULL, NULL, '9466120527', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-05 22:53:23', '2026-05-05 22:54:33', NULL, NULL, NULL),
(36, 'Dinesh Kumar', 'dineshkumar1111974@gmail.com', '9871590040', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_36_1779159303.jpg', 'adh_b_36_1779159303.jpg', 'selfie_36_1779159303.jpg', 'partner', 'Active', 'Approved', '2026-05-06 00:23:36', '2026-05-19 02:55:10', '844882776291', 'New Delhi 110062', NULL),
(37, 'GAURAV KUMAR DIKSHIT', 'kiyanshdikshit@gmail.com', '8708454771', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_37_1778340704.jpg', 'adh_b_37_1778340704.jpg', 'selfie_37_1778340704.jpg', 'partner', 'Active', 'Approved', '2026-05-06 00:52:22', '2026-05-13 11:42:42', '232687159738', 'gurgaon', NULL),
(38, 'sandeep', 'sandiipnehra396@gmail.com', '9352602374', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_38_1779355100.jpg', 'adh_b_38_1779355100.jpg', 'selfie_38_1779355100.jpg', 'partner', 'Active', 'Approved', '2026-05-06 01:06:15', '2026-05-21 09:49:21', '915604571812', 'Sikar', NULL),
(39, 'vijay kumar yadav', 'vijayyadav085.vy@gmail.com', '9911058555', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_39_1778029883.jpg', 'adh_b_39_1778029883.jpg', 'selfie_39_1778029883.jpg', 'partner', 'Active', 'Approved', '2026-05-06 01:06:39', '2026-05-06 01:31:31', '518355134683', 'Faridabad', NULL),
(40, 'jagjit singh', 'gavi93081@gmail.com', '9817217571', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_40_1778035268.jpg', 'adh_b_40_1778035268.jpg', 'selfie_40_1778035268.jpg', 'partner', 'Active', 'Approved', '2026-05-06 02:34:40', '2026-05-06 02:57:57', '822831164537', 'mandi dabwali', NULL),
(41, 'Dinesh Kumar', 'dineshk2360@gmail.com', '9664323244', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_41_1778038790.jpg', 'adh_b_41_1778038790.jpg', 'selfie_41_1778038790.jpg', 'partner', 'Active', 'Approved', '2026-05-06 03:19:54', '2026-05-06 03:40:32', '827519901507', 'Gurgaon', NULL),
(43, 'deepak kumar', 'deepak100790shirothia@gmail.com', '9560594831', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_43_1778040452.jpg', 'adh_b_43_1778040452.jpg', 'selfie_43_1778040452.jpg', 'partner', 'Active', 'Approved', '2026-05-06 04:04:37', '2026-05-06 04:13:41', '612220094791', 'new delhi', NULL),
(44, 'islam', 'mrislam9096@gmail.com', '7534064076', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_44_1778042658.jpg', 'adh_b_44_1778042658.jpg', 'selfie_44_1778042658.jpg', 'partner', 'Active', 'Approved', '2026-05-06 04:40:31', '2026-05-06 04:46:54', '726095853251', 'Uttar Pradesh Rampur', NULL),
(45, 'AMIT KUMAR SINGH', 'amit.gaurav72@gmail.com', '8130834757', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_45_1778298483.jpg', 'adh_b_45_1778298483.jpg', 'selfie_45_1778298483.jpg', 'partner', 'Active', 'Approved', '2026-05-06 04:40:43', '2026-05-09 07:49:27', '721187189313', 'mathura', NULL),
(46, NULL, NULL, '9334718009', '8868', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-06 04:41:03', '2026-05-06 04:41:03', NULL, NULL, NULL),
(47, 'Deepak', 'deepaknehra880@gmail.com', '9933287316', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_47_1779270089.jpg', 'adh_b_47_1779270089.jpg', 'selfie_47_1779270089.jpg', 'partner', 'Active', 'Approved', '2026-05-06 04:41:14', '2026-05-20 09:55:21', '973886924936', 'Gurugram', NULL),
(48, NULL, NULL, '9634718009', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-06 04:41:24', '2026-05-06 04:41:35', NULL, NULL, NULL),
(49, 'vikash Gour', 'pandittapodhanswami@gmail.com', '9929014994', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_49_1778042640.jpg', 'adh_b_49_1778042640.jpg', 'selfie_49_1778042640.jpg', 'partner', 'Active', 'Approved', '2026-05-06 04:41:34', '2026-05-06 04:47:16', '563584006180', 'jaipur rajasthan', NULL),
(50, 'Ramavatar saini', 'sramavtar320@gmail.com', '9783074132', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_50_1778042812.png', 'adh_b_50_1778042812.png', 'selfie_50_1778042812.jpg', 'partner', 'Active', 'Approved', '2026-05-06 04:41:50', '2026-05-06 04:49:54', '228592066381', 'alwer', NULL),
(51, 'Pramod Kumar', 'kumarpramod24628@gmail.com', '7017808918', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_51_1778042728.jpg', 'adh_b_51_1778042728.jpg', 'selfie_51_1778042728.jpg', 'partner', 'Active', 'Approved', '2026-05-06 04:42:46', '2026-05-06 04:47:32', '667998351233', 'MAHIPALPUR', NULL),
(52, NULL, NULL, '9855718661', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-06 04:45:01', '2026-05-06 04:45:15', NULL, NULL, NULL),
(53, 'shankarlalgurjar', 'shankarlalgurjar928@gmail.com', '9509067313', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_53_1778302136.jpg', 'adh_b_53_1778302136.jpg', 'selfie_53_1778302136.jpg', 'partner', 'Active', 'Approved', '2026-05-06 04:51:40', '2026-05-09 07:50:55', '282863830883', 'Jaipur', NULL),
(54, 'Karan Miglani', 'Karantourdelhi@gmail.com', '8882509670', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_54_1778053704.jpg', 'adh_b_54_1778053704.jpg', 'selfie_54_1778053704.jpg', 'partner', 'Active', 'Approved', '2026-05-06 04:54:30', '2026-05-06 07:53:34', '356916614682', 'delhi', NULL),
(55, NULL, NULL, '8009096460', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-06 04:56:26', '2026-05-06 04:56:35', NULL, NULL, NULL),
(56, NULL, NULL, '9917333199', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-06 04:57:22', '2026-05-06 04:57:37', NULL, NULL, NULL),
(57, 'kuldeep', 'kuldeeps81712@gmail.com', '8383046357', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_57_1778043799.jpg', 'adh_b_57_1778043799.jpg', 'selfie_57_1778043799.jpg', 'partner', 'Active', 'Approved', '2026-05-06 05:00:48', '2026-05-06 05:06:54', '913582937807', 'Delhi NCR', NULL),
(58, 'Sandeep Yadav', 'srao1346@gmail.com', '8930361411', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_58_1778044216.jpg', 'adh_b_58_1778044216.jpg', 'selfie_58_1778044216.jpg', 'partner', 'Active', 'Approved', '2026-05-06 05:06:09', '2026-05-06 05:14:05', '219763270875', 'gurgaon', NULL),
(59, NULL, NULL, '7835940108', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-06 05:11:07', '2026-05-06 05:11:22', NULL, NULL, NULL),
(60, NULL, NULL, '9717190091', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-06 05:15:37', '2026-05-06 05:16:18', NULL, NULL, NULL),
(61, '606436601426', 'ramansidhu1059@gmail.com', '8685835232', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_61_1778045232.jpg', 'adh_b_61_1778045232.jpg', NULL, 'partner', '', 'Pending', '2026-05-06 05:22:31', '2026-05-06 05:27:12', '606436601426', 'delhi', NULL),
(62, 'Mehtab alam', 'zoraansaifi@gmail.com', '9310754797', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_62_1778179092.jpg', 'adh_b_62_1778179092.jpg', 'selfie_62_1778179092.jpg', 'partner', 'Active', 'Approved', '2026-05-06 05:26:49', '2026-05-08 11:42:37', '326105150157', 'delhi', NULL),
(63, 'mukesh Chandra', 'mokj661@gmail.com', '9756961988', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_63_1778574646.jpg', 'adh_b_63_1778574646.jpg', 'selfie_63_1778574646.jpg', 'partner', 'Active', 'Approved', '2026-05-06 06:38:05', '2026-05-12 09:25:02', '966087733555', 'Faridabad Haryana', NULL),
(64, 'VIJAY KUMAR AHIRWAR', 'pilgrimcabservices@gmail.com', '9893916181', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_64_1778050329.png', 'adh_b_64_1778050329.png', 'selfie_64_1778050329.jpg', 'partner', 'Active', 'Approved', '2026-05-06 06:48:44', '2026-05-06 07:55:38', '574480153623', 'Tikamgarh', NULL),
(65, 'Rajpal', 'rajpal759945@gmail.com', '8958028605', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_65_1778055371.jpg', 'adh_b_65_1778055371.jpg', 'selfie_65_1778055371.jpg', 'partner', 'Active', 'Approved', '2026-05-06 07:52:52', '2026-06-13 14:21:07', '514455353953', 'Mathura Uttar Pradesh', NULL),
(66, 'Mahesh Parmar', 'maheshparma816@gmail.com', '9998500523', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_66_1778068628.jpg', 'adh_b_66_1778068628.jpg', 'selfie_66_1778068628.jpg', 'partner', 'Active', 'Approved', '2026-05-06 11:50:29', '2026-05-06 12:41:35', '526418740676', 'Ahmedabad Gujarat', NULL),
(67, 'Maroof Ali', 'alirahi901000@gmail.com', '8882911218', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_67_1778068591.jpg', 'adh_b_67_1778068591.jpg', 'selfie_67_1778068591.jpg', 'partner', 'Active', 'Approved', '2026-05-06 11:54:28', '2026-05-06 12:39:45', '687916521375', 'Panipat', NULL),
(68, 'Deepak Kumar', 'deepakkumar15275@gmail.com', '9045374841', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_68_1778070845.jpg', 'adh_b_68_1778070845.jpg', 'selfie_68_1778070845.jpg', 'partner', 'Active', 'Approved', '2026-05-06 12:30:02', '2026-05-06 12:39:20', '490731986620', 'roorkee', NULL),
(69, 'Dhiraj', 'anitadhawand@gmail.com', '8448548191', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_69_1778070803.jpg', 'adh_b_69_1778070803.jpg', 'selfie_69_1778070803.jpg', 'partner', 'Active', 'Approved', '2026-05-06 12:30:45', '2026-05-06 12:39:03', '268874778785', 'delhi', NULL),
(70, 'ANKIT SHARMA', 'sharmaankit05031991@gmail.com', '9555731896', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_70_1778073958.jpg', 'adh_b_70_1778073958.jpg', 'selfie_70_1778073958.jpg', 'partner', 'Active', 'Approved', '2026-05-06 13:00:02', '2026-05-06 13:27:14', '243192595026', 'lucknow', NULL),
(71, 'Rahul yadav', 'ry5084647@gmail.com', '9599306497', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_71_1778679242.jpg', 'adh_b_71_1778679242.jpg', 'selfie_71_1778679242.jpg', 'partner', 'Active', 'Approved', '2026-05-06 13:31:53', '2026-05-13 15:12:08', '701393228130', 'new delhi', NULL),
(72, 'Baleshwar sharma', 'bali.sharma631@gmail.com', '7503999212', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_72_1778074954.jpg', 'adh_b_72_1778074954.jpg', 'selfie_72_1778074954.jpg', 'partner', 'Active', 'Approved', '2026-05-06 13:32:18', '2026-05-06 16:00:33', '359364738271', 'delhi', NULL),
(73, NULL, NULL, '9837537204', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-06 14:22:34', '2026-05-06 14:22:58', NULL, NULL, NULL),
(74, NULL, NULL, '8930887166', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-06 14:32:33', '2026-05-06 14:34:48', NULL, NULL, NULL),
(75, 'Moseem Rao', 'sahil.rana516@gmail.com', '9812802192', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_75_1778083245.jpg', 'adh_b_75_1778083245.jpg', 'selfie_75_1778083245.jpg', 'partner', 'Active', 'Approved', '2026-05-06 15:46:49', '2026-05-06 17:15:25', '323810552372', 'Yamunanagar', NULL),
(76, NULL, NULL, '9634911263', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-06 16:51:30', '2026-05-06 16:51:44', NULL, NULL, NULL),
(77, 'Afsar', 'Rana555877@gmail.com', '9258332490', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_77_1778093100.jpg', 'adh_b_77_1778093100.jpg', 'selfie_77_1778093100.jpg', 'partner', 'Active', 'Approved', '2026-05-06 18:41:13', '2026-05-07 00:22:15', '560579544945', 'delhi', NULL),
(78, 'Manoj Kumar Dang', 'manoj.dang101981@gmail.com', '9359602229', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_78_1778093558.jpg', 'adh_b_78_1778093558.jpg', 'selfie_78_1778093558.jpg', 'partner', '', 'Pending', '2026-05-06 18:46:05', '2026-05-06 18:52:38', '504349902531', 'rishikesh', NULL),
(79, 'Ravinder', 'ravinderjangra08530@gmail.com', '8168948146', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_79_1778216997.jpg', 'adh_b_79_1778216997.jpg', 'selfie_79_1778216997.jpg', 'partner', 'Active', 'Approved', '2026-05-06 20:20:41', '2026-05-08 05:14:55', '917879277042', 'gurgaon', NULL),
(80, NULL, NULL, '8816856230', '5085', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-06 20:22:13', '2026-05-06 20:22:20', NULL, NULL, NULL),
(81, NULL, NULL, '8059602516', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-06 20:35:28', '2026-05-06 20:35:30', NULL, NULL, NULL),
(82, 'yashdeep Shrivastava', 'nidhi.kumari3015@gmail.com', '9504073222', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_82_1778119866.jpg', 'adh_b_82_1778119866.jpg', 'selfie_82_1778119866.jpg', 'partner', 'Active', 'Approved', '2026-05-07 00:52:05', '2026-05-07 02:54:24', '693463801194', 'Delhi', NULL),
(83, 'BIJENDER', 'bijenderkumar36901@gmail.com', '7015085106', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_83_1778116409.jpg', 'adh_b_83_1778116409.jpg', 'selfie_83_1778116409.jpg', 'partner', 'Active', 'Approved', '2026-05-07 01:01:22', '2026-05-10 13:35:40', '330250782440', 'ROHTAK', NULL),
(84, NULL, NULL, '9149319424', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-07 01:16:57', '2026-05-07 01:17:18', NULL, NULL, NULL),
(85, 'Aniket bawa', 'aniketsharma26772@gmail.com', '9320604843', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_85_1778261945.jpg', 'adh_b_85_1778261945.jpg', 'selfie_85_1778261945.jpg', 'partner', 'Active', 'Approved', '2026-05-07 01:57:35', '2026-05-08 17:51:36', '704929831824', 'Chandigarh', NULL),
(86, NULL, NULL, '8449331721', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-07 02:18:41', '2026-05-07 02:19:00', NULL, NULL, NULL),
(87, 'Nirmal Singh', 'nirmal.ibad@gmail.com', '7988285465', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_87_1779252235.jpg', 'adh_b_87_1779252235.jpg', 'selfie_87_1779252235.jpg', 'partner', 'Active', 'Approved', '2026-05-07 02:35:27', '2026-05-20 06:09:46', '905830628903', 'Ismailabad, kurukshetra, Haryana,136129', NULL),
(88, 'gulfan', 'gulfan.8813036801@gmail.com', '8813036801', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_88_1778243067.jpg', 'adh_b_88_1778243067.jpg', 'selfie_88_1778243067.jpg', 'partner', 'Active', 'Approved', '2026-05-07 03:10:15', '2026-05-08 12:26:51', '325678092797', 'Yamunanagar', NULL),
(89, NULL, NULL, '9690095838', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-07 03:24:19', '2026-05-07 03:26:12', NULL, NULL, NULL),
(90, NULL, NULL, '9053511626', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-07 05:16:33', '2026-05-07 05:16:51', NULL, NULL, NULL),
(91, 'Manoj kumar', '449manojkumar1997@gmail.com', '9719165449', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_91_1778131365.jpg', 'adh_b_91_1778131365.jpg', 'selfie_91_1778131365.jpg', 'partner', 'Active', 'Approved', '2026-05-07 05:19:57', '2026-05-07 06:54:09', '362863862299', 'maheshra', NULL),
(92, NULL, NULL, '8433292738', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-07 05:22:00', '2026-05-07 05:22:09', NULL, NULL, NULL),
(93, NULL, NULL, '8218073808', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-07 06:08:57', '2026-05-07 06:09:15', NULL, NULL, NULL),
(94, 'SUVAN', 'subhanmohammad84148@gmail.com', '9711471253', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_94_1778138644.jpg', 'adh_b_94_1778138644.jpg', 'selfie_94_1778138644.jpg', 'partner', 'Active', 'Approved', '2026-05-07 07:20:09', '2026-05-07 09:35:28', '936585849785', 'Delhi Malviya Nagar South Delhi', NULL),
(95, 'Ramjan', 'aryanaali2116@gmail.com', '7053932219', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_95_1778262962.jpg', 'adh_b_95_1778262962.jpg', 'selfie_95_1778262962.jpg', 'partner', 'Active', 'Approved', '2026-05-07 08:00:54', '2026-05-08 18:01:50', '719459604433', 'delhi', NULL),
(96, 'vikkas gupta', 'basalenterprises@gmail.com', '7982179332', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_96_1778483094.jpg', 'adh_b_96_1778483094.jpg', 'selfie_96_1778483094.jpg', 'partner', 'Active', 'Approved', '2026-05-07 08:25:22', '2026-05-11 07:44:05', '756777696644', 'Delhi', NULL),
(97, 'sarfraj khan', 'khansarfraj3565@gmail.com', '9368749392', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_97_1778144212.jpg', 'adh_b_97_1778144212.jpg', 'selfie_97_1778144212.jpg', 'partner', 'Active', 'Approved', '2026-05-07 08:53:10', '2026-05-07 09:35:50', '582468338053', 'Agra', NULL),
(98, 'Pardeep Kumar', 'pksdahiya@gmail.com', '8700296263', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_98_1778147730.jpg', 'adh_b_98_1778147730.jpg', 'selfie_98_1778147730.jpg', 'partner', 'Active', 'Approved', '2026-05-07 09:50:10', '2026-05-07 12:15:27', '243416749438', 'Delhi', NULL),
(99, 'majeed mohmmad', 'rinkkhan2745@gmail.com', '9988747586', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_99_1778504372.jpg', 'adh_b_99_1778504372.jpg', 'selfie_99_1778504372.jpg', 'partner', 'Active', 'Approved', '2026-05-07 09:51:46', '2026-05-11 15:28:54', '599026497190', 'Patiala', NULL),
(100, 'Pardeep', 'pksaini.seed@gmail.com', '9350437454', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_100_1778246530.jpg', 'adh_b_100_1778246530.jpg', 'selfie_100_1778246530.jpg', 'partner', 'Active', 'Approved', '2026-05-07 11:18:13', '2026-05-08 15:33:12', '730930294227', 'Rohtak', NULL),
(101, 'Shyam sundar', 'shyamabc72@gmail.com', '9410041244', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_101_1778153496.jpg', 'adh_b_101_1778153496.jpg', 'selfie_101_1778153496.jpg', 'partner', 'Active', 'Approved', '2026-05-07 11:27:35', '2026-05-07 13:09:01', '300665906772', 'mathura uttar pradesh', NULL),
(102, 'Nishin Sharma', 'nishinsharma981@gmail.com', '9896300562', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_102_1778153875.jpg', 'adh_b_102_1778153875.jpg', 'selfie_102_1778153875.jpg', 'partner', 'Active', 'Approved', '2026-05-07 11:33:51', '2026-05-14 06:07:50', '697321337823', 'kurukshetra', NULL),
(103, 'KHETA Dangi', 'idanatours6434@gmail.com', '9950505991', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_103_1778157767.jpg', 'adh_b_103_1778157767.jpg', 'selfie_103_1778157767.jpg', 'partner', 'Active', 'Approved', '2026-05-07 12:28:53', '2026-05-10 15:01:27', '586759917600', 'Udaipur', NULL),
(104, NULL, NULL, '9756880888', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-07 13:02:14', '2026-05-07 13:02:26', NULL, NULL, NULL),
(105, NULL, NULL, '7906187879', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-07 13:36:15', '2026-05-07 13:36:34', NULL, NULL, NULL),
(106, 'sonu rathour', 'sonurathour016@gmail.com', '9634347223', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_106_1778733360.heic', 'adh_b_106_1778733360.heic', 'selfie_106_1778733360.jpg', 'partner', 'Active', 'Approved', '2026-05-07 14:17:21', '2026-05-14 06:19:31', '372429720956', 'Rudrapur', NULL),
(107, 'Gulshan kumar', 'gk371404@gmail.com', '8433432542', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_107_1778166089.jpg', 'adh_b_107_1778166089.jpg', 'selfie_107_1778166089.jpg', 'partner', 'Active', 'Approved', '2026-05-07 14:54:40', '2026-06-11 08:33:48', '696131920715', 'रामनगर', NULL),
(108, NULL, NULL, '7428125808', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-07 15:37:37', '2026-05-07 15:37:48', NULL, NULL, NULL),
(109, NULL, NULL, '9910645818', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-07 15:40:18', '2026-05-07 15:40:37', NULL, NULL, NULL),
(110, 'Rahul kumar', 'rahulpmg1997@gmail.com', '7895439497', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_110_1778399392.jpg', 'adh_b_110_1778399392.jpg', 'selfie_110_1778399392.jpg', 'partner', 'Active', 'Approved', '2026-05-07 15:47:32', '2026-05-10 07:54:47', '910121982786', 'Dehradun', NULL),
(111, 'MDSUHAIL', 'suhailkhan8311@gmail.com', '8700871993', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_111_1778169722.jpg', 'adh_b_111_1778169722.jpg', 'selfie_111_1778169722.jpg', 'partner', 'Active', 'Approved', '2026-05-07 15:49:41', '2026-05-08 01:56:51', '675921416198', 'Sayed gaou paschim vihar delhi', NULL),
(112, 'pushpender kumar', 'dhillugujjar2924@gmail.com', '9810313118', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_112_1778396630.jpg', 'adh_b_112_1778396630.jpg', 'selfie_112_1778396630.jpg', 'partner', 'Active', 'Approved', '2026-05-07 15:58:42', '2026-05-10 07:05:47', '435251329320', 'Delhi', NULL),
(113, 'Rajkumar', 'rajk35902@gmail.com', '9812668865', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_113_1778353190.jpg', 'adh_b_113_1778353190.jpg', 'selfie_113_1778353190.jpg', 'partner', 'Active', 'Approved', '2026-05-07 17:44:31', '2026-05-10 04:57:46', '690891332568', 'jind', NULL),
(114, NULL, NULL, '8059982046', '6125', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-07 17:49:08', '2026-06-12 20:24:47', NULL, NULL, NULL),
(115, NULL, NULL, '9911546221', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-07 19:58:13', '2026-05-07 19:58:29', NULL, NULL, NULL),
(116, 'mohanlal', 'rahul@gmail.com', '9466939049', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_116_1778185231.jpg', 'adh_b_116_1778185231.jpg', 'selfie_116_1778185231.jpg', 'partner', 'Active', 'Approved', '2026-05-07 20:19:30', '2026-05-12 13:20:34', '254645363636', 'jind', NULL),
(117, 'Anwar Ahmad', 'anwarkhan9311251979@gmail.com', '9311251979', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_117_1778200312.jpg', 'adh_b_117_1778200312.jpg', 'selfie_117_1778200312.jpg', 'partner', 'Active', 'Approved', '2026-05-08 00:23:34', '2026-05-23 03:52:48', '308250023378', 'GHAZIABAD', NULL),
(118, NULL, NULL, '8851644921', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-08 00:25:15', '2026-05-08 00:25:58', NULL, NULL, NULL),
(119, 'Arun Kumar', 'arunrajput680@gmail.com', '9716998635', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_119_1778202676.jpg', 'adh_b_119_1778202676.jpg', 'selfie_119_1778202676.jpg', 'partner', 'Active', 'Approved', '2026-05-08 01:07:59', '2026-05-08 01:58:22', '471091070161', 'delhi', NULL),
(120, NULL, NULL, '9675880888', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-08 01:16:44', '2026-05-08 01:16:53', NULL, NULL, NULL),
(121, 'khurashaid ali', 'kabeerali3557@gmail.com', '9897793391', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_121_1778386429.heic', 'adh_b_121_1778386429.jpg', 'selfie_121_1778386429.jpg', 'partner', 'Active', 'Approved', '2026-05-08 01:19:59', '2026-05-10 04:58:55', '208751338283', 'aminagar sarai', NULL),
(122, 'krishan soni', 'harrysoni11@gmail.com', '7014323363', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_122_1778207187.jpg', 'adh_b_122_1778207187.jpg', 'selfie_122_1778207187.jpg', 'partner', 'Active', 'Approved', '2026-05-08 02:23:13', '2026-05-08 11:10:19', '338727942492', 'hanumangarh', NULL),
(123, NULL, NULL, '9728999789', '7096', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-08 05:09:54', '2026-05-08 05:09:54', NULL, NULL, NULL),
(124, NULL, NULL, '9354961106', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-08 05:38:59', '2026-05-08 05:39:14', NULL, NULL, NULL),
(125, NULL, NULL, '7206381106', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-08 05:41:10', '2026-05-08 05:41:23', NULL, NULL, NULL),
(126, NULL, NULL, '7351724502', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-08 06:52:36', '2026-05-08 06:52:51', NULL, NULL, NULL),
(127, 'SUNEEL ARAVIND JADHAV', 'lovesunil0616@gmail.com', '9353479644', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_127_1778231963.jpg', 'adh_b_127_1778231963.jpg', 'selfie_127_1778231963.jpg', 'partner', 'Active', 'Approved', '2026-05-08 09:16:35', '2026-05-08 11:40:27', '723751610160', 'goa', NULL),
(128, NULL, NULL, '8160323745', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-08 10:03:03', '2026-05-08 10:03:21', NULL, NULL, NULL),
(129, 'sumit Singh', 'singhsumit0832@gmail.com', '8221003029', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_129_1778238568.jpg', 'adh_b_129_1778238568.jpg', 'selfie_129_1778238568.jpg', 'partner', 'Active', 'Approved', '2026-05-08 11:06:10', '2026-05-08 11:41:28', '424079289614', 'Panipat Haryana', NULL),
(130, NULL, NULL, '9894368459', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-08 11:56:15', '2026-05-08 11:56:46', NULL, NULL, NULL),
(131, 'Kamran Khan', 'kamran.khan6848@gmail.com', '8958195278', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_131_1779613253.jpg', 'adh_b_131_1779613253.jpg', 'selfie_131_1779613253.jpg', 'partner', 'Active', 'Approved', '2026-05-08 12:11:32', '2026-05-24 16:53:45', '634549262381', 'Bareilly', NULL),
(132, 'Manish kumar', 'manishpanwarm@gmail.com', '7417490706', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_132_1778242609.jpg', 'adh_b_132_1778242609.jpg', 'selfie_132_1778242609.jpg', 'partner', 'Active', 'Approved', '2026-05-08 12:13:04', '2026-05-08 13:28:50', '959736451087', 'Saharanpur', NULL),
(133, 'vijay Kumar', 'vkd003@gmail.com', '9872428235', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_133_1778243049.jpg', 'adh_b_133_1778243049.jpg', 'selfie_133_1778243049.jpg', 'partner', 'Active', 'Approved', '2026-05-08 12:20:22', '2026-05-08 13:29:42', '613487234468', 'nangal', NULL),
(134, NULL, NULL, '6306573008', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-08 12:30:29', '2026-05-08 12:30:41', NULL, NULL, NULL),
(135, 'Satya kishor', 'satyakishor383@gmail.com', '8802966564', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_135_1778293290.jpg', 'adh_b_135_1778293290.jpg', 'selfie_135_1778293290.jpg', 'partner', 'Active', 'Approved', '2026-05-08 12:40:00', '2026-05-09 03:06:23', '381003716112', 'Delhi', NULL),
(136, 'sandeep singh', 'sp482112@gmail.com', '7073485019', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_136_1778244721.jpg', 'adh_b_136_1778244721.jpg', 'selfie_136_1778244721.jpg', 'partner', 'Active', 'Approved', '2026-05-08 12:49:27', '2026-05-08 13:30:00', '296024035267', 'jaipur', NULL),
(137, NULL, NULL, '9017237114', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-08 14:41:34', '2026-05-22 16:42:52', NULL, NULL, NULL),
(138, 'Thakor nanuji sedha ji', 'nanuji1569@gmail.com', '7048301081', '3680', NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_138_1778257370.jpg', 'adh_b_138_1778257370.jpg', 'selfie_138_1778257370.jpg', 'partner', 'Active', 'Approved', '2026-05-08 16:11:43', '2026-05-08 16:57:43', '615887046565', 'ahemdabad', NULL),
(139, NULL, NULL, '9316706714', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-08 16:12:03', '2026-05-08 16:12:18', NULL, NULL, NULL),
(140, 'Ravindra', 'ravinderkashyap2620@gmail.com', '7982190634', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_140_1778493582.jpg', 'adh_b_140_1778493582.jpg', 'selfie_140_1778493582.jpg', 'partner', 'Active', 'Approved', '2026-05-08 17:39:05', '2026-05-11 10:12:44', '544424446809', 'dehli', NULL),
(141, NULL, NULL, '7042668145', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-08 17:39:38', '2026-05-08 17:39:49', NULL, NULL, NULL),
(142, 'RAHUL KUMAR', 'rahulkumar15890@gmail.com', '9599954947', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_142_1778420985.jpg', 'adh_b_142_1778420985.jpg', 'selfie_142_1778420985.jpg', 'partner', 'Active', 'Approved', '2026-05-09 02:03:32', '2026-05-13 09:25:54', '511713748553', 'DELHI', NULL),
(143, 'sunder', 'sundersingh2015@gmail.com', '7665833201', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_143_1778296004.jpg', 'adh_b_143_1778296004.jpg', 'selfie_143_1778296004.jpg', 'partner', 'Active', 'Approved', '2026-05-09 02:59:18', '2026-05-09 04:09:49', '989709085427', 'faridabad', NULL),
(144, NULL, NULL, '7792969679', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-09 04:04:37', '2026-05-09 04:04:47', NULL, NULL, NULL),
(145, 'laxman', 'laxmandewda73@gmail.com', '7742964241', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_145_1778304271.jpg', 'adh_b_145_1778304271.jpg', 'selfie_145_1778304271.jpg', 'partner', 'Active', 'Approved', '2026-05-09 04:07:21', '2026-05-09 05:40:59', '558103572142', 'Udaipur', NULL),
(147, 'singarajesh R', 'singam37227@gmail.com', '6369399141', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_147_1778312586.jpg', 'adh_b_147_1778312586.jpg', 'selfie_147_1778312586.jpg', 'partner', 'Active', 'Approved', '2026-05-09 07:33:21', '2026-05-09 07:49:54', '715716915307', 'kovilpatti', NULL),
(148, 'gajendra meena', 'Chiragmeena002@gmail.com', '9829514023', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_148_1778313463.jpg', 'adh_b_148_1778313463.jpg', 'selfie_148_1778313463.jpg', 'partner', 'Active', 'Approved', '2026-05-09 07:48:37', '2026-05-09 14:40:19', '852004755159', 'Bharatpur', NULL),
(149, NULL, NULL, '8810584922', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-09 08:07:46', '2026-05-09 08:07:55', NULL, NULL, NULL),
(150, NULL, NULL, '9518036249', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-09 09:09:43', '2026-05-09 09:10:04', NULL, NULL, NULL),
(151, 'harish singh', 'harishsinghmehra352@gmail.com', '9717755106', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_151_1778328533.jpg', 'adh_b_151_1778328533.jpg', 'selfie_151_1778328533.jpg', 'partner', 'Active', 'Approved', '2026-05-09 09:17:34', '2026-05-09 14:41:00', '943477298649', 'Haldwani', NULL),
(152, 'Sachin Kumar', 'sachinrana9309@gmail.com', '8130315742', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_152_1778323729.jpg', 'adh_b_152_1778323729.jpg', 'selfie_152_1778323729.jpg', 'partner', 'Active', 'Approved', '2026-05-09 09:20:14', '2026-05-09 14:41:37', '345471033193', 'New Delhi', NULL),
(153, NULL, NULL, '9634982981', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-09 10:21:53', '2026-05-09 10:22:03', NULL, NULL, NULL),
(154, 'kanhaiya', 'kalika.enterprises7@gmail.com', '9694576757', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_154_1778322685.jpg', 'adh_b_154_1778322685.jpg', 'selfie_154_1778322685.jpg', 'partner', 'Active', 'Approved', '2026-05-09 10:26:16', '2026-05-09 14:42:10', '219760075038', 'udaipur', NULL),
(155, 'devendra tiwari', 'devendra.tripa@gmail.com', '7897161389', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_155_1778324581.jpg', 'adh_b_155_1778324581.jpg', 'selfie_155_1778324581.jpg', 'partner', 'Active', 'Approved', '2026-05-09 10:58:06', '2026-05-09 14:42:37', '716712121114', 'prayagraj', NULL),
(156, 'Sunil Chauhan', 'sunilchauhan1988@gmail.com', '9899900355', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_156_1778401889.jpg', 'adh_b_156_1778401889.jpg', 'selfie_156_1778401889.jpg', 'partner', 'Active', 'Approved', '2026-05-09 11:55:00', '2026-05-10 12:42:59', '506188369461', 'Indirapuram Ghaziabad', NULL),
(157, NULL, NULL, '9813113201', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-09 12:24:27', '2026-05-09 12:24:47', NULL, NULL, NULL),
(159, NULL, NULL, '8401999253', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-09 15:51:51', '2026-05-14 02:36:05', NULL, NULL, NULL),
(160, 'vijay kant', 'anuragvrm35@gmail.com', '9718770501', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_160_1778342394.jpg', 'adh_b_160_1778342394.jpg', 'selfie_160_1778342394.jpg', 'partner', 'Active', 'Approved', '2026-05-09 15:58:17', '2026-05-09 16:11:20', '478348348661', 'delhi', NULL),
(161, 'Vikram sandhu', 'sandhuvikram764@gmail.com', '9996996769', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_161_1778346544.jpg', 'adh_b_161_1778346544.jpg', 'selfie_161_1778346544.jpg', 'partner', 'Active', 'Approved', '2026-05-09 17:04:16', '2026-05-09 17:16:54', '828088558055', 'sirsa haryana', NULL),
(162, 'Amit Kumar', 'amit77210@gmail.com', '9315325877', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_162_1778379373.jpg', 'adh_b_162_1778379373.jpg', 'selfie_162_1778379373.jpg', 'partner', 'Active', 'Approved', '2026-05-09 17:05:07', '2026-05-10 04:59:46', '512736411159', 'panipat', NULL),
(163, NULL, NULL, '9718580393', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-09 17:50:29', '2026-05-09 17:50:46', NULL, NULL, NULL),
(164, NULL, NULL, '9560504805', '5564', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-09 18:01:44', '2026-05-14 07:08:29', NULL, NULL, NULL),
(165, 'Mandeep Singh', 'mandeeptaxichd@gmail.com', '9501859291', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_165_1778381562.jpg', 'adh_b_165_1778381562.jpg', 'selfie_165_1778381562.jpg', 'partner', 'Active', 'Approved', '2026-05-10 02:49:11', '2026-05-10 05:00:30', '949609318225', 'chandigarh', NULL),
(166, NULL, NULL, '9509429924', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-10 03:53:15', '2026-05-14 16:10:18', NULL, NULL, NULL),
(167, 'sonu sharma', 'sonusharma99126@gmail.com', '8178980712', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_167_1778386721.jpg', 'adh_b_167_1778386721.jpg', 'selfie_167_1778386721.jpg', 'partner', 'Active', 'Approved', '2026-05-10 04:12:35', '2026-05-10 05:01:28', '664567542363', 'Delhi', NULL),
(168, 'Shubham', 'kumarnogiya759@gmail.com', '9166709370', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_168_1778386609.jpg', 'adh_b_168_1778386609.jpg', 'selfie_168_1778386609.jpg', 'partner', 'Active', 'Approved', '2026-05-10 04:13:52', '2026-05-10 05:01:57', '822337383968', 'jaipur Rajasthan', NULL),
(169, NULL, NULL, '7404152167', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-10 04:13:59', '2026-05-10 04:14:11', NULL, NULL, NULL),
(170, 'Rakesh Panchal', 'rakeshpanchal0923@gmail.com', '7011413555', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_170_1778387099.jpg', 'adh_b_170_1778387099.jpg', 'selfie_170_1778387099.jpg', 'partner', 'Active', 'Approved', '2026-05-10 04:20:40', '2026-05-10 05:02:27', '260504265944', 'faridabad', NULL),
(171, NULL, NULL, '9808664107', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-10 04:33:35', '2026-05-10 04:33:55', NULL, NULL, NULL),
(172, NULL, NULL, '9555711766', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-10 04:45:42', '2026-05-10 04:46:30', NULL, NULL, NULL),
(173, NULL, NULL, '9950967199', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-10 04:53:20', '2026-05-10 04:53:34', NULL, NULL, NULL),
(174, NULL, NULL, '7973396473', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-10 05:26:12', '2026-05-10 05:26:58', NULL, NULL, NULL),
(175, 'Sandeep Kumar', 'sandeepkumarkursanda123@gmail.com', '9198929585', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_175_1778393076.jpg', 'adh_b_175_1778393076.jpg', 'selfie_175_1778393076.jpg', 'partner', 'Active', 'Approved', '2026-05-10 05:57:08', '2026-05-10 06:54:08', '213195558894', 'New Delhi', NULL),
(176, 'Raj Kumar', 'rajkumarchaudhary710@gmail.com', '8755089487', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_176_1778392809.jpg', 'adh_b_176_1778392809.jpg', 'selfie_176_1778392809.jpg', 'partner', 'Active', 'Approved', '2026-05-10 05:57:35', '2026-05-10 06:54:29', '798629645010', 'Delhi NCR', NULL),
(177, NULL, NULL, '7530920725', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-10 06:13:32', '2026-05-10 06:13:47', NULL, NULL, NULL),
(178, 'vishal sharma', 'vishalsharma315000@gmail.com', '9215383777', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_178_1778399812.jpg', 'adh_b_178_1778399812.jpg', 'selfie_178_1778399812.jpg', 'partner', 'Active', 'Approved', '2026-05-10 07:52:43', '2026-05-10 12:42:14', '825967698695', 'Ambala', NULL),
(179, 'Vivek Kumar Singh', 'vivek198197@gmail.com', '8398058388', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_179_1778401005.jpg', 'adh_b_179_1778401005.jpg', 'selfie_179_1778401005.jpg', 'partner', 'Active', 'Approved', '2026-05-10 08:11:48', '2026-05-10 10:18:57', '275513410051', 'lucknow', NULL),
(180, NULL, NULL, '9719531722', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-10 09:52:55', '2026-05-10 09:53:19', NULL, NULL, NULL),
(181, 'Rahul Kumar dev', 'rahulkumardev007@gmail.com', '7009635184', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_181_1778407133.jpg', 'adh_b_181_1778407133.jpg', 'selfie_181_1778407133.jpg', 'partner', 'Active', 'Approved', '2026-05-10 09:54:39', '2026-05-10 12:44:22', '920016181633', 'Chandigarh', NULL),
(182, NULL, NULL, '8700809010', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-10 10:41:26', '2026-05-10 10:41:40', NULL, NULL, NULL),
(183, NULL, NULL, '9705305880', '9811', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-10 12:43:49', '2026-05-10 12:43:49', NULL, NULL, NULL),
(184, 'aman', 'tyagiaman952@gmail.com', '8923522330', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_184_1778417188.jpg', 'adh_b_184_1778417188.jpg', 'selfie_184_1778417188.jpg', 'partner', 'Active', 'Approved', '2026-05-10 12:43:53', '2026-05-10 15:37:26', '637509996322', 'ghaziabad', NULL),
(185, 'Rabins Raj Sah', 'Dipaksah620@gmail.com', '9873916850', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_185_1778417737.jpg', 'adh_b_185_1778417737.jpg', 'selfie_185_1778417737.jpg', 'partner', 'Active', 'Approved', '2026-05-10 12:44:29', '2026-05-10 15:39:16', '469620736353', 'New delhi', NULL),
(186, NULL, NULL, '9876961280', '1105', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-10 12:46:21', '2026-05-10 17:31:52', NULL, NULL, NULL),
(187, 'Ikrar', 'ikrarkhanikrarkhan938@gmail.com', '8958149084', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_187_1778417550.jpg', 'adh_b_187_1778417550.jpg', 'selfie_187_1778417550.jpg', 'partner', 'Active', 'Approved', '2026-05-10 12:48:15', '2026-05-14 11:11:36', '353452149053', 'Delhi se Dehradun', NULL),
(188, 'Javed', 'alijaved0389@gmail.com', '6395320692', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_188_1778417483.jpg', 'adh_b_188_1778417483.jpg', 'selfie_188_1778417483.jpg', 'partner', 'Active', 'Approved', '2026-05-10 12:48:26', '2026-05-18 09:08:16', '324222794948', 'Gurugram', NULL),
(189, NULL, NULL, '9899439760', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-10 12:51:30', '2026-05-10 12:51:44', NULL, NULL, NULL),
(190, NULL, NULL, '8619144835', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-10 15:01:00', '2026-05-10 15:01:02', NULL, NULL, NULL),
(191, NULL, NULL, '8851543231', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-10 16:44:03', '2026-05-10 16:44:18', NULL, NULL, NULL),
(192, NULL, NULL, '8303394828', '4107', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-10 17:00:07', '2026-05-10 17:01:01', NULL, NULL, NULL),
(193, NULL, NULL, '9022042639', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-10 18:31:16', '2026-06-07 02:42:36', NULL, NULL, NULL),
(194, NULL, NULL, '9324758569', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-10 18:32:48', '2026-05-14 09:18:13', NULL, NULL, NULL),
(195, 'amit kumar', 'babalamit94@gmail.com', '7891256689', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_195_1778445529.jpg', 'adh_b_195_1778445529.jpg', 'selfie_195_1778445529.jpg', 'partner', 'Active', 'Approved', '2026-05-10 20:35:08', '2026-05-11 00:12:40', '540798255303', 'jaipur', NULL),
(196, 'Moh Ikabal', 'guddaybhairose327@gmail.com', '9528280295', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_196_1778455589.jpg', 'adh_b_196_1778455589.jpg', 'selfie_196_1778455589.jpg', 'partner', 'Active', 'Approved', '2026-05-10 23:19:51', '2026-06-09 00:38:34', '587305887354', 'Bareilly Uttar Pradesh', NULL),
(197, 'Lalit Kumar', 'lk448106@gmail.com', '9560956714', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_197_1779080687.jpg', 'adh_b_197_1779080687.jpg', 'selfie_197_1779080687.jpg', 'partner', 'Active', 'Approved', '2026-05-11 02:46:47', '2026-05-18 10:47:00', '375063762871', 'house number 176 industries area Sahibabad side fall Ghaziabad', NULL),
(198, NULL, NULL, '8800445212', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-11 04:24:22', '2026-05-11 04:24:35', NULL, NULL, NULL),
(199, 'Mohammad Shahnawaz Husain', 'kh561668@gmail.com', '8178809087', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_199_1778476148.jpg', 'adh_b_199_1778476148.jpg', 'selfie_199_1778476148.jpg', 'partner', 'Active', 'Approved', '2026-05-11 05:06:14', '2026-05-11 07:44:58', '324561350277', 'DELHI', NULL),
(200, NULL, NULL, '9389568792', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-11 05:06:29', '2026-05-11 05:07:35', NULL, NULL, NULL),
(201, NULL, NULL, '9812234005', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-11 05:09:31', '2026-05-11 05:09:53', NULL, NULL, NULL),
(202, NULL, NULL, '6396115732', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-11 05:13:48', '2026-05-11 05:13:59', NULL, NULL, NULL),
(203, NULL, NULL, '9653764671', '5097', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-11 05:45:55', '2026-05-11 06:09:09', NULL, NULL, NULL),
(204, 'Deepak Chandela', 'deepakchandela95@gmail.com', '8467059503', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_204_1778697736.jpg', 'adh_b_204_1778697736.jpg', 'selfie_204_1778697736.jpg', 'partner', 'Active', 'Approved', '2026-05-11 06:36:30', '2026-05-14 06:20:10', '451075803270', 'Ghaziabad', NULL);
INSERT INTO `partners` (`id`, `full_name`, `email`, `mobile`, `login_otp`, `password`, `mobile_verified`, `aadhaar_verified`, `aadhaar_number`, `surepass_client_id`, `aadhaar_pdf_link`, `driving_license_link`, `rc_book_link`, `aadhaar_front_link`, `aadhaar_back_link`, `selfie_link`, `roles`, `status`, `manual_verification_status`, `created_at`, `updated_at`, `aadhar_number`, `city`, `fcm_token`) VALUES
(205, 'Deepak Tripathi', 'shreeramrakshatoursntravels@gmail.com', '9599016019', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_205_1778484074.jpg', 'adh_b_205_1778484074.jpg', 'selfie_205_1778484074.jpg', 'partner', 'Active', 'Approved', '2026-05-11 07:15:13', '2026-05-11 07:43:04', '513054559094', 'delhi', NULL),
(206, NULL, NULL, '9311857453', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-11 07:27:07', '2026-05-15 08:16:50', NULL, NULL, NULL),
(207, 'Rahul', 'rahulgola251@gmail.com', '9870460350', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_207_1779124171.jpg', 'adh_b_207_1779124171.jpg', 'selfie_207_1779124171.jpg', 'partner', 'Active', 'Approved', '2026-05-11 09:36:03', '2026-05-18 18:54:43', '434505498954', 'delhi', NULL),
(208, NULL, NULL, '8780474400', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-11 10:48:26', '2026-05-11 10:48:37', NULL, NULL, NULL),
(209, NULL, NULL, '8700843658', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-11 12:31:34', '2026-05-11 12:32:01', NULL, NULL, NULL),
(210, NULL, NULL, '8295053070', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-11 12:34:59', '2026-05-11 12:35:10', NULL, NULL, NULL),
(211, 'saleman khan', 'salemankhankhan368@gmail.com', '6375407285', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_211_1778505682.jpg', 'adh_b_211_1778505682.jpg', 'selfie_211_1778505682.jpg', 'partner', 'Active', 'Approved', '2026-05-11 13:18:15', '2026-05-11 15:27:05', '305650715119', 'delhi', NULL),
(212, 'Anas warsi', 'anaswarsi70770@gmail.com', '9654730050', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_212_1778509653.jpg', 'adh_b_212_1778509653.jpg', 'selfie_212_1778509653.jpg', 'partner', 'Active', 'Approved', '2026-05-11 14:24:02', '2026-05-11 15:27:50', '394602790182', 'Bareilly', NULL),
(213, 'ANIL KUMAR', 'ak809648@gmail.com', '9289077054', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_213_1778511529.jpg', 'adh_b_213_1778511529.jpg', 'selfie_213_1778511529.jpg', 'partner', 'Active', 'Approved', '2026-05-11 14:56:09', '2026-05-11 15:26:01', '578248650723', 'Bijwasan new Delhi 110061', NULL),
(214, 'Dharmendra Kumar', 'dharmendrayadavyadav775@gmail.com', '9821170646', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_214_1778520631.jpg', 'adh_b_214_1778520631.jpg', 'selfie_214_1778520631.jpg', 'partner', 'Active', 'Approved', '2026-05-11 15:28:09', '2026-05-12 09:21:14', '633702783884', 'okhla3 delhi', NULL),
(215, NULL, NULL, '9671559847', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-11 15:48:58', '2026-05-11 15:49:11', NULL, NULL, NULL),
(216, 'Nikhilesh Kumar Kamal', 'nikhilesh221292@gmail.com', '7531085110', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_216_1778515409.jpg', 'adh_b_216_1778515409.jpg', 'selfie_216_1778515409.jpg', 'partner', 'Active', 'Approved', '2026-05-11 15:57:35', '2026-05-11 16:05:58', '314283372268', 'Agra', NULL),
(217, NULL, NULL, '8178945657', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-11 15:59:38', '2026-05-11 16:00:23', NULL, NULL, NULL),
(218, NULL, NULL, '8850743930', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-12 02:06:23', '2026-05-12 02:06:36', NULL, NULL, NULL),
(219, NULL, NULL, '7248604383', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-12 03:41:14', '2026-05-12 03:41:29', NULL, NULL, NULL),
(220, NULL, NULL, '9773701492', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-12 04:37:20', '2026-05-12 04:37:33', NULL, NULL, NULL),
(221, NULL, NULL, '9812358606', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-12 05:23:39', '2026-05-12 05:23:47', NULL, NULL, NULL),
(222, 'akashdeep', 'akashdeep75776@gmail.com', '8195085677', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_222_1778570749.jpg', 'adh_b_222_1778570749.jpg', 'selfie_222_1778570749.jpg', 'partner', 'Active', 'Approved', '2026-05-12 07:23:11', '2026-05-12 09:22:39', '900626067962', 'ludhiana', NULL),
(223, 'Jadeja mihirrasinh', 'belikebanna0716@gmail.com', '9825382882', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_223_1778945650.jpg', 'adh_b_223_1778945650.jpg', 'selfie_223_1778945650.jpg', 'partner', 'Active', 'Approved', '2026-05-12 08:55:02', '2026-05-16 16:28:28', '700235814040', 'gandhidham', NULL),
(224, NULL, NULL, '7579075524', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-12 09:23:42', '2026-05-12 09:24:02', NULL, NULL, NULL),
(225, 'Ankur Rajauriya', 'ankurpandit1234567@gmail.com', '7906222214', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_225_1778579310.jpg', 'adh_b_225_1778579310.jpg', 'selfie_225_1778579310.jpg', 'partner', 'Active', 'Approved', '2026-05-12 09:45:51', '2026-05-12 10:38:33', '811063334639', 'Firozabad', NULL),
(226, 'Tayyib Mughal', 'tayyibrashidmughal@gmail.com', '9906329873', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_226_1778581651.jpg', 'adh_b_226_1778581651.jpg', 'selfie_226_1778581651.jpg', 'partner', 'Active', 'Approved', '2026-05-12 10:23:44', '2026-05-12 10:39:16', '381029142898', 'rajouri', NULL),
(227, 'deepak pal', 'bagheldeepak5050@gmail.com', '8882398005', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_227_1778587445.jpg', 'adh_b_227_1778587445.jpg', 'selfie_227_1778587445.jpg', 'partner', 'Active', 'Approved', '2026-05-12 12:02:25', '2026-05-12 13:43:08', '302936363563', 'delhi', NULL),
(228, NULL, NULL, '9785667787', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-12 12:12:34', '2026-05-23 15:17:51', NULL, NULL, NULL),
(229, 'Azeem travels', 'azeemghazi052@gmail.com', '8535014455', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_229_1779122007.jpg', 'adh_b_229_1779122007.jpg', 'selfie_229_1779122007.jpg', 'partner', 'Active', 'Approved', '2026-05-12 13:50:25', '2026-05-18 17:05:34', '797776771986', 'Dehradun', NULL),
(230, NULL, NULL, '9258631112', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-12 15:09:19', '2026-05-12 15:16:04', NULL, NULL, NULL),
(231, NULL, NULL, '8954499325', '1974', NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-12 15:48:00', '2026-05-14 16:10:30', NULL, NULL, NULL),
(232, NULL, NULL, '9217193225', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-12 17:03:29', '2026-05-12 17:03:40', NULL, NULL, NULL),
(233, NULL, NULL, '6280857920', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-13 00:25:51', '2026-05-13 00:26:06', NULL, NULL, NULL),
(234, 'bheem singh', 'lishacabs2615@gmail.com', '9461759913', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_234_1778640617.jpg', 'adh_b_234_1778640617.jpg', 'selfie_234_1778640617.jpg', 'partner', 'Active', 'Approved', '2026-05-13 02:47:02', '2026-05-13 07:21:34', '777643649359', 'jaipur', NULL),
(235, NULL, NULL, '9888842767', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-13 03:39:41', '2026-05-13 03:39:58', NULL, NULL, NULL),
(236, NULL, NULL, '9310975203', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-13 06:32:24', '2026-05-13 06:32:35', NULL, NULL, NULL),
(237, NULL, NULL, '7065778504', '6298', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-13 09:33:36', '2026-05-13 09:34:12', NULL, NULL, NULL),
(238, 'nikhil', 'nikhilnt096@gmail.com', '7065739506', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_238_1778665030.jpg', 'adh_b_238_1778665030.jpg', 'selfie_238_1778665030.jpg', 'partner', 'Active', 'Approved', '2026-05-13 09:34:29', '2026-05-13 15:11:23', '665319246837', 'dhili', NULL),
(239, 'satyam', 'satyam.bhagat99000@gmail.com', '8368298658', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_239_1778694999.jpg', 'adh_b_239_1778694999.jpg', 'selfie_239_1778694999.jpg', 'partner', 'Active', 'Approved', '2026-05-13 17:53:41', '2026-05-14 06:30:34', '848032713676', 'faridabad', NULL),
(240, 'Arun kumar', 'karun05749@gmail.com', '8700071365', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_240_1778723622.jpg', 'adh_b_240_1778723622.jpg', 'selfie_240_1778723622.jpg', 'partner', 'Active', 'Approved', '2026-05-13 18:35:43', '2026-05-14 06:24:07', '785854038362', 'delhi', NULL),
(241, NULL, NULL, '9891126872', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 00:38:16', '2026-05-14 00:38:27', NULL, NULL, NULL),
(242, NULL, NULL, '8907886619', '5620', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 02:44:58', '2026-05-14 02:44:58', NULL, NULL, NULL),
(243, NULL, NULL, '8468935626', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 03:30:23', '2026-05-14 03:30:43', NULL, NULL, NULL),
(244, NULL, NULL, '8011257156', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 04:08:19', '2026-05-14 04:08:37', NULL, NULL, NULL),
(245, 'gurnam Singh', 'goldynirman410@gmail.com', '7009951450', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_245_1778937571.jpg', 'adh_b_245_1778937571.jpg', 'selfie_245_1778937571.jpg', 'partner', 'Active', 'Approved', '2026-05-14 04:47:41', '2026-05-16 13:34:00', '285357359402', 'patiala', NULL),
(246, NULL, NULL, '8882586447', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 05:15:02', '2026-05-14 05:15:29', NULL, NULL, NULL),
(247, NULL, NULL, '8285617596', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 05:15:58', '2026-05-14 05:16:09', NULL, NULL, NULL),
(248, NULL, NULL, '8445523037', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 06:37:58', '2026-05-14 06:38:33', NULL, NULL, NULL),
(249, NULL, NULL, '8006003724', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 06:39:59', '2026-05-14 06:40:15', NULL, NULL, NULL),
(250, 'Mohd javed', 'mohdjaved58337@gmail.com', '7906858943', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_250_1778742275.jpg', 'adh_b_250_1778742275.jpg', 'selfie_250_1778742275.jpg', 'partner', 'Active', 'Approved', '2026-05-14 07:02:22', '2026-05-14 11:41:09', '300974368665', 'rampur', NULL),
(251, 'Akshay Kapoor', 'akkitourandtravels10@gmail.com', '6280265761', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_251_1778742715.jpg', 'adh_b_251_1778742715.jpg', 'selfie_251_1778742715.jpg', 'partner', 'Active', 'Approved', '2026-05-14 07:07:38', '2026-05-14 07:18:47', '298054815360', 'chandigarh', NULL),
(252, 'Ankur', 'aankurrajput944@gmail.com', '9540173746', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_252_1778742747.jpg', 'adh_b_252_1778742747.jpg', 'selfie_252_1778742747.jpg', 'partner', 'Active', 'Approved', '2026-05-14 07:07:42', '2026-05-14 07:19:03', '479752080261', 'Gurgaon', NULL),
(253, 'kartik', 'kartic.arora@gmail.com', '9041515159', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_253_1778742794.jpg', 'adh_b_253_1778742794.jpg', 'selfie_253_1778742794.jpg', 'partner', 'Active', 'Approved', '2026-05-14 07:09:58', '2026-05-14 07:19:19', '223088625949', 'bathinda', NULL),
(254, NULL, NULL, '9877658267', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 07:14:28', '2026-05-14 07:15:10', NULL, NULL, NULL),
(255, 'pankaj wadhawan', 'pankajkuki9@gmail.com', '9646325402', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_255_1778743442.jpg', 'adh_b_255_1778743442.jpg', 'selfie_255_1778743443.jpg', 'partner', 'Active', 'Approved', '2026-05-14 07:17:39', '2026-05-14 07:31:47', '685857729924', 'jalandhar', NULL),
(256, 'Senthilkumar T A', 'aaradhyatoursandtravels22@gmail.com', '9080423872', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_256_1778743893.jpg', 'adh_b_256_1778743893.jpg', 'selfie_256_1778743893.jpg', 'partner', 'Active', 'Approved', '2026-05-14 07:18:14', '2026-05-14 07:32:36', '817283824537', 'Coimbatore', NULL),
(257, 'Govind tiwari', 'govindtiwari845@gmail.com', '8700219533', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_257_1778763858.jpg', 'adh_b_257_1778763858.jpg', 'selfie_257_1778763858.jpg', 'partner', 'Active', 'Approved', '2026-05-14 07:26:57', '2026-06-12 16:52:52', '659410878030', 'khora colony Ghaziabad', NULL),
(258, NULL, NULL, '9910445018', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 07:28:17', '2026-05-14 07:28:29', NULL, NULL, NULL),
(259, NULL, NULL, '8571053890', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 07:43:42', '2026-05-14 07:44:30', NULL, NULL, NULL),
(260, NULL, NULL, '9773605039', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 09:09:06', '2026-05-14 09:09:28', NULL, NULL, NULL),
(261, NULL, NULL, '9012107776', '2234', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 09:11:56', '2026-05-14 09:12:34', NULL, NULL, NULL),
(262, NULL, NULL, '7452029786', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 09:47:43', '2026-05-14 09:48:06', NULL, NULL, NULL),
(263, 'ritik yadav', 'yritik553@gmail.com', '8085310288', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_263_1778756231.jpg', 'adh_b_263_1778756231.jpg', 'selfie_263_1778756231.jpg', 'partner', 'Active', 'Approved', '2026-05-14 10:49:37', '2026-05-14 11:16:45', '341887283992', 'bhopal madhya Pradesh', NULL),
(264, 'Gurdeep', 'gurdeepsingh32229@gmail.com', '8837632229', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_264_1778756430.jpg', 'adh_b_264_1778756430.jpg', 'selfie_264_1778756430.jpg', 'partner', 'Active', 'Approved', '2026-05-14 10:53:25', '2026-05-14 11:16:59', '939153144685', 'Ludhiana', NULL),
(265, NULL, NULL, '6758175615', '7577', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 11:59:52', '2026-05-14 12:00:27', NULL, NULL, NULL),
(266, 'Ankul Kumar Singh', 'bhm.ankulkumar@gmail.com', '8341918244', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_266_1778761716.jpg', 'adh_b_266_1778761716.jpg', 'selfie_266_1778761716.jpg', 'partner', 'Active', 'Approved', '2026-05-14 12:26:31', '2026-05-14 13:09:39', '714546151530', 'Hyderabad', NULL),
(267, NULL, NULL, '9671838313', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 13:53:15', '2026-05-14 13:53:28', NULL, NULL, NULL),
(268, 'Gaurav', 'Gk98193@gmail.com', '8572051240', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_268_1778768301.jpg', 'adh_b_268_1778768301.jpg', 'selfie_268_1778768301.jpg', 'partner', 'Active', 'Approved', '2026-05-14 14:14:36', '2026-05-14 15:17:11', '713408424858', 'New Delhi', NULL),
(269, 'badri prasad', 'plusstar027@gmail.com', '8058531844', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_269_1778771048.jpg', 'adh_b_269_1778771048.jpg', 'selfie_269_1778771048.jpg', 'partner', 'Active', 'Approved', '2026-05-14 14:58:27', '2026-05-14 15:18:00', '932014690855', 'jaipur', NULL),
(270, 'JUGENDRA SINGH', 'jugendrachaudhary594@gmail.com', '7037855109', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_270_1778773269.jpg', 'adh_b_270_1778773269.jpg', 'selfie_270_1778773269.jpg', 'partner', 'Active', 'Approved', '2026-05-14 15:37:28', '2026-05-14 17:03:24', '656900121674', 'faridabad', NULL),
(271, 'Shailendra Singh', 'shinghshailendra1362@gmail.com', '7229989923', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_271_1778773292.jpg', 'adh_b_271_1778773292.jpg', 'selfie_271_1778773292.jpg', 'partner', 'Active', 'Approved', '2026-05-14 15:38:39', '2026-05-14 15:43:57', '387999550372', 'Jaipur', NULL),
(272, NULL, NULL, '9179886132', '8654', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 15:38:55', '2026-05-14 15:38:55', NULL, NULL, NULL),
(273, NULL, NULL, '7988613211', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 15:39:15', '2026-05-14 15:39:27', NULL, NULL, NULL),
(274, 'Uvaish Raza', 'razauvaish24@gmail.com', '9548219577', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_274_1778913562.jpg', 'adh_b_274_1778913562.jpg', 'selfie_274_1778913562.jpg', 'partner', 'Active', 'Approved', '2026-05-14 15:42:25', '2026-05-16 07:30:11', '420357734601', 'Bareilly', NULL),
(275, NULL, NULL, '8930988960', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 15:42:27', '2026-05-14 15:42:39', NULL, NULL, NULL),
(276, 'Sanjay tomar', 'sanjaytomer57@gmail.com', '9026959898', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_276_1778773814.jpg', 'adh_b_276_1778773814.jpg', 'selfie_276_1778773814.jpg', 'partner', 'Active', 'Approved', '2026-05-14 15:42:40', '2026-05-14 15:51:31', '294853168727', 'Delhi', NULL),
(277, 'LOVELEEN BAINS', 'bainstravel005@gmail.com', '7298040005', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_277_1778773661.jpg', 'adh_b_277_1778773661.jpg', 'selfie_277_1778773661.jpg', 'partner', 'Active', 'Approved', '2026-05-14 15:45:50', '2026-05-14 15:50:41', '257019178346', 'ludhiana', NULL),
(278, NULL, NULL, '9897344805', '5333', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 15:47:11', '2026-05-14 15:47:11', NULL, NULL, NULL),
(279, 'subhash singh', 'subhashshekhawat331@gmail.com', '8930809999', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_279_1779162833.jpg', 'adh_b_279_1779162833.jpg', 'selfie_279_1779162833.jpg', 'partner', 'Active', 'Approved', '2026-05-14 15:52:16', '2026-05-19 03:57:17', '902510834014', 'Gurugram', NULL),
(280, 'shakti singh', 'bnnashaktisingh@gmail.com', '9358527349', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_280_1778774224.jpg', 'adh_b_280_1778774224.jpg', 'selfie_280_1778774224.jpg', 'partner', 'Active', 'Approved', '2026-05-14 15:54:36', '2026-05-14 17:02:58', '710486364271', 'jaipur', NULL),
(281, 'roshan lal', 'roshanlaljarwal1@gmail.com', '9784553157', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_281_1778896785.jpg', 'adh_b_281_1778896785.jpg', 'selfie_281_1778896785.jpg', 'partner', 'Active', 'Approved', '2026-05-14 15:57:23', '2026-05-16 06:20:28', '530638570999', 'Jaipur', NULL),
(282, NULL, NULL, '7018253371', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 16:02:50', '2026-05-14 16:02:59', NULL, NULL, NULL),
(283, NULL, NULL, '8146368483', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 16:10:47', '2026-05-14 16:11:03', NULL, NULL, NULL),
(284, 'vansh meena', 'vanshmeena9372@gmail.com', '6376489327', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_284_1778775426.jpg', 'adh_b_284_1778775426.jpg', 'selfie_284_1778775426.jpg', 'partner', 'Active', 'Approved', '2026-05-14 16:12:02', '2026-05-14 17:04:08', '790212183340', 'kota', NULL),
(285, NULL, NULL, '9719256313', '8757', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 16:17:56', '2026-05-14 16:17:56', NULL, NULL, NULL),
(286, 'sonu', 'sonuhanswaliya327@gmail.com', '7827314417', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_286_1778775824.jpg', 'adh_b_286_1778775824.jpg', 'selfie_286_1778775824.jpg', 'partner', 'Active', 'Approved', '2026-05-14 16:21:52', '2026-05-14 17:04:27', '208597374099', 'south delhi', NULL),
(287, NULL, NULL, '8475058017', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 16:32:55', '2026-05-14 16:33:16', NULL, NULL, NULL),
(288, 'Mohammad Naeem khan', 'naeemkhan0063@gmail.com', '8930360063', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_288_1778777975.jpg', 'adh_b_288_1778777975.jpg', 'selfie_288_1778777975.jpg', 'partner', 'Active', 'Approved', '2026-05-14 16:55:24', '2026-05-14 17:04:44', '749306930823', 'sohna', NULL),
(289, 'Sona Ram Swami', 'swamisonaram11@gmail.com', '7878985046', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_289_1778777965.jpg', 'adh_b_289_1778777965.jpg', 'selfie_289_1778777965.jpg', 'partner', 'Active', 'Approved', '2026-05-14 16:55:52', '2026-05-14 17:05:09', '426213086444', 'jaipur rajasthan', NULL),
(290, NULL, NULL, '7014663020', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 17:13:09', '2026-05-14 17:19:49', NULL, NULL, NULL),
(291, NULL, NULL, '9352620338', '3935', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 17:15:27', '2026-05-14 17:15:27', NULL, NULL, NULL),
(292, 'Suraj', 'gurubabathakur36@gmail.com', '7042201719', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_292_1778781507.jpg', 'adh_b_292_1778781507.jpg', 'selfie_292_1778781507.jpg', 'partner', 'Active', 'Approved', '2026-05-14 17:53:21', '2026-05-14 18:04:07', '760514381714', 'delhi', NULL),
(293, 'harman', 'harmangholia26@gmail.com', '9592009391', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_293_1778781598.jpg', 'adh_b_293_1778781598.jpg', 'selfie_293_1778781598.jpg', 'partner', 'Active', 'Approved', '2026-05-14 17:56:45', '2026-05-14 18:05:57', '624738793009', 'moga punjab', NULL),
(294, 'Rinku Thakur', 'rinkurajput63560@gmail.com', '9711459781', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_294_1778782170.jpg', 'adh_b_294_1778782170.jpg', 'selfie_294_1778782170.jpg', 'partner', 'Active', 'Approved', '2026-05-14 18:06:17', '2026-05-14 18:13:50', '566618275316', 'delhi', NULL),
(295, NULL, NULL, '9050557831', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 18:20:40', '2026-05-14 18:20:53', NULL, NULL, NULL),
(296, NULL, NULL, '9730284118', '6815', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 18:56:41', '2026-05-14 18:56:41', NULL, NULL, NULL),
(297, 'Rajinder Singh', 'rs9144028@gmail.com', '8699392546', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_297_1778789391.jpg', 'adh_b_297_1778789391.jpg', 'selfie_297_1778789391.jpg', 'partner', 'Active', 'Approved', '2026-05-14 20:07:34', '2026-05-15 02:56:52', '488094955135', 'sangrur', NULL),
(298, NULL, NULL, '8448556895', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-14 22:53:00', '2026-05-21 17:19:51', NULL, NULL, NULL),
(299, NULL, NULL, '8607886619', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-15 02:36:48', '2026-05-15 02:36:56', NULL, NULL, NULL),
(300, NULL, NULL, '9758449396', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-15 02:47:08', '2026-05-15 02:47:24', NULL, NULL, NULL),
(301, 'Surendra Singh', 'mobile978563@gmail.com', '9649264161', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_301_1778815867.jpg', 'adh_b_301_1778815867.jpg', 'selfie_301_1778815867.jpg', 'partner', 'Active', 'Approved', '2026-05-15 03:28:53', '2026-05-15 08:32:52', '689294515368', 'jaipur', NULL),
(302, NULL, NULL, '8755653197', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-15 03:55:23', '2026-05-15 03:55:52', NULL, NULL, NULL),
(303, NULL, NULL, '9899807421', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-15 04:02:49', '2026-05-15 04:03:10', NULL, NULL, NULL),
(304, NULL, NULL, '9812409067', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-15 07:39:45', '2026-05-15 07:40:13', NULL, NULL, NULL),
(305, 'NRAPENDRA SINGH', 'AbhiaroTravels@gmail.com', '9759336699', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_305_1778831304.jpg', 'adh_b_305_1778831304.jpg', 'selfie_305_1778831304.jpg', 'partner', 'Active', 'Approved', '2026-05-15 07:45:05', '2026-05-15 08:33:21', '774510128346', 'agra', NULL),
(306, NULL, NULL, '9540363760', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-15 08:21:44', '2026-05-15 08:22:04', NULL, NULL, NULL),
(307, 'Mohit kumar', 'mahimohit5525@gmail.com', '7060625525', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_307_1778836863.jpg', 'adh_b_307_1778836863.jpg', 'selfie_307_1778836863.jpg', 'partner', 'Active', 'Approved', '2026-05-15 09:16:12', '2026-05-15 11:22:40', '707947460767', 'Dehradun', NULL),
(308, NULL, NULL, '8630069394', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-15 09:36:45', '2026-05-15 09:36:57', NULL, NULL, NULL),
(309, 'ABDUL RAHIMAN MIYAZ', 'Niyyafara07@gmail.com', '9008719860', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_309_1778839670.jpg', 'adh_b_309_1778839670.jpg', 'selfie_309_1778839670.jpg', 'partner', 'Active', 'Approved', '2026-05-15 09:51:14', '2026-05-15 11:23:06', '586897072350', 'nadsal', NULL),
(310, NULL, NULL, '7597729026', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-15 10:54:46', '2026-05-15 10:55:14', NULL, NULL, NULL),
(311, 'Ranjitsinh', 'ranjitsinhpagi442@gmail.com', '9316296742', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_311_1778845004.jpg', 'adh_b_311_1778845004.jpg', 'selfie_311_1778845004.jpg', 'partner', 'Active', 'Approved', '2026-05-15 11:33:58', '2026-05-15 15:03:11', '549833621252', 'Ahmedabad', NULL),
(312, 'pritam singh', 'pritams1983@yahoo.com', '9650420149', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_312_1779258804.jpg', 'adh_b_312_1779258804.jpg', 'selfie_312_1779258804.jpg', 'partner', 'Active', 'Approved', '2026-05-15 12:56:32', '2026-05-20 06:55:34', '515630081084', 'new delhi', NULL),
(313, 'Gautam singh', 'gautam6388@gmail.com', '9810260519', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_313_1778855982.jpg', 'adh_b_313_1778855982.jpg', 'selfie_313_1778855982.jpg', 'partner', 'Active', 'Approved', '2026-05-15 14:34:57', '2026-05-15 15:03:26', '581247855006', 'new delhi', NULL),
(314, 'GIRISH PANWAR', 'girish.panwar85@gmail.com', '8619095130', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_314_1778856876.png', 'adh_b_314_1778856876.png', 'selfie_314_1778856876.jpg', 'partner', 'Active', 'Approved', '2026-05-15 14:50:10', '2026-05-15 15:03:56', '659648035949', 'jaipur', NULL),
(315, 'Abhishek', 'abhiwayal6@gmail.com', '7738242695', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_315_1778867741.jpg', 'adh_b_315_1778867741.jpg', 'selfie_315_1778867741.jpg', 'partner', 'Active', 'Approved', '2026-05-15 17:48:49', '2026-05-15 17:57:49', '722066963352', 'thane', NULL),
(316, 'Mohammad Shoaib', 'khanshoib497@gmail.com', '9690109085', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_316_1778878746.jpg', 'adh_b_316_1778878746.jpg', 'selfie_316_1778878746.jpg', 'partner', 'Active', 'Approved', '2026-05-15 20:55:46', '2026-05-16 06:20:56', '961563193137', 'dehradun', NULL),
(317, NULL, NULL, '9561802910', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-16 02:45:50', '2026-05-16 02:46:03', NULL, NULL, NULL),
(318, NULL, NULL, '7048966399', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-16 04:09:11', '2026-05-16 04:09:40', NULL, NULL, NULL),
(319, 'Aman Kumar Sahu', 'aman.kumar.sahu.rn07@gmail.com', '9355661401', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_319_1778904824.jpg', 'adh_b_319_1778904824.jpg', 'selfie_319_1778904824.jpg', 'partner', 'Active', 'Approved', '2026-05-16 04:10:38', '2026-05-16 06:21:08', '480484957299', 'delhi', NULL),
(320, NULL, NULL, '9557048983', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-16 05:35:30', '2026-05-16 05:35:54', NULL, NULL, NULL),
(321, NULL, NULL, '9318481713', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-16 05:51:43', '2026-05-16 05:52:02', NULL, NULL, NULL),
(322, 'Hemant nagar', 'annunagar210@gmail.com', '8085148923', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_322_1778918585.jpg', 'adh_b_322_1778918585.jpg', 'selfie_322_1778918585.jpg', 'partner', 'Active', 'Approved', '2026-05-16 07:56:30', '2026-05-16 09:36:28', '906357606690', 'morena', NULL),
(323, NULL, NULL, '8430313947', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-16 08:43:44', '2026-05-16 08:44:19', NULL, NULL, NULL),
(324, NULL, NULL, '8800676819', '1401', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-16 09:04:15', '2026-05-16 09:04:15', NULL, NULL, NULL),
(325, 'aamir shamsi', 'aamirshamsi639@gmail.com', '8755202333', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_325_1778936689.jpg', 'adh_b_325_1778936689.jpg', 'selfie_325_1778936689.jpg', 'partner', 'Active', 'Approved', '2026-05-16 13:02:28', '2026-05-16 13:34:38', '436506580150', 'Rampur', NULL),
(326, 'SACHIN KAPOOR', 'Kapoorsachin54@gmail.com', '9855012354', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_326_1778937481.jpg', 'adh_b_326_1778937481.jpg', 'selfie_326_1778937481.jpg', 'partner', 'Active', 'Approved', '2026-05-16 13:08:13', '2026-05-16 13:34:51', '506263706494', 'NABHA PUNJAB', NULL),
(327, 'Shashank Pandey', 'ershashank07@gmail.com', '9335252452', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_327_1778937351.jpg', 'adh_b_327_1778937351.jpg', 'selfie_327_1778937351.jpg', 'partner', 'Active', 'Approved', '2026-05-16 13:12:31', '2026-05-16 13:35:19', '953753104004', 'Lucknow', NULL),
(328, 'mushaid', 'khanmujahid5868@gmail.com', '9259473709', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_328_1778937882.jpg', 'adh_b_328_1778937882.jpg', 'selfie_328_1778937882.jpg', 'partner', 'Active', 'Approved', '2026-05-16 13:19:57', '2026-05-16 13:35:38', '242710837466', 'bareilly', NULL),
(329, 'Kishokumar Naryanji chopade', 'kishorchopde61@gmail.com', '7415687799', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_329_1778938522.jpg', 'adh_b_329_1778938522.jpg', 'selfie_329_1778938522.jpg', 'partner', 'Active', 'Approved', '2026-05-16 13:27:46', '2026-05-16 13:50:30', '200970357598', 'Ujjain Madhya Pradesh', NULL),
(330, 'mani Bhushan', 'mupadhyay6291@gmail.com', '9956634610', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_330_1778988822.jpg', 'adh_b_330_1778988822.jpg', 'selfie_330_1778988822.jpg', 'partner', 'Active', 'Approved', '2026-05-16 13:33:34', '2026-05-17 03:59:51', '288697620852', 'lucknow', NULL),
(331, 'kuldeep kumar', 'kuldeepjk2025@gmail.com', '7051319443', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_331_1778938767.jpg', 'adh_b_331_1778938767.jpg', 'selfie_331_1778938767.jpg', 'partner', 'Active', 'Approved', '2026-05-16 13:35:18', '2026-05-16 13:42:24', '604492064096', 'jammu and kashmir', NULL),
(332, NULL, NULL, '9690877792', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-16 14:16:27', '2026-05-16 14:16:47', NULL, NULL, NULL),
(333, 'SUNNY BHATTI', 'bhattisunny1510@gmail.com', '9723999859', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_333_1779110781.jpg', 'adh_b_333_1779110781.jpg', 'selfie_333_1779110781.jpg', 'partner', 'Active', 'Approved', '2026-05-16 14:53:49', '2026-05-18 15:29:18', '674990387427', 'Mayur green jamnagar', NULL),
(334, 'Rohit kumar', 'rohitkumar17129@gmail.com', '8199010233', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_334_1778949203.jpg', 'adh_b_334_1778949203.jpg', 'selfie_334_1778949203.jpg', 'partner', 'Active', 'Approved', '2026-05-16 14:55:40', '2026-05-16 17:17:38', '569517744017', 'ambala', NULL),
(335, NULL, NULL, '9850849197', '1353', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-16 15:19:52', '2026-05-16 15:19:52', NULL, NULL, NULL),
(336, 'Jeetu  Singh', 'jeeturajput7532@gmail.com', '8193972176', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_336_1778948953.jpg', 'adh_b_336_1778948953.jpg', 'selfie_336_1778948953.jpg', 'partner', 'Active', 'Approved', '2026-05-16 16:16:59', '2026-05-16 16:32:20', '309306217595', 'Krishna Nagar Mathura', NULL),
(337, 'dilshad khan', 'dk7257889@gmail.com', '9690230182', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_337_1778951624.jpg', 'adh_b_337_1778951624.jpg', 'selfie_337_1778951624.jpg', 'partner', 'Active', 'Approved', '2026-05-16 16:54:05', '2026-05-16 17:18:01', '816683616564', 'dehradun', NULL),
(338, NULL, NULL, '9690876232', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-16 17:21:48', '2026-05-16 17:22:09', NULL, NULL, NULL),
(339, 'man singh', 'pmansingh632@gmail.com', '8528042128', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_339_1778955241.jpg', 'adh_b_339_1778955241.jpg', 'selfie_339_1778955241.jpg', 'partner', '', 'Pending', '2026-05-16 18:09:22', '2026-05-16 18:14:01', '335198007884', 'Gurugram', NULL),
(340, 'sartaj ahmad', 'sartajahmad7642@gmail.com', '7983040485', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_340_1778961546.jpg', 'adh_b_340_1778961546.jpg', 'selfie_340_1778961546.jpg', 'partner', '', 'Pending', '2026-05-16 19:42:57', '2026-05-16 19:59:06', '357379900310', 'moradabad', NULL),
(341, 'SARTAJ KHAN', 'sartajkhan98214@gmail.com', '9821447146', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_341_1779020105.jpg', 'adh_b_341_1779020105.jpg', 'selfie_341_1779020105.jpg', 'partner', 'Active', 'Approved', '2026-05-17 03:57:57', '2026-05-17 12:26:08', '508498801208', 'Delhi', NULL),
(342, 'subash Kumar', 'earn7596@gmail.com', '7007614762', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_342_1778991121.jpg', 'adh_b_342_1778991121.jpg', 'selfie_342_1778991121.jpg', 'partner', 'Active', 'Approved', '2026-05-17 04:00:15', '2026-05-17 05:33:22', '430847012077', 'Varanasi', NULL),
(343, 'krishna kumar', 'ksishnatrived@gmail.com', '8957715341', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_343_1778994520.jpg', 'adh_b_343_1778994520.jpg', 'selfie_343_1778994520.jpg', 'partner', 'Active', 'Approved', '2026-05-17 05:07:11', '2026-05-17 05:33:44', '726853277442', 'kanpur', NULL),
(344, NULL, NULL, '9756421539', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-17 05:35:20', '2026-05-17 05:35:35', NULL, NULL, NULL),
(345, NULL, NULL, '9756845933', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-17 05:42:33', '2026-05-17 05:45:46', NULL, NULL, NULL),
(346, NULL, NULL, '8750433650', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-17 08:14:38', '2026-05-17 08:14:51', NULL, NULL, NULL),
(347, 'Deep Singh', 'deepsingh.deep8353@gmail.com', '9650484873', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_347_1779021751.jpg', 'adh_b_347_1779021751.jpg', 'selfie_347_1779021751.jpg', 'partner', 'Active', 'Approved', '2026-05-17 12:37:38', '2026-05-17 15:48:28', '304714548353', 'Delhi', NULL),
(348, NULL, NULL, '8384854746', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-17 14:24:22', '2026-05-17 14:24:34', NULL, NULL, NULL),
(349, 'md Umar', 'mdumar6327@gmail.com', '6395592964', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_349_1779107835.jpg', 'adh_b_349_1779107835.jpg', 'selfie_349_1779107835.jpg', 'partner', 'Active', 'Approved', '2026-05-17 19:04:36', '2026-05-18 13:25:45', '604352775677', 'Gurgaon', NULL),
(350, 'mohd abid', 'abidtyagi666@gmail.com', '7827617986', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_350_1779066641.jpg', 'adh_b_350_1779066641.jpg', 'selfie_350_1779066641.jpg', 'partner', 'Active', 'Approved', '2026-05-18 01:07:28', '2026-05-18 10:47:43', '399883107070', 'delhi ncr', NULL),
(351, NULL, NULL, '9592852614', '7569', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-18 01:27:20', '2026-05-18 01:27:59', NULL, NULL, NULL),
(352, NULL, NULL, '7652812463', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-18 01:29:16', '2026-05-18 01:37:39', NULL, NULL, NULL),
(353, NULL, NULL, '6371506854', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-18 05:59:51', '2026-05-18 06:00:16', NULL, NULL, NULL),
(354, 'Shivam Gupta', 'sg445761@gmail.com', '7233028000', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_354_1779086386.jpg', 'adh_b_354_1779086386.jpg', 'selfie_354_1779086386.jpg', 'partner', 'Active', 'Approved', '2026-05-18 06:35:48', '2026-05-18 10:48:22', '475049730464', 'Ayodhya', NULL),
(355, NULL, NULL, '8618723905', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-18 07:42:15', '2026-05-18 07:42:44', NULL, NULL, NULL),
(356, 'sunil Kumar Raidas', 'suneelsarasdol260@gmail.com', '7996750954', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_356_1779099139.jpg', 'adh_b_356_1779099139.jpg', 'selfie_356_1779099139.jpg', 'partner', 'Active', 'Approved', '2026-05-18 10:10:08', '2026-05-18 10:48:53', '607547204000', 'indore', NULL),
(357, NULL, NULL, '8130331991', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-18 10:23:58', '2026-05-18 10:24:14', NULL, NULL, NULL),
(358, 'anup singh kandari', 'discovernainital@gmail.xom', '8755997426', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_358_1779111680.jpg', NULL, NULL, 'partner', '', 'Pending', '2026-05-18 13:34:57', '2026-05-18 13:41:20', '898880076357', 'delhi', NULL),
(359, 'Satendra', 'satendrakrl12345@gmail.com', '9528824577', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_359_1779112223.png', 'adh_b_359_1779112223.jpg', 'selfie_359_1779112223.jpg', 'partner', 'Active', 'Approved', '2026-05-18 13:47:29', '2026-05-18 15:31:02', '888126205569', 'new delhi', NULL),
(360, 'Sumit Kumar', 'sumityadavs9675@gmail.com', '9675247422', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_360_1779118723.jpg', 'adh_b_360_1779118723.jpg', 'selfie_360_1779118723.jpg', 'partner', 'Active', 'Approved', '2026-05-18 15:31:21', '2026-05-18 17:06:38', '324639765238', 'noida', NULL),
(361, NULL, NULL, '8630375685', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-18 15:32:40', '2026-05-18 15:32:51', NULL, NULL, NULL),
(362, 'Ravi kumar R', 'ravikumarroja0@gmail.com', '8792544420', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_362_1779135340.jpg', 'adh_b_362_1779135340.jpg', 'selfie_362_1779135340.jpg', 'partner', 'Active', 'Approved', '2026-05-18 19:54:16', '2026-05-19 02:57:39', '787522358718', 'bangalore', NULL),
(363, NULL, NULL, '9700820832', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-19 00:23:48', '2026-05-19 00:24:07', NULL, NULL, NULL),
(364, 'malkeet Singh', 'malkeetsingh13803@gmail.com', '9592013803', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_364_1779154723.jpg', 'adh_b_364_1779154723.jpg', 'selfie_364_1779154723.jpg', 'partner', 'Active', 'Approved', '2026-05-19 01:32:16', '2026-05-19 02:57:22', '980602888395', 'chandigarh', NULL),
(365, 'vijendra yadav', 'vijanderyadav555@gmail.com', '9217551611', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_365_1779158529.jpg', 'adh_b_365_1779158529.jpg', 'selfie_365_1779158529.jpg', 'partner', 'Active', 'Approved', '2026-05-19 02:37:54', '2026-05-19 02:57:10', '640483786546', 'Jaipur Rajasthan', NULL),
(366, 'Ravi Mandal', 'ravimandal372@gmail.com', '9389818692', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_366_1779419849.jpg', 'adh_b_366_1779419849.jpg', 'selfie_366_1779419849.jpg', 'partner', 'Active', 'Approved', '2026-05-19 02:43:55', '2026-05-22 12:58:19', '656600864216', 'Dineshpur udham Singh Nagar', NULL),
(367, NULL, NULL, '8318881843', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-19 05:19:49', '2026-05-19 05:19:54', NULL, NULL, NULL),
(368, 'Rinku sharma', 'rinkusharma8847@gmail.com', '9878369855', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_368_1779279718.jpg', 'adh_b_368_1779279718.jpg', 'selfie_368_1779279718.jpg', 'partner', 'Active', 'Approved', '2026-05-19 05:48:41', '2026-05-20 19:17:28', '620895931636', 'ludhiana', NULL),
(369, 'narsitilor', 'narshitilor1@gmail.com', '9967167232', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_369_1779185294.jpg', 'adh_b_369_1779185294.jpg', 'selfie_369_1779185294.jpg', 'partner', 'Active', 'Approved', '2026-05-19 10:04:13', '2026-05-19 17:03:36', '437115269378', 'kota', NULL),
(370, NULL, NULL, '9667403656', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-19 10:39:06', '2026-05-19 10:39:20', NULL, NULL, NULL),
(371, 'Sukhamani singh jandu', 'sukhmanijandu97@gmail.com', '7986032465', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_371_1779196957.jpg', 'adh_b_371_1779196957.jpg', 'selfie_371_1779196957.jpg', 'partner', 'Active', 'Approved', '2026-05-19 13:17:55', '2026-05-19 17:04:25', '947280576734', 'Ludhiana', NULL),
(372, NULL, NULL, '7997538690', '2211', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-19 13:37:10', '2026-05-19 15:39:15', NULL, NULL, NULL),
(373, NULL, NULL, '9654919199', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-19 15:14:27', '2026-05-19 15:14:38', NULL, NULL, NULL),
(374, 'satyavir', 'dhara00564700@gmail.com', '6377860240', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_374_1779206496.jpg', 'adh_b_374_1779206496.jpg', 'selfie_374_1779206496.jpg', 'partner', 'Active', 'Approved', '2026-05-19 15:54:44', '2026-05-19 17:04:47', '442395160710', 'jaipur', NULL),
(375, NULL, NULL, '6363155021', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-19 18:13:28', '2026-05-19 18:13:37', NULL, NULL, NULL),
(376, 'Harshad', 'htrivedi478@gmail.com', '9510328744', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_376_1779217180.jpg', 'adh_b_376_1779217180.jpg', 'selfie_376_1779217180.jpg', 'partner', 'Active', 'Approved', '2026-05-19 18:58:24', '2026-05-19 19:03:44', '800671206824', 'Surat', NULL),
(377, 'AMAR RAY', 'amarroy305@gmail.com', '9319039790', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_377_1779256881.jpg', 'adh_b_377_1779256881.jpg', 'selfie_377_1779256881.jpg', 'partner', 'Active', 'Approved', '2026-05-20 05:40:56', '2026-05-20 06:07:13', '467565589983', 'dehli', NULL),
(378, 'sudhanshu gupta', 'wwwsidhanshukumar022@gmail.com', '7270086783', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_378_1779262008.jpg', 'adh_b_378_1779262008.jpg', 'selfie_378_1779262008.jpg', 'partner', 'Active', 'Approved', '2026-05-20 07:22:47', '2026-05-20 09:09:37', '650254901445', 'lucknow', NULL),
(379, 'Bhupendra', 'bhupenderchaudhary49@gmail.com', '8882427582', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_379_1779271703.jpg', 'adh_b_379_1779271703.jpg', 'selfie_379_1779271703.jpg', 'partner', 'Active', 'Approved', '2026-05-20 08:22:50', '2026-05-20 19:17:05', '577754445537', 'f_101 jai vihar najafgarh Nangloi road new Delhi 110043#', NULL),
(380, NULL, NULL, '8447749227', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-20 09:31:52', '2026-05-20 09:32:10', NULL, NULL, NULL),
(381, NULL, NULL, '9050921424', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-20 09:40:21', '2026-05-25 13:26:48', NULL, NULL, NULL),
(382, 'Babu Lal', 'ww.babulal1024@gmail.com', '7300091005', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_382_1779275809.jpg', 'adh_b_382_1779275809.jpg', 'selfie_382_1779275809.jpg', 'partner', 'Active', 'Approved', '2026-05-20 11:11:56', '2026-05-20 19:16:46', '632988660353', 'jaipur', NULL),
(383, NULL, NULL, '9111165467', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-20 14:27:40', '2026-05-20 14:28:05', NULL, NULL, NULL),
(384, NULL, NULL, '7027002416', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-20 17:14:29', '2026-05-20 17:14:32', NULL, NULL, NULL),
(385, NULL, NULL, '8168586327', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-20 17:23:16', '2026-05-20 17:23:18', NULL, NULL, NULL),
(386, 'rohitkumar', 'rohit648257@gmail.com', '8818009412', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_386_1779298710.png', 'adh_b_386_1779298710.jpg', 'selfie_386_1779298710.jpg', 'partner', 'Active', 'Approved', '2026-05-20 17:33:44', '2026-05-20 19:16:26', '468388031577', 'delhi', NULL),
(387, NULL, NULL, '9724426603', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-20 19:17:59', '2026-05-20 19:18:25', NULL, NULL, NULL),
(388, NULL, NULL, '9818980090', '8718', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-20 19:35:43', '2026-05-20 19:35:43', NULL, NULL, NULL),
(389, 'mohamad jelhoque ali', 'jelhoquea272@gmail.com', '9650803709', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_389_1779333718.jpg', 'adh_b_389_1779333718.jpg', 'selfie_389_1779333718.jpg', 'partner', 'Active', 'Approved', '2026-05-21 03:17:06', '2026-05-21 04:05:01', '583562406517', 'Delhi vasant Kunj', NULL),
(390, 'surajsingh', 'ssuraj06695@gmail.com', '8130433738', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_390_1779335016.jpg', 'adh_b_390_1779335016.jpg', 'selfie_390_1779335016.jpg', 'partner', 'Active', 'Approved', '2026-05-21 03:17:21', '2026-06-17 06:51:39', '382189569965', 'Ahmedabad', NULL),
(391, 'pushpender', 'pushpendergautam350@gmail.com', '9718808018', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_391_1779338541.jpg', 'adh_b_391_1779338541.jpg', 'selfie_391_1779338541.jpg', 'partner', 'Active', 'Approved', '2026-05-21 04:39:49', '2026-05-21 05:14:23', '377565569220', 'Delhi', NULL),
(392, 'ismeet singh', 'ismeet13093@gmail.com', '7061015878', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_392_1779347184.png', 'adh_b_392_1779347184.png', 'selfie_392_1779347184.jpg', 'partner', 'Active', 'Approved', '2026-05-21 05:47:44', '2026-05-21 07:09:29', '988957752453', 'patna', NULL),
(393, 'manoj', 'sachin4444g@gmail.com', '9829724433', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_393_1779347037.jpg', 'adh_b_393_1779347037.jpg', 'selfie_393_1779347037.jpg', 'partner', 'Active', 'Approved', '2026-05-21 06:57:33', '2026-05-21 09:49:52', '818789887334', 'Jaipur', NULL),
(394, 'suraj prakash', 'kittu24jan@gmail.com', '9716170914', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_394_1779367596.jpg', 'adh_b_394_1779367596.jpg', 'selfie_394_1779367596.jpg', 'partner', 'Active', 'Approved', '2026-05-21 11:29:38', '2026-05-21 15:49:00', '389282698920', 'Delhi', NULL),
(395, NULL, NULL, '8899125344', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-21 12:11:06', '2026-05-21 12:11:25', NULL, NULL, NULL),
(396, 'Gulfam khan', 'gulfam991166@gmail.com', '8743979777', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_396_1779371371.jpg', 'adh_b_396_1779371371.jpg', 'selfie_396_1779371371.jpg', 'partner', 'Active', 'Approved', '2026-05-21 13:47:20', '2026-05-21 17:16:28', '270989856593', 'ghaziabad', NULL),
(397, 'ganesh Shukla', 'ganeshshukla214@gmail.com', '9173773214', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_397_1779380235.jpg', 'adh_b_397_1779380235.jpg', 'selfie_397_1779380235.jpg', 'partner', 'Active', 'Approved', '2026-05-21 16:13:35', '2026-05-21 17:15:49', '425165441516', 'surat', NULL),
(398, 'Ganesh Shukla', 'ganeshshukla45@gmail.com', '9638809101', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_398_1779540518.jpg', 'adh_b_398_1779540518.jpg', 'selfie_398_1779540518.jpg', 'partner', 'Active', 'Approved', '2026-05-21 18:45:16', '2026-05-23 14:59:38', '425165441516', 'surat', NULL),
(399, NULL, NULL, '9877068171', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-21 21:41:25', '2026-06-07 21:10:30', NULL, NULL, NULL);
INSERT INTO `partners` (`id`, `full_name`, `email`, `mobile`, `login_otp`, `password`, `mobile_verified`, `aadhaar_verified`, `aadhaar_number`, `surepass_client_id`, `aadhaar_pdf_link`, `driving_license_link`, `rc_book_link`, `aadhaar_front_link`, `aadhaar_back_link`, `selfie_link`, `roles`, `status`, `manual_verification_status`, `created_at`, `updated_at`, `aadhar_number`, `city`, `fcm_token`) VALUES
(400, 'kumer singh', 'gurjarkumersingh344@gmail.com', '9057704704', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_400_1779406444.jpg', 'adh_b_400_1779406444.jpg', 'selfie_400_1779406444.jpg', 'partner', 'Active', 'Approved', '2026-05-21 23:26:11', '2026-05-22 13:16:18', '976571824122', 'jaypur', NULL),
(401, NULL, NULL, '7417591050', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-22 02:54:56', '2026-05-22 02:55:14', NULL, NULL, NULL),
(402, NULL, NULL, '9671250400', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-22 02:56:17', '2026-05-22 02:56:52', NULL, NULL, NULL),
(403, NULL, NULL, '8630627512', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-22 06:26:33', '2026-05-22 06:26:49', NULL, NULL, NULL),
(404, NULL, NULL, '8058163250', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-22 12:17:25', '2026-05-22 12:17:31', NULL, NULL, NULL),
(405, NULL, NULL, '1234567890', '6943', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-22 12:41:24', '2026-05-22 12:41:24', NULL, NULL, NULL),
(406, NULL, NULL, '6353921034', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-23 03:23:18', '2026-05-23 03:23:27', NULL, NULL, NULL),
(407, NULL, NULL, '9358212837', '2265', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-23 03:24:10', '2026-05-23 03:24:10', NULL, NULL, NULL),
(408, NULL, NULL, '7643023806', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-23 06:32:09', '2026-05-23 06:32:31', NULL, NULL, NULL),
(409, NULL, NULL, '9024242474', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-23 06:57:03', '2026-05-23 06:57:20', NULL, NULL, NULL),
(410, 'Ashish Dixit', 'ashishdixit1481@gmail.com', '9540350401', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_410_1779519942.jpg', 'adh_b_410_1779519942.jpg', 'selfie_410_1779519942.jpg', 'partner', 'Active', 'Approved', '2026-05-23 07:02:57', '2026-05-23 07:20:55', '782812127668', 'gurugram', NULL),
(411, NULL, NULL, '9785656556', '7437', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-23 09:19:08', '2026-05-23 09:19:08', NULL, NULL, NULL),
(412, NULL, NULL, '8352838304', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-23 09:21:41', '2026-05-23 09:21:58', NULL, NULL, NULL),
(413, NULL, NULL, '8920941066', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-23 10:30:09', '2026-05-23 10:30:41', NULL, NULL, NULL),
(414, 'Mohd Akram', 'ma335211@gmail.com', '8273066980', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_414_1779586129.jpg', 'adh_b_414_1779586129.jpg', 'selfie_414_1779586129.jpg', 'partner', 'Active', 'Approved', '2026-05-24 01:19:38', '2026-05-24 16:55:28', '419221909374', 'Chandausi Sambhal', NULL),
(415, NULL, NULL, '7978032079', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-24 02:40:30', '2026-05-24 02:40:44', NULL, NULL, NULL),
(416, NULL, NULL, '7980524281', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-24 08:40:36', '2026-05-24 08:40:53', NULL, NULL, NULL),
(417, NULL, NULL, '9953334263', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-24 15:29:05', '2026-05-24 15:30:43', NULL, NULL, NULL),
(418, NULL, NULL, '9758175615', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-24 15:32:07', '2026-05-24 15:32:35', NULL, NULL, NULL),
(419, NULL, NULL, '9041436265', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-24 21:19:59', '2026-05-24 21:20:24', NULL, NULL, NULL),
(420, 'MAZHAR IQBAL', 'mrworldcafe@gmail.com', '9756276666', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_420_1779681062.jpg', 'adh_b_420_1779681062.jpg', 'selfie_420_1779681062.jpg', 'partner', 'Active', 'Approved', '2026-05-25 03:48:34', '2026-05-25 13:37:12', '479813841343', 'DELHI', NULL),
(421, NULL, NULL, '9450579489', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-25 06:03:34', '2026-05-25 06:03:49', NULL, NULL, NULL),
(422, NULL, NULL, '8076652278', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-25 06:32:35', '2026-05-25 06:32:49', NULL, NULL, NULL),
(423, 'Narinder pal', 'narinderpal954@gamil.com', '9041993780', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_423_1779695227.jpg', 'adh_b_423_1779695227.jpg', 'selfie_423_1779695227.jpg', 'partner', 'Active', 'Approved', '2026-05-25 07:43:56', '2026-05-25 13:35:43', '471537967515', 'jalandhar', NULL),
(424, NULL, NULL, '9272050561', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-25 07:55:21', '2026-05-25 07:55:39', NULL, NULL, NULL),
(425, NULL, NULL, '9789812357', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-25 08:39:05', '2026-05-25 08:39:30', NULL, NULL, NULL),
(426, NULL, NULL, '8059763114', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-05-25 13:27:51', '2026-05-25 13:27:59', NULL, NULL, NULL),
(427, 'Mohammad Nadimuddin', 'mohammadnadimuddin59@gmail.com', '8766243412', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_427_1779721269.jpg', 'adh_b_427_1779721269.jpg', 'selfie_427_1779721269.jpg', 'partner', 'Active', 'Approved', '2026-05-25 14:56:54', '2026-06-06 12:26:42', '527540727747', 'delhi', NULL),
(428, 'abhay singh', 'abhisinghpilkhwal76@gmail.com', '9319650993', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_428_1779725249.jpg', 'adh_b_428_1779725249.jpg', 'selfie_428_1779725249.jpg', 'partner', 'Active', 'Approved', '2026-05-25 16:01:41', '2026-06-06 12:27:26', '435004639420', 'faridabad', NULL),
(429, NULL, NULL, '8005623482', '7419', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-05 01:08:32', '2026-06-05 01:08:58', NULL, NULL, NULL),
(430, NULL, NULL, '7608872096', '8592', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-05 03:48:46', '2026-06-05 03:50:24', NULL, NULL, NULL),
(431, NULL, NULL, '7015769868', '4326', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-05 04:30:15', '2026-06-05 04:30:37', NULL, NULL, NULL),
(432, NULL, NULL, '9315443997', '7758', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-05 04:30:47', '2026-06-05 04:30:47', NULL, NULL, NULL),
(433, NULL, NULL, '8368061864', '6520', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-05 04:35:12', '2026-06-05 04:35:16', NULL, NULL, NULL),
(434, NULL, NULL, '9818980098', '4026', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-05 09:43:00', '2026-06-05 09:43:00', NULL, NULL, NULL),
(435, NULL, NULL, '9821390091', '3242', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-05 15:13:12', '2026-06-05 15:14:52', NULL, NULL, NULL),
(436, 'pravesh lodhi', 'lodhipravesh433@gmail.com', '9516436658', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_436_1781704233.jpg', 'adh_b_436_1781704233.jpg', 'selfie_436_1781704233.jpg', 'partner', '', 'Pending', '2026-06-05 15:51:43', '2026-06-17 13:50:33', '238687619667', 'Indore', NULL),
(437, 'Sonu', 'sonusanny99@gmail.com', '9592555666', '2378', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_437_1781598319.jpg', 'adh_b_437_1781598319.jpg', 'selfie_437_1781598319.jpg', 'partner', 'Active', 'Approved', '2026-06-05 16:00:40', '2026-06-17 08:04:30', '287002227593', 'delhi', NULL),
(438, 'bikash Kumar', 'rajputpajput659@gmail.com', '8882249501', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_438_1781682373.jpg', 'adh_b_438_1781682373.jpg', 'selfie_438_1781682373.jpg', 'partner', 'Active', 'Approved', '2026-06-06 00:55:02', '2026-06-17 08:05:41', '713782422817', 'patna', NULL),
(439, NULL, NULL, '9557761682', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-06 01:47:25', '2026-06-06 01:47:35', NULL, NULL, NULL),
(440, NULL, NULL, '9186308906', '8057', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-06 08:14:47', '2026-06-06 08:15:37', NULL, NULL, NULL),
(441, NULL, NULL, '9457130459', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-06 08:16:23', '2026-06-06 08:25:35', NULL, NULL, NULL),
(442, 'Rajkumar', 'rajkmarsharmazirakpur@gmail.com', '7835024001', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_442_1781370029.jpg', 'adh_b_442_1781370029.jpg', 'selfie_442_1781370029.jpg', 'partner', 'Active', 'Approved', '2026-06-06 08:33:57', '2026-06-13 17:30:50', '263368608949', 'Zirakpur', NULL),
(443, NULL, NULL, '9727880808', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-06 08:36:10', '2026-06-06 08:36:22', NULL, NULL, NULL),
(444, NULL, NULL, '9464505204', '7763', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-06 08:36:32', '2026-06-06 08:36:32', NULL, NULL, NULL),
(445, NULL, NULL, '7009502962', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-06 08:36:48', '2026-06-06 08:37:00', NULL, NULL, NULL),
(446, NULL, NULL, '9719800025', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-06 09:17:53', '2026-06-06 09:18:08', NULL, NULL, NULL),
(447, 'LAXMI NARAYAN', 'lnarayan2154@gmail.com', '9187121251', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_447_1781352761.jpg', 'adh_b_447_1781352761.jpg', 'selfie_447_1781352761.jpg', 'partner', 'Active', 'Approved', '2026-06-06 11:55:24', '2026-06-13 13:17:48', '208225240788', 'jaipur', NULL),
(448, NULL, NULL, '7771991027', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-06 12:49:59', '2026-06-06 12:50:10', NULL, NULL, NULL),
(449, NULL, NULL, '8789743174', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-06 14:04:43', '2026-06-06 14:04:58', NULL, NULL, NULL),
(450, NULL, NULL, '8475814717', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-06 14:37:23', '2026-06-06 14:38:00', NULL, NULL, NULL),
(451, NULL, NULL, '8445494577', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-06 16:02:31', '2026-06-06 16:02:45', NULL, NULL, NULL),
(452, NULL, NULL, '9650221409', '3352', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-06 19:14:09', '2026-06-06 19:14:09', NULL, NULL, NULL),
(453, NULL, NULL, '9758528515', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-07 03:05:57', '2026-06-07 03:06:12', NULL, NULL, NULL),
(454, NULL, NULL, '8743891770', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-07 07:15:04', '2026-06-07 07:15:21', NULL, NULL, NULL),
(455, NULL, NULL, '7017641961', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-07 08:58:53', '2026-06-07 08:59:13', NULL, NULL, NULL),
(456, NULL, NULL, '9319309425', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-07 13:06:53', '2026-06-08 20:47:17', NULL, NULL, NULL),
(457, NULL, NULL, '9081173777', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-07 13:10:18', '2026-06-07 13:10:29', NULL, NULL, NULL),
(458, NULL, NULL, '7011928151', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-07 13:12:50', '2026-06-07 13:13:02', NULL, NULL, NULL),
(459, NULL, NULL, '6352839163', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-07 15:38:03', '2026-06-07 15:38:27', NULL, NULL, NULL),
(460, NULL, NULL, '7404947381', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-07 18:55:18', '2026-06-07 18:55:29', NULL, NULL, NULL),
(461, NULL, NULL, '9915642215', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-07 19:02:35', '2026-06-07 19:02:48', NULL, NULL, NULL),
(462, NULL, NULL, '9896763914', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-08 04:21:22', '2026-06-08 04:21:38', NULL, NULL, NULL),
(463, NULL, NULL, '9990137016', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-08 07:05:11', '2026-06-08 07:05:26', NULL, NULL, NULL),
(464, 'Himanshu Kumar', 'thaukurvarun@gmail.com', '9813162341', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_464_1781346785.jpg', 'adh_b_464_1781346785.jpg', 'selfie_464_1781346785.jpg', 'partner', 'Active', 'Approved', '2026-06-08 09:21:37', '2026-06-13 10:54:04', '877506071085', 'delhi', NULL),
(465, NULL, NULL, '7303014951', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-08 18:50:31', '2026-06-08 18:50:42', NULL, NULL, NULL),
(466, 'Shiva ashish', 'nishankshiva@gmail.com', '9837867353', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_466_1781369226.jpg', 'adh_b_466_1781369226.jpg', 'selfie_466_1781369226.jpg', 'partner', 'Active', 'Approved', '2026-06-09 00:57:57', '2026-06-14 02:36:27', '562831283335', 'agra', NULL),
(467, NULL, NULL, '7435928297', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-09 02:43:37', '2026-06-09 02:48:18', NULL, NULL, NULL),
(468, NULL, NULL, '8126271633', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-09 05:47:00', '2026-06-09 05:47:20', NULL, NULL, NULL),
(469, NULL, NULL, '9243524906', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-09 06:06:25', '2026-06-09 06:06:34', NULL, NULL, NULL),
(470, NULL, NULL, '8218383237', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-09 06:48:13', '2026-06-09 06:48:23', NULL, NULL, NULL),
(471, 'Tarsem Singh', 'raisingh52352@gmail.com', '9988491852', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_471_1781444164.jpg', 'adh_b_471_1781444164.jpg', 'selfie_471_1781444164.jpg', 'partner', 'Active', 'Approved', '2026-06-09 08:19:42', '2026-06-15 19:00:41', '819701227777', 'Patiala', NULL),
(472, NULL, NULL, '9992059808', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-09 13:02:49', '2026-06-09 13:03:08', NULL, NULL, NULL),
(473, NULL, NULL, '8810682257', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-09 14:04:19', '2026-06-09 14:04:42', NULL, NULL, NULL),
(474, NULL, NULL, '8777068713', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-09 15:19:46', '2026-06-09 15:20:17', NULL, NULL, NULL),
(475, NULL, NULL, '9414747776', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-09 16:01:35', '2026-06-09 16:01:52', NULL, NULL, NULL),
(476, NULL, NULL, '7698916452', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-09 16:46:52', '2026-06-09 16:47:19', NULL, NULL, NULL),
(477, NULL, NULL, '8107727298', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-10 11:28:31', '2026-06-10 11:28:45', NULL, NULL, NULL),
(478, NULL, NULL, '7003631913', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-10 11:37:06', '2026-06-10 11:37:15', NULL, NULL, NULL),
(479, NULL, NULL, '9599257240', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-10 16:45:55', '2026-06-10 16:46:14', NULL, NULL, NULL),
(480, NULL, NULL, '9834687670', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-10 17:43:07', '2026-06-10 17:43:18', NULL, NULL, NULL),
(481, NULL, NULL, '9034877779', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-11 03:52:37', '2026-06-11 03:52:48', NULL, NULL, NULL),
(482, 'chandu jha', 'jha028666@gmail.com', '6200399008', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_482_1781356207.jpg', 'adh_b_482_1781356207.jpg', 'selfie_482_1781356207.jpg', 'partner', 'Active', 'Approved', '2026-06-11 04:22:22', '2026-06-13 13:12:38', '414743132044', 'delhi ncr', NULL),
(483, NULL, NULL, '9079255686', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-11 04:33:17', '2026-06-11 04:33:23', NULL, NULL, NULL),
(484, 'Ravindra kumar', 'ravisisodiya2062@gmail.com', '8882104357', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_484_1781370723.jpg', 'adh_b_484_1781370723.jpg', 'selfie_484_1781370723.jpg', 'partner', 'Active', 'Approved', '2026-06-11 04:58:15', '2026-06-13 18:41:13', '330777620007', 'Gurgaon', NULL),
(485, 'MOHD IZHAR', 'ijharkhan425@gmail.com', '6204019288', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_485_1781432154.jpg', 'adh_b_485_1781432154.jpg', 'selfie_485_1781432154.jpg', 'partner', 'Active', 'Approved', '2026-06-11 05:37:58', '2026-06-15 19:00:51', '719410036049', 'Delhi', NULL),
(486, NULL, NULL, '9812605555', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-11 06:11:41', '2026-06-11 06:13:27', NULL, NULL, NULL),
(487, 'Jevan Kumar', 'chanderjevan@gmail.com', '9501082214', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_487_1781696537.jpg', 'adh_b_487_1781696537.jpg', 'selfie_487_1781696537.jpg', 'partner', '', 'Pending', '2026-06-11 06:16:04', '2026-06-17 11:42:17', '722526664280', 'Phagwara', NULL),
(488, NULL, NULL, '8920872595', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-12 09:55:18', '2026-06-12 09:55:59', NULL, NULL, NULL),
(489, 'tasabbur Husain', 'tasabburhusain9555@gmail.com', '9555740732', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_489_1781398398.jpg', 'adh_b_489_1781398398.jpg', 'selfie_489_1781398398.jpg', 'partner', 'Active', 'Approved', '2026-06-12 09:58:07', '2026-06-14 02:35:40', '678528708549', 'Moradabad', NULL),
(490, NULL, NULL, '6363946917', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-12 10:15:05', '2026-06-12 10:15:26', NULL, NULL, NULL),
(491, NULL, NULL, '8058602816', '4285', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-12 12:24:38', '2026-06-12 12:24:38', NULL, NULL, NULL),
(492, 'Rahul', 'rahul.dhiman.mohanlal@gmail.com', '8056362316', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_492_1781291513.jpg', 'adh_b_492_1781291513.jpg', 'selfie_492_1781291513.jpg', 'partner', '', 'Pending', '2026-06-12 12:25:59', '2026-06-12 19:11:53', '658994693632', 'Jind', NULL),
(493, NULL, NULL, '7978839914', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-12 13:05:26', '2026-06-12 13:06:26', NULL, NULL, NULL),
(494, NULL, NULL, '8630586905', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-12 13:40:03', '2026-06-12 13:40:26', NULL, NULL, NULL),
(495, NULL, NULL, '8937928685', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-12 13:58:47', '2026-06-12 13:59:11', NULL, NULL, NULL),
(496, NULL, NULL, '8928392115', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-12 17:57:32', '2026-06-12 17:57:54', NULL, NULL, NULL),
(497, NULL, NULL, '9315876300', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-12 19:36:20', '2026-06-12 19:36:54', NULL, NULL, NULL),
(498, NULL, NULL, '8556913378', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-13 08:21:27', '2026-06-13 08:22:52', NULL, NULL, NULL),
(499, 'yuvraj salat', 'ys1067273@gmail.com', '8200923906', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_499_1781339681.jpg', 'adh_b_499_1781339681.jpg', 'selfie_499_1781339681.jpg', 'partner', 'Active', 'Approved', '2026-06-13 08:31:41', '2026-06-13 10:53:36', '647345496314', 'Vadodara', NULL),
(500, NULL, NULL, '9837708107', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-13 13:38:12', '2026-06-13 13:38:25', NULL, NULL, NULL),
(501, NULL, NULL, '9990919275', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-13 14:07:38', '2026-06-13 14:08:02', NULL, NULL, NULL),
(502, 'Yogi Sain Thakur', 'yogeshdahri@gmail.com', '7071920001', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_502_1781369610.png', 'adh_b_502_1781369610.png', 'selfie_502_1781369610.jpg', 'partner', 'Active', 'Approved', '2026-06-13 16:51:43', '2026-06-14 02:36:07', '978651222789', 'yamuna nagar', NULL),
(503, NULL, NULL, '9996933156', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-14 05:29:20', '2026-06-14 05:29:45', NULL, NULL, NULL),
(504, 'sumit gupta', 'sg7484663@gmail.com', '6398390214', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_504_1781596798.jpg', 'adh_b_504_1781596798.jpg', 'selfie_504_1781596798.jpg', 'partner', 'Active', 'Approved', '2026-06-14 14:17:12', '2026-06-17 08:07:09', '880907284841', 'new delhi', NULL),
(505, NULL, NULL, '9450045694', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-14 17:18:10', '2026-06-14 17:20:21', NULL, NULL, NULL),
(506, NULL, NULL, '9456263899', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-14 19:41:19', '2026-06-14 19:41:30', NULL, NULL, NULL),
(507, 'rakesh', 'godaramonu94@gmail.com', '9711447539', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_507_1781489065.png', 'adh_b_507_1781489065.jpg', 'selfie_507_1781489065.jpg', 'partner', 'Active', 'Approved', '2026-06-15 01:58:41', '2026-06-15 19:01:02', '936565859619', 'delhi', NULL),
(508, NULL, NULL, '7310115722', '6196', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-15 06:09:55', '2026-06-15 06:14:27', NULL, NULL, NULL),
(509, 'Suraj', 'yadavsuraj87042@gmail.com', '8115122262', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_509_1781544447.jpg', 'adh_b_509_1781544447.jpg', 'selfie_509_1781544447.jpg', 'partner', 'Active', 'Approved', '2026-06-15 06:59:54', '2026-06-15 19:01:16', '696761402099', 'Lucknow', NULL),
(510, NULL, NULL, '9871455770', '7329', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-15 08:18:00', '2026-06-15 08:18:35', NULL, NULL, NULL),
(511, 'akash solanki', 'bellawings001@gmail.com', '9977420087', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_511_1781525078.jpg', 'adh_b_511_1781525078.jpg', 'selfie_511_1781525078.jpg', 'partner', 'Active', 'Approved', '2026-06-15 12:00:03', '2026-06-15 19:01:26', '947241967871', 'indore', NULL),
(512, NULL, NULL, '7461900130', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-16 10:56:59', '2026-06-16 10:57:25', NULL, NULL, NULL),
(513, NULL, NULL, '8133433738', '7595', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'partner', '', 'Pending', '2026-06-17 06:48:32', '2026-06-17 06:48:32', NULL, NULL, NULL),
(514, 'Himanshu Kumar', 'itsmerajuriya@gmail.com', '8630239955', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_514_1781681106.jpg', 'adh_b_514_1781681106.jpg', 'selfie_514_1781681106.jpg', 'partner', 'Active', 'Approved', '2026-06-17 07:22:51', '2026-06-17 08:08:15', '245843272066', 'firozabad', NULL),
(515, 'shashank', 'tshashank949@gmail.com', '9528178480', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_515_1781682048.jpg', 'adh_b_515_1781682048.jpg', 'selfie_515_1781682048.jpg', 'partner', 'Active', 'Approved', '2026-06-17 07:30:16', '2026-06-17 08:09:42', '710763981659', 'agra', NULL),
(516, 'Thakor Prabhat', 'mohitji402@gmail.com', '8141382545', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_516_1781682893.jpg', 'adh_b_516_1781682893.jpg', 'selfie_516_1781682893.jpg', 'partner', '', 'Pending', '2026-06-17 07:51:05', '2026-06-17 07:54:53', '627278931368', 'Ahmedabad', NULL),
(517, 'Naresh Chauhan', 'chauhanboys8477@gmail.com', '6395800860', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_517_1781683915.jpg', 'adh_b_517_1781683915.jpg', 'selfie_517_1781683915.jpg', 'partner', '', 'Pending', '2026-06-17 08:10:12', '2026-06-17 08:11:55', '652426818382', 'mathura', NULL),
(518, 'sandeep Kumar', 'pprawat7351@gmail.com', '7087378351', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_518_1781697195.png', 'adh_b_518_1781697195.jpg', 'selfie_518_1781697195.jpg', 'partner', '', 'Pending', '2026-06-17 11:47:58', '2026-06-17 11:53:15', '265545886997', 'punjab', NULL),
(519, 'Ash mohammad', 'khana7868@gmail.com', '9958563282', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_519_1781699169.jpg', 'adh_b_519_1781699169.jpg', 'selfie_519_1781699169.jpg', 'partner', '', 'Pending', '2026-06-17 12:10:58', '2026-06-17 12:26:09', '828926549464', 'delhi', NULL),
(520, 'prajapati viraj', 'virajprajapati1076@gmail.com', '8780904874', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'adh_f_520_1781701766.jpg', 'adh_b_520_1781701766.jpg', 'selfie_520_1781701766.jpg', 'partner', '', 'Pending', '2026-06-17 13:00:45', '2026-06-17 13:09:26', '508248865052', 'ahmedabad', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `partner_alert_settings`
--

CREATE TABLE `partner_alert_settings` (
  `partner_id` int(11) NOT NULL,
  `vehicle_types` text DEFAULT NULL,
  `trip_types` text DEFAULT NULL,
  `notification_types` text DEFAULT NULL,
  `routes` text DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `partner_alert_settings`
--

INSERT INTO `partner_alert_settings` (`partner_id`, `vehicle_types`, `trip_types`, `notification_types`, `routes`, `updated_at`) VALUES
(4, 'Hatchback,Sedan,Ertiga,Innova Hycross ,Tempoo Traveller,Innova Crysta,Kia Carance ', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'Chat Notifications,Commission Request,Booking Accept,Booking Cancel,Booking Complete,Trip Start,Trip End,Live Tracking URL', '[]', '2026-04-27 19:32:02'),
(14, 'Hatchback,Sedan,Ertiga,Innova Hycross ,Tempoo Traveller,Innova Crysta,Kia Carance ', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[]', '2026-05-07 17:36:59'),
(38, 'Hatchback,Sedan,Ertiga', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[]', '2026-06-05 12:09:57'),
(56, 'Ertiga,Sedan', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[]', '2026-05-16 08:03:45'),
(57, 'Ertiga,Sedan', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[]', '2026-05-18 00:11:26'),
(63, 'Ertiga', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[{\"pickup\":\"Faridabad, Haryana, India\",\"drop\":\"Champawat, Uttarakhand, India\"}]', '2026-05-25 09:26:33'),
(75, 'Sedan,Hatchback', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[]', '2026-05-15 15:25:27'),
(85, '', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[{\"pickup\":\"Dharamshala, Himachal Pradesh, India\",\"drop\":\"Chandigarh, India\"}]', '2026-05-14 09:10:29'),
(94, 'Ertiga', 'One Way,Round Trip', 'All', '[]', '2026-06-17 10:59:59'),
(111, 'Sedan', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[{\"pickup\":\"Nangloi Saiyed Village, Paschim Vihar, Delhi, 110087, India\",\"drop\":\"Har Ki Pauri, Haridwar, Uttarakhand, India\"},{\"pickup\":\"Paschim Vihar, Delhi, India\",\"drop\":\"Ajmer, Rajasthan, India\"},{\"pickup\":\"Paschim Vihar, Delhi, India\",\"drop\":\"Rajasthan, India\"},{\"pickup\":\"Paschim Vihar, Delhi, India\",\"drop\":\"Agar, Madhya Pradesh, India\"},{\"pickup\":\"Paschim Vihar, Delhi, India\",\"drop\":\"jaha bhi jana ho sampark kara\"}]', '2026-05-20 11:34:55'),
(176, 'Ertiga,Innova Hycross ,Innova Crysta', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[]', '2026-05-15 02:27:11'),
(179, 'Hatchback,Sedan', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[]', '2026-06-15 11:14:07'),
(207, 'Innova Crysta,Innova Hycross ', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[{\"pickup\":\"Ramnagar, Uttarakhand, India\",\"drop\":\"Delhi, India\"},{\"pickup\":\"Nainital, Uttarakhand, India\",\"drop\":\"Delhi, India\"}]', '2026-05-21 06:06:59'),
(212, 'Sedan', 'One Way,Round Trip,Airport Transfer', 'All', '[]', '2026-05-15 19:56:12'),
(232, 'Sedan,Innova Crysta', 'Round Trip,Hourly Rental,Airport Transfer', 'All', '[]', '2026-05-23 08:37:48'),
(245, 'Sedan', 'One Way,Round Trip,Airport Transfer', 'All', '[{\"pickup\":\"Patiala, Punjab, India\",\"drop\":\"Dehli, India\"}]', '2026-05-16 16:51:40'),
(252, 'Ertiga,Innova Crysta,Kia Carance ', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[]', '2026-05-14 09:28:47'),
(256, 'Hatchback,Sedan,Innova Hycross ,Ertiga', 'Round Trip,Hourly Rental,Airport Transfer', 'All', '[{\"pickup\":\"Coimbatore, Tamil Nadu, India\",\"drop\":\"Coimbatore, Tamil Nadu, India\"}]', '2026-05-14 07:49:19'),
(257, 'Ertiga,Sedan,Hatchback', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[]', '2026-05-15 00:56:56'),
(277, '', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[]', '2026-05-23 15:12:49'),
(279, 'Ertiga', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[{\"pickup\":\"Gurugram, Haryana, India\",\"drop\":\"Jaipur, Rajasthan, India\"}]', '2026-05-19 18:58:43'),
(280, 'Sedan', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[]', '2026-05-15 06:14:47'),
(281, 'Sedan', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[]', '2026-05-14 16:01:35'),
(294, 'Sedan', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[{\"pickup\":\"Noida, Uttar Pradesh, India\",\"drop\":\"Agra Cantt Railway Station, Sultanpura, Agra Cantt, Idgah Colony, Agra, Uttar Pradesh, India\"}]', '2026-05-16 07:34:00'),
(309, 'Sedan', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[{\"pickup\":\"Mangalore, Karnataka, India\",\"drop\":\"Bangalore, Karnataka, India\"}]', '2026-05-16 07:15:09'),
(313, 'Sedan,Hatchback', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[]', '2026-05-15 15:32:10'),
(316, 'Sedan', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[{\"pickup\":\"Dehradun, Uttarakhand, India\",\"drop\":\"Delhi, India\"},{\"pickup\":\"Delhi, India\",\"drop\":\"Dehradun, Uttarakhand, India\"},{\"pickup\":\"Roorkee, Uttarakhand, India\",\"drop\":\"Delhi, India\"},{\"pickup\":\"Delhi, India\",\"drop\":\"Roorkee, Uttarakhand, India\"},{\"pickup\":\"Saharanpur, Uttar Pradesh, India\",\"drop\":\"Delhi, India\"},{\"pickup\":\"Haridwar, Uttarakhand, India\",\"drop\":\"Delhi, India\"},{\"pickup\":\"Delhi, India\",\"drop\":\"Haridwar, Uttarakhand, India\"}]', '2026-06-07 11:25:16'),
(333, 'Sedan', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[{\"pickup\":\"Jamnagar, Gujarat, India\",\"drop\":\"Rajkot, Gujarat, India\"}]', '2026-05-18 13:28:05'),
(336, 'Ertiga,Sedan', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[]', '2026-05-17 02:57:13'),
(343, 'Ertiga', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[]', '2026-05-17 05:33:25'),
(345, '', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[]', '2026-05-20 10:38:58'),
(350, 'Ertiga', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[]', '2026-05-18 14:51:43'),
(359, 'Sedan', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[]', '2026-05-20 10:14:06'),
(369, '', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[]', '2026-05-21 10:41:52'),
(390, 'Sedan', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[]', '2026-05-21 05:14:03'),
(392, '', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[{\"pickup\":\"Patna, Bihar, India\",\"drop\":\"Siwan, Bihar, India\"},{\"pickup\":\"Patna, Bihar, India\",\"drop\":\"Gaya, Bihar, India\"},{\"pickup\":\"Patna, Bihar, India\",\"drop\":\"Rajgir, Bihar, India\"},{\"pickup\":\"Patna, Bihar, India\",\"drop\":\"Nawada, Bihar, India\"}]', '2026-05-21 07:11:51'),
(397, 'Ertiga,Sedan,Tempoo Traveller,Innova Crysta,Innova Hycross ,Kia Carance ', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[]', '2026-05-21 18:32:17'),
(398, '', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[]', '2026-05-23 14:11:12'),
(420, 'Sedan,Ertiga', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[]', '2026-05-25 15:38:55'),
(423, 'Ertiga', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[{\"pickup\":\"Jalandhar Cantt, Jalandhar, Punjab, India\",\"drop\":\"Delhi Airport (DEL), New Delhi, Delhi, India\"},{\"pickup\":\"Jalandhar, Punjab, India\",\"drop\":\"amritsar\"},{\"pickup\":\"Jalandhar, Punjab, India\",\"drop\":\"Himachal Pradesh, India\"},{\"pickup\":\"Jalandhar, Punjab, India\",\"drop\":\"chandighar\"}]', '2026-05-25 16:43:54'),
(447, 'Ertiga', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[]', '2026-06-13 13:25:33'),
(471, 'Ertiga', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[]', '2026-06-17 11:00:56'),
(499, 'Ertiga', 'One Way,Hourly Rental,Airport Transfer', 'All', '[{\"pickup\":\"Delhi, India\",\"drop\":\"muzffarngar \"}]', '2026-06-05 12:37:10'),
(511, 'Sedan,Hatchback,Ertiga,Innova Crysta,Tempoo Traveller,Kia Carance ,Innova Hycross ', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[]', '2026-06-14 13:43:24'),
(514, 'Ertiga,Sedan', 'One Way,Round Trip,Hourly Rental,Airport Transfer', 'All', '[]', '2026-06-17 10:55:28');

-- --------------------------------------------------------

--
-- Table structure for table `partner_bank_details`
--

CREATE TABLE `partner_bank_details` (
  `id` int(11) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `holder_name` varchar(150) DEFAULT NULL,
  `bank_name` varchar(100) DEFAULT NULL,
  `account_number` varchar(50) DEFAULT NULL,
  `ifsc_code` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `partner_bank_details`
--

INSERT INTO `partner_bank_details` (`id`, `partner_id`, `holder_name`, `bank_name`, `account_number`, `ifsc_code`, `created_at`, `updated_at`) VALUES
(1, 4, 'Rahul', 'HDFC BANK', '1196000100351034', 'PUNB0119600', '2026-04-04 13:17:35', '2026-04-04 13:17:35'),
(2, 9, 'Manish Kumar ', 'State Bank of India ', '33803434806', 'SBIN0016019', '2026-04-04 14:03:18', '2026-04-04 14:03:18'),
(3, 14, 'manish Kumar ', 'state bank of india ', '300544582275', 'SBIN0016019', '2026-04-12 11:29:20', '2026-04-12 11:29:20'),
(4, 21, 'SALAMAN KHAN', 'Punjab National Bank ', '7789001700049752', 'PUNB0778900', '2026-05-08 05:46:23', '2026-05-08 05:46:23'),
(5, 50, 'Ramavatar saini ', 'Panjab national Bank ', '3565000100119412', '3565PUNB', '2026-05-08 05:49:22', '2026-05-08 05:49:22'),
(6, 95, 'RAMJAN ', 'bank of Baroda ', '21740100017865', 'BARB0KARAMP', '2026-05-09 00:49:19', '2026-05-09 00:49:19'),
(7, 168, 'Shubham Kumar Nogiya ', 'Canara Bank ', '2459101003884', 'CNRB0002459', '2026-05-10 06:18:06', '2026-05-10 06:18:06'),
(8, 122, 'krishan soni ', 'union Bank of India ', '227012010001793', 'UBIN0822701', '2026-05-10 14:03:26', '2026-05-10 14:03:26'),
(9, 277, 'LOVELEEN BAINS ', 'HDFC BANK', '50100153754707', 'HDFC0000606', '2026-05-15 05:21:07', '2026-05-15 05:21:07'),
(10, 313, 'Gautam singh ', 'punjab national bank ', '4209000100052799', 'PUNB0420900', '2026-05-15 15:31:48', '2026-05-15 15:31:48'),
(11, 309, 'ABDUL RAHIMAN MIYAZ ', 'STATE Bank of India ', '42515920512', 'SBIN0040520', '2026-05-16 07:16:35', '2026-05-16 07:16:35'),
(13, 314, 'GIRISH PANWAR', 'SBI', '34914395067', 'SBIN0032383', '2026-05-18 01:00:38', '2026-05-18 01:00:38'),
(14, 199, 'Kamran Hussain ', 'Bank Of Baroda ', '32140100032893', 'BARB0SHADOI', '2026-05-19 05:07:15', '2026-05-19 05:07:29'),
(18, 469, 'Vineet Saini', 'Axis Bank', '911010047336481', 'UTIB0000179', '2026-06-07 19:02:00', '2026-06-07 19:02:00');

-- --------------------------------------------------------

--
-- Table structure for table `partner_bookings`
--

CREATE TABLE `partner_bookings` (
  `id` int(11) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `booking_type` varchar(100) NOT NULL,
  `pickup_location` text DEFAULT NULL,
  `drop_location` text DEFAULT NULL,
  `stops` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`stops`)),
  `car_type` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `start_time` varchar(50) DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `end_time` varchar(50) DEFAULT NULL,
  `pricing_option` varchar(50) DEFAULT 'quote',
  `total_amount` decimal(10,2) DEFAULT NULL,
  `commission` decimal(10,2) DEFAULT NULL,
  `toll_tax` varchar(20) DEFAULT 'Included',
  `parking` varchar(20) DEFAULT 'Included',
  `note` text DEFAULT NULL,
  `preferences` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`preferences`)),
  `status` varchar(50) DEFAULT 'Open',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `approach_type` enum('first_driver','manual_selection') DEFAULT 'first_driver',
  `allow_calls` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `partner_bookings`
--

INSERT INTO `partner_bookings` (`id`, `partner_id`, `booking_type`, `pickup_location`, `drop_location`, `stops`, `car_type`, `start_date`, `start_time`, `end_date`, `end_time`, `pricing_option`, `total_amount`, `commission`, `toll_tax`, `parking`, `note`, `preferences`, `status`, `created_at`, `updated_at`, `approach_type`, `allow_calls`) VALUES
(2627616, 9, 'One Way', 'Jind, Haryana, India', 'Kaithal, Haryana, India', '[\"Naguran, Haryana, India\",\"Kithana, Haryana, India\"]', '9', '2026-04-12', '12:30 PM', NULL, NULL, 'fixed', 100.00, 50.00, 'Included', 'Included', 'minimum wallet balance test booking', '{\"carrier\":true,\"hide_profile\":true}', 'Expired', '2026-04-11 20:21:14', '2026-04-20 19:23:31', 'first_driver', 1),
(2627619, 12, 'One Way', 'Jind, Haryana, India', 'Kaithal Bus Stand Road, Manjhla, Kaithal, Haryana', '[]', '9', '2026-04-12', '6:30 PM', NULL, NULL, 'fixed', 1000.00, 200.00, 'Included', 'Included', '', '{\"carrier\":true,\"hide_profile\":true}', 'Expired', '2026-04-12 08:10:12', '2026-04-20 19:23:31', 'first_driver', 1),
(2627623, 15, 'One Way', 'Jind, Haryana, India', 'Kandela, Haryana, India', '[]', '9', '2026-04-14', '5:00 PM', NULL, NULL, 'quote', NULL, NULL, 'Included', 'Included', '', '{\"carrier\":true,\"hide_profile\":true}', 'Expired', '2026-04-14 11:30:19', '2026-04-20 19:46:47', 'first_driver', 1),
(2627624, 15, 'One Way', 'Jind, Haryana, India', 'Kaithal, Haryana, India', '[\"Naguran, Haryana, India\",\"Kithana, Haryana, India\",\"Titram, Haryana, India\"]', '9', '2026-04-14', '6:14 PM', NULL, NULL, 'fixed', 100.00, 50.00, 'Included', 'Included', '', '{\"carrier\":true,\"hide_profile\":true}', 'Expired', '2026-04-14 11:44:36', '2026-04-20 19:46:47', 'first_driver', 1),
(2627634, 14, 'One Way', 'Vrindavan, Uttar Pradesh, India', 'Paharganj, New Delhi, Delhi, India', '[]', '9', '2026-04-23', '5:00 AM', NULL, NULL, 'fixed', 2300.00, 200.00, 'Included', 'Excluded', '', '{\"carrier\":true,\"hide_profile\":true}', 'Expired', '2026-04-21 04:18:03', '2026-04-23 02:35:58', 'manual_selection', 0),
(2627635, 14, 'Airport Transfer', 'Kempegowda International Airport Bengaluru (BLR), Terminal 2, Karnataka', 'MGM MARK WHITEFIELD, opp. to Capgemini, next to Accenture, EPIP Zone, Whitefield, Bengaluru, Karnataka, India', '[]', '8', '2026-04-22', '6:00 AM', NULL, NULL, 'fixed', 1000.00, 200.00, 'Included', 'Excluded', '', '{\"carrier\":false,\"hide_profile\":false}', 'Expired', '2026-04-21 15:18:33', '2026-04-22 11:10:23', 'manual_selection', 0),
(2627637, 14, 'One Way', 'Delhi, India', 'Agra, Uttar Pradesh, India', '[]', '9', '2026-04-23', '12:50 AM', NULL, NULL, 'fixed', 100.00, 20.00, 'Included', 'Included', '', '{\"carrier\":true,\"hide_profile\":true}', 'Completed', '2026-04-21 19:20:35', '2026-04-22 17:07:44', 'first_driver', 1),
(2627638, 14, 'One Way', 'Chandigarh airport, Road to Airport, Chandigarh Airport Area, Chandigarh, India', 'Ambala Cantt Railway Station, Railway Colony, Ambala Cantt, Haryana, India', '[\"Kaithal, Haryana, India\",\"Pegan, Haryana, India\"]', '9', '2026-04-24', '1:20 AM', NULL, NULL, 'fixed', 2000.00, 200.00, 'Included', 'Included', '*ChooseATaxi - Booking Details*\n\n🚖 *From:* Chandigarh airport, Road to Airport, Chandigarh Airport Area, Chandigarh, India\n📍 *To:* Ambala Cantt Railway Station, Railway Colony, Ambala Cantt, Haryana, India\n📅 *Date:* N/A\n🚗 *Vehicle:* Ertiga\n💰 *Fare:* ₹2000.00\n\nCheck this booking on ChooseATaxi App!', '{\"carrier\":true,\"hide_profile\":true}', 'Expired', '2026-04-21 19:50:51', '2026-04-23 19:50:38', 'first_driver', 1),
(2627639, 4, 'One Way', 'Jind, Haryana, India', 'Bhatinda, Punjab, India', '[]', '9', '2026-04-25', '6:10 PM', NULL, NULL, 'quote', NULL, NULL, 'Included', 'Included', '', '{\"carrier\":true,\"hide_profile\":false}', 'Completed', '2026-04-24 12:40:20', '2026-04-24 15:51:36', 'first_driver', 1),
(2627645, 4, 'Hourly/Rental', 'Jind, Haryana, India', '', '[\"\"]', '9', '2026-04-26', '10:35 PM', NULL, NULL, 'quote', NULL, NULL, 'Included', 'Included', 'Package: 40hrs/2000kms. need carrier into it', '{\"carrier\":true,\"hide_profile\":false}', 'Expired', '2026-04-25 17:05:56', '2026-04-27 04:08:19', 'first_driver', 1),
(2627646, 4, 'One Way', 'Jind, Haryana, India', 'Agra, Uttar Pradesh, India', '[\"Delhi, India\",\"Terminal 1, Indira Gandhi International Airport, New Delhi, Delhi, India\"]', '7', '2026-04-27', '11:45 AM', NULL, NULL, 'fixed', 100.00, 20.00, 'Included', 'Included', 'Note: Need Carrier & Rooftop type car.\nNote: Need Carrier & Rooftop type car.', '{\"carrier\":true,\"rooftop\":true,\"hide_profile\":false}', 'Expired', '2026-04-26 07:10:30', '2026-04-27 09:47:26', 'first_driver', 1),
(2627647, 4, 'One Way', 'Pai, Haryana, India', 'Haydarabad, Telangana, India', '[\"Delhi, India\",\"Agra, Uttar Pradesh, India\",\"Bhopal, Madhya Pradesh, India\"]', '7', '2026-04-27', '12:41 PM', NULL, NULL, 'fixed', 1000.00, 200.00, 'Included', 'Included', 'Note: Need Carrier & Rooftop type car.', '{\"carrier\":true,\"rooftop\":true,\"hide_profile\":false}', 'Completed', '2026-04-26 07:11:26', '2026-04-26 11:33:07', 'first_driver', 1),
(2627648, 4, 'One Way', 'Jind, Haryana, India', 'Agra, Uttar Pradesh, India', '[\"Delhi, India\"]', '7', '2026-04-26', '6:00 PM', NULL, NULL, 'fixed', 100.00, 50.00, 'Included', 'Included', 'Note: Need Carrier & Rooftop type car.\nNote: Need Carrier & Rooftop type car.\nNote: Need Carrier & Rooftop type car.', '{\"carrier\":true,\"rooftop\":true,\"hide_profile\":false}', 'Expired', '2026-04-26 07:14:34', '2026-04-26 16:59:52', 'first_driver', 1),
(2627649, 4, 'One Way', 'New Delhi, Delhi, India', 'Gurugram, Haryana, India', '[]', '7', '2026-04-26', '11:47 PM', NULL, NULL, 'fixed', 200.00, 100.00, 'Included', 'Included', 'Note: Need Carrier & Rooftop type car.', '{\"carrier\":true,\"rooftop\":true,\"hide_profile\":false}', 'Expired', '2026-04-26 07:17:32', '2026-04-27 04:08:19', 'first_driver', 1),
(2627651, 4, 'One Way', 'Kandela, Haryana, India', 'Jind, Haryana, India', '[]', '7', '2026-04-26', '5:08 PM', NULL, NULL, 'fixed', 200.00, 20.00, 'Included', 'Included', '', '{\"carrier\":false,\"rooftop\":false,\"hide_profile\":false}', 'Expired', '2026-04-26 08:38:58', '2026-04-26 16:59:52', 'first_driver', 1),
(2627653, 14, 'One Way', 'Jind, Haryana, India', 'Delhi, India', '[]', '7', '2026-04-28', '12:24 PM', NULL, NULL, 'fixed', 100.00, 20.00, 'Included', 'Included', 'Note: Need Carrier & Rooftop type car.', '{\"carrier\":true,\"rooftop\":true,\"hide_profile\":false}', 'Expired', '2026-04-27 18:54:46', '2026-04-28 13:11:03', 'first_driver', 1),
(2627654, 14, 'One Way', 'Jind, Haryana, India', 'Delhi, India', '[]', '7', '2026-04-28', '12:34 AM', NULL, NULL, 'fixed', 100.00, 20.00, 'Included', 'Included', 'Note: Need Carrier & Rooftop type car.', '{\"carrier\":true,\"rooftop\":true,\"hide_profile\":false}', 'Expired', '2026-04-27 19:04:45', '2026-04-28 13:11:03', 'first_driver', 1),
(2627658, 14, 'Round Trip', 'Airport (T-3), Indira Gandhi International Airport (DEL), Terminal 2, Delhi, हवाईअड्डा, Delhi, India', 'Delhi, India', '[\"Tirthan Valley, Gushaini, Himachal Pradesh, India\",\"Jibhi, Himachal Pradesh, India\"]', '9', '2026-04-30', '4:00 PM', '2026-05-03', '10:00 PM', 'fixed', 18500.00, 1000.00, 'Included', 'Included', 'Chandani Chowk & Red Fort  ( agar time rha to jayege )\n\n1st day\nJibhi  local sightseeing \nGiyagi Village\nTirthan valley \n\nDay 2\nSerolskar Lake ( tracking way )\nShoja\n\nkuch near by hua to as pas ja sakte h .', '{\"carrier\":false,\"rooftop\":false,\"hide_profile\":false}', 'Expired', '2026-04-29 02:10:10', '2026-04-30 13:45:26', 'first_driver', 0),
(2627659, 14, 'Hourly/Rental', 'The Leela Ambience Convention Hotel Delhi, Maharaja Surajmal Marg, Vishwas Nagar Extension, Vishwas Nagar, Shahdara, Delhi, India', '', '[]', '13', '2026-05-04', '9:00 AM', NULL, NULL, 'quote', NULL, NULL, 'Included', 'Included', 'Package: 12hrs/120kms. last drop noida sector 62', '{\"carrier\":false,\"rooftop\":false,\"hide_profile\":false}', 'Expired', '2026-04-29 02:25:17', '2026-05-04 05:54:48', 'first_driver', 0),
(2627660, 14, 'Round Trip', 'Delhi Airport (DEL), New Delhi, Delhi, India', 'Delhi, India', '[\"Nainital, Uttarakhand, India\",\"Almora, Uttarakhand, India\",\"Binsar, Uttarakhand, India\",\"Ranikhet, Uttarakhand, India\"]', '11', '2026-05-24', '6:00 AM', '2026-05-27', '11:59 PM', 'fixed', 21500.00, 500.00, 'Included', 'Included', '1st day\ndelhi Airport to Nainital & local sightseeing \n\n2nd day \nnainital to almora ( keshar devi temple)& local sightseeing \n\n3rd day\nalmora to binsar / ranikhet sightseeing \nnight stay almora / ranikhet (depend on hotel)\n\n4th Day \n      return delhi Via nainital ARIES Observatory ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-04-30 07:05:48', '2026-05-24 00:50:07', 'first_driver', 0),
(2627661, 14, 'Round Trip', 'Dharamshala, Himachal Pradesh, India', 'Dharamshala, Himachal Pradesh, India', '[\"Macleodganj, McLeod Ganj, Dharamshala, Himachal Pradesh, India\"]', '8', '2026-05-16', '7:00 AM', '2026-05-18', '11:59 PM', 'fixed', 7700.00, 500.00, 'Included', 'Included', 'dharmshala & Macleodganj local sightseeing ', '{\"carrier\":false,\"rooftop\":false,\"hide_profile\":false}', 'Accepted', '2026-04-30 07:11:02', '2026-05-09 05:09:28', 'manual_selection', 0),
(2627662, 14, 'Round Trip', 'Delhi Airport (DEL), New Delhi, Delhi, India', 'Lucknow, Uttar Pradesh, India', '[\"Mathura, Uttar Pradesh, India\",\"Agra, Uttar Pradesh, India\",\"Ayodhya, Uttar Pradesh, India\"]', '12', '2026-05-10', '6:00 AM', '2026-05-17', '11:59 PM', 'fixed', 63000.00, 1000.00, 'Included', 'Excluded', '12 seater Tempoo travelar requirement \n\n3 night \nMathura ,vrindavan, goverdhan,barsana sightseeing \n\n1 night \n agra sightseeing \n\n2 night \nayodhya sightseeing \n\n1 night \nLucknow sightseeing \n\nlast drop Lucknow h ', '{\"carrier\":false,\"rooftop\":false,\"hide_profile\":false}', 'Expired', '2026-04-30 07:50:04', '2026-05-10 01:02:56', 'first_driver', 0),
(2627663, 14, 'One Way', 'Paharganj, New Delhi, Delhi, India', 'Haldwani, Uttarakhand, India', '[]', '9', '2026-05-11', '5:00 PM', NULL, NULL, 'fixed', 4000.00, 400.00, 'Included', 'Included', '', '{\"carrier\":false,\"rooftop\":false,\"hide_profile\":false}', 'Expired', '2026-05-03 17:59:58', '2026-05-11 11:45:56', 'manual_selection', 0),
(2627664, 14, 'One Way', 'Vrindavan, Uttar Pradesh, India', 'Delhi Airport (DEL), New Delhi, Delhi, India', '[]', '8', '2026-05-09', '3:45 AM', NULL, NULL, 'fixed', 2700.00, 500.00, 'Included', 'Included', '', '{\"carrier\":false,\"rooftop\":false,\"hide_profile\":false}', 'Expired', '2026-05-04 06:02:41', '2026-05-08 23:34:16', 'manual_selection', 0),
(2627665, 14, 'One Way', 'Sector 8 Dwarka, Dwarka, Delhi, India', 'Sector 155, Noida, Uttar Pradesh, India', '[]', '8', '2026-05-07', '7:30 AM', NULL, NULL, 'fixed', 980.00, 80.00, 'Included', 'Included', 'cx ka exam h late nhi kre.', '{\"carrier\":false,\"rooftop\":false,\"hide_profile\":false}', 'Expired', '2026-05-04 13:57:27', '2026-05-07 02:19:11', 'manual_selection', 0),
(2627666, 14, 'Round Trip', 'Kathgodam, Haldwani, Uttarakhand, India', 'Kathgodam, Haldwani, Uttarakhand, India', '[\"Nainital, Uttarakhand, India\",\"Bhimtal, Uttarakhand, India\",\"Ranikhet, Uttarakhand, India\",\"Kausani, Uttarakhand, India\",\"Almora, Uttarakhand, India\",\"Jim Corbett National Park, Uttarakhand, India\"]', '8', '2026-05-06', '5:00 AM', '2026-05-12', '11:59 PM', 'fixed', 21000.00, 500.00, 'Included', 'Included', 'all location local sightseeing including ', '{\"carrier_rooftop\":false,\"ac_included\":false,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-05 13:36:42', '2026-05-06 01:30:07', 'manual_selection', 0),
(2627667, 14, 'One Way', 'Vrindavan, Uttar Pradesh, India', 'Delhi Airport (DEL), New Delhi, Delhi, India', '[]', '8', '2026-05-06', '6:00 PM', NULL, NULL, 'fixed', 2700.00, 700.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":false,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-05 15:24:21', '2026-05-06 12:45:56', 'first_driver', 0),
(2627668, 14, 'Round Trip', 'Delhi Airport (DEL), New Delhi, Delhi, India', 'Delhi, India', '[\"Nainital, Uttarakhand, India\",\"Bhimtal, Uttarakhand, India\",\"Binsar, Uttarakhand, India\",\"Ranikhet, Uttarakhand, India\"]', '11', '2026-05-31', '6:00 AM', '2026-06-06', '11:59 PM', 'fixed', 35500.00, 500.00, 'Included', 'Included', 'Sightseeing is included in all the above locations.\n\nall inclusive no any extra.', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-05 18:11:19', '2026-06-04 18:43:23', 'first_driver', 0),
(2627669, 14, 'Round Trip', 'Sector 9, Gurugram, Haryana, India', 'Sector 9, Gurugram, Haryana, India', '[\"Khatu Shyam Ji Temple, Rajasthan, India\"]', '8', '2026-05-06', '10:15 AM', '2026-05-06', '11:59 PM', 'fixed', 5800.00, 500.00, 'Included', 'Included', 'aane jane me jo time lagega wo or darshan krke turant wapis aana h. ', '{\"carrier_rooftop\":false,\"ac_included\":false,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-06 03:07:21', '2026-05-06 06:20:37', 'manual_selection', 0),
(2627670, 14, 'One Way', 'Khatima, Uttarakhand, India', 'Delhi cantt railway Junction, Kirby Place, Delhi Cantonment, New Delhi, Delhi, India', '[]', '8', '2026-05-06', '8:30 PM', NULL, NULL, 'fixed', 5000.00, 700.00, 'Included', 'Included', 'near by se 1 pickup extra hoga \nNote: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":false,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-06 06:13:28', '2026-05-06 15:15:16', 'manual_selection', 0),
(2627671, 13, 'One Way', 'Patparganj, Delhi, India', 'Haldwani, Uttarakhand, India', '[]', '9', '2026-05-06', '16:00', NULL, NULL, 'fixed', 3900.00, 400.00, 'Included', 'Included', 'singal person h . 4/5 bandal books k h ', '{\"carrier_rooftop\":false,\"ac_included\":false,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-06 07:18:44', '2026-05-06 10:59:26', 'first_driver', 0),
(2627672, 14, 'Round Trip', 'Agra, Uttar Pradesh, India', 'Agra, Uttar Pradesh, India', '[\"Malviya Nagar, New Delhi, Delhi, India\"]', '8', '2026-05-07', '6:00 AM', '2026-05-07', '11:59 PM', 'fixed', 5000.00, 500.00, 'Included', 'Included', 'delhi me 1/2 jgah jana h.2023+ model cab requirement.', '{\"carrier_rooftop\":false,\"ac_included\":false,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-06 07:38:40', '2026-05-07 00:47:14', 'first_driver', 0),
(2627673, 13, 'One Way', 'Delhi Airport (DEL), New Delhi, Delhi, India', 'Kaithal, Haryana, India', '[]', '8', '2026-05-06', '23:45', NULL, NULL, 'quote', NULL, NULL, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":true,\"hide_profile\":false}', 'Expired', '2026-05-06 11:00:36', '2026-05-06 18:35:44', 'manual_selection', 0),
(2627675, 14, 'One Way', 'Chirag Delhi Metro station no. 5, Chirag Delhi Flyover, Chirag Dilli, New Delhi, Delhi, India', 'Purkaji, Uttar Pradesh, India', '[]', '8', '2026-05-07', '7:00 AM', NULL, NULL, 'fixed', 2600.00, 300.00, 'Included', 'Included', 'purkaji se 5 km aage drop h ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-06 14:29:22', '2026-05-07 01:48:21', 'first_driver', 0),
(2627676, 13, 'One Way', 'Gaur City 2, Ghaziabad, Uttar Pradesh, India', 'Haridwar, Uttarakhand, India', '[]', '8', '2026-05-06', '23:30', NULL, NULL, 'fixed', 2800.00, 200.00, 'Included', 'Included', 'urgent ki booking h ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-06 17:31:53', '2026-05-06 18:35:44', 'first_driver', 0),
(2627677, 14, 'One Way', 'Chander Vihar, Nilothi, Delhi, India', 'Gharaunda, Haryana, India', '[]', '9', '2026-05-07', '2:00 PM', NULL, NULL, 'fixed', 2700.00, 300.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-07 02:34:42', '2026-05-07 08:45:33', 'manual_selection', 0),
(2627678, 13, 'One Way', 'Gwal pahari gurugram, Tanwar Wy, Gwal Pahari, Bandhwari, Haryana, India', 'Gunnaur, Uttar Pradesh, India', '[]', '8', '2026-05-07', '10:00', NULL, NULL, 'fixed', 2700.00, 300.00, 'Included', 'Included', 'anupshahar se aage pdega chohali me drop h gunnaur k pas ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-07 03:17:13', '2026-05-07 04:49:39', 'manual_selection', 0),
(2627679, 14, 'One Way', 'Sector 21, Gurugram, India', 'Bahona Kotra, Uttar Pradesh, India', '[]', '9', '2026-05-07', '6:00 PM', NULL, NULL, 'fixed', 3300.00, 300.00, 'Included', 'Included', 'Note: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-07 03:53:58', '2026-05-07 12:45:30', 'first_driver', 0),
(2627680, 14, 'One Way', 'Findoc, Ferozepur Road, Gurdev Nagar, Ludhiana, Punjab, India', 'Rohini, Delhi, India', '[]', '8', '2026-05-07', '6:30 PM', NULL, NULL, 'fixed', 3800.00, 200.00, 'Included', 'Included', 'cng raste me 1 bar bharaye baar baar nhi.', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-07 10:51:39', '2026-05-07 13:23:44', 'manual_selection', 0),
(2627681, 13, 'One Way', 'Sector 150, Noida, Uttar Pradesh, India', 'Shamli, Uttar Pradesh, India', '[]', '8', '2026-05-07', '19:00', NULL, NULL, 'fixed', 1900.00, 200.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-07 11:35:53', '2026-05-07 13:45:29', 'first_driver', 0),
(2627682, 13, 'One Way', 'Sector 129, Noida, Uttar Pradesh, India', 'Rishikesh, Uttarakhand, India', '[]', '9', '2026-05-08', '23:15', NULL, NULL, 'fixed', 3750.00, 500.00, 'Included', 'Included', 'haridwar waiting krege 20/25 minute uski parking lagegi to extra milegi.\nNote: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":false,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-07 17:14:18', '2026-05-08 18:00:12', 'manual_selection', 0),
(2627685, 14, 'One Way', 'Sector 67, Gurugram, Haryana, India', 'ijjat Nagar station, Izatnagar, Bareilly, Uttar Pradesh, India', '[]', '8', '2026-05-08', '8:15 AM', NULL, NULL, 'fixed', 3600.00, 400.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-07 18:22:30', '2026-05-08 03:03:29', 'first_driver', 0),
(2627691, 13, 'One Way', 'Sector 79, Noida, Uttar Pradesh, India', 'Rohtak, Haryana, India', '[]', '8', '2026-05-08', '14:30', NULL, NULL, 'fixed', 2000.00, 200.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Accepted', '2026-05-08 05:06:28', '2026-05-08 05:50:51', 'first_driver', 0),
(2627692, 14, 'One Way', 'Terminal 1, Indira Gandhi International Airport, New Delhi, Delhi, India', 'Sonipat, Haryana, India', '[]', '8', '2026-05-08', '7:00 PM', NULL, NULL, 'fixed', 1500.00, 300.00, 'Included', 'Excluded', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-08 10:25:21', '2026-05-08 13:45:12', 'first_driver', 0),
(2627693, 13, 'One Way', 'Pitampura, Delhi, India', 'Jim Corbett National Park, Uttarakhand, India', '[]', '9', '2026-05-09', '05:45', NULL, NULL, 'fixed', 4000.00, 500.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-08 12:19:14', '2026-05-09 00:35:39', 'first_driver', 0),
(2627694, 14, 'One Way', 'Sector 100, Noida, Uttar Pradesh, India', 'Sahastradhara, Timilimansingh, Uttarakhand, India', '[]', '8', '2026-05-09', '5:00 AM', NULL, NULL, 'fixed', 3200.00, 300.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-08 16:53:30', '2026-05-08 23:58:30', 'first_driver', 0),
(2627695, 13, 'Round Trip', 'Lajpat Nagar, New Delhi, Delhi, India', 'Lajpat Nagar, New Delhi, Delhi, India', '[\"Bareilly, Uttar Pradesh, India\"]', '8', '2026-05-10', '07:00', '2026-05-10', '23:59', 'fixed', 5800.00, 300.00, 'Included', 'Included', '2023+ gadi honi chahiye ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Accepted', '2026-05-08 17:26:08', '2026-05-09 04:08:21', 'first_driver', 0),
(2627696, 14, 'One Way', 'Dwarka, Delhi, India', 'Ludhiana, Punjab, India', '[]', '9', '2026-05-09', '6:00 AM', NULL, NULL, 'quote', NULL, NULL, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-08 17:56:50', '2026-05-09 00:45:16', 'manual_selection', 0),
(2627697, 41, 'One Way', 'Patanjali Yogpeeth, National Highway, near Bahadarbad, Uttarakhand, India', 'Sector 38, Sector 38 Road, Medicity, Islampur Colony, Sector 38, Gurgaon, Haryana, India', '[]', '9', '2026-05-09', '12:30 PM', NULL, NULL, 'fixed', 4000.00, 500.00, 'Included', 'Included', 'Note: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":false,\"airport_parking\":false,\"hide_profile\":false}', 'Cancelled', '2026-05-09 02:47:13', '2026-05-09 05:24:47', 'first_driver', 1),
(2627699, 14, 'One Way', 'Sector 28, Rohini, Delhi, India', 'Narayanpur, Rajasthan, India', '[]', '8', '2026-05-09', '3:30 PM', NULL, NULL, 'fixed', 3000.00, 300.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-09 09:01:21', '2026-05-09 10:22:09', 'first_driver', 0),
(2627700, 14, 'Round Trip', 'Sector 14, Gurugram, Haryana, India', 'Sector 14, Gurgaon, Haryana, India', '[\"Barsana, Uttar Pradesh, India\",\"Vrindavan, Uttar Pradesh, India\"]', '9', '2026-05-10', '4:30 AM', '2026-05-11', '1:00 AM', 'fixed', 5000.00, 400.00, 'Included', 'Included', '10/10:15 bje vrindavan se niklege wapis \non the way sohna road se 1 pickup Krna h.\n\n', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-09 10:37:29', '2026-05-09 23:29:16', 'manual_selection', 0),
(2627702, 14, 'One Way', 'Hotel Jagat Raj, Sitapur, Uttarakhand, India', 'Helipad, Phata, Khariya, Uttarakhand, India', '[\"Arrow SERSI HELIPAD, Triugi Narayan Sonprayag Road, Sersi, Uttarakhand, India\"]', '8', '2026-05-10', '6:00 AM', NULL, NULL, 'quote', NULL, NULL, 'Included', 'Included', 'koi gadi ertiga / dzire available h to apna rate btaye ', '{\"carrier_rooftop\":false,\"ac_included\":false,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-09 15:26:29', '2026-05-10 01:02:56', 'manual_selection', 0),
(2627703, 14, 'Hourly/Rental', 'Pitampura, Delhi, India', '', '[]', '11', '2026-05-10', '3:00 PM', NULL, NULL, 'quote', NULL, NULL, 'Excluded', 'Excluded', 'Package: 19hrs/200kms. delhi ncr me hi rhegi gadi apna rate send kijiye ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-09 15:29:50', '2026-05-10 09:52:40', 'manual_selection', 0),
(2627704, 14, 'One Way', 'H block, Block H, Virendra Gram, Sector 26, Gurugram, Haryana, India', 'The Bohemian Casa Dehradun, New LKD Road, Kimadi, Mussoorie, Dehradun, Uttarakhand, India', '[]', '9', '2026-05-16', '10:00 AM', NULL, NULL, 'fixed', 4000.00, 10.00, 'Included', 'Included', 'garhi cannt se 12 km aage drop h.', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-09 16:35:08', '2026-05-16 04:45:40', 'first_driver', 0),
(2627714, 14, 'One Way', 'The Bohemian Casa Dehradun, New LKD Road, Kimadi, Mussoorie, Dehradun, Uttarakhand, India', 'Sector 26, Gurugram, Haryana, India', '[]', '9', '2026-05-18', '11:00', NULL, NULL, 'fixed', 4000.00, 200.00, 'Included', 'Included', 'time thoda upar niche ho sakta h ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Accepted', '2026-05-09 17:42:16', '2026-05-15 11:19:18', 'first_driver', 0),
(2627728, 103, 'One Way', 'Udaipur, Rajasthan, India', 'Jaipur, Rajasthan, India', '[]', '8', '2026-05-10', '3:33 PM', NULL, NULL, 'quote', NULL, NULL, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":false,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-10 10:05:07', '2026-05-10 10:19:28', 'first_driver', 1),
(2627731, 14, 'Hourly/Rental', 'Chaudhary Charan Singh International Airport (LKO), Amausi, Lucknow, Uttar Pradesh, India', '', '[]', '9', '2026-05-11', '10:00', NULL, NULL, 'fixed', 2800.00, 300.00, 'Excluded', 'Excluded', 'Package: 8hrs/80kms. ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-10 17:27:56', '2026-05-11 04:45:42', 'first_driver', 0),
(2627734, 14, 'One Way', 'Tapovan, Rishikesh, Uttarakhand, India', 'Palam Vihar, Gurugram, Haryana, India', '[]', '8', '2026-05-11', '08:30', NULL, NULL, 'fixed', 5000.00, 1400.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-10 23:59:22', '2026-05-11 03:17:47', 'first_driver', 0),
(2627735, 14, 'One Way', 'Chandigarh, India', 'Tirthan Valley, Gushaini, Himachal Pradesh, India', '[]', '8', '2026-05-21', '10:00 AM', NULL, NULL, 'fixed', 4700.00, 800.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-11 05:06:47', '2026-05-21 04:45:49', 'first_driver', 0),
(2627736, 14, 'Hourly/Rental', 'Sector 12, RK Puram, New Delhi, Delhi, India', '', '[]', '11', '2026-05-11', '14:30', NULL, NULL, 'fixed', 2550.00, 50.00, 'Excluded', 'Excluded', 'Package: 8hrs/80kms. VIP clint cab neat & clean must.', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-11 06:08:51', '2026-05-11 09:19:37', 'manual_selection', 0),
(2627737, 14, 'Hourly/Rental', 'Kolkata, West Bengal, India', '', '[]', '9', '2026-05-12', '10:00', NULL, NULL, 'quote', NULL, NULL, 'Included', 'Included', 'Package: 9hrs/90kms. monthly cab chahiye daily 9hour /90 km 2025 model Suv cab honi chahiye agar kisi k pas h to apna rate send kijiye ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-11 07:52:38', '2026-05-12 04:45:06', 'manual_selection', 0),
(2627738, 13, 'Hourly/Rental', 'Findoc, DLF Cyber City, DLF Phase 3, Sector 24, Gurugram, Haryana, India', '', '[]', '8', '2026-05-11', '1:50 PM', NULL, NULL, 'fixed', 1800.00, 300.00, 'Excluded', 'Excluded', 'Package: 8hrs/80kms. extra hour 120/-', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-11 07:58:21', '2026-05-11 08:36:29', 'first_driver', 0),
(2627739, 14, 'Hourly/Rental', 'Findoc, DLF Cyber City, DLF Phase 3, Sector 24, Gurugram, Haryana, India', '', '[]', '8', '2026-05-11', '16:30', NULL, NULL, 'fixed', 1800.00, 300.00, 'Excluded', 'Excluded', 'Package: 8hrs/80kms. extra hour _ 120/-\nextra km __ 11 /-', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-11 10:30:56', '2026-05-11 11:15:15', 'manual_selection', 0),
(2627740, 14, 'One Way', 'Findoc, Ferozepur Road, Gurdev Nagar, Ludhiana, Punjab, India', 'Cyber City, DLF Cyber City, DLF Phase 2, Sector 24, Gurugram, Haryana, India', '[]', '8', '2026-05-11', '17:30', NULL, NULL, 'fixed', 4200.00, 200.00, 'Included', 'Included', 'via dwarka xpress way ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-11 11:22:30', '2026-05-11 12:16:46', 'manual_selection', 0),
(2627741, 14, 'One Way', 'Chandigarh Airport Area, Chandigarh, India', 'Aggar Nagar, Ludhiana, Punjab, India', '[]', '8', '2026-05-11', '23:40', NULL, NULL, 'fixed', 1500.00, 100.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":true,\"hide_profile\":false}', 'Expired', '2026-05-11 12:21:20', '2026-05-11 18:25:07', 'manual_selection', 0),
(2627745, 4, 'One Way', 'Jind, Haryana, India', 'Delhi, India', '[]', '7', '2026-05-13', '1:28 AM', NULL, NULL, 'quote', NULL, NULL, 'Included', 'Included', 'Note: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":false,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-11 19:58:53', '2026-05-12 20:18:11', 'first_driver', 0),
(2627746, 13, 'One Way', 'Haridwar, Uttarakhand, India', 'Delhi, India', '[]', '8', '2026-05-13', '6:00 AM', NULL, NULL, 'quote', NULL, NULL, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":false,\"airport_parking\":false,\"hide_profile\":false}', 'Accepted', '2026-05-12 04:43:10', '2026-05-12 13:20:03', 'first_driver', 0),
(2627747, 14, 'One Way', 'Natraj chowk, Tehsil Rd, Bsnl Colony, Rishikesh, Uttarakhand, India', 'Delhi Airport (DEL), New Delhi, Delhi, India', '[]', '8', '2026-05-12', '20:30', NULL, NULL, 'fixed', 3500.00, 500.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-12 08:55:12', '2026-05-12 15:15:19', 'manual_selection', 0),
(2627748, 14, 'Round Trip', 'Jolly Grant Airport - Dehradun, Airport Road, Jauligrant, Uttarakhand, India', 'Rishikesh, Uttarakhand, India', '[\"Mussoorie, Uttarakhand, India\",\"Tungnath Mandir, Rudraprayag, Uttarakhand, India\",\"Sari Village, Saari Village, Dilmi, Uttarakhand, India\"]', '8', '2026-05-16', '6:00 AM', '2026-05-21', '11:59 PM', 'fixed', 20500.00, 2000.00, 'Included', 'Excluded', 'mussoorie local sightseeing, tungnath sightseeing, sari village sightseeing & near by / on the way sightseeing included.', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-12 10:31:21', '2026-05-16 00:45:58', 'first_driver', 0),
(2627750, 14, 'One Way', 'Sahastradhara, Sahastradhara Road, Kulhan, Dhanaula, Dehradun, Uttarakhand, India', 'Delhi Airport (DEL), New Delhi, Delhi, India', '[]', '8', '2026-05-13', '16:00', NULL, NULL, 'fixed', 3500.00, 500.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-12 14:27:09', '2026-05-13 10:56:26', 'first_driver', 0),
(2627751, 14, 'Round Trip', 'South Extension I, New Delhi, Delhi, India', 'South Extension I, New Delhi, Delhi, India', '[\"Barsana, Uttar Pradesh, India\",\"Vrindavan, Uttar Pradesh, India\"]', '9', '2026-05-13', '08:15', '2026-05-13', '23:59', 'fixed', 5500.00, 500.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Accepted', '2026-05-12 15:19:52', '2026-05-12 15:39:49', 'manual_selection', 0),
(2627755, 13, 'One Way', 'Tapovan, Rishikesh, Uttarakhand, India', 'Jolly Grant Airport - Dehradun, Airport Road, Jauligrant, Uttarakhand, India', '[]', '8', '2026-05-22', '8:00 AM', NULL, NULL, 'fixed', 1000.00, 50.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":true,\"hide_profile\":false}', 'Expired', '2026-05-12 17:57:08', '2026-05-22 02:54:28', 'first_driver', 0),
(2627756, 14, 'Round Trip', 'Delhi Airport (DEL), New Delhi, Delhi, India', 'Jolly Grant Airport - Dehradun, Airport Road, Jauligrant, Uttarakhand, India', '[\"Mussoorie, Uttarakhand, India\",\"Dehradun, Uttarakhand, India\"]', '11', '2026-06-02', '12:30', '2026-06-03', '18:00', 'fixed', 11500.00, 1000.00, 'Excluded', 'Excluded', 'mussoorie, dehradun location sightseeing including ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":true,\"hide_profile\":false}', 'Expired', '2026-05-13 03:39:00', '2026-06-04 18:43:23', 'manual_selection', 0),
(2627757, 13, 'Round Trip', 'Tapovan, Rishikesh, Uttarakhand, India', 'Tapovan, Rishikesh, Uttarakhand, India', '[]', '8', '2026-05-13', '10:30 AM', '2026-05-13', '11:59 PM', 'quote', NULL, NULL, 'Included', 'Included', 'snan krke turant wapis ana h ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-13 04:11:33', '2026-05-13 05:22:59', 'manual_selection', 0),
(2627758, 14, 'One Way', 'Shimla, Himachal Pradesh, India', 'Manali, Himachal Pradesh, India', '[]', '8', '2026-05-19', '8:00 AM', NULL, NULL, 'fixed', 4000.00, 500.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-13 18:34:39', '2026-05-19 02:45:12', 'first_driver', 0),
(2627759, 14, 'Round Trip', 'Lucknow, Uttar Pradesh, India', 'Lucknow, Uttar Pradesh, India', '[\"Kanpur, Uttar Pradesh, India\"]', '9', '2026-05-14', '4:00 PM', '2026-05-14', '11:59 PM', 'quote', NULL, NULL, 'Included', 'Included', '7 passanger ho sakte h ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-14 04:12:50', '2026-05-14 10:45:13', 'manual_selection', 0),
(2627760, 14, 'One Way', 'Chhatrapati Shivaji Maharaj International Airport Mumbai (BOM), Mumbai, Maharashtra, India', 'Kolhar, Maharashtra, India', '[\"Pune Airport (PNQ), Pune International Airport Area, Lohegaon, Pune, Maharashtra, India\",\"Ahilyanagar, Maharashtra, India\"]', '8', '2026-05-15', '11:00 AM', NULL, NULL, 'fixed', 4500.00, 500.00, 'Included', 'Included', '1 pickup mumbai Airport & 1 pickup pune airport se hoga\nuske bad 1 drop ahilyanagar me & 1 drop kolhar me hoga', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-14 04:37:13', '2026-05-15 05:45:38', 'first_driver', 0),
(2627761, 14, 'Hourly/Rental', 'Doddaballapura, Karnataka, India', '', '[]', '8', '2026-05-17', '8:00 AM', NULL, NULL, 'quote', NULL, NULL, 'Included', 'Included', 'Package: 8hrs/80kms. 8hr/80km rental duty\n\nextra km_ 12/-\nextra hour _ 150/-', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-14 04:39:35', '2026-05-17 02:45:53', 'first_driver', 0),
(2627762, 14, 'One Way', 'AIIMS Patna, Phulwari Sharif, Patna, Bihar, India', 'Bariya, Uttar Pradesh, India', '[]', '8', '2026-05-14', '3:00 PM', NULL, NULL, 'fixed', 2800.00, 500.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-14 05:11:55', '2026-05-14 09:45:05', 'first_driver', 0),
(2627763, 14, 'One Way', 'Guru Arjan Dev Nagar, Ludhiana, Punjab, India', 'Karol Bagh, New Delhi, Delhi, India', '[]', '9', '2026-05-14', '1:30 PM', NULL, NULL, 'fixed', 4500.00, 300.00, 'Included', 'Included', 'driver behavior achcha Ho \ndriving normal speed me chalaye.', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-14 05:47:32', '2026-05-14 08:15:14', 'manual_selection', 0),
(2627765, 14, 'One Way', 'Siwan, Bihar, India', 'Delhi, India', '[]', '9', '2026-05-16', '8:00 AM', NULL, NULL, 'fixed', 16000.00, 1000.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-14 05:52:03', '2026-05-16 02:51:13', 'first_driver', 0),
(2627766, 14, 'One Way', 'Ghaziabad, Uttar Pradesh, India', 'Kaulagarh, Dehradun, Uttarakhand, India', '[]', '9', '2026-05-14', '1:00 PM', NULL, NULL, 'fixed', 4000.00, 300.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-14 06:25:19', '2026-05-14 07:45:05', 'first_driver', 0),
(2627767, 14, 'One Way', 'Hotel Greenwoods Inn McLeodganj #Roof top Terrace#Lift#All Balcony Rooms#Close to the Triund Trek Point 400 Mtr Head, Dharamkot Road, Dharamkot, McLeod Ganj, Dharamshala, Himachal Pradesh, India', 'Dalhousie, Himachal Pradesh, India', '[]', '8', '2026-05-15', '8:00 AM', NULL, NULL, 'fixed', 3000.00, 400.00, 'Included', 'Included', 'Note: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-14 07:28:09', '2026-05-15 02:48:05', 'first_driver', 0),
(2627769, 14, 'One Way', 'Tundla, Uttar Pradesh, India', 'Vrindavan, Uttar Pradesh, India', '[]', '9', '2026-05-29', '5:00 PM', NULL, NULL, 'fixed', 2500.00, 500.00, 'Included', 'Included', 'Note: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-14 08:16:47', '2026-06-04 18:43:23', 'manual_selection', 0),
(2627770, 14, 'Hourly/Rental', 'Findoc, DLF Cyber City, DLF Phase 3, Sector 24, Gurugram, Haryana, India', '', '[]', '11', '2026-05-14', '2:30 PM', NULL, NULL, 'fixed', 2700.00, 200.00, 'Excluded', 'Excluded', 'Package: 8hrs/80kms. ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-14 08:30:44', '2026-05-14 09:15:06', 'first_driver', 0),
(2627771, 14, 'One Way', 'Hari Nagar, Delhi, India', 'Hapur, Uttar Pradesh, India', '[]', '8', '2026-05-18', '9:00 AM', NULL, NULL, 'fixed', 1600.00, 100.00, 'Included', 'Included', 'Note: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-14 08:44:26', '2026-05-18 03:45:01', 'manual_selection', 0),
(2627773, 14, 'One Way', 'Janakpuri, New Delhi, Delhi, India', 'Agra, Uttar Pradesh, India', '[]', '8', '2026-05-15', '6:30 AM', NULL, NULL, 'fixed', 2200.00, 200.00, 'Included', 'Included', 'Note: Need Carrier/Rooftop type car.\nNote: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-14 10:06:19', '2026-05-15 01:15:59', 'first_driver', 0),
(2627774, 14, 'Round Trip', 'Ahmedabad, Gujarat, India', 'Ahmedabad, Gujarat, India', '[\"Dwarka, Gujarat, India\"]', '12', '2026-05-28', '6:00 AM', '2026-05-30', '11:59 PM', 'quote', NULL, NULL, 'Included', 'Included', '12 seater Tempoo traveller requirement ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-14 11:33:05', '2026-06-04 18:43:23', 'first_driver', 0),
(2627776, 14, 'One Way', 'Kashipur, Uttarakhand, India', 'Delhi Airport (DEL), New Delhi, Delhi, India', '[]', '8', '2026-05-16', '4:00 AM', NULL, NULL, 'fixed', 3500.00, 500.00, 'Included', 'Included', 'Kashipur se ramnagar road se pickup h ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-14 15:06:00', '2026-05-15 22:46:01', 'first_driver', 0),
(2627777, 14, 'One Way', 'Daryaganj, Delhi, India', 'Manali, Himachal Pradesh, India', '[]', '8', '2026-05-15', '10:00 PM', NULL, NULL, 'fixed', 6500.00, 500.00, 'Included', 'Included', 'Note: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Accepted', '2026-05-14 15:20:38', '2026-05-15 10:09:47', 'first_driver', 0),
(2627778, 14, 'One Way', 'Delhi Airport (DEL), New Delhi, Delhi, India', 'Jaipur, Rajasthan, India', '[]', '11', '2026-05-15', '12:45 PM', NULL, NULL, 'fixed', 5000.00, 200.00, 'Included', 'Excluded', 'customer ko problem nhi ho to kisi bhi route se ja sakti h gadi wrna delhi Mumbai expressway se jana h ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-14 15:26:29', '2026-05-15 07:30:11', 'first_driver', 0),
(2627780, 14, 'One Way', 'Nizamuddin Railway Station Road, Jangpura, Block C, Jangpura B, Nizamuddin East, New Delhi, Delhi, India', 'Dehradun, Uttarakhand, India', '[]', '9', '2026-05-16', '8:55 AM', NULL, NULL, 'fixed', 4000.00, 400.00, 'Included', 'Excluded', 'Note: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Accepted', '2026-05-14 18:33:38', '2026-05-15 02:12:00', 'first_driver', 0),
(2627781, 14, 'One Way', 'Patel Nagar, New Delhi, Delhi, India', 'Atul verma home, Agra Shamshabad Raja Kherah Marg, Kaulakha, Rajrai, Kaulakha, Uttar Pradesh, India', '[]', '8', '2026-05-15', '11:00 AM', NULL, NULL, 'fixed', 2200.00, 150.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-14 18:40:19', '2026-05-15 05:45:38', 'first_driver', 0),
(2627782, 14, 'One Way', 'Delhi Airport (DEL), New Delhi, Delhi, India', 'Lucknow, Uttar Pradesh, India', '[]', '8', '2026-06-05', '11:35 PM', NULL, NULL, 'fixed', 6000.00, 300.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":true,\"hide_profile\":false}', 'Expired', '2026-05-14 19:16:20', '2026-06-05 18:23:06', 'first_driver', 0),
(2627783, 13, 'Hourly/Rental', 'Sector 21, Gurugram, India', '', '[]', '9', '2026-05-16', '05:30', NULL, NULL, 'fixed', 2500.00, 10.00, 'Excluded', 'Excluded', 'Package: 12hrs/120kms. ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-15 02:36:23', '2026-05-16 00:23:28', 'first_driver', 0),
(2627784, 14, 'One Way', 'Delhi Cantt, Jail Road, Nangal Village, Delhi Cantonment, New Delhi, Delhi, India', 'Swaminarayan Ashram Rishikesh, near Ganga Kinare, Muni Ki Reti, Rishikesh, Uttarakhand, India', '[]', '9', '2026-05-16', '9:30 AM', NULL, NULL, 'fixed', 3830.00, 230.00, 'Included', 'Excluded', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-15 02:40:43', '2026-05-16 04:16:22', 'manual_selection', 0),
(2627785, 292, 'Round Trip', 'Delhi, India', 'Delhi, India', '[]', '12', '2026-05-16', '6:00 PM', '2026-05-18', '11:00 PM', 'fixed', 42000.00, 4000.00, 'Included', 'Included', 'Need \n\n20 Seater Traveller \n \n\n3 Days Tour\n\nDelhi To Sawariya Seth and Chittorgarh Fort\n\nPickup- 16 may\nNote: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-15 06:29:25', '2026-05-16 12:45:04', 'first_driver', 1),
(2627787, 14, 'Round Trip', 'Sector 31, Gurugram, Haryana, India', 'Sector 31, Gurugram, Haryana, India', '[\"Vrindavan, Uttar Pradesh, India\",\"Mathura, Uttar Pradesh, India\"]', '8', '2026-05-16', '6:00 AM', '2026-05-16', '11:59 PM', 'fixed', 4000.00, 500.00, 'Included', 'Excluded', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Accepted', '2026-05-15 09:05:52', '2026-05-15 15:48:34', 'manual_selection', 0),
(2627788, 14, 'One Way', 'Imlitala Temple, Vrindavan, Sri Premanand Road, Gotam Nagar, Vrindavan, Uttar Pradesh, India', 'Paramount Dental Centre, Outer Ring Road, Block B, Chittaranjan Park, New Delhi, Delhi, India', '[]', '8', '2026-05-18', '8:15 AM', NULL, NULL, 'fixed', 2500.00, 500.00, 'Included', 'Included', 'pickup imlitala se hi hoga. ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-15 10:25:48', '2026-05-18 03:00:15', 'first_driver', 0),
(2627789, 14, 'One Way', 'Rishikesh, Uttarakhand, India', 'Nizamuddin Railway Station Road, Jangpura, Block C, Jangpura B, Nizamuddin East, New Delhi, Delhi, India', '[]', '9', '2026-05-17', '5:00 AM', NULL, NULL, 'fixed', 3500.00, 50.00, 'Included', 'Included', 'Note: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-15 10:49:03', '2026-05-17 00:41:04', 'first_driver', 0),
(2627790, 14, 'One Way', 'Gurugram, Haryana, India', 'McLeod Ganj, Dharamshala, Himachal Pradesh, India', '[]', '8', '2026-05-16', '3:00 AM', NULL, NULL, 'fixed', 6800.00, 300.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-15 15:22:59', '2026-05-15 22:04:14', 'first_driver', 0),
(2627791, 14, 'One Way', 'Delhi, India', 'Delhi, India', '[\"Haridwar, Uttarakhand, India\",\"Sonprayag, Uttarakhand, India\"]', '12', '2026-05-16', '11:30 PM', NULL, NULL, 'fixed', 34000.00, 2000.00, 'Included', 'Included', '12 seater Tempoo traveller requirement \nonly haridwar parking extra ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-15 16:52:13', '2026-05-16 18:17:43', 'first_driver', 0),
(2627792, 195, 'Round Trip', 'Noida, Uttar Pradesh, India', 'Badrinath to noida', '[]', '11', '2026-05-16', '2:07 AM', '2026-05-20', '1:07 AM', 'fixed', 27000.00, 3000.00, 'Included', 'Included', 'Note: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":false,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-15 19:38:22', '2026-05-15 21:08:47', 'first_driver', 1),
(2627793, 195, 'Round Trip', 'Noida, Uttar Pradesh, India', 'Noida, Uttar Pradesh, India', '[\"Badrinath, Uttarakhand, India\"]', '11', '2026-05-16', '3:30 AM', '2026-05-20', '3:09 PM', 'fixed', 26000.00, NULL, 'Included', 'Included', '5 day raund trip 1000 km \nNote: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":false,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-15 21:40:07', '2026-05-15 22:46:01', 'first_driver', 1),
(2627794, 195, 'Round Trip', 'Noida, Uttar Pradesh, India', 'Noida, Uttar Pradesh, India', '[\"Kedarnath, Uttarakhand, India\"]', '11', '2026-05-16', '8:58 PM', '2026-05-20', '10:59 PM', 'fixed', 26000.00, NULL, 'Included', 'Included', 'kedarnath agar 2 jagh or jayenge 11 km to 3200 extra or badrinath jayegi to 11600 alg\nNote: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":false,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-16 05:30:15', '2026-05-16 15:44:14', 'first_driver', 1),
(2627795, 14, 'Round Trip', 'Palam, Delhi, India', 'Palam, Delhi, India', '[\"Bilari, Uttar Pradesh, India\"]', '8', '2026-05-17', '5:15 AM', '2026-05-17', '11:59 PM', 'fixed', 5000.00, 200.00, 'Included', 'Included', 'bilari k pas 10/12 km gaon me jana h ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Accepted', '2026-05-16 06:15:10', '2026-05-16 09:41:07', 'first_driver', 0),
(2627796, 14, 'Round Trip', 'Gurgaon, Haryana, India', 'Gurgaon, Haryana, India', '[]', '8', '2026-05-16', '1:00 PM', '2026-05-18', '11:59 PM', 'quote', NULL, NULL, 'Included', 'Included', 'rishikesh & kurukshetra all sightseeing including ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-16 06:16:23', '2026-05-16 07:47:40', 'manual_selection', 0),
(2627797, 14, 'Round Trip', 'Delhi, India', 'Delhi, India', '[\"Haridwar, Uttarakhand, India\",\"Sonprayag, Uttarakhand, India\"]', '9', '2026-05-16', '11:00 PM', '2026-05-20', '11:59 PM', 'fixed', 17000.00, 500.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-16 06:24:40', '2026-05-16 18:05:08', 'first_driver', 0),
(2627798, 14, 'Round Trip', 'Delhi, India', 'Delhi, India', '[\"Haridwar, Uttarakhand, India\",\"Sonprayag, Uttarakhand, India\"]', '9', '2026-05-16', '11:00 PM', '2026-05-20', '11:59 PM', 'fixed', 17000.00, 500.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-16 06:25:48', '2026-05-16 18:05:08', 'first_driver', 0),
(2627799, 14, 'One Way', 'Mansarovar, Jaipur, Rajasthan, India', 'Railway, Station Road, Gopalbari, Jaipur, Rajasthan, India', '[]', '8', '2026-05-23', '5:45 AM', NULL, NULL, 'fixed', 700.00, 200.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-16 07:21:02', '2026-05-23 00:31:26', 'first_driver', 0),
(2627802, 14, 'One Way', 'Jodhpur, Rajasthan, India', 'Greater Noida, Uttar Pradesh, India', '[]', '8', '2026-05-17', '4:00 PM', NULL, NULL, 'fixed', 8500.00, 1000.00, 'Included', 'Included', 'diggi/ cariar hona chahiye ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-16 11:03:58', '2026-05-17 10:50:58', 'first_driver', 0),
(2627803, 14, 'Hourly/Rental', 'The Bohemian Casa Dehradun, New LKD Road, Kimadi, Mussoorie, Uttarakhand, India', '', '[]', '9', '2026-05-17', '10:00 AM', NULL, NULL, 'fixed', 3500.00, 300.00, 'Included', 'Excluded', 'Package: 10hrs/100kms. extra km _ 15/-\nextra hour __ 200/-', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Accepted', '2026-05-16 14:11:29', '2026-05-16 15:36:27', 'first_driver', 0);
INSERT INTO `partner_bookings` (`id`, `partner_id`, `booking_type`, `pickup_location`, `drop_location`, `stops`, `car_type`, `start_date`, `start_time`, `end_date`, `end_time`, `pricing_option`, `total_amount`, `commission`, `toll_tax`, `parking`, `note`, `preferences`, `status`, `created_at`, `updated_at`, `approach_type`, `allow_calls`) VALUES
(2627804, 14, 'One Way', 'Haridwar, Uttarakhand, India', 'Sonprayag, Uttarakhand, India', '[]', '8', '2026-05-17', '9:15 AM', NULL, NULL, 'quote', NULL, NULL, 'Included', 'Included', 'urgent pickup h', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-17 03:09:10', '2026-05-17 04:00:03', 'manual_selection', 0),
(2627806, 14, 'One Way', 'Old Delhi Railway Station, Mori Gate, Delhi, India', 'Trident Hotel Gurgaon, Udyog Vihar Phase V Road, Phase V, Udyog Vihar, Sector 19, Gurugram, Haryana, India', '[]', '11', '2026-05-17', '2:00 PM', NULL, NULL, 'fixed', 2200.00, 50.00, 'Included', 'Excluded', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-17 06:15:13', '2026-05-17 08:56:31', 'first_driver', 0),
(2627807, 145, 'One Way', 'Dehradun Airport - Jolly grant, Airport Road, Jauligrant, Uttarakhand, India', 'Rishikesh New Railway Station, IL, Bypass Road, Indra Nagar, THDC Colony, Rishikesh, Uttarakhand, India', '[]', '9', '2026-05-18', '10:55 AM', NULL, NULL, 'fixed', 1500.00, 200.00, 'Included', 'Included', 'Note: Need Carrier/Rooftop type car.\nNote: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":true,\"hide_profile\":true}', 'Expired', '2026-05-17 11:43:34', '2026-05-18 05:40:25', 'first_driver', 1),
(2627808, 13, 'One Way', 'Sector 67, Gurgaon, Haryana, India', 'Deeg, Rajasthan, India', '[]', '8', '2026-05-17', '20:00', NULL, NULL, 'fixed', 2700.00, 200.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-17 13:46:02', '2026-05-17 14:45:38', 'first_driver', 0),
(2627809, 14, 'One Way', 'Terminal 2, Indira Gandhi International Airport, Delhi, India', 'Agra, Uttar Pradesh, India', '[]', '8', '2026-05-18', '1:30 AM', NULL, NULL, 'fixed', 2500.00, 200.00, 'Included', 'Included', 'flight 6E2413 \nflight late chal rhi late bhi ho sakti h thoda bahut ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":true,\"hide_profile\":false}', 'Expired', '2026-05-17 16:33:47', '2026-05-17 21:11:21', 'first_driver', 0),
(2627810, 13, 'One Way', 'Pitampura, Delhi, India', 'Zirakpur, Punjab, India', '[]', '8', '2026-05-18', '01:00', NULL, NULL, 'fixed', 3000.00, 300.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-17 18:51:58', '2026-05-17 19:52:28', 'first_driver', 0),
(2627811, 14, 'Round Trip', 'Hodal, Haryana, India', 'Hodal, Haryana, India', '[\"Wazirabad, Delhi, India\"]', '12', '2026-05-25', '6:00 AM', '2026-05-25', '11:59 PM', 'quote', NULL, NULL, 'Included', 'Included', '20 seater Tempoo travelar requirement ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-18 02:54:35', '2026-05-25 00:49:56', 'manual_selection', 0),
(2627812, 14, 'Hourly/Rental', 'Hometel Chandigarh, Industrial Area Phase I, Chandigarh, India', '', '[]', '7', '2026-05-19', '7:35 PM', NULL, NULL, 'fixed', 1400.00, 100.00, 'Excluded', 'Excluded', 'Package: 5hrs/50kms. ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-18 05:42:17', '2026-05-19 14:29:08', 'first_driver', 0),
(2627813, 13, 'One Way', 'Varanasi, Uttar Pradesh, India', 'Asansol, West Bengal, India', '[]', '9', '2026-05-25', '10:00', NULL, NULL, 'quote', NULL, NULL, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-18 06:14:58', '2026-05-25 04:47:53', 'manual_selection', 0),
(2627814, 14, 'One Way', 'Delhi Airport (DEL), New Delhi, Delhi, India', 'Manali, Himachal Pradesh, India', '[]', '9', '2026-05-19', '8:50 AM', NULL, NULL, 'fixed', 8500.00, 500.00, 'Included', 'Excluded', 'route dwarka expressway.', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-18 09:53:50', '2026-05-19 03:37:06', 'first_driver', 0),
(2627815, 14, 'Round Trip', 'Shimla, Himachal Pradesh, India', 'Chandigarh, India', '[\"Manali, Himachal Pradesh, India\",\"Solang Valley, Solang, Burwa, Himachal Pradesh\",\"Kasol, Himachal Pradesh, India\"]', '12', '2026-05-24', '6:00 AM', '2026-05-27', '11:59 PM', 'quote', NULL, NULL, 'Included', 'Included', '12 seater Tempoo travelar requirement \nnight me 1/2 bje drop ho sakta h.', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-18 09:57:07', '2026-05-24 00:50:07', 'manual_selection', 0),
(2627816, 14, 'One Way', 'Sector 36, Gurugram, Haryana, India', 'Dehradun, Uttarakhand, India', '[]', '8', '2026-05-22', '9:30 AM', NULL, NULL, 'fixed', 3500.00, 300.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-18 12:34:53', '2026-05-22 04:26:20', 'first_driver', 0),
(2627817, 14, 'One Way', 'Sangam Vihar, New Delhi, Delhi, India', 'Bhiwadi, Rajasthan, India', '[]', '8', '2026-05-19', '7:15 AM', NULL, NULL, 'fixed', 1600.00, 200.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-18 12:37:34', '2026-05-19 02:05:31', 'first_driver', 0),
(2627818, 14, 'One Way', 'Greater Kailash, New Delhi, Delhi, India', 'Vrindavan, Uttar Pradesh, India', '[]', '8', '2026-05-18', '8:00 PM', NULL, NULL, 'fixed', 2300.00, 300.00, 'Included', 'Included', 'urgent pickup in 30 minutes ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-18 13:18:41', '2026-05-18 14:45:33', 'first_driver', 0),
(2627819, 14, 'One Way', 'Ludhiana, Punjab, India', 'Cyber Hub, DLF Cyber City, DLF Phase 2, Sector 24, Gurugram, Haryana, India', '[]', '9', '2026-05-19', '6:00 AM', NULL, NULL, 'fixed', 4400.00, 150.00, 'Included', 'Included', 'route dwarka expressway ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-18 15:27:38', '2026-05-19 00:45:38', 'first_driver', 0),
(2627820, 14, 'One Way', 'Delhi Cantt Railway Station, Jail Road, Nangal Village, Delhi Cantonment, New Delhi, Delhi, India', 'Mussoorie, Uttarakhand, India', '[\"Haridwar, Uttarakhand, India\"]', '9', '2026-05-19', '6:00 AM', NULL, NULL, 'fixed', 6000.00, 800.00, 'Included', 'Excluded', 'haridwar waiting rhegi 30 minute', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-18 16:28:48', '2026-05-19 00:45:38', 'first_driver', 0),
(2627821, 13, 'Round Trip', 'Faridabad, Haryana, India', 'Faridabad, Haryana, India', '[\"Agra, Uttar Pradesh, India\"]', '8', '2026-05-19', '09:00', '2026-05-19', '23:59', 'fixed', 4400.00, 400.00, 'Included', 'Excluded', 'agra me 2 jagah jana h ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-18 18:43:11', '2026-05-19 03:45:19', 'first_driver', 0),
(2627822, 14, 'Round Trip', 'Budh Vihar, Delhi, India', 'Budh Vihar, Delhi, India', '[\"Chulkana Dham, Chulkana, Haryana, India\",\"Pathri Devi Temple, Islam Nagar, Pathri, Haryana, India\"]', '8', '2026-05-21', '7:30 AM', '2026-05-21', '11:59 PM', 'fixed', 3000.00, 200.00, 'Included', 'Excluded', 'chulkana and pathri mata mandir Jana h \n250 km limit h extra 11/-km', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Accepted', '2026-05-18 19:15:04', '2026-05-20 06:34:05', 'first_driver', 0),
(2627823, 14, 'One Way', 'Agra, Uttar Pradesh, India', 'Sector 51, Gurgaon, Haryana, India', '[]', '8', '2026-05-20', '9:00 AM', NULL, NULL, 'fixed', 2500.00, 300.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-19 03:59:45', '2026-05-20 03:45:29', 'first_driver', 0),
(2627824, 14, 'Round Trip', 'Ooty, Tamil Nadu, India', 'Bangalore, Karnataka, India', '[\"Misty Grove Resort, Road, Nadugani, Tamil Nadu, India\",\"Accord Highland Ooty, Doddabetta Road, Ooty, Tamil Nadu, India\"]', '8', '2026-05-26', '3:00 PM', '2026-05-28', '11:59 PM', 'fixed', 12000.00, 1000.00, 'Included', 'Excluded', '26th may pickup from ooty railway station around 3 pm \nand going to devala (misty groovy resort) \nwill cover paykara lake, boat house and any other sightseeing which we can. \n\n27th may from devala to ooty (accord highland) with all sightseeing. \n\nDay 3 28th may from ooty to bangalore (carmelaram station). \n\nyadi time hoga to banglore k 1/2 sightseeing ho sakte h ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-19 04:26:55', '2026-06-04 18:43:23', 'first_driver', 0),
(2627825, 13, 'One Way', 'Delhi, India', 'Thakurdwara, Uttar Pradesh, India', '[]', '8', '2026-05-19', '19:10', NULL, NULL, 'fixed', 3386.00, 386.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-19 04:30:17', '2026-05-19 14:00:11', 'manual_selection', 0),
(2627826, 292, 'Round Trip', 'Delhi, India', 'Delhi, India', '[]', '12', '2026-05-27', '10:00 PM', '2026-05-31', NULL, 'fixed', 36000.00, 2000.00, 'Included', 'Included', 'Need \n2 traveller 17 Seater\n\nDelhi To Macleodgang \n\n4 Days Tour\n\nPickup - 27th May Night\n\nCall me - 7042201719\n*Radhe TOUR AND TRAVELS)*\nNote: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-19 08:04:42', '2026-06-04 18:43:23', 'first_driver', 1),
(2627827, 14, 'One Way', 'Janakpuri, New Delhi, Delhi, India', 'Thapar University, Prem Nagar, Patiala, Punjab, India', '[]', '8', '2026-05-20', '12:25 PM', NULL, NULL, 'fixed', 3200.00, 200.00, 'Included', 'Included', '2023+ model cab requirement ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Accepted', '2026-05-19 10:05:17', '2026-05-19 10:50:02', 'first_driver', 0),
(2627828, 13, 'One Way', 'Haldwani, Uttarakhand, India', 'Greater Noida, Uttar Pradesh, India', '[]', '9', '2026-05-22', '08:00', NULL, NULL, 'fixed', 3500.00, 100.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-19 17:01:15', '2026-05-22 02:54:28', 'first_driver', 0),
(2627829, 13, 'Round Trip', 'Noida, Uttar Pradesh, India', 'Noida, Uttar Pradesh, India', '[\"Haridwar, Uttarakhand, India\"]', '12', '2026-05-25', '05:00', '2026-05-25', '23:59', 'quote', NULL, NULL, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-19 17:22:11', '2026-05-24 23:55:41', 'manual_selection', 0),
(2627830, 13, 'Round Trip', 'Tagore Garden, Tagore Garden Extension, Delhi, India', 'Tagore Garden, Tagore Garden Extension, Delhi, India', '[\"Nagar, Rajasthan, India\"]', '9', '2026-05-22', '07:00', '2026-05-22', '23:59', 'fixed', 5500.00, 500.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Cancelled', '2026-05-19 17:48:35', '2026-05-21 09:29:05', 'first_driver', 0),
(2627831, 257, 'Round Trip', 'Delhi, India', 'Delhi, India', '[]', '11', '2026-05-31', '7:00 AM', '2026-06-01', '10:01 AM', 'quote', NULL, NULL, 'Included', 'Included', 'time upar niche ho sakta h apna batye gadi chenj nhi honi chahiye gadi vahi lagegi customer certified karo FIR aap apna ghar bhi Ja sakte ho Jahan bhi jana hai vahan jao lekin 3 din gadi vahin rahegi customer ke sath ok bhai g jyada gadi chalegi nahin Maharaj ke Bhavan se belgaon Bharat Mandapam airport bus इधर-उधर chalegi aur ho sakta hai to parking alag karva dunga\nNote: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":true,\"hide_profile\":true}', 'Expired', '2026-05-20 02:09:55', '2026-06-04 18:43:23', 'manual_selection', 0),
(2627833, 14, 'One Way', 'Horawala, Uttarakhand, India', 'Delhi Airport (DEL), New Delhi, Delhi, India', '[]', '8', '2026-06-03', '8:30 PM', NULL, NULL, 'fixed', 4800.00, 800.00, 'Included', 'Included', 'route from delhi dehradun expressway ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-20 04:09:22', '2026-06-04 18:43:23', 'manual_selection', 0),
(2627834, 14, 'Round Trip', 'Vrindavan, Uttar Pradesh, India', 'Vrindavan, Uttar Pradesh, India', '[\"Mathura, Uttar Pradesh, India\"]', '8', '2026-05-20', '1:10 PM', '2026-05-20', '5:00 PM', 'fixed', 1600.00, 400.00, 'Excluded', 'Excluded', 'ak shoping mall me jakar ana h mathura reliance digital ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-20 07:15:43', '2026-05-20 07:55:34', 'first_driver', 0),
(2627835, 14, 'One Way', 'Horawala, Uttarakhand, India', 'Chandigarh, India', '[]', '8', '2026-05-21', '7:30 AM', NULL, NULL, 'fixed', 3000.00, 300.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-20 07:32:21', '2026-05-21 02:34:47', 'first_driver', 0),
(2627836, 14, 'One Way', 'Sector 49, Gurugram, Haryana, India', 'Nanakmatta, Uttarakhand, India', '[]', '8', '2026-06-03', '5:15 AM', NULL, NULL, 'fixed', 5000.00, 1000.00, 'Included', 'Included', '2024+ model neat & clean cab requirement \ngood behaviour driver.', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-20 09:25:39', '2026-06-04 18:43:23', 'manual_selection', 0),
(2627837, 14, 'One Way', 'Sector 49, Gurugram, Haryana, India', 'Nanakmatta, Uttarakhand, India', '[]', '9', '2026-06-03', '5:15 AM', NULL, NULL, 'fixed', 6000.00, 1300.00, 'Included', 'Included', '2024+ model neat & clean cab requirement \ngood behaviour driver.', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-20 09:29:22', '2026-06-04 18:43:23', 'first_driver', 0),
(2627838, 14, 'One Way', 'Delhi Airport (DEL), New Delhi, Delhi, India', 'Haridwar, Uttarakhand, India', '[]', '9', '2026-05-21', '4:40 PM', NULL, NULL, 'fixed', 3500.00, 100.00, 'Included', 'Excluded', 'AC properly working hona chahiye ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-20 09:36:54', '2026-05-21 11:27:49', 'first_driver', 0),
(2627839, 14, 'One Way', 'Nanakmatta, Uttarakhand, India', 'Sector 49, Gurgaon, Haryana, India', '[]', '8', '2026-06-07', '2:00 PM', NULL, NULL, 'fixed', 4500.00, 500.00, 'Included', 'Included', '2023+ model cab required \n', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-20 09:47:39', '2026-06-07 08:45:58', 'manual_selection', 0),
(2627840, 14, 'One Way', 'Noida, Uttar Pradesh, India', 'Rishikesh, Uttarakhand, India', '[\"Haridwar, Uttarakhand, India\"]', '9', '2026-05-22', '11:30 PM', NULL, NULL, 'fixed', 4150.00, 150.00, 'Included', 'Included', '30/40 minute haridwar me waiting rhegi ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-20 10:53:48', '2026-05-22 18:16:43', 'first_driver', 0),
(2627841, 14, 'One Way', 'Noida, Uttar Pradesh, India', 'Rishikesh, Uttarakhand, India', '[\"Haridwar, Uttarakhand, India\"]', '9', '2026-05-22', '11:30 PM', NULL, NULL, 'fixed', 4150.00, 150.00, 'Included', 'Included', '30/40 minutes waiting h haridwar me ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Accepted', '2026-05-20 10:55:48', '2026-05-21 11:45:25', 'first_driver', 0),
(2627842, 14, 'One Way', 'Rishikesh, Uttarakhand, India', 'Noida, Uttar Pradesh, India', '[]', '9', '2026-05-24', '5:00 PM', NULL, NULL, 'fixed', 4100.00, 200.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-20 11:02:29', '2026-05-24 11:48:05', 'first_driver', 0),
(2627843, 14, 'One Way', 'Rishikesh, Uttarakhand, India', 'Noida, Uttar Pradesh, India', '[]', '9', '2026-05-24', '5:00 PM', NULL, NULL, 'fixed', 4000.00, 200.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-20 11:29:42', '2026-05-24 11:48:05', 'first_driver', 0),
(2627844, 14, 'One Way', 'Cyber City, DLF Cyber City, DLF Phase 2, Sector 24, Gurugram, Haryana, India', 'Ludhiana, Punjab, India', '[\"Hisar, Haryana, India\",\"Jalandhar, Punjab, India\"]', '8', '2026-05-21', '6:00 AM', NULL, NULL, 'fixed', 7000.00, 300.00, 'Included', 'Excluded', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-20 16:47:04', '2026-05-21 00:45:08', 'first_driver', 0),
(2627845, 14, 'One Way', 'CP, New Delhi, Delhi, India', 'Jaipur, Rajasthan, India', '[\"Jaipur, Rajasthan, India\"]', '8', '2026-05-21', '3:00 PM', NULL, NULL, 'fixed', 3500.00, 200.00, 'Included', 'Included', 'route Mumbai expressway se jana h\nJaipur me pas pas me hi drop 2 jgah ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-20 16:48:46', '2026-05-21 09:45:07', 'first_driver', 0),
(2627847, 14, 'One Way', 'Delhi Airport (DEL), New Delhi, Delhi, India', 'Dehradun, Uttarakhand, India', '[]', '8', '2026-05-22', '10:05 PM', NULL, NULL, 'fixed', 3500.00, 300.00, 'Included', 'Excluded', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-21 05:53:51', '2026-05-22 16:50:12', 'first_driver', 0),
(2627849, 14, 'One Way', 'Patel Nagar, New Delhi, Delhi, India', 'Ahmedabad, Gujarat, India', '[]', '9', '2026-05-23', '6:30 AM', NULL, NULL, 'fixed', 16000.00, 1000.00, 'Included', 'Included', '2/3 passanger, 1 dog h customer k sath \ndelhi mumbai expressway se jana h', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-21 09:26:08', '2026-05-23 01:40:22', 'first_driver', 0),
(2627850, 14, 'One Way', 'Nanakmatta, Uttarakhand, India', 'Sector 49, Gurgaon, Haryana, India', '[]', '9', '2026-06-07', '2:00 PM', NULL, NULL, 'fixed', 5750.00, 1250.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-21 10:15:47', '2026-06-07 08:45:58', 'first_driver', 0),
(2627851, 14, 'Hourly/Rental', 'Surajpur, Greater Noida, Uttar Pradesh, India', '', '[]', '9', '2026-05-22', '8:00 AM', NULL, NULL, 'fixed', 4000.00, 800.00, 'Included', 'Excluded', 'Package: 12hrs/120kms. delhi local sightseeing \nextra km__ 12/-\nextra hour __ 150/-', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Accepted', '2026-05-21 11:59:04', '2026-05-21 14:35:05', 'manual_selection', 0),
(2627852, 14, 'One Way', 'Ambala, Haryana, India', 'Horawala, Uttarakhand, India', '[]', '8', '2026-05-24', '4:45 AM', NULL, NULL, 'fixed', 3000.00, 300.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-21 16:13:52', '2026-05-24 00:18:09', 'first_driver', 0),
(2627853, 14, 'Hourly/Rental', 'Karnataka Bhawan, Sardar Patel Marg, Diplomatic Enclave, Chanakyapuri, New Delhi, Delhi, India', '', '[]', '8', '2026-05-22', '4:00 PM', NULL, NULL, 'fixed', 1200.00, 200.00, 'Excluded', 'Excluded', 'Package: 4hrs/40kms. ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-22 05:19:21', '2026-05-22 10:45:13', 'first_driver', 0),
(2627854, 14, 'Round Trip', 'Pathankot, Punjab, India', 'Pathankot, Punjab, India', '[\"Dharamshala, Himachal Pradesh, India\",\"Macleodganj, McLeod Ganj, Dharamshala, Himachal Pradesh, India\",\"Dalhousie, Himachal Pradesh, India\",\"Khajjiar, Himachal Pradesh, India\"]', '11', '2026-06-11', '6:00 AM', '2026-06-16', '11:59 PM', 'quote', NULL, NULL, 'Included', 'Included', 'all near local sightseeing including ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-22 07:57:30', '2026-06-11 00:57:35', 'manual_selection', 0),
(2627855, 14, 'One Way', 'Cyber City, DLF Cyber City, DLF Phase 2, Sector 24, Gurugram, Haryana, India', 'Ludhiana, Punjab, India', '[\"Karol Bagh, New Delhi, Delhi, India\"]', '11', '2026-05-22', '6:15 PM', NULL, NULL, 'fixed', 7000.00, 500.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-22 11:39:50', '2026-05-22 13:00:10', 'first_driver', 0),
(2627856, 14, 'Round Trip', 'Gurugram, Haryana, India', 'Gurugram, Haryana, India', '[\"Rudraprayag, Uttarakhand, India\",\"Badrinath, Uttarakhand, India\"]', '12', '2026-05-23', '5:00 AM', '2026-05-26', '11:59 PM', 'quote', NULL, NULL, 'Included', 'Included', 'only 12 seater urbnia requirement ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-22 13:12:24', '2026-05-23 00:10:56', 'manual_selection', 0),
(2627857, 14, 'One Way', 'MOD AVENUE, Moulsari Avenue, DLF Phase 3, Sector 24, Gurugram, Haryana, India', 'New Delhi Railway Station Retiring Rooms, Ratan Lal Market, Kaseru Walan, Ajmeri Gate, New Delhi, Delhi, India', '[]', '8', '2026-05-23', '5:35 AM', NULL, NULL, 'fixed', 1000.00, 200.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-22 15:06:05', '2026-05-23 00:24:07', 'first_driver', 0),
(2627858, 14, 'One Way', 'Kadarpur, Haryana, India', 'Panchkula, Haryana, India', '[]', '8', '2026-05-23', '12:30 PM', NULL, NULL, 'fixed', 4000.00, 500.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-23 06:10:32', '2026-05-23 07:15:28', 'first_driver', 0),
(2627859, 14, 'One Way', 'Ajmeri gate, Kamla Market, Ajmeri Gate, Delhi, India', 'Nainital, Uttarakhand, India', '[]', '8', '2026-05-25', '7:30 AM', NULL, NULL, 'fixed', 4500.00, 300.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-23 06:52:00', '2026-05-25 02:18:03', 'first_driver', 0),
(2627860, 14, 'Round Trip', 'Amritsar, Punjab, India', 'Chandigarh, India', '[\"Dalhousie, Himachal Pradesh, India\",\"Dharamshala, Himachal Pradesh, India\",\"Manali, Himachal Pradesh, India\",\"Rohtang Pass, Himachal Pradesh\",\"Shimla, Himachal Pradesh, India\",\"Kufri, Himachal Pradesh, India\"]', '11', '2026-05-24', '6:00 AM', '2026-05-31', '2:00 PM', 'quote', NULL, NULL, 'Included', 'Included', '24 - Amritsar to Dalhousie\n25 - Dalhousie sight seeing \n26- Dalhousie to Manali enroute Dharamsala\n27-Manali Local Sight seeing\n28 - Snow point Rohtang\n29 - Manali to Shimla\n30 - Shimla local sightseeing + Kufri\n31 - Drop at Chandigarh at 10:30 Am', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-23 09:15:37', '2026-05-24 00:50:07', 'manual_selection', 0),
(2627861, 377, 'Round Trip', 'Ashok Vihar, Delhi, India', 'Jaipur, Rajasthan, India', '[]', '8', '2026-05-23', '3:56 AM', '2026-05-23', '3:57 PM', 'fixed', 5000.00, 200.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-23 10:28:27', '2026-05-23 10:28:33', 'first_driver', 0),
(2627862, 14, 'One Way', 'Sector 65, Gurgaon, Haryana, India', 'Baddi, Himachal Pradesh, India', '[]', '8', '2026-05-24', '7:00 AM', NULL, NULL, 'fixed', 4500.00, 300.00, 'Included', 'Included', 'time thoda uper niche ho sakta h ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-23 12:25:10', '2026-05-24 01:45:42', 'first_driver', 0),
(2627863, 14, 'One Way', 'Delhi Airport (DEL), New Delhi, Delhi, India', 'Vrindavan, Uttar Pradesh, India', '[\"Green Park, New Delhi, Delhi, India\"]', '8', '2026-05-24', '2:35 PM', NULL, NULL, 'fixed', 3500.00, 700.00, 'Included', 'Excluded', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-23 13:59:45', '2026-05-24 09:26:37', 'first_driver', 0),
(2627864, 14, 'One Way', 'Tirthan Valley, Gushaini, Himachal Pradesh, India', 'Chandigarh, India', '[]', '8', '2026-05-25', '7:30 AM', NULL, NULL, 'fixed', 5000.00, 500.00, 'Included', 'Included', 'Note: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-23 14:43:01', '2026-05-25 02:18:03', 'first_driver', 0),
(2627865, 13, 'Round Trip', 'Garhi Harsaru, Gurugram, Haryana, India', 'Garhi Harsaru, Gurugram, Haryana, India', '[\"Haridwar, Uttarakhand, India\"]', '9', '2026-05-25', '05:00', '2026-05-26', '02:00', 'fixed', 7500.00, 50.00, 'Included', 'Excluded', 'sham ko arti dekh ke return honge \n6 adult  1/2 bachhe  8/10 k h', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-24 07:45:12', '2026-05-24 23:55:41', 'first_driver', 0),
(2627866, 13, 'One Way', 'Dehradun, Uttarakhand, India', 'DLF Phase 4, Gurugram, Haryana, India', '[]', '8', '2026-05-24', '20:00', NULL, NULL, 'fixed', 3200.00, 50.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-24 13:03:08', '2026-05-24 15:06:37', 'first_driver', 0),
(2627867, 14, 'One Way', 'New Delhi Railway Station Retiring Rooms, Ratan Lal Market, Kaseru Walan, Ajmeri Gate, New Delhi, Delhi, India', 'Findoc, DLF Cyber City, DLF Phase 3, Sector 24, Gurugram, Haryana, India', '[]', '11', '2026-05-25', '11:00 AM', NULL, NULL, 'fixed', 2200.00, 200.00, 'Included', 'Excluded', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-25 02:55:17', '2026-05-25 05:45:01', 'first_driver', 0),
(2627868, 14, 'One Way', 'Sector 51, Gurgaon, Haryana, India', 'Agra, Uttar Pradesh, India', '[]', '8', '2026-05-26', '9:00 AM', NULL, NULL, 'fixed', 2500.00, 300.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-05-25 08:55:48', '2026-06-04 18:43:23', 'first_driver', 0),
(2627872, 41, 'One Way', 'AIIMS Rishikesh Trauma, Virbhadra Road, Sturida Colony, Rishikesh, Uttarakhand, India', 'Sector 28 Road, Sector 28, Chakkarpur, Gurgaon, Haryana, India', '[]', '8', '2026-06-05', '12:45 PM', NULL, NULL, 'fixed', 4000.00, 100.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":false,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-05 02:36:35', '2026-06-05 07:38:45', 'first_driver', 1),
(2627873, 14, 'Round Trip', 'Jaipur, Rajasthan, India', 'Jaipur, Rajasthan, India', '[\"Delhi, India\"]', '8', '2026-06-10', '7:45 AM', '2026-06-10', '11:59 PM', 'fixed', 6000.00, 500.00, 'Included', 'Included', 'agar new highway se updown hoga to 800 rs extra milege ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-05 03:36:37', '2026-06-10 02:30:25', 'first_driver', 1),
(2627874, 13, 'Round Trip', 'Sector 37D, Gurugram, Haryana, India', 'Sector 37, Gurugram, Haryana, India', '[\"Haridwar, Uttarakhand, India\",\"Rishikesh, Uttarakhand, India\",\"Dhanaulti, Uttarakhand, India\",\"Landour, Mussoorie, Uttarakhand, India\",\"Mussoorie, Uttarakhand, India\"]', '9', '2026-06-06', '07:00', '2026-06-11', '23:59', 'fixed', 23500.00, 500.00, 'Included', 'Excluded', 'all location sightseeing including ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-05 05:20:09', '2026-06-06 01:45:05', 'first_driver', 1),
(2627875, 14, 'Round Trip', 'Palam Vihar, Gurugram, Haryana, India', 'Palam Vihar, Gurugram, Haryana, India', '[\"Bhisi Mirzapur, Uttar Pradesh, India\"]', '9', '2026-06-07', '2:00 PM', '2026-06-09', '11:59 PM', 'fixed', 11000.00, 200.00, 'Included', 'Excluded', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Accepted', '2026-06-05 05:30:31', '2026-06-06 12:27:34', 'first_driver', 1),
(2627876, 13, 'One Way', 'Cyber City, DLF Cyber City, DLF Phase 2, Sector 24, Gurugram, Haryana, India', 'New Delhi Railway Station Retiring Rooms, Ratan Lal Market, Kaseru Walan, Ajmeri Gate, New Delhi, Delhi, India', '[]', '8', '2026-06-05', '14:30', NULL, NULL, 'fixed', 800.00, 50.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-05 08:13:10', '2026-06-05 09:16:03', 'first_driver', 1),
(2627877, 14, 'Round Trip', 'Delhi Airport (DEL), New Delhi, Delhi, India', 'Delhi Airport (DEL), New Delhi, Delhi, India', '[\"Nainital, Uttarakhand, India\",\"Almora, Uttarakhand, India\",\"Ranikhet, Uttarakhand, India\"]', '9', '2026-06-06', '9:00 AM', '2026-06-10', '11:59 PM', 'fixed', 20000.00, 500.00, 'Included', 'Excluded', 'near by 15/20 km local sightseeing including \nparking extra \nagar extra day hoga to 4000 extra milega ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-05 09:21:52', '2026-06-06 03:48:25', 'first_driver', 1),
(2627878, 14, 'One Way', 'Sector 49, Gurugram, Haryana, India', 'Delhi Airport (DEL), New Delhi, Delhi, India', '[]', '9', '2026-06-05', '5:55 PM', NULL, NULL, 'fixed', 900.00, 100.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-05 09:56:01', '2026-06-05 12:55:00', 'first_driver', 1),
(2627879, 14, 'One Way', 'Vishnu Garden, Delhi, India', 'Vrindavan, Uttar Pradesh, India', '[]', '7', '2026-07-29', '5:00 AM', NULL, NULL, 'fixed', 1780.00, 80.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Accepted', '2026-06-05 18:08:15', '2026-06-09 03:50:42', 'first_driver', 1),
(2627881, 14, 'Round Trip', 'Moradabad, Uttar Pradesh, India', 'Moradabad, Uttar Pradesh, India', '[\"Ramnagar, Uttarakhand, India\"]', '8', '2026-06-16', '9:15 AM', '2026-06-16', '11:59 PM', 'fixed', 2650.00, 150.00, 'Excluded', 'Excluded', '250 km limit extra 10 rs km \ntoll tax parking extra ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-06 06:28:53', '2026-06-16 04:05:20', 'first_driver', 0),
(2627882, 14, 'One Way', 'Ludhiana, Punjab, India', 'Dwarka, Delhi, India', '[]', '9', '2026-06-07', '12:00 PM', NULL, NULL, 'fixed', 5400.00, 900.00, 'Included', 'Included', 'route dwarka expressway \n\nNote: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-06 12:30:44', '2026-06-07 06:56:10', 'first_driver', 0),
(2627883, 14, 'One Way', 'Bindapur, Delhi, India', 'Ludhiana, Punjab, India', '[\"Rohini, Delhi, India\"]', '9', '2026-06-07', '4:30 PM', NULL, NULL, 'fixed', 4300.00, 300.00, 'Included', 'Included', 'cab neat & clean no create any complaint ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-07 02:54:25', '2026-06-07 11:20:51', 'first_driver', 0),
(2627884, 13, 'One Way', 'Terminal 3, Delhi', 'Sector 51, Chandigarh, India', '[]', '9', '2026-06-08', '20:30', NULL, NULL, 'fixed', 3662.00, 362.00, 'Included', 'Excluded', 'Note: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-07 08:15:47', '2026-06-08 17:15:09', 'first_driver', 0),
(2627885, 14, 'One Way', 'Greater Noida, Uttar Pradesh, India', 'Bareilly, Uttar Pradesh, India', '[]', '8', '2026-06-08', '8:00 AM', NULL, NULL, 'fixed', 3200.00, 300.00, 'Included', 'Included', 'Ac properly working honi chahiye \nNote: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-07 08:18:18', '2026-06-08 02:50:00', 'first_driver', 0),
(2627886, 14, 'Round Trip', 'Agra, Uttar Pradesh, India', 'Agra, Uttar Pradesh, India', '[\"RK Puram, New Delhi, Delhi, India\",\"Nanukala, Haryana, India\"]', '8', '2026-06-08', '7:00 AM', '2026-06-08', '11:59 PM', 'fixed', 6000.00, 500.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-07 14:06:48', '2026-06-08 02:06:13', 'first_driver', 0),
(2627887, 14, 'One Way', 'Delhi Airport (DEL), New Delhi, Delhi, India', 'Vrindavan, Uttar Pradesh, India', '[]', '8', '2026-06-08', '10:00 AM', NULL, NULL, 'fixed', 2500.00, 700.00, 'Included', 'Excluded', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-07 17:09:54', '2026-06-08 04:49:20', 'first_driver', 0),
(2627888, 14, 'One Way', 'Sector 15, Gurugram, Haryana, India', 'Haridwar, Uttarakhand, India', '[]', '9', '2026-06-17', '8:00 AM', NULL, NULL, 'fixed', 4020.00, 520.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-07 18:25:11', '2026-06-17 06:33:56', 'manual_selection', 0),
(2627889, 96, 'One Way', 'Vrindavan, Uttar Pradesh, India', 'Anand vihar railway station, Isbt Anand Vihar, Anand Vihar, Delhi, India', '[\"Indira Gandhi International Airport (DEL), New Delhi, Delhi, India\"]', '8', '2026-06-08', '15:00', NULL, NULL, 'fixed', 2800.00, 400.00, 'Included', 'Included', 'parking extra \nNote: Need Carrier/Rooftop type car.\nNote: Need Carrier/Rooftop type car.\nNote: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":true}', 'Expired', '2026-06-08 03:57:00', '2026-06-08 09:45:07', 'first_driver', 0),
(2627890, 145, 'One Way', 'Mahipalpur, New Delhi, Delhi, India', 'Haridwar, Uttarakhand, India', '[]', '11', '2026-06-09', '7:05 AM', NULL, NULL, 'fixed', 5000.00, 0.00, 'Excluded', 'Included', 'Note: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":true,\"hide_profile\":true}', 'Expired', '2026-06-08 07:25:48', '2026-06-09 01:50:26', 'first_driver', 1),
(2627891, 14, 'One Way', 'Peepal Apartment, Pocket-E, Sector 17 Dwarka, Dwarka, New Delhi, Delhi, India', 'Vrindavan, Uttar Pradesh, India', '[]', '8', '2026-06-13', '4:00 AM', NULL, NULL, 'fixed', 1780.00, 80.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Accepted', '2026-06-08 10:06:03', '2026-06-09 03:48:06', 'first_driver', 0),
(2627892, 14, 'Round Trip', 'Delhi, India', 'Delhi, India', '[\"Manali, Himachal Pradesh, India\",\"Atal Tunnel, Atal Tunnel, Burwa, Himachal Pradesh, India\",\"Rohtang Pass, Himachal Pradesh\",\"Sissu, Himachal Pradesh, India\"]', '12', '2026-06-12', '12:00 AM', '2026-06-16', '11:59 PM', 'quote', NULL, NULL, 'Included', 'Included', 'Please share your best transport quotation for the below requirement:\n\n🚘 Vehicle Required: 12 Seater Tempo Traveller\n\n📍 Route: Delhi – Manali – Kullu – Naggar – Rohtang / Atal Tunnel – Delhi\n📅 Travel Dates: 12 June 2026 to 16 June 2026\n👥 Pax: 7 Adults + 1 Child\n\n🗓 Tour Plan:\n\n• Day 1: Delhi Pickup & Overnight Journey to Manali\n• Day 2: Manali Local Sightseeing\n• Day 3: Kullu Valley & Naggar Excursion\n• Day 4: Rohtang Pass / Snow Point / Atal Tunnel Excursion\n• Day 5: Manali to Delhi Drop\n\n📍 Sightseeing Includes:\n• Hadimba Temple\n• Club House\n• Tibetan Monastery\n• Manu Temple\n• Mall Road\n• Kullu Valley\n• Naggar Castle\n• Rohtang / Snow Point\n• Atal Tunnel / Sissu (subject to time)\n\nPlease share:\n• Total vehicle cost\n', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-08 17:30:14', '2026-06-12 06:48:02', 'first_driver', 0),
(2627893, 13, 'One Way', 'Nizamuddin Railway Station Road, Jangpura, Block C, Jangpura B, Nizamuddin East, New Delhi, Delhi, India', 'Shimla, Himachal Pradesh, India', '[]', '9', '2026-06-09', '12:30 PM', NULL, NULL, 'fixed', 6405.00, 1205.00, 'Included', 'Included', 'Note: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-08 18:46:40', '2026-06-09 07:17:51', 'manual_selection', 0),
(2627894, 13, 'One Way', 'Palam, Delhi, India', 'Vrindavan, Uttar Pradesh, India', '[]', '8', '2026-06-10', '6:00 AM', NULL, NULL, 'fixed', 1772.00, 122.00, 'Included', 'Excluded', 'Note: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-08 19:43:17', '2026-06-10 00:45:19', 'first_driver', 0),
(2627895, 14, 'One Way', 'Faridabad, Haryana, India', 'Srinagar, Uttarakhand, India', '[]', '9', '2026-06-10', '11:30 PM', NULL, NULL, 'fixed', 7210.00, 710.00, 'Included', 'Included', '7 passanger h . 363 km limit extra 14 rs km \nNote: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-10 01:56:53', '2026-06-10 18:15:42', 'manual_selection', 0),
(2627896, 14, 'Round Trip', 'Gurugram, Haryana, India', 'Gurugram, Haryana, India', '[\"Dalhousie, Himachal Pradesh, India\",\"Khajjiar, Himachal Pradesh, India\",\"Dharamshala, Himachal Pradesh, India\",\"Macleodganj, McLeod Ganj, Dharamshala, Himachal Pradesh, India\"]', '12', '2026-06-12', '10:00 AM', '2026-06-17', '11:59 PM', 'quote', NULL, NULL, 'Included', 'Included', '17 seater Tempoo travelar requirement \nlocation sightseeing including \n1400 km limit\nNote: Need Carrier/Rooftop type car.\nNote: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-10 05:59:21', '2026-06-12 05:35:31', 'first_driver', 0),
(2627897, 13, 'One Way', 'Udaipur, Rajasthan, India', 'Bareilly, Uttar Pradesh, India', '[]', '8', '2026-06-13', '5:30 AM', NULL, NULL, 'fixed', 11500.00, 1000.00, 'Included', 'Included', '1/2 bird\'s h passanger k sath \nNote: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-10 06:26:48', '2026-06-13 07:57:46', 'manual_selection', 0),
(2627899, 14, 'One Way', 'Sector 110, Gurugram, Haryana, India', 'Haldwani, Uttarakhand, India', '[]', '9', '2026-06-12', '5:30 AM', NULL, NULL, 'fixed', 4216.00, 416.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-11 06:54:45', '2026-06-12 05:35:31', 'first_driver', 0),
(2627900, 14, 'One Way', 'Ludhiana, Punjab, India', 'Cyber City, DLF Cyber City, DLF Phase 2, Sector 24, Gurugram, Haryana, India', '[\"Rohini, Delhi, India\",\"Madhu Vihar, Delhi, India\"]', '9', '2026-06-11', '5:15 PM', NULL, NULL, 'fixed', 5500.00, 100.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-11 10:22:33', '2026-06-11 12:05:19', 'first_driver', 0),
(2627901, 14, 'One Way', 'Vrindavan, Uttar Pradesh, India', 'Ghaziabad, Uttar Pradesh, India', '[]', '8', '2026-06-14', '9:00 AM', NULL, NULL, 'fixed', 2300.00, 300.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-12 12:34:33', '2026-06-14 03:45:21', 'first_driver', 0),
(2627902, 14, 'One Way', 'Vrindavan, Uttar Pradesh, India', 'Airport (T-3), Indira Gandhi International Airport (DEL), Terminal 2, Delhi, हवाईअड्डा, Delhi, India', '[]', '8', '2026-06-13', '2:30 PM', NULL, NULL, 'fixed', 2800.00, 800.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-12 13:04:54', '2026-06-13 09:44:32', 'first_driver', 0),
(2627903, 14, 'One Way', 'Dehradun, Uttarakhand, India', 'Airport (T-3), Indira Gandhi International Airport (DEL), Terminal 2, Delhi, हवाईअड्डा, Delhi, India', '[]', '8', '2026-06-13', '8:30 AM', NULL, NULL, 'fixed', 3500.00, 500.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-12 13:05:31', '2026-06-13 07:57:46', 'first_driver', 0),
(2627904, 14, 'Round Trip', 'Sector 42, Gurgaon, Haryana, India', 'Sector 42, Gurugram, Haryana, India', '[\"Haridwar, Uttarakhand, India\"]', '8', '2026-06-13', '5:00 AM', '2026-06-13', '11:59 PM', 'quote', NULL, NULL, 'Included', 'Excluded', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-12 13:09:29', '2026-06-13 07:57:46', 'manual_selection', 0),
(2627905, 14, 'Hourly/Rental', 'Delhi Airport (DEL), New Delhi, Delhi, India', '', '[]', '11', '2026-06-13', '8:45 AM', NULL, NULL, 'fixed', 2700.00, 200.00, 'Excluded', 'Excluded', 'Package: 8hrs/80kms. extra km __ 20/-\nextra hour __ 180/-\n\nkm limit pickup to pickup', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-12 15:05:18', '2026-06-13 07:57:46', 'first_driver', 0),
(2627906, 14, 'One Way', 'Sector 26, Gurgaon, Haryana, India', 'Rishikesh bus station, Adarsh Gram, Rishikesh, Uttarakhand, India', '[]', '9', '2026-06-14', '8:00 AM', NULL, NULL, 'fixed', 4085.00, 385.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-13 12:03:58', '2026-06-14 02:46:47', 'first_driver', 0),
(2627907, 14, 'One Way', 'Moradabad, Uttar Pradesh, India', 'Sagarpur, New Delhi, Delhi, India', '[]', '8', '2026-06-14', '1:00 PM', NULL, NULL, 'fixed', 2300.00, 300.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-13 13:33:04', '2026-06-14 07:52:08', 'first_driver', 0),
(2627908, 14, 'One Way', 'Aligarh, Uttar Pradesh, India', 'Bareilly, Uttar Pradesh, India', '[]', '8', '2026-06-14', '11:00 PM', NULL, NULL, 'fixed', 3000.00, 400.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-13 16:13:44', '2026-06-14 17:47:15', 'first_driver', 0),
(2627909, 13, 'One Way', 'ऋषिकेश, Uttarakhand, India', 'पहाड़गंज, New Delhi, Delhi, India', '[]', '9', '2026-06-14', '6:00 AM', NULL, NULL, 'fixed', 5090.00, 890.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-13 18:48:25', '2026-06-14 00:49:55', 'manual_selection', 0),
(2627910, 13, 'One Way', 'Rampur, Uttar Pradesh, India', 'Delhi Airport (DEL), New Delhi, Delhi, India', '[]', '8', '2026-06-14', '2:00 PM', NULL, NULL, 'fixed', 2700.00, 300.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-14 04:52:46', '2026-06-14 09:04:13', 'manual_selection', 0),
(2627911, 14, 'One Way', 'Chhatarpur, New Delhi, Delhi, India', 'Ramnagar, Uttarakhand, India', '[]', '9', '2026-06-15', '5:50 AM', NULL, NULL, 'fixed', 3800.00, 300.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-14 05:58:13', '2026-06-15 00:38:58', 'first_driver', 0),
(2627912, 14, 'One Way', 'Sector 23, Gurugram, Haryana, India', 'Kathgodam, Haldwani, Uttarakhand, India', '[]', '9', '2026-06-16', '6:30 AM', NULL, NULL, 'fixed', 5000.00, 800.00, 'Included', 'Included', 'Note: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-14 10:11:28', '2026-06-16 01:15:36', 'manual_selection', 0),
(2627914, 14, 'One Way', 'Vrindavan, Uttar Pradesh, India', 'Ghaziabad, Uttar Pradesh, India', '[]', '8', '2026-06-15', '9:00 AM', NULL, NULL, 'fixed', 2300.00, 300.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-14 10:20:38', '2026-06-15 04:24:05', 'first_driver', 0),
(2627916, 14, 'One Way', 'Dayal Bagh Colony, Faridabad, Haryana, India', 'Township mathura, Ronchi Bangar, Mathura, Uttar Pradesh, India', '[]', '8', '2026-06-15', '3:30 PM', NULL, NULL, 'fixed', 2200.00, 400.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-15 05:12:58', '2026-06-15 10:15:39', 'first_driver', 0),
(2627917, 14, 'One Way', 'The Park Hotel, Sansad Marg, Hanuman Road Area, Connaught Place, New Delhi, Delhi, India', 'Delhi Airport (DEL), New Delhi, Delhi, India', '[]', '11', '2026-06-16', '6:00 AM', NULL, NULL, 'fixed', 1800.00, 150.00, 'Included', 'Included', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-15 09:05:55', '2026-06-16 01:04:41', 'first_driver', 0),
(2627918, 14, 'One Way', 'Saharanpur, Uttar Pradesh, India', 'Mussoorie, Uttarakhand, India', '[]', '9', '2026-06-17', '7:00 AM', NULL, NULL, 'fixed', 3677.00, 477.00, 'Included', 'Excluded', '102 km limit extra 14 rs km ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Expired', '2026-06-16 07:41:52', '2026-06-17 06:33:56', 'first_driver', 0),
(2627919, 14, 'One Way', 'Saharanpur Railway Station SRE, Sabungaran Street, Mehandi Sarai, Saharanpur, Uttar Pradesh, India', 'Mussoorie, Uttarakhand, India', '[]', '9', '2026-06-18', '7:00 AM', NULL, NULL, 'fixed', 3676.00, 476.00, 'Included', 'Included', '102 km limit extra 14 rs km \nNote: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Open', '2026-06-17 07:32:27', '2026-06-17 07:32:29', 'first_driver', 0),
(2627920, 14, 'Round Trip', 'Delhi, India', 'Delhi, India', '[\"Rishikesh, Uttarakhand, India\",\"Mussoorie, Uttarakhand, India\",\"Dehradun, Uttarakhand, India\"]', '9', '2026-07-01', '12:01 AM', '2026-07-04', '11:59 PM', 'fixed', 16200.00, 1000.00, 'Included', 'Excluded', 'Pickup location:- Delhi \n\nDay 1_ Delhi to Rishikesh \nRishikesh Ganga Aarti dekh kar\n drive to Mussoorie\n\nDay 2& 3\n\nall local sightseeing including.\nSurkanda Devi temple (optional)\n\nDay 4 \n\nDehradun sahastradhara sightseeing\n\nDrop location:- Delhi\n\nPickup :- 01/07/2026 @ 12:00 am\nDrop :- 04/07/2026 @ 11:59 pm \n\nCab type :- Ertiga (6+1) \n\nParking excluded on actual\nNote: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Accepted', '2026-06-17 07:46:05', '2026-06-17 10:52:03', 'manual_selection', 0),
(2627921, 14, 'Round Trip', 'Jiva Institute of Vedic Studies, Sheetal Chhaya Road, Raman Reiti, Vrindavan, Mathura, Uttar Pradesh, India', 'Jiva Institute of Vedic Studies, Sheetal Chhaya Road, Raman Reiti, Vrindavan, Mathura, Uttar Pradesh, India', '[\"Lohagard Fort Bharatpur (Maharaja Surajmal Smarak) Bharatpur., Bihari ka Mindair, Lohagarh Fort, Gopalgarh, Bharatpur, Rajasthan, India\"]', '8', '2026-06-18', '10:00 AM', '2026-06-18', '5:00 PM', 'fixed', 2500.00, 300.00, 'Included', 'Excluded', '', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Open', '2026-06-17 10:49:46', '2026-06-17 10:49:49', 'first_driver', 0),
(2627922, 14, 'One Way', 'Delhi Airport (DEL), New Delhi, Delhi, India', 'Agra, Uttar Pradesh, India', '[]', '8', '2026-06-18', '2:00 AM', NULL, NULL, 'fixed', 2200.00, 200.00, 'Included', 'Excluded', 'Note: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Open', '2026-06-17 10:52:13', '2026-06-17 10:52:15', 'first_driver', 0);
INSERT INTO `partner_bookings` (`id`, `partner_id`, `booking_type`, `pickup_location`, `drop_location`, `stops`, `car_type`, `start_date`, `start_time`, `end_date`, `end_time`, `pricing_option`, `total_amount`, `commission`, `toll_tax`, `parking`, `note`, `preferences`, `status`, `created_at`, `updated_at`, `approach_type`, `allow_calls`) VALUES
(2627923, 14, 'One Way', 'Rajiv Chowk Flyover, Shanti Nagar, Hans Enclave, Sector 11, Gurugram, Haryana, India', 'Anand vihar railway station, Isbt Anand Vihar, Anand Vihar, Delhi, India', '[]', '9', '2026-06-19', '4:55 AM', NULL, NULL, 'fixed', 1400.00, 350.00, 'Included', 'Included', 'Note: Need Carrier/Rooftop type car.\nNote: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Open', '2026-06-17 10:56:29', '2026-06-17 10:57:02', 'first_driver', 0),
(2627924, 13, 'One Way', 'Uttam Nagar, Delhi, India', 'Mussoorie, Uttarakhand, India', '[]', '9', '2026-06-18', '3:50 AM', NULL, NULL, 'fixed', 4700.00, 200.00, 'Included', 'Included', 'Note: Need Carrier/Rooftop type car.', '{\"carrier_rooftop\":true,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":true}', 'Open', '2026-06-17 11:13:40', '2026-06-17 11:13:44', 'first_driver', 0),
(2627925, 14, 'Hourly/Rental', 'Connaught Place, New Delhi, Delhi, India', '', '[]', '8', '2026-06-18', '9:00 AM', NULL, NULL, 'fixed', 1700.00, 200.00, 'Excluded', 'Excluded', 'Package: 8hrs/80kms. extra km__ 11/-\nextra hours 120/-\n\n2023+ model cab requirement ', '{\"carrier_rooftop\":false,\"ac_included\":true,\"airport_parking\":false,\"hide_profile\":false}', 'Open', '2026-06-17 12:46:40', '2026-06-17 12:47:03', 'first_driver', 0);

-- --------------------------------------------------------

--
-- Table structure for table `partner_booking_popups_seen`
--

CREATE TABLE `partner_booking_popups_seen` (
  `id` int(11) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `seen_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `partner_booking_popups_seen`
--

INSERT INTO `partner_booking_popups_seen` (`id`, `partner_id`, `booking_id`, `seen_at`) VALUES
(1, 14, 2627637, '2026-05-08 20:53:09'),
(2, 14, 2627639, '2026-05-08 20:53:14'),
(3, 14, 2627647, '2026-05-08 20:53:39'),
(4, 4, 2627637, '2026-05-09 17:04:23'),
(5, 4, 2627639, '2026-05-09 17:04:31'),
(6, 4, 2627647, '2026-05-09 17:04:43');

-- --------------------------------------------------------

--
-- Table structure for table `partner_deposits`
--

CREATE TABLE `partner_deposits` (
  `id` int(11) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `razorpay_order_id` varchar(100) DEFAULT NULL,
  `razorpay_payment_id` varchar(100) DEFAULT NULL,
  `razorpay_signature` text DEFAULT NULL,
  `status` enum('Pending','Success','Failed') DEFAULT 'Pending',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `partner_deposits`
--

INSERT INTO `partner_deposits` (`id`, `partner_id`, `amount`, `razorpay_order_id`, `razorpay_payment_id`, `razorpay_signature`, `status`, `created_at`) VALUES
(1, 4, 1.00, 'order_SZQeI1XuAukcrV', 'pay_SZQeW8MpOR84il', '6591c4912581bc9b65f3635fa982f1238fdc4ba615205992bb66be7911d6d9e8', 'Success', '2026-04-04 13:16:17'),
(2, 4, 100.00, 'order_SZQvQsjOevD4to', NULL, NULL, 'Pending', '2026-04-04 13:32:31'),
(3, 9, 1.00, 'order_SZR48ud8Bc7xpF', 'pay_SZR4WAduIrBQJ3', '74cb64d1a34fa3b228ab976997be8f06a434c12dec82a00c1442ca5ba0797530', 'Success', '2026-04-04 13:40:45'),
(4, 4, 100.00, 'order_SZRHRxkDG9Ye9x', NULL, NULL, 'Pending', '2026-04-04 13:53:21'),
(5, 9, 1.00, 'order_SZRLFHOx3s2W3Q', NULL, NULL, 'Pending', '2026-04-04 13:56:57'),
(6, 4, 100.00, 'order_SZRLPWqxg00BIh', NULL, NULL, 'Pending', '2026-04-04 13:57:06'),
(7, 9, 1.00, 'order_SZRM8hXFn02hR3', 'pay_SZRMJp2qR3Jgco', 'dd6c03a4ccb37061633d6f590593b5ddf341d4d50cba975fc45b9847754da0d6', 'Success', '2026-04-04 13:57:48'),
(8, 4, 500.00, 'order_SZTR7okQOHUpeI', NULL, NULL, 'Pending', '2026-04-04 15:59:54'),
(9, 4, 500.00, 'order_SZYnDz2Un6tOgL', NULL, NULL, 'Pending', '2026-04-04 21:14:17'),
(10, 13, 500.00, 'order_SloAIbl0MfxDoN', NULL, NULL, 'Pending', '2026-05-05 20:04:34'),
(11, 21, 300.00, 'order_Sml9V7YFjAmSj8', 'pay_SmlAPwErdradgy', 'fcf7f53a31268c881c97a066d16d14301bcf10e4ab3c84e7a8dfdbe360ba65c7', 'Success', '2026-05-08 05:46:43'),
(12, 21, 100.00, 'order_SmlBao2m8zXBaQ', 'pay_SmlBi4plsTXR04', '41b34b2daa8330aa7bb5a348ae1511b4993499c767c98a64a7ad229089c30c40', 'Success', '2026-05-08 05:48:42'),
(13, 95, 300.00, 'order_Sn53TmjchcVMbr', NULL, NULL, 'Pending', '2026-05-09 01:14:54'),
(14, 95, 300.00, 'order_Sn53oaDn98MZZB', NULL, NULL, 'Pending', '2026-05-09 01:15:13'),
(15, 85, 550.00, 'order_Sn90ARMCPk8Fwx', NULL, NULL, 'Pending', '2026-05-09 05:06:32'),
(16, 85, 550.00, 'order_Sn90cwHpz59hZd', 'pay_Sn90kCp58cNX1S', '51930b6c71d8ace337a0e01ce71f853d30174d5110c698f748c7efb5b21c4fdd', 'Success', '2026-05-09 05:06:58'),
(17, 85, 300.00, 'order_Sn92DoKFYCl2gh', 'pay_Sn92LJKwCdig9l', '9356ba008f03fee63aecfc4c31eb2be1f9613cc45411116a7836eb4b7bb16ea7', 'Success', '2026-05-09 05:08:29'),
(18, 28, 600.00, 'order_SoVLcFXvEPc2Ab', 'pay_SoVLpfpMxp1UVR', '83d078f084ce2bf949ee89c97e06a0053880d2ec9b353b927215ae1b474810d1', 'Success', '2026-05-12 15:37:06'),
(19, 28, 300.00, 'order_SoVNebE2NSYxHu', 'pay_SoVNidUC6sH7po', '04210a1befff19eabbdd53e609fdee923900498879dd00265e7ea10a3d8c9d1a', 'Success', '2026-05-12 15:39:02'),
(20, 145, 30.00, 'order_SoqNVftn6zr6GR', NULL, NULL, 'Pending', '2026-05-13 12:11:27'),
(21, 102, 800.00, 'order_Sp8boEDrvAi7Wq', NULL, NULL, 'Pending', '2026-05-14 06:01:29'),
(22, 102, 600.00, 'order_Sp8d6UbCHHVRqH', 'pay_Sp8dAduNqpjZSZ', 'addc7e8055467acdd1457c8ea43eebd83a96ee919df0822bc41f1e8e543dac84', 'Success', '2026-05-14 06:02:42'),
(23, 102, 50.00, 'order_Sp8xNpns5aLVS8', NULL, NULL, 'Pending', '2026-05-14 06:21:54'),
(24, 252, 20.00, 'order_SpC77dsVKiTSER', 'pay_SpC7WbSVL1Nucf', '51aecab036328ea9137523ca081d74def18696f8fbe15a9f8dfe0fcbc59dfcab', 'Success', '2026-05-14 09:27:12'),
(25, 252, 400.00, 'order_SpCEiHmlpBfhX6', NULL, NULL, 'Pending', '2026-05-14 09:34:23'),
(26, 277, 100.00, 'order_SpIiIkpbpgHHQm', 'pay_SpIj0DtJh8Be9a', '2a9be9c849849da36033b275d355fe2253d12a55cf738ffef0a2190925d60628', 'Success', '2026-05-14 15:54:34'),
(27, 88, 150.00, 'order_SpXOxz7eVbLGtT', 'pay_SpXPFipGVfhycM', '5ea88630c5e3db26b970f8a67ab5801156734373dc4846f08aa598ec91fcb0ad', 'Success', '2026-05-15 06:16:40'),
(28, 28, 1300.00, 'order_SpYvD3XJJg7aPa', 'pay_SpYvOv3f7SzpQt', '47d62cf3a910459be5be5905c9bc1c58536e729d27882227ae08af4344646952', 'Success', '2026-05-15 07:45:53'),
(29, 277, 800.00, 'order_SpbM1yHjf9CTC5', 'pay_SpbMMkpBVcZucz', 'ede9e6a64850ba490f214f0552c65f8f431d67e49d195d7314b09b580ba32ee9', 'Success', '2026-05-15 10:08:39'),
(30, 313, 500.00, 'order_Sph777Tzs464WB', 'pay_Sph7beDB17Maob', 'e3e69bad6436fa8884dcb71a45aee43f58787fe48fb67737bcab825b7186a701', 'Success', '2026-05-15 15:46:42'),
(31, 309, 50.00, 'order_SpwxvnQ7Div8Ho', NULL, NULL, 'Pending', '2026-05-16 07:17:06'),
(32, 309, 50.00, 'order_SpwyDggLFJwHg5', NULL, NULL, 'Pending', '2026-05-16 07:17:22'),
(33, 50, 230.00, 'order_SpzDyvwhUerqra', 'pay_SpzECXPRXZVort', 'f3f74fa8e1675a7a69c0ff60ee5d3cc85fe41a06cad5e3076ebfa217a0aa52a7', 'Success', '2026-05-16 09:29:41'),
(34, 95, 200.00, 'order_Sq3GhHxByW4keS', NULL, NULL, 'Pending', '2026-05-16 13:27:02'),
(35, 95, 200.00, 'order_Sq3I2ksUg8NXmC', NULL, NULL, 'Pending', '2026-05-16 13:28:18'),
(36, 95, 150.00, 'order_Sq3J6PdKJwmoOm', NULL, NULL, 'Pending', '2026-05-16 13:29:18'),
(37, 95, 200.00, 'order_Sq3Mv9eYXd8ZpT', NULL, NULL, 'Pending', '2026-05-16 13:32:55'),
(38, 377, 500.00, 'order_SrWFXyGU3OHTCZ', NULL, NULL, 'Pending', '2026-05-20 06:27:03'),
(39, 377, 500.00, 'order_SrWGWrmTZzdYj2', 'pay_SrWH2ERMv3r1Lh', '8300f500f24eab9f44b474a4d57906cc81171fcf9ec74f299346640609b01706', 'Success', '2026-05-20 06:27:59'),
(40, 377, 15.00, 'order_SrWLVIELYzxYZu', 'pay_SrWLdBmp0aRCLz', '44d9e8384b828f95412a4efa92134c56e386cb5070aef9f29aa1a91cbfdfd11b', 'Success', '2026-05-20 06:32:42'),
(41, 409, 500.00, 'order_SsiSzJTfefjTBX', NULL, NULL, 'Pending', '2026-05-23 07:03:06'),
(42, 410, 100.00, 'order_SsiqJNy1QwfRUW', NULL, NULL, 'Pending', '2026-05-23 07:25:11'),
(43, 28, 400.00, 'order_T2elxI5UkwgGvK', 'pay_T2em7484CBIn8e', 'd53a4ab1517d9ce4361372c13e15c8c121b4e0c05c82e339c62f35bba74a2a79', 'Success', '2026-06-17 09:56:18'),
(44, 28, 300.00, 'order_T2fhxhjQQWnyfB', 'pay_T2fiBxXNMtvfRc', '7a56e889e242bfee2f66a6e3f9ec90e195a251b8c5f84218c4f7e6eef1f95d31', 'Success', '2026-06-17 10:51:13');

-- --------------------------------------------------------

--
-- Table structure for table `partner_notices_seen`
--

CREATE TABLE `partner_notices_seen` (
  `id` int(11) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `notice_id` int(11) NOT NULL,
  `seen_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `partner_notices_seen`
--

INSERT INTO `partner_notices_seen` (`id`, `partner_id`, `notice_id`, `seen_at`) VALUES
(1, 14, 1, '2026-05-08 20:56:35'),
(2, 14, 2, '2026-05-08 21:02:16'),
(3, 4, 2, '2026-05-09 17:00:40'),
(4, 116, 2, '2026-05-09 18:54:31'),
(5, 13, 2, '2026-05-10 15:02:48'),
(6, 41, 2, '2026-05-13 10:15:51'),
(7, 151, 2, '2026-05-13 11:18:12'),
(9, 25, 2, '2026-05-13 11:27:30'),
(10, 179, 2, '2026-05-13 11:38:03'),
(11, 37, 2, '2026-05-13 11:42:53'),
(12, 63, 2, '2026-05-13 11:43:06'),
(13, 20, 2, '2026-05-13 12:22:23'),
(14, 188, 2, '2026-05-13 13:07:01'),
(15, 91, 2, '2026-05-13 13:32:37'),
(16, 26, 2, '2026-05-13 13:36:32'),
(17, 28, 2, '2026-05-13 14:05:20'),
(18, 65, 2, '2026-05-13 14:07:14'),
(19, 102, 2, '2026-05-13 14:07:57'),
(20, 21, 2, '2026-05-13 14:39:09'),
(21, 182, 2, '2026-05-13 16:24:19'),
(22, 110, 2, '2026-05-13 16:46:06'),
(23, 212, 2, '2026-05-13 16:47:40'),
(24, 29, 2, '2026-05-13 17:37:51'),
(25, 113, 2, '2026-05-13 17:50:16'),
(26, 140, 2, '2026-05-13 18:37:01'),
(27, 204, 2, '2026-05-13 18:39:49'),
(28, 94, 2, '2026-05-13 19:20:13'),
(29, 77, 2, '2026-05-13 19:38:48'),
(30, 75, 2, '2026-05-13 20:12:52'),
(31, 31, 2, '2026-05-13 22:37:13'),
(32, 143, 2, '2026-05-13 23:27:08'),
(33, 107, 2, '2026-05-14 01:07:10'),
(34, 240, 2, '2026-05-14 01:50:51'),
(35, 100, 2, '2026-05-14 02:23:06'),
(36, 40, 2, '2026-05-14 03:01:44'),
(37, 232, 2, '2026-05-14 03:02:55'),
(38, 243, 2, '2026-05-14 03:31:11'),
(39, 101, 2, '2026-05-14 03:57:13'),
(40, 23, 2, '2026-05-14 04:25:15'),
(41, 162, 2, '2026-05-14 04:43:15'),
(42, 153, 2, '2026-05-14 05:17:35'),
(43, 246, 2, '2026-05-14 05:21:33'),
(44, 57, 2, '2026-05-14 05:30:21'),
(45, 145, 2, '2026-05-14 05:31:11'),
(46, 95, 2, '2026-05-14 05:33:16'),
(47, 117, 2, '2026-05-14 05:49:29'),
(48, 30, 2, '2026-05-14 05:53:18'),
(49, 170, 2, '2026-05-14 05:53:19'),
(50, 122, 2, '2026-05-14 05:56:35'),
(51, 168, 2, '2026-05-14 05:58:04'),
(52, 213, 2, '2026-05-14 05:58:35'),
(53, 88, 2, '2026-05-14 06:02:33'),
(54, 24, 2, '2026-05-14 06:14:19'),
(55, 82, 2, '2026-05-14 06:26:42'),
(56, 160, 2, '2026-05-14 06:33:29'),
(57, 22, 2, '2026-05-14 06:33:55'),
(58, 248, 2, '2026-05-14 06:39:14'),
(59, 36, 2, '2026-05-14 06:40:25'),
(60, 175, 2, '2026-05-14 06:59:30'),
(61, 253, 2, '2026-05-14 07:17:59'),
(62, 255, 2, '2026-05-14 07:27:06'),
(63, 257, 2, '2026-05-14 07:27:49'),
(64, 256, 2, '2026-05-14 07:28:49'),
(65, 258, 2, '2026-05-14 07:29:11'),
(66, 195, 2, '2026-05-14 07:33:50'),
(67, 156, 2, '2026-05-14 07:34:28'),
(68, 259, 2, '2026-05-14 07:48:34'),
(69, 142, 2, '2026-05-14 08:32:44'),
(70, 167, 2, '2026-05-14 08:33:18'),
(71, 85, 2, '2026-05-14 08:43:35'),
(72, 71, 2, '2026-05-14 08:47:50'),
(73, 227, 2, '2026-05-14 09:03:42'),
(74, 32, 2, '2026-05-14 09:10:04'),
(75, 260, 2, '2026-05-14 09:11:40'),
(76, 252, 2, '2026-05-14 09:16:16'),
(77, 194, 2, '2026-05-14 09:18:26'),
(78, 196, 2, '2026-05-14 09:21:00'),
(79, 35, 2, '2026-05-14 09:21:49'),
(80, 176, 2, '2026-05-14 09:41:15'),
(81, 262, 2, '2026-05-14 09:48:35'),
(82, 50, 2, '2026-05-14 09:49:30'),
(83, 216, 2, '2026-05-14 10:04:05'),
(84, 161, 2, '2026-05-14 10:06:09'),
(85, 250, 2, '2026-05-14 10:06:39'),
(86, 251, 2, '2026-05-14 10:44:00'),
(87, 264, 2, '2026-05-14 11:01:33'),
(88, 187, 2, '2026-05-14 11:11:45'),
(89, 263, 2, '2026-05-14 11:16:55'),
(90, 67, 2, '2026-05-14 11:36:33'),
(91, 79, 2, '2026-05-14 11:53:26'),
(92, 225, 2, '2026-05-14 12:17:24'),
(93, 112, 2, '2026-05-14 13:38:53'),
(94, 58, 2, '2026-05-14 14:17:02'),
(95, 149, 2, '2026-05-14 14:39:53'),
(96, 106, 2, '2026-05-14 15:09:23'),
(97, 152, 2, '2026-05-14 15:33:40'),
(98, 271, 2, '2026-05-14 15:41:50'),
(99, 276, 2, '2026-05-14 15:48:35'),
(100, 277, 2, '2026-05-14 15:50:56'),
(101, 180, 2, '2026-05-14 15:54:46'),
(102, 281, 2, '2026-05-14 15:59:41'),
(103, 279, 2, '2026-05-14 16:13:46'),
(104, 284, 2, '2026-05-14 16:15:23'),
(105, 70, 2, '2026-05-14 16:34:40'),
(106, 288, 2, '2026-05-14 17:00:35'),
(107, 289, 2, '2026-05-14 17:00:38'),
(108, 292, 2, '2026-05-14 17:56:40'),
(109, 103, 2, '2026-05-14 18:24:29'),
(110, 294, 2, '2026-05-14 18:27:00'),
(111, 274, 2, '2026-05-14 18:36:25'),
(112, 239, 2, '2026-05-14 19:59:57'),
(113, 99, 2, '2026-05-15 01:37:03'),
(114, 47, 2, '2026-05-15 03:03:20'),
(115, 300, 2, '2026-05-15 03:49:41'),
(116, 280, 2, '2026-05-15 06:10:48'),
(117, 72, 2, '2026-05-15 06:19:03'),
(118, 286, 2, '2026-05-15 06:36:02'),
(119, 267, 2, '2026-05-15 07:39:20'),
(120, 205, 2, '2026-05-15 08:15:11'),
(121, 305, 2, '2026-05-15 09:07:16'),
(122, 287, 2, '2026-05-15 09:08:37'),
(123, 191, 2, '2026-05-15 09:19:04'),
(124, 69, 2, '2026-05-15 09:37:09'),
(125, 283, 2, '2026-05-15 10:46:50'),
(126, 135, 2, '2026-05-15 12:32:33'),
(127, 311, 2, '2026-05-15 12:43:28'),
(128, 312, 2, '2026-05-15 12:57:42'),
(129, 119, 2, '2026-05-15 13:29:43'),
(130, 307, 2, '2026-05-15 13:44:49'),
(131, 313, 2, '2026-05-15 15:23:11'),
(132, 314, 2, '2026-05-15 15:26:52'),
(133, 44, 2, '2026-05-15 16:54:03'),
(134, 39, 2, '2026-05-15 19:08:54'),
(135, 316, 2, '2026-05-15 21:42:30'),
(136, 96, 2, '2026-05-16 00:50:55'),
(137, 38, 2, '2026-05-16 02:28:08'),
(138, 315, 2, '2026-05-16 03:09:35'),
(139, 318, 2, '2026-05-16 04:09:59'),
(140, 214, 2, '2026-05-16 04:37:44'),
(141, 201, 2, '2026-05-16 06:31:39'),
(142, 309, 2, '2026-05-16 07:11:32'),
(143, 320, 2, '2026-05-16 07:33:35'),
(144, 56, 2, '2026-05-16 08:02:52'),
(145, 322, 2, '2026-05-16 08:04:22'),
(146, 132, 2, '2026-05-16 08:11:02'),
(147, 325, 2, '2026-05-16 13:07:03'),
(148, 327, 2, '2026-05-16 13:21:06'),
(149, 328, 2, '2026-05-16 13:26:06'),
(150, 329, 2, '2026-05-16 13:31:37'),
(151, 331, 2, '2026-05-16 13:40:11'),
(152, 330, 2, '2026-05-16 13:42:05'),
(153, 245, 2, '2026-05-16 14:13:17'),
(154, 333, 2, '2026-05-16 14:56:25'),
(155, 223, 2, '2026-05-16 15:33:13'),
(156, 334, 2, '2026-05-16 16:33:45'),
(157, 336, 2, '2026-05-16 16:59:18'),
(158, 209, 2, '2026-05-16 17:42:41'),
(159, 339, 2, '2026-05-16 18:14:13'),
(160, 165, 2, '2026-05-16 18:21:55'),
(161, 310, 2, '2026-05-16 21:36:59'),
(162, 342, 2, '2026-05-17 04:04:49'),
(163, 343, 2, '2026-05-17 05:32:51'),
(164, 345, 2, '2026-05-17 05:52:21'),
(165, 268, 2, '2026-05-17 06:23:22'),
(166, 340, 2, '2026-05-17 06:46:59'),
(167, 53, 2, '2026-05-17 10:59:53'),
(168, 206, 2, '2026-05-17 11:43:51'),
(169, 341, 2, '2026-05-17 12:09:38'),
(170, 347, 2, '2026-05-17 12:43:17'),
(171, 193, 2, '2026-05-17 12:49:02'),
(172, 129, 2, '2026-05-17 15:12:41'),
(173, 349, 2, '2026-05-17 19:07:27'),
(174, 350, 2, '2026-05-18 01:11:38'),
(175, 348, 2, '2026-05-18 03:55:34'),
(176, 266, 2, '2026-05-18 04:36:41'),
(177, 136, 2, '2026-05-18 08:52:09'),
(178, 269, 2, '2026-05-18 09:31:32'),
(179, 354, 2, '2026-05-18 09:55:02'),
(180, 189, 2, '2026-05-18 10:33:05'),
(181, 178, 2, '2026-05-18 12:20:43'),
(182, 359, 2, '2026-05-18 13:51:24'),
(183, 197, 2, '2026-05-18 15:06:31'),
(184, 360, 2, '2026-05-18 15:39:00'),
(185, 229, 2, '2026-05-18 16:29:10'),
(186, 356, 2, '2026-05-18 16:29:17'),
(187, 207, 2, '2026-05-18 17:10:22'),
(188, 362, 2, '2026-05-18 20:13:57'),
(189, 364, 2, '2026-05-19 01:32:54'),
(190, 83, 2, '2026-05-19 04:13:31'),
(191, 365, 2, '2026-05-19 04:30:14'),
(192, 199, 2, '2026-05-19 05:01:05'),
(193, 319, 2, '2026-05-19 07:34:01'),
(194, 221, 2, '2026-05-19 12:49:21'),
(195, 374, 2, '2026-05-19 16:03:23'),
(196, 235, 2, '2026-05-19 16:40:46'),
(197, 198, 2, '2026-05-19 16:52:33'),
(198, 369, 2, '2026-05-19 17:22:40'),
(199, 111, 2, '2026-05-19 17:43:48'),
(200, 376, 2, '2026-05-19 19:00:02'),
(201, 370, 2, '2026-05-20 01:33:54'),
(202, 366, 2, '2026-05-20 03:09:16'),
(203, 87, 2, '2026-05-20 04:41:55'),
(204, 377, 2, '2026-05-20 05:41:40'),
(205, 381, 2, '2026-05-20 09:40:48'),
(206, 378, 2, '2026-05-20 10:39:46'),
(207, 368, 2, '2026-05-20 13:50:10'),
(208, 379, 2, '2026-05-20 16:53:30'),
(209, 384, 2, '2026-05-20 17:14:55'),
(210, 385, 2, '2026-05-20 17:23:29'),
(211, 386, 2, '2026-05-20 17:39:15'),
(212, 344, 2, '2026-05-21 01:00:55'),
(213, 390, 2, '2026-05-21 03:23:01'),
(214, 389, 2, '2026-05-21 03:23:28'),
(215, 391, 2, '2026-05-21 04:58:40'),
(216, 392, 2, '2026-05-21 07:06:38'),
(217, 394, 2, '2026-05-21 12:42:44'),
(218, 78, 2, '2026-05-21 12:56:13'),
(219, 397, 2, '2026-05-21 16:18:20'),
(220, 298, 2, '2026-05-21 17:21:46'),
(221, 398, 2, '2026-05-21 21:57:37'),
(222, 400, 2, '2026-05-21 23:30:22'),
(223, 401, 2, '2026-05-22 02:55:45'),
(224, 402, 2, '2026-05-22 03:00:59'),
(225, 290, 2, '2026-05-22 05:19:45'),
(226, 346, 2, '2026-05-22 08:40:56'),
(227, 337, 2, '2026-05-22 12:31:15'),
(228, 49, 2, '2026-05-22 13:22:46'),
(229, 403, 2, '2026-05-22 14:10:50'),
(230, 157, 2, '2026-05-23 01:32:20'),
(231, 409, 2, '2026-05-23 06:57:46'),
(232, 410, 2, '2026-05-23 07:06:29'),
(233, 393, 2, '2026-05-23 07:19:39'),
(234, 352, 2, '2026-05-23 13:08:44'),
(235, 92, 2, '2026-05-23 14:49:11'),
(236, 236, 2, '2026-05-24 06:49:12'),
(237, 131, 2, '2026-05-24 16:59:03'),
(238, 414, 2, '2026-05-25 07:23:24'),
(239, 395, 2, '2026-05-25 09:56:46'),
(240, 420, 2, '2026-05-25 15:38:05'),
(241, 423, 2, '2026-05-25 16:32:55'),
(242, 387, 2, '2026-05-25 16:58:59'),
(243, 459, 2, '2026-06-04 23:13:05'),
(244, 474, 2, '2026-06-05 00:41:26'),
(245, 467, 2, '2026-06-05 02:00:21'),
(246, 437, 2, '2026-06-05 02:32:37'),
(247, 504, 2, '2026-06-05 02:57:47'),
(248, 487, 2, '2026-06-05 03:04:03'),
(249, 464, 2, '2026-06-05 03:06:06'),
(250, 431, 2, '2026-06-05 06:44:23'),
(251, 515, 2, '2026-06-05 06:53:17'),
(252, 499, 2, '2026-06-05 12:29:46'),
(253, 442, 2, '2026-06-05 12:39:38'),
(254, 469, 2, '2026-06-05 13:35:20'),
(255, 466, 2, '2026-06-05 15:08:15'),
(256, 511, 2, '2026-06-05 16:09:02'),
(257, 430, 2, '2026-06-05 19:11:58'),
(258, 495, 2, '2026-06-06 08:17:30'),
(260, 62, 2, '2026-06-06 13:42:55'),
(261, 427, 2, '2026-06-06 17:14:51'),
(262, 121, 2, '2026-06-06 21:01:33'),
(263, 173, 2, '2026-06-07 12:48:32'),
(264, 382, 2, '2026-06-08 02:30:24'),
(265, 475, 2, '2026-06-08 04:25:17'),
(266, 426, 2, '2026-06-08 06:55:59'),
(267, 68, 2, '2026-06-08 07:47:18'),
(268, 470, 2, '2026-06-08 17:45:50'),
(269, 461, 2, '2026-06-09 10:51:44'),
(270, 222, 2, '2026-06-09 13:45:20'),
(271, 485, 2, '2026-06-09 14:57:19'),
(272, 488, 2, '2026-06-10 02:45:04'),
(273, 438, 2, '2026-06-10 06:00:19'),
(274, 447, 2, '2026-06-13 13:20:31'),
(275, 482, 2, '2026-06-13 14:16:17'),
(276, 484, 2, '2026-06-13 18:43:54'),
(277, 13, 3, '2026-06-13 18:46:49'),
(278, 57, 3, '2026-06-13 19:01:19'),
(279, 484, 3, '2026-06-13 19:04:49'),
(280, 14, 3, '2026-06-13 19:08:05'),
(281, 86, 3, '2026-06-13 20:18:22'),
(282, 464, 3, '2026-06-13 21:19:24'),
(283, 65, 3, '2026-06-14 00:49:58'),
(284, 102, 3, '2026-06-14 00:53:38'),
(285, 53, 3, '2026-06-14 00:55:31'),
(286, 488, 3, '2026-06-14 01:04:56'),
(287, 132, 3, '2026-06-14 01:09:18'),
(288, 235, 3, '2026-06-14 01:31:52'),
(289, 41, 3, '2026-06-14 02:14:46'),
(290, 83, 3, '2026-06-14 02:35:49'),
(291, 36, 3, '2026-06-14 03:04:04'),
(292, 21, 3, '2026-06-14 03:05:52'),
(293, 4, 3, '2026-06-14 03:43:34'),
(294, 511, 3, '2026-06-14 03:57:44'),
(295, 447, 3, '2026-06-14 04:47:25'),
(296, 466, 3, '2026-06-14 04:58:15'),
(297, 25, 3, '2026-06-14 05:00:31'),
(298, 175, 3, '2026-06-14 05:21:26'),
(299, 343, 3, '2026-06-14 05:56:21'),
(300, 145, 3, '2026-06-14 05:58:53'),
(301, 305, 3, '2026-06-14 06:00:36'),
(302, 79, 3, '2026-06-14 06:05:28'),
(303, 188, 3, '2026-06-14 06:08:18'),
(304, 489, 3, '2026-06-14 06:14:54'),
(305, 30, 3, '2026-06-14 06:32:36'),
(306, 136, 3, '2026-06-14 06:36:51'),
(307, 364, 3, '2026-06-14 06:54:53'),
(308, 341, 3, '2026-06-14 07:54:54'),
(309, 442, 3, '2026-06-14 08:31:04'),
(310, 37, 3, '2026-06-14 09:16:51'),
(311, 207, 3, '2026-06-14 09:29:17'),
(312, 140, 3, '2026-06-14 10:11:55'),
(313, 485, 3, '2026-06-14 10:14:31'),
(314, 252, 3, '2026-06-14 10:17:54'),
(315, 95, 3, '2026-06-14 10:21:44'),
(317, 227, 3, '2026-06-14 10:24:43'),
(318, 250, 3, '2026-06-14 10:34:14'),
(319, 448, 3, '2026-06-14 11:06:19'),
(320, 24, 3, '2026-06-14 11:26:40'),
(321, 386, 3, '2026-06-14 11:38:34'),
(322, 49, 3, '2026-06-14 12:05:26'),
(323, 316, 3, '2026-06-14 12:17:46'),
(324, 20, 3, '2026-06-14 12:47:56'),
(325, 410, 3, '2026-06-14 12:48:42'),
(326, 277, 3, '2026-06-14 13:15:28'),
(327, 28, 3, '2026-06-14 13:33:23'),
(328, 420, 3, '2026-06-14 13:34:56'),
(329, 110, 3, '2026-06-14 13:44:11'),
(330, 504, 3, '2026-06-14 13:48:33'),
(331, 31, 3, '2026-06-14 13:55:34'),
(332, 161, 3, '2026-06-14 14:04:11'),
(333, 162, 3, '2026-06-14 14:19:16'),
(334, 336, 3, '2026-06-14 14:49:34'),
(335, 47, 3, '2026-06-14 16:05:00'),
(336, 40, 3, '2026-06-14 16:52:45'),
(337, 44, 3, '2026-06-14 17:05:03'),
(338, 360, 3, '2026-06-14 17:47:22'),
(339, 197, 3, '2026-06-14 18:32:49'),
(340, 378, 3, '2026-06-15 00:21:51'),
(341, 499, 3, '2026-06-15 01:43:16'),
(342, 50, 3, '2026-06-15 05:46:15'),
(344, 257, 3, '2026-06-15 06:51:09'),
(345, 368, 3, '2026-06-15 07:07:58'),
(346, 379, 3, '2026-06-15 08:35:17'),
(347, 85, 3, '2026-06-15 09:38:36'),
(348, 350, 3, '2026-06-15 10:35:24'),
(349, 482, 3, '2026-06-15 10:43:52'),
(350, 179, 3, '2026-06-15 11:09:31'),
(351, 143, 3, '2026-06-15 15:16:56'),
(352, 99, 3, '2026-06-15 15:41:58'),
(353, 26, 3, '2026-06-15 18:16:33'),
(354, 509, 3, '2026-06-15 19:17:28'),
(355, 471, 3, '2026-06-16 04:56:25'),
(356, 54, 3, '2026-06-16 05:09:59'),
(357, 151, 3, '2026-06-16 06:24:30'),
(358, 96, 3, '2026-06-16 08:30:34'),
(359, 279, 3, '2026-06-16 10:26:07'),
(360, 337, 3, '2026-06-16 11:09:01'),
(361, 390, 3, '2026-06-17 06:52:00'),
(362, 178, 3, '2026-06-17 07:25:21'),
(363, 260, 3, '2026-06-17 07:46:52'),
(364, 29, 3, '2026-06-17 07:48:27'),
(365, 58, 3, '2026-06-17 07:51:00'),
(366, 112, 3, '2026-06-17 07:51:49'),
(367, 313, 3, '2026-06-17 07:51:53'),
(368, 437, 3, '2026-06-17 08:07:01'),
(369, 94, 3, '2026-06-17 08:22:13'),
(370, 263, 3, '2026-06-17 09:30:11'),
(371, 514, 3, '2026-06-17 10:51:05'),
(372, 391, 3, '2026-06-17 10:52:26'),
(373, 167, 3, '2026-06-17 11:08:59'),
(374, 43, 3, '2026-06-17 12:51:43'),
(375, 314, 3, '2026-06-17 12:59:58'),
(376, 121, 3, '2026-06-17 14:35:16'),
(377, 75, 3, '2026-06-17 14:42:06');

-- --------------------------------------------------------

--
-- Table structure for table `partner_ratings`
--

CREATE TABLE `partner_ratings` (
  `id` int(11) NOT NULL,
  `reviewer_id` int(11) NOT NULL,
  `reviewed_id` int(11) NOT NULL,
  `booking_id` int(11) DEFAULT NULL,
  `rating` tinyint(4) NOT NULL CHECK (`rating` between 1 and 5),
  `review_text` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `partner_ratings`
--

INSERT INTO `partner_ratings` (`id`, `reviewer_id`, `reviewed_id`, `booking_id`, `rating`, `review_text`, `created_at`) VALUES
(1, 4, 9, NULL, 5, 'Great Experience I have Got with the manish', '2026-04-07 11:15:28'),
(2, 4, 9, NULL, 5, 'great', '2026-04-07 11:26:31'),
(3, 4, 9, NULL, 5, 'excellent work 👍', '2026-04-07 11:34:44'),
(4, 9, 4, NULL, 5, '', '2026-04-07 12:54:55'),
(5, 4, 9, NULL, 5, 'great service I have got from the manish regarding driver service', '2026-04-07 12:55:02'),
(6, 12, 4, NULL, 5, 'great job', '2026-04-12 08:23:20'),
(7, 14, 4, 2627637, 5, 'Excellent Service', '2026-04-23 20:55:01'),
(8, 4, 14, 2627652, 5, 'Excellent driver behaviour', '2026-05-05 12:49:13');

-- --------------------------------------------------------

--
-- Table structure for table `partner_subscriptions`
--

CREATE TABLE `partner_subscriptions` (
  `id` int(11) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `plan_id` int(11) NOT NULL,
  `razorpay_payment_id` varchar(255) NOT NULL,
  `razorpay_order_id` varchar(255) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` enum('active','expired','cancelled','pending') DEFAULT 'active',
  `start_date` datetime NOT NULL,
  `expiry_date` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `partner_subscriptions`
--

INSERT INTO `partner_subscriptions` (`id`, `partner_id`, `plan_id`, `razorpay_payment_id`, `razorpay_order_id`, `amount`, `status`, `start_date`, `expiry_date`, `created_at`) VALUES
(1, 4, 1, 'pay_SZu9MfiWLn3Bmm', 'order_SZu9FPEVt8CN2i', 1.00, 'expired', '2026-04-05 18:08:17', '2026-05-03 18:08:17', '2026-04-05 18:08:17'),
(2, 9, 1, 'pay_SZuKDPhmY7jZXa', 'order_SZuK5OAvO8HVEn', 1.00, 'active', '2026-04-05 18:18:30', '2026-05-05 18:18:30', '2026-04-05 18:18:30'),
(3, 4, 1, 'pay_SZuMEcbhfeaazP', 'order_SZuM9GOFLDj44w', 1.00, 'active', '2026-04-05 18:20:34', '2026-05-05 18:20:34', '2026-04-05 18:20:34');

-- --------------------------------------------------------

--
-- Table structure for table `partner_subscription_plans`
--

CREATE TABLE `partner_subscription_plans` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `duration_value` int(11) NOT NULL,
  `duration_unit` enum('days','months','years') NOT NULL,
  `terms` text DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `partner_subscription_plans`
--

INSERT INTO `partner_subscription_plans` (`id`, `name`, `price`, `duration_value`, `duration_unit`, `terms`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Basic Plan ', 199.00, 30, 'days', '<p>Note Money Will Not be Refundable&nbsp;</p>\r\n', 'inactive', '2026-04-05 17:47:53', '2026-04-05 19:56:26'),
(2, 'Standard Plan', 549.00, 90, 'days', '<p>Note Money Will Not be Refundable&nbsp;</p>\r\n', 'inactive', '2026-04-05 19:55:25', '2026-04-05 19:58:18'),
(3, 'Premium Plan', 1099.00, 180, 'days', '<p>Note Money Will Not be Refundable&nbsp;</p>\r\n', 'inactive', '2026-04-05 19:57:48', '2026-04-05 19:58:02');

-- --------------------------------------------------------

--
-- Table structure for table `partner_transactions`
--

CREATE TABLE `partner_transactions` (
  `id` int(11) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `type` enum('Credit','Debit') NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `source` enum('Deposit','Withdrawal','Booking','Bonus','Penalty','Commission') NOT NULL,
  `source_id` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `partner_transactions`
--

INSERT INTO `partner_transactions` (`id`, `partner_id`, `type`, `amount`, `source`, `source_id`, `description`, `created_at`) VALUES
(1, 4, 'Credit', 1.00, 'Deposit', 1, 'Fund added via Razorpay (pay_SZQeW8MpOR84il)', '2026-04-04 13:16:55'),
(2, 9, 'Credit', 1.00, 'Deposit', 3, 'Fund added via Razorpay (pay_SZR4WAduIrBQJ3)', '2026-04-04 13:41:35'),
(3, 4, 'Debit', 100.00, 'Withdrawal', 5, 'Withdrawal request submitted', '2026-04-04 13:53:08'),
(4, 4, 'Debit', 100.00, 'Withdrawal', 6, 'Withdrawal request submitted', '2026-04-04 13:53:36'),
(5, 9, 'Credit', 1.00, 'Deposit', 7, 'Fund added via Razorpay (pay_SZRMJp2qR3Jgco)', '2026-04-04 13:58:20'),
(6, 9, 'Debit', 1000.00, 'Withdrawal', 7, 'Withdrawal request submitted', '2026-04-04 14:03:21'),
(7, 4, 'Debit', 5.00, 'Withdrawal', 8, 'Withdrawal request submitted', '2026-04-04 16:00:36'),
(8, 4, 'Debit', 50.00, '', 3, 'Commission for Booking #2627606', '2026-04-06 20:11:48'),
(9, 9, 'Debit', 200.00, '', 4, 'Commission for Booking #2627607', '2026-04-07 13:33:59'),
(10, 4, 'Debit', 300.00, '', 5, 'Commission for Booking #2627608', '2026-04-07 13:56:37'),
(11, 4, 'Debit', 300.00, '', 6, 'Commission for Booking #2627608', '2026-04-07 13:57:11'),
(12, 9, 'Debit', 1.00, '', 7, 'Commission for Booking #2627609', '2026-04-07 17:08:03'),
(13, 4, 'Debit', 1.00, '', 8, 'Commission for Booking #2627610', '2026-04-07 18:20:37'),
(14, 9, 'Debit', 1.00, '', 9, 'Commission for Booking #2627611', '2026-04-07 18:27:49'),
(15, 9, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: ARSHAD AHMAD', '2026-04-07 18:53:51'),
(16, 9, 'Debit', 7.50, '', NULL, 'Registration fee for Vehicle: DREAM NEO (HR31H8982)', '2026-04-07 18:58:54'),
(17, 9, 'Debit', 0.00, '', 0, 'Commission payment for Booking #2627612 via Razorpay', '2026-04-07 19:09:50'),
(18, 9, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: MOHAN  LAL', '2026-04-08 08:18:30'),
(19, 4, 'Debit', 50.00, '', 11, 'Commission for Booking #2627613', '2026-04-08 19:53:27'),
(20, 9, 'Debit', 20.00, '', 12, 'Commission for Booking #2627614', '2026-04-09 13:01:56'),
(21, 9, 'Debit', 10.00, '', 13, 'Commission for Booking #2627615', '2026-04-10 08:34:47'),
(22, 9, 'Debit', 200.00, '', 14, 'Commission for Booking #2627617', '2026-04-11 21:04:27'),
(23, 9, 'Debit', 2000.00, '', 15, 'Commission for Booking #2627618', '2026-04-11 21:27:22'),
(24, 14, 'Debit', 7.50, '', NULL, 'Registration fee for Vehicle: TOUR S STD(O) CNG (RJ53TA0074)', '2026-04-12 15:45:37'),
(25, 14, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: MANISH  KUMAR', '2026-04-12 15:46:59'),
(26, 14, 'Debit', 100.00, '', 16, 'Commission for Booking #2627622', '2026-04-12 15:56:53'),
(27, 15, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: PRAVESH  CHANDER', '2026-04-14 07:40:47'),
(28, 15, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: HR31H8982', '2026-04-14 07:52:27'),
(29, 14, 'Credit', 100.00, '', 16, 'Refund for Cancelling Booking #2627622', '2026-04-19 16:43:33'),
(30, 14, 'Debit', 100.00, '', 17, 'Commission for Booking #2627622', '2026-04-19 17:22:16'),
(31, 14, 'Debit', 10.00, '', 18, 'Commission for Booking #2627636', '2026-04-21 19:00:02'),
(32, 14, 'Credit', 10.00, '', 18, 'Refund for Cancelling Booking #2627636', '2026-04-21 19:00:22'),
(33, 14, 'Debit', 10.00, '', 19, 'Commission for Booking #2627636', '2026-04-21 19:09:54'),
(34, 14, 'Debit', 100.00, 'Penalty', 19, 'Penalty for Cancelling Booking #2627636 after 8 minutes', '2026-04-21 19:17:20'),
(35, 14, 'Credit', 10.00, '', 19, 'Refund for Cancelling Booking #2627636', '2026-04-21 19:17:20'),
(36, 4, 'Debit', 20.00, '', 20, 'Commission for Booking #2627637', '2026-04-22 16:58:35'),
(37, 4, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: PB01A4737', '2026-04-22 17:00:23'),
(38, 4, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: HR68C5759', '2026-04-22 17:02:51'),
(39, 14, 'Credit', 20.00, '', 20, 'Commission for Booking #2627637 (Trip Completed)', '2026-04-22 17:07:44'),
(40, 14, 'Debit', 20.00, '', 21, 'Commission for Booking #2627639', '2026-04-24 15:50:35'),
(41, 4, 'Credit', 20.00, '', 21, 'Commission for Booking #2627639 (Trip Completed)', '2026-04-24 15:51:36'),
(42, 13, 'Credit', 100.00, '', 17, 'Commission for Booking #2627622 (Trip Completed)', '2026-04-24 15:53:32'),
(43, 4, 'Credit', 20.00, '', 21, 'Commission for Booking #2627639 (Trip Completed)', '2026-04-24 16:57:31'),
(44, 4, 'Debit', 300.00, '', 22, 'Commission for Booking #2627640', '2026-04-25 14:07:44'),
(45, 14, 'Debit', 200.00, '', 23, 'Commission for Booking #2627647', '2026-04-26 07:12:14'),
(46, 14, 'Debit', 100.00, '', 24, 'Commission for Booking #2627650', '2026-04-26 07:34:49'),
(47, 4, 'Credit', 100.00, '', 24, 'Commission for Booking #2627650 (Trip Completed)', '2026-04-26 11:12:02'),
(48, 4, 'Credit', 200.00, '', 23, 'Commission for Booking #2627647 (Trip Completed)', '2026-04-26 11:33:07'),
(49, 14, 'Credit', 40000.00, '', NULL, 'Admin Adjustment', '2026-04-26 18:58:19'),
(50, 14, 'Debit', 50.00, '', 25, 'Commission for Booking #2627652', '2026-04-27 18:55:16'),
(51, 14, 'Debit', 50.00, '', 26, 'Commission for Booking #2627652', '2026-04-27 18:55:23'),
(52, 14, 'Debit', 50.00, '', 27, 'Commission for Booking #2627652', '2026-04-27 19:00:09'),
(53, 4, 'Credit', 100.00, '', 24, 'Commission for Booking #2627650 (Trip Completed)', '2026-04-27 19:06:00'),
(54, 4, 'Credit', 200.00, '', 23, 'Commission for Booking #2627647 (Trip Completed)', '2026-04-27 19:08:24'),
(55, 4, 'Credit', 50.00, '', 25, 'Commission for Booking #2627652 (Trip Completed)', '2026-04-27 19:10:48'),
(56, 4, 'Debit', 100.00, 'Withdrawal', 9, 'Withdrawal request submitted', '2026-04-28 18:40:09'),
(57, 4, 'Debit', 50.00, 'Withdrawal', 10, 'Withdrawal request submitted (Processing)', '2026-04-28 19:11:32'),
(58, 4, 'Debit', 50.00, 'Withdrawal', 11, 'Withdrawal request submitted (Processing)', '2026-04-28 19:11:34'),
(59, 4, 'Debit', 50.00, 'Withdrawal', 12, 'Withdrawal request submitted (Processing)', '2026-04-28 19:11:47'),
(60, 4, 'Debit', 100.00, 'Withdrawal', 13, 'Withdrawal request submitted (Processing)', '2026-04-28 19:40:30'),
(61, 4, 'Debit', 50.00, 'Withdrawal', 14, 'Withdrawal request submitted (Processing)', '2026-04-28 19:41:06'),
(62, 4, 'Debit', 55.00, 'Withdrawal', 15, 'Withdrawal request submitted (Processing)', '2026-04-28 19:48:12'),
(63, 20, 'Credit', 500.00, '', NULL, 'Balance bring  over from the previous app', '2026-05-05 13:56:51'),
(64, 23, 'Credit', 100.00, '', NULL, 'Balance bearing from previous app', '2026-05-05 14:55:11'),
(65, 24, 'Credit', 1000.00, '', NULL, 'Bearing balance previous app', '2026-05-05 14:58:49'),
(66, 26, 'Credit', 150.00, '', NULL, 'Balance bering from previous app', '2026-05-05 15:00:21'),
(67, 25, 'Credit', 150.00, '', NULL, 'Bering balance  from previous app', '2026-05-05 15:05:13'),
(68, 29, 'Credit', 900.00, '', NULL, 'bering balance from previous app', '2026-05-05 16:17:44'),
(69, 30, 'Credit', 300.00, '', NULL, 'Bering balance from previous app', '2026-05-05 16:29:27'),
(70, 24, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: HR55BB0491', '2026-05-06 06:41:09'),
(71, 24, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: AKHILESH KUMAR PATEL', '2026-05-06 06:47:00'),
(72, 14, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: HR46E6758', '2026-05-06 06:47:37'),
(73, 24, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: ATINDER PAL SINGH', '2026-05-06 06:50:17'),
(74, 24, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: BIJENDER  KUMAR', '2026-05-06 06:52:43'),
(75, 24, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: JAIPAL VERMA', '2026-05-06 06:54:18'),
(76, 24, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: SONU  KUMAR', '2026-05-06 06:55:41'),
(77, 24, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: MUKESH  PATEL', '2026-05-06 06:57:20'),
(78, 24, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: RAM  SINGH', '2026-05-06 07:01:08'),
(79, 24, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: PREMLAL  MANJHI', '2026-05-06 07:03:02'),
(80, 24, 'Debit', 500.00, '', 28, 'Commission for Booking ID-2627660', '2026-05-06 07:04:39'),
(81, 24, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: SUNIL KUMAR YADAV', '2026-05-06 07:10:10'),
(82, 24, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: RAMESH KUMAR CHAUHAN', '2026-05-06 07:18:17'),
(83, 24, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: JASWANT  SINGH', '2026-05-06 07:24:42'),
(84, 24, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: DEEPAK', '2026-05-06 07:25:56'),
(85, 24, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: GAJENDRA', '2026-05-06 07:27:38'),
(86, 24, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: VIDHAN SINGH', '2026-05-06 07:28:46'),
(87, 24, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: RAVI  KUMAR', '2026-05-06 07:36:37'),
(88, 24, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: SATYAM  SINGH', '2026-05-06 07:39:43'),
(89, 14, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: HR74A4491', '2026-05-06 07:41:18'),
(90, 24, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: CHANDAN KUMAR', '2026-05-06 07:44:03'),
(91, 24, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: HR38AH4456', '2026-05-06 07:45:41'),
(92, 24, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: HR69F0265', '2026-05-06 07:48:00'),
(93, 24, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: SHIVAM', '2026-05-06 07:54:50'),
(94, 65, 'Credit', 400.00, '', NULL, 'This balance bering from previous app', '2026-05-06 08:33:26'),
(95, 29, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: RJ01 TA 5304', '2026-05-06 11:56:53'),
(96, 67, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: MAROOF ALI', '2026-05-06 14:12:24'),
(97, 67, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: HR67E9785', '2026-05-06 14:13:01'),
(98, 21, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: UP14ST4009', '2026-05-06 17:08:02'),
(99, 21, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: UP14RT8489', '2026-05-06 17:08:55'),
(100, 21, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: SALMAN', '2026-05-06 17:11:30'),
(101, 72, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: HR55AH1009', '2026-05-07 05:18:00'),
(102, 72, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: BALESHWAR  SHARMA', '2026-05-07 05:21:13'),
(103, 75, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: MOSEEM RAO', '2026-05-07 07:00:53'),
(104, 75, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: HR58C1560', '2026-05-07 07:01:14'),
(105, 14, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: HR55BB9183', '2026-05-07 10:49:01'),
(106, 14, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: DL1VC6754', '2026-05-07 10:59:16'),
(107, 14, 'Debit', 10.00, '', 29, 'Commission for Booking ID-2627686', '2026-05-07 20:37:42'),
(108, 4, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: HR55BC1321', '2026-05-07 20:42:39'),
(109, 4, 'Debit', 5.00, '', 30, 'Commission for Booking ID-2627688', '2026-05-07 20:43:07'),
(110, 4, 'Debit', 20.00, '', 31, 'Commission for Booking ID-2627689', '2026-05-07 20:51:30'),
(111, 4, 'Debit', 10.00, '', 32, 'Commission for Booking ID-2627690', '2026-05-07 20:53:15'),
(112, 117, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: ANWAR  KHAN', '2026-05-08 02:09:47'),
(113, 117, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: HR38AF0552', '2026-05-08 02:11:08'),
(114, 79, 'Credit', 975.00, '', NULL, 'Bearing balance from previous app', '2026-05-08 05:14:45'),
(115, 21, 'Credit', 300.00, 'Deposit', 11, 'Fund added via Razorpay (pay_SmlAPwErdradgy)', '2026-05-08 05:48:04'),
(116, 21, 'Credit', 100.00, 'Deposit', 12, 'Fund added via Razorpay (pay_SmlBi4plsTXR04)', '2026-05-08 05:49:20'),
(117, 21, 'Debit', 200.00, '', 0, 'Commission payment for Booking ID-2627691 via Razorpay', '2026-05-08 05:50:51'),
(118, 88, 'Credit', 200.00, '', NULL, 'Bering balance from previous app', '2026-05-08 12:28:57'),
(119, 100, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: HR47G9745', '2026-05-08 17:32:08'),
(120, 85, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: PB01C2250', '2026-05-08 17:53:27'),
(121, 85, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: ANIKET  BAWA', '2026-05-08 17:58:19'),
(122, 95, 'Credit', 100.00, '', NULL, 'Bering balance from previous app ', '2026-05-08 18:03:05'),
(123, 95, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: DL1ZD8581', '2026-05-08 18:04:04'),
(124, 95, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: DL1ZD8581', '2026-05-08 18:04:50'),
(125, 14, 'Debit', 250.00, '', 34, 'Commission for Booking ID-2627683', '2026-05-08 18:07:29'),
(126, 14, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: DL1VC6754', '2026-05-08 19:27:06'),
(127, 14, 'Debit', 500.00, '', 35, 'Commission for Booking ID-2627693', '2026-05-08 19:49:11'),
(128, 14, 'Debit', 500.00, 'Penalty', 35, 'Penalty for Cancelling Booking ID-2627693 after 18 minutes', '2026-05-08 20:06:45'),
(129, 14, 'Credit', 500.00, '', 35, 'Refund for Cancelling Booking ID-2627693', '2026-05-08 20:06:45'),
(130, 95, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: DL1ZD8581', '2026-05-09 00:44:38'),
(131, 95, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: RAMJAN', '2026-05-09 00:47:47'),
(132, 77, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: HR38AH6433', '2026-05-09 01:11:12'),
(133, 101, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: SHYAM  SUNDAR', '2026-05-09 01:23:44'),
(134, 101, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: UP85BT5291', '2026-05-09 01:24:08'),
(135, 127, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: GA03V0728', '2026-05-09 01:46:55'),
(136, 43, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: HR55BC6289', '2026-05-09 03:17:59'),
(137, 31, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: AMAR  KUMAR', '2026-05-09 03:20:06'),
(138, 31, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: DL1ZD2704', '2026-05-09 03:20:57'),
(139, 31, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: DL1ZD2704', '2026-05-09 03:22:47'),
(140, 21, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: PB01F3761', '2026-05-09 04:07:02'),
(141, 21, 'Debit', 300.00, '', 0, 'Commission payment for Booking ID-2627695 via Razorpay', '2026-05-09 04:08:21'),
(142, 95, 'Credit', 300.00, '', NULL, 'Pay via rezorpay ', '2026-05-09 05:00:45'),
(143, 85, 'Credit', 550.00, 'Deposit', 16, 'Fund added via Razorpay (pay_Sn90kCp58cNX1S)', '2026-05-09 05:07:38'),
(144, 85, 'Credit', 300.00, 'Deposit', 17, 'Fund added via Razorpay (pay_Sn92LJKwCdig9l)', '2026-05-09 05:09:09'),
(145, 85, 'Debit', 500.00, '', 37, 'Commission for Booking ID-2627661', '2026-05-09 05:09:28'),
(146, 21, 'Debit', 500.00, '', 0, 'Commission payment for Booking ID-2627697 via Razorpay', '2026-05-09 05:20:57'),
(147, 21, 'Credit', 500.00, '', NULL, 'Booking cancelled refund  #2627697', '2026-05-09 05:35:00'),
(148, 21, 'Debit', 570.00, 'Withdrawal', 16, 'Withdrawal request submitted (Processing)', '2026-05-09 05:43:18'),
(149, 53, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: RJ06TA2726', '2026-05-09 10:52:31'),
(150, 53, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: RJ14TG4535', '2026-05-09 10:53:32'),
(151, 151, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: HARISH CHANDRA  SINGH', '2026-05-09 12:03:53'),
(152, 151, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: UK04TC0655', '2026-05-09 12:05:16'),
(153, 107, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: GULSHAN  KUMAR', '2026-05-09 13:38:08'),
(154, 107, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: HR55AS5876', '2026-05-09 13:39:06'),
(155, 21, 'Credit', 200.00, '', NULL, 'Add fund via rezorpay ', '2026-05-09 14:19:09'),
(156, 21, 'Debit', 200.00, 'Withdrawal', 17, 'Withdrawal request submitted (Processing)', '2026-05-09 14:29:46'),
(157, 152, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: HR55AV6512', '2026-05-09 16:40:18'),
(158, 14, 'Debit', 10.00, '', 39, 'Commission for Booking ID-2627707', '2026-05-09 21:46:04'),
(159, 14, 'Credit', 10.00, '', 39, 'Refund for Cancelling Booking ID-2627707', '2026-05-09 21:48:39'),
(160, 14, 'Debit', 10.00, '', 40, 'Commission for Booking ID-2627707', '2026-05-09 21:49:05'),
(161, 85, 'Debit', 0.00, '', 41, 'Commission for Booking ID-2627709', '2026-05-10 04:19:58'),
(162, 168, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: RJ14TA0286', '2026-05-10 05:55:35'),
(163, 168, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: RJ51TA0286', '2026-05-10 05:56:25'),
(164, 176, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: RAJ  KUMAR', '2026-05-10 07:04:16'),
(165, 176, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: HR38AL6467', '2026-05-10 07:04:52'),
(166, 40, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: JAGJIT SINGH', '2026-05-10 07:05:16'),
(167, 40, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: HR57B5977', '2026-05-10 07:05:58'),
(168, 175, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: UP27CT1815', '2026-05-10 09:02:54'),
(169, 175, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: SANDEEP  KUMAR', '2026-05-10 09:07:03'),
(170, 112, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: HR84A1704', '2026-05-10 10:05:59'),
(171, 112, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: HR55BC6559', '2026-05-10 10:08:04'),
(172, 50, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: RAMAVATAR  SAINI', '2026-05-10 10:30:11'),
(173, 50, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: MAHENDRA KUMAR SAINI', '2026-05-10 10:33:10'),
(174, 50, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: HR66C4142', '2026-05-10 10:34:29'),
(175, 50, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: HR842650', '2026-05-10 10:35:34'),
(176, 4, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: HR55BB9183', '2026-05-10 12:11:48'),
(177, 4, 'Debit', 10.00, '', 42, 'Commission for Booking ID-2627698', '2026-05-10 12:14:39'),
(178, 83, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: BIJENDER SINGH', '2026-05-10 13:13:07'),
(179, 83, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: HR841384', '2026-05-10 13:13:24'),
(180, 122, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: RJ31CC2891', '2026-05-10 14:02:00'),
(181, 4, 'Debit', 10.00, '', 43, 'Commission for Booking ID-2627727', '2026-05-10 14:24:30'),
(182, 165, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: PB01D 3388', '2026-05-10 14:53:34'),
(183, 113, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: HR47E5481', '2026-05-10 16:49:45'),
(184, 168, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: SHUBHAM KUMAR NOGIA', '2026-05-10 17:01:02'),
(185, 4, 'Debit', 1.00, '', 44, 'Commission for Booking ID-2627710', '2026-05-10 19:00:03'),
(186, 14, 'Debit', 2.00, '', 45, 'Commission for Booking ID-2627716', '2026-05-10 19:00:48'),
(187, 14, 'Credit', 2.00, '', 45, 'Refund for Cancelling Booking ID-2627716', '2026-05-10 19:01:13'),
(188, 14, 'Debit', 2.00, '', 46, 'Commission for Booking ID-2627716', '2026-05-10 19:01:38'),
(189, 14, 'Credit', 2.00, '', 46, 'Refund for Cancelling Booking ID-2627716', '2026-05-10 19:01:58'),
(190, 14, 'Debit', 2.00, '', 47, 'Commission for Booking ID-2627716', '2026-05-10 19:13:17'),
(191, 14, 'Credit', 2.00, '', 47, 'Refund for Cancelling Booking ID-2627716', '2026-05-10 19:13:28'),
(192, 14, 'Debit', 2.00, '', 48, 'Commission for Booking ID-2627716', '2026-05-10 19:14:13'),
(193, 14, 'Credit', 2.00, '', 48, 'Refund for Cancelling Booking ID-2627716', '2026-05-10 19:14:28'),
(194, 14, 'Debit', 2.00, '', 49, 'Commission for Booking ID-2627716', '2026-05-10 19:16:47'),
(195, 14, 'Credit', 2.00, '', 49, 'Refund for Cancelling Booking ID-2627716', '2026-05-10 19:18:11'),
(196, 14, 'Debit', 2.00, '', 50, 'Commission for Booking ID-2627716', '2026-05-10 19:20:54'),
(197, 14, 'Credit', 2.00, '', 50, 'Refund for Cancelling Booking ID-2627716', '2026-05-10 19:21:25'),
(198, 14, 'Debit', 2.00, '', 51, 'Commission for Booking ID-2627716', '2026-05-10 19:27:07'),
(199, 14, 'Credit', 2.00, '', 51, 'Refund for Cancelling Booking ID-2627716', '2026-05-10 19:27:19'),
(200, 14, 'Debit', 2.00, '', 52, 'Commission for Booking ID-2627716', '2026-05-10 19:38:07'),
(201, 14, 'Credit', 2.00, '', 52, 'Refund for Cancelling Booking ID-2627716', '2026-05-10 19:38:21'),
(202, 195, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: RJ18TA5751', '2026-05-11 09:29:22'),
(203, 113, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: RAJ KUMAR', '2026-05-11 20:36:23'),
(204, 225, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: ANKUR  RAJAURIYA', '2026-05-12 10:42:55'),
(205, 226, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: JK 11J 6648', '2026-05-12 11:01:19'),
(206, 28, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: DL1ZD9277', '2026-05-12 11:27:07'),
(207, 28, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: RAJ KUMAR', '2026-05-12 11:33:52'),
(208, 28, 'Debit', 7.50, '', NULL, 'Registration fee for Driver: MUKESH KUMAR MANDAL', '2026-05-12 11:36:12'),
(209, 162, 'Debit', 7.50, '', NULL, 'Lookup fee for RC: HR38AF6490', '2026-05-12 12:03:07'),
(210, 4, 'Debit', 50.00, '', 58, 'Commission for Booking ID-2627746', '2026-05-12 13:20:03'),
(211, 227, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR55AX2774', '2026-05-12 14:52:49'),
(212, 21, 'Debit', 500.00, '', 0, 'Commission payment for Booking ID-2627750 via Razorpay', '2026-05-12 15:34:22'),
(213, 28, 'Credit', 600.00, 'Deposit', 18, 'Fund added via Razorpay (pay_SoVLpfpMxp1UVR)', '2026-05-12 15:37:48'),
(214, 28, 'Credit', 300.00, 'Deposit', 19, 'Fund added via Razorpay (pay_SoVNidUC6sH7po)', '2026-05-12 15:39:31'),
(215, 28, 'Debit', 500.00, '', 60, 'Commission for Booking ID-2627751', '2026-05-12 15:39:49'),
(216, 212, 'Debit', 7.50, '', 0, 'Lookup fee for RC: DL9CAA3899', '2026-05-12 15:47:28'),
(217, 13, 'Debit', 7.50, '', 0, 'Registration fee for Driver: AJAY  KUMAR', '2026-05-12 16:00:17'),
(218, 29, 'Debit', 7.50, '', 0, 'Registration fee for Driver: AJAY  KUMAR', '2026-05-12 16:02:51'),
(219, 24, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR55BB9183', '2026-05-12 16:24:06'),
(220, 24, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR55BA2936', '2026-05-12 16:25:08'),
(221, 14, 'Debit', 20.00, '', 61, 'Commission for Booking ID-2627752', '2026-05-12 17:08:01'),
(222, 14, 'Debit', 1500.00, 'Penalty', 61, 'Penalty for Cancelling Booking ID-2627752 after 39 minutes', '2026-05-12 17:46:38'),
(223, 14, 'Credit', 20.00, '', 61, 'Refund for Cancelling Booking ID-2627752', '2026-05-12 17:46:38'),
(224, 14, 'Debit', 20.00, '', 62, 'Commission for Booking ID-2627752', '2026-05-12 18:35:19'),
(225, 21, 'Debit', 1500.00, 'Penalty', 59, 'Penalty for Cancelling Booking ID-2627750 after 643 minutes', '2026-05-13 02:16:55'),
(226, 21, 'Credit', 500.00, '', 59, 'Refund for Cancelling Booking ID-2627750', '2026-05-13 02:16:55'),
(227, 156, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UP14ST 9734', '2026-05-13 02:44:10'),
(228, 63, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR 38 AJ 5296', '2026-05-13 04:11:00'),
(229, 110, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UK07TD5054', '2026-05-13 04:57:18'),
(230, 213, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR55AW0318', '2026-05-13 06:45:51'),
(231, 156, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UP14ST 9734', '2026-05-13 08:21:54'),
(232, 145, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ27TB0506', '2026-05-13 08:40:00'),
(233, 145, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ27TA7253', '2026-05-13 09:56:18'),
(234, 145, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ59TA0122', '2026-05-13 09:57:45'),
(235, 145, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ59TA0122', '2026-05-13 09:58:17'),
(236, 102, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR65A3390', '2026-05-14 05:52:36'),
(237, 102, 'Debit', 7.50, '', 0, 'Registration fee for Driver: NISHIN SHARMA', '2026-05-14 05:56:54'),
(238, 122, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ31CC2891', '2026-05-14 06:00:27'),
(239, 102, 'Credit', 600.00, 'Deposit', 22, 'Fund added via Razorpay (pay_Sp8dAduNqpjZSZ)', '2026-05-14 06:03:09'),
(240, 102, 'Debit', 300.00, '', NULL, 'accept booking id 2627764', '2026-05-14 06:11:58'),
(241, 36, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR38AD2427', '2026-05-14 06:37:27'),
(242, 36, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR38AL0999', '2026-05-14 06:38:12'),
(243, 253, 'Debit', 7.50, '', 0, 'Lookup fee for RC: PB01E5665', '2026-05-14 07:28:50'),
(244, 253, 'Debit', 7.50, '', 0, 'Lookup fee for RC: PB01G3415', '2026-05-14 07:29:18'),
(245, 253, 'Debit', 7.50, '', 0, 'Lookup fee for RC: PB01E5665', '2026-05-14 07:29:38'),
(246, 256, 'Debit', 7.50, '', 0, 'Lookup fee for RC: TN38CU4227', '2026-05-14 07:40:08'),
(247, 162, 'Debit', 7.50, '', 0, 'Registration fee for Driver: AMIT KUMAR', '2026-05-14 08:32:21'),
(248, 71, 'Debit', 7.50, '', 0, 'Lookup fee for RC: DL1ZD9974', '2026-05-14 08:50:21'),
(249, 71, 'Debit', 7.50, '', 0, 'Registration fee for Driver: RAHUL  YADAV', '2026-05-14 08:59:35'),
(250, 252, 'Debit', 7.50, '', 0, 'Registration fee for Driver: ANKUR  SINGH', '2026-05-14 09:24:17'),
(251, 252, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR55AR6271', '2026-05-14 09:25:24'),
(252, 252, 'Credit', 20.00, 'Deposit', 24, 'Fund added via Razorpay (pay_SpC7WbSVL1Nucf)', '2026-05-14 09:28:08'),
(253, 252, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UP75CT5879', '2026-05-14 09:53:27'),
(254, 250, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UP22BK6037', '2026-05-14 10:09:35'),
(255, 252, 'Credit', 400.00, '', NULL, 'pay via rezorpay', '2026-05-14 10:19:32'),
(256, 263, 'Debit', 7.50, '', 0, 'Lookup fee for RC: MP04WC1701', '2026-05-14 11:21:02'),
(257, 264, 'Debit', 7.50, '', 0, 'Registration fee for Driver: GURDEEP SINGH', '2026-05-14 12:04:52'),
(258, 257, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR38AH0462', '2026-05-14 13:16:08'),
(259, 257, 'Debit', 7.50, '', 0, 'Registration fee for Driver: GOVIND TIWARI', '2026-05-14 13:21:42'),
(260, 106, 'Debit', 7.50, '', 0, 'Registration fee for Driver: SONU  RATHOUR', '2026-05-14 15:11:46'),
(261, 106, 'Debit', 7.50, '', 0, 'Registration fee for Driver: RAMBABU  RATHORE', '2026-05-14 15:13:01'),
(262, 106, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UK06TA7775', '2026-05-14 15:13:47'),
(263, 106, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UK04TC7775', '2026-05-14 15:15:20'),
(264, 271, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TH0286', '2026-05-14 15:45:52'),
(265, 271, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF7725', '2026-05-14 15:47:19'),
(266, 277, 'Debit', 7.50, '', 0, 'Lookup fee for RC: PB01E9809', '2026-05-14 15:53:19'),
(267, 277, 'Credit', 100.00, 'Deposit', 26, 'Fund added via Razorpay (pay_SpIj0DtJh8Be9a)', '2026-05-14 15:55:47'),
(268, 276, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR55BB8372', '2026-05-14 15:56:18'),
(269, 271, 'Debit', 7.50, '', 0, 'Registration fee for Driver: SHAILENDRA SINGH', '2026-05-14 16:00:27'),
(270, 277, 'Debit', 7.50, '', 0, 'Registration fee for Driver: LOVELEEN KUMAR', '2026-05-14 16:41:20'),
(271, 288, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR74B9884', '2026-05-14 18:45:20'),
(272, 29, 'Debit', 400.00, '', 0, 'Commission payment for Booking ID-2627780 via Razorpay', '2026-05-15 02:12:00'),
(273, 29, 'Debit', 200.00, '', 0, 'Commission payment for Booking ID-2627714 via Razorpay', '2026-05-15 02:14:28'),
(274, 88, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR58E1326', '2026-05-15 05:58:27'),
(275, 88, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR58D1762', '2026-05-15 05:59:52'),
(276, 280, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ 14 TE 7349', '2026-05-15 06:12:41'),
(277, 88, 'Debit', 7.50, '', 0, 'Registration fee for Driver: GULFAN', '2026-05-15 06:13:36'),
(278, 88, 'Credit', 150.00, 'Deposit', 27, 'Fund added via Razorpay (pay_SpXPFipGVfhycM)', '2026-05-15 06:17:16'),
(279, 277, 'Debit', 7.50, '', 0, 'Lookup fee for RC: PB10HJ9423', '2026-05-15 07:29:06'),
(280, 28, 'Credit', 1300.00, 'Deposit', 28, 'Fund added via Razorpay (pay_SpYvOv3f7SzpQt)', '2026-05-15 07:46:35'),
(281, 255, 'Debit', 7.50, '', 0, 'Lookup fee for RC: PB08FZ2293', '2026-05-15 07:49:37'),
(282, 28, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR55AU7020', '2026-05-15 07:49:38'),
(283, 28, 'Debit', 7.50, '', 0, 'Registration fee for Driver: SATIHISH  KUMAR', '2026-05-15 07:52:23'),
(284, 27, 'Credit', 1300.00, '', NULL, 'add fund via rezorpay', '2026-05-15 08:36:10'),
(285, 277, 'Debit', 7.50, '', 0, 'Lookup fee for RC: PB01F5300', '2026-05-15 09:51:30'),
(286, 277, 'Debit', 7.50, '', 0, 'Lookup fee for RC: PB01F5300', '2026-05-15 09:52:20'),
(287, 277, 'Debit', 7.50, '', 0, 'Registration fee for Driver: JASBIR SINGH DHANOA', '2026-05-15 10:05:09'),
(288, 277, 'Credit', 800.00, 'Deposit', 29, 'Fund added via Razorpay (pay_SpbMMkpBVcZucz)', '2026-05-15 10:09:28'),
(289, 277, 'Debit', 500.00, '', 65, 'Commission for Booking ID-2627777', '2026-05-15 10:09:47'),
(290, 286, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR26DY0241', '2026-05-15 10:40:37'),
(291, 277, 'Debit', 55.00, 'Withdrawal', 18, 'Withdrawal request submitted (Processing)', '2026-05-15 10:42:56'),
(292, 29, 'Debit', 1500.00, 'Penalty', 64, 'Penalty for Cancelling Booking ID-2627714 after 539 minutes', '2026-05-15 11:12:36'),
(293, 29, 'Credit', 200.00, '', 64, 'Refund for Cancelling Booking ID-2627714', '2026-05-15 11:12:36'),
(294, 29, 'Credit', 1657.50, '', NULL, 'fund refund cancle by mistake id 2627714 ', '2026-05-15 11:16:41'),
(295, 29, 'Debit', 342.00, '', NULL, 'nill', '2026-05-15 11:17:23'),
(296, 29, 'Debit', 15.00, '', NULL, 'nill', '2026-05-15 11:18:07'),
(297, 29, 'Debit', 200.00, '', 66, 'Commission for Booking ID-2627714', '2026-05-15 11:19:18'),
(298, 135, 'Debit', 7.50, '', 0, 'Registration fee for Driver: SATYA  KISHOR', '2026-05-15 12:37:29'),
(299, 135, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR55AB9798', '2026-05-15 12:39:00'),
(300, 313, 'Debit', 7.50, '', 0, 'Registration fee for Driver: GAUTAM SINGH', '2026-05-15 15:40:51'),
(301, 313, 'Debit', 7.50, '', 0, 'Lookup fee for RC: DL1ZD7312', '2026-05-15 15:41:27'),
(302, 313, 'Credit', 500.00, 'Deposit', 30, 'Fund added via Razorpay (pay_Sph7beDB17Maob)', '2026-05-15 15:47:38'),
(303, 313, 'Debit', 500.00, '', 0, 'Commission payment for Booking ID-2627787 via Razorpay', '2026-05-15 15:48:34'),
(304, 212, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UP25FT9896', '2026-05-16 05:38:39'),
(305, 294, 'Debit', 7.50, '', 0, 'Registration fee for Driver: RINKU  KUMAR', '2026-05-16 06:19:26'),
(306, 294, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UP14RT9996', '2026-05-16 06:20:04'),
(307, 309, 'Debit', 7.50, '', 0, 'Lookup fee for RC: KA19AB1800', '2026-05-16 07:12:24'),
(308, 309, 'Debit', 7.50, '', 0, 'Registration fee for Driver: ABDUL REHAMAN  MIYAZ', '2026-05-16 07:14:39'),
(309, 294, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UP14RT9996', '2026-05-16 07:22:17'),
(310, 294, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UP14RT8731', '2026-05-16 07:30:25'),
(311, 24, 'Debit', 0.00, '', 68, 'Commission for Booking ID-2627794', '2026-05-16 07:51:43'),
(312, 21, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UP14RT8489', '2026-05-16 08:22:22'),
(313, 50, 'Credit', 230.00, 'Deposit', 33, 'Fund added via Razorpay (pay_SpzECXPRXZVort)', '2026-05-16 09:30:34'),
(314, 50, 'Credit', 300.00, '', NULL, 'demo fund', '2026-05-16 09:38:43'),
(315, 50, 'Debit', 200.00, '', 69, 'Commission for Booking ID-2627795', '2026-05-16 09:41:07'),
(316, 50, 'Debit', 300.00, '', NULL, 'demo fund ', '2026-05-16 09:41:49'),
(317, 65, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UP 85 DT 4657', '2026-05-16 11:48:23'),
(318, 65, 'Debit', 7.50, '', 0, 'Registration fee for Driver: RAJPAL', '2026-05-16 11:53:02'),
(319, 85, 'Debit', 300.00, '', NULL, 'cab noshow booking id 2627661', '2026-05-16 12:26:38'),
(320, 95, 'Credit', 200.00, '', NULL, 'Fund added by rezorpay', '2026-05-16 13:55:33'),
(321, 329, 'Debit', 7.50, '', 0, 'Registration fee for Driver: KISHOR  CHOPDE', '2026-05-16 14:01:54'),
(322, 328, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UP25CB9199', '2026-05-16 14:20:13'),
(323, 325, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UP22AR4803', '2026-05-16 15:03:24'),
(324, 327, 'Debit', 7.50, '', 0, 'Registration fee for Driver: SHASHANK  PANDEY', '2026-05-16 15:08:20'),
(325, 327, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UP36AT4645', '2026-05-16 15:08:48'),
(326, 325, 'Debit', 7.50, '', 0, 'Registration fee for Driver: AMIR  SHAMSI', '2026-05-16 15:10:45'),
(327, 29, 'Debit', 300.00, '', 70, 'Commission for Booking ID-2627803', '2026-05-16 15:36:27'),
(328, 334, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR37F9609', '2026-05-16 16:37:49'),
(329, 245, 'Debit', 7.50, '', 0, 'Lookup fee for RC: PB 01C9092', '2026-05-16 16:48:41'),
(330, 343, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UP78LN1813', '2026-05-17 05:33:42'),
(331, 343, 'Debit', 7.50, '', 0, 'Registration fee for Driver: KRISHNA  KUMAR', '2026-05-17 05:35:12'),
(332, 339, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UP30ET0891', '2026-05-17 13:53:21'),
(333, 57, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UP16RT 6135', '2026-05-18 00:13:14'),
(334, 314, 'Debit', 7.50, '', 0, 'Registration fee for Driver: GIRISH                   PANWAR', '2026-05-18 00:41:02'),
(335, 314, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TG1780', '2026-05-18 00:41:53'),
(336, 212, 'Debit', 7.50, '', 0, 'Registration fee for Driver: ANAS  WARSI', '2026-05-18 01:09:47'),
(337, 269, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF2941', '2026-05-18 09:32:53'),
(338, 178, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR37E6123', '2026-05-18 12:23:07'),
(339, 96, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UK07TE1580', '2026-05-18 12:27:28'),
(340, 178, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR37F7458', '2026-05-18 12:27:55'),
(341, 96, 'Debit', 7.50, '', 0, 'Registration fee for Driver: VIKKAS  GUPTA', '2026-05-18 12:30:41'),
(342, 312, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR55AD6829', '2026-05-18 12:38:48'),
(343, 359, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UP84BT5903', '2026-05-18 15:38:43'),
(344, 359, 'Debit', 7.50, '', 0, 'Registration fee for Driver: SATENDRA', '2026-05-18 15:41:50'),
(345, 229, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UK08TA8367', '2026-05-18 16:36:53'),
(346, 229, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UK08TA8367', '2026-05-18 16:39:34'),
(347, 229, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UK 08 TA8367', '2026-05-18 16:43:13'),
(348, 229, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UK 08 TA8367', '2026-05-18 16:43:14'),
(349, 229, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UK 08 TA8367', '2026-05-18 16:44:20'),
(350, 229, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UK 08 TA8367', '2026-05-18 16:44:21'),
(351, 229, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UK 08 TA8367', '2026-05-18 16:44:23'),
(352, 24, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR55BC1321', '2026-05-18 16:46:52'),
(353, 24, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR55BB9183', '2026-05-18 16:50:10'),
(354, 24, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR55BB6762', '2026-05-18 17:40:04'),
(355, 24, 'Debit', 7.50, '', 0, 'Lookup fee for RC: DL1VC6754', '2026-05-18 17:42:05'),
(356, 24, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR55BB8005', '2026-05-18 17:43:42'),
(357, 24, 'Debit', 7.50, '', 0, 'Lookup fee for RC: DL1VC6873', '2026-05-18 17:44:33'),
(358, 24, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR55BA2936', '2026-05-18 17:45:31'),
(359, 24, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR55BB3797', '2026-05-18 17:46:57'),
(360, 24, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR55BA3797', '2026-05-18 17:49:56'),
(361, 24, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR55BB4781', '2026-05-18 17:51:10'),
(362, 199, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UP30ET4595', '2026-05-19 05:02:06'),
(363, 199, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UP30ET4595', '2026-05-19 05:03:56'),
(364, 199, 'Debit', 7.50, '', 0, 'Registration fee for Driver: KAMRAN  HUSSAIN', '2026-05-19 05:06:04'),
(365, 277, 'Debit', 200.00, '', 0, 'Commission payment for Booking ID-2627827 via Razorpay', '2026-05-19 10:50:02'),
(366, 374, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TG3042', '2026-05-19 16:05:48'),
(367, 111, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR55BC6448', '2026-05-19 17:47:50'),
(368, 168, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ51TA0286', '2026-05-19 18:06:17'),
(369, 29, 'Debit', 500.00, '', 0, 'Commission payment for Booking ID-2627830 via Razorpay', '2026-05-19 18:06:43'),
(370, 29, 'Credit', 300.00, '', NULL, 'fund for less amount receive dehradun to delhi trip', '2026-05-19 18:38:00'),
(371, 376, 'Debit', 7.50, '', 0, 'Lookup fee for RC: GJ32AG4830', '2026-05-19 19:06:30'),
(372, 377, 'Debit', 7.50, '', 0, 'Registration fee for Driver: AMAR  RAY', '2026-05-20 05:43:51'),
(373, 377, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR55AW4413', '2026-05-20 05:44:19'),
(374, 377, 'Credit', 500.00, 'Deposit', 39, 'Fund added via Razorpay (pay_SrWH2ERMv3r1Lh)', '2026-05-20 06:28:59'),
(375, 377, 'Credit', 15.00, 'Deposit', 40, 'Fund added via Razorpay (pay_SrWLdBmp0aRCLz)', '2026-05-20 06:33:27'),
(376, 377, 'Debit', 200.00, '', 73, 'Commission for Booking ID-2627822', '2026-05-20 06:34:05'),
(377, 281, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TH0466', '2026-05-20 07:33:07'),
(378, 281, 'Debit', 7.50, '', 0, 'Registration fee for Driver: ROSHAN LAL BAIRWA', '2026-05-20 07:36:04'),
(379, 378, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UP32RT5042', '2026-05-20 10:43:13'),
(380, 316, 'Debit', 7.50, '', 0, 'Registration fee for Driver: MOHAMMAD SHOAIB', '2026-05-20 12:43:10'),
(381, 316, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UK07TE3227', '2026-05-20 12:44:17'),
(382, 312, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR55AD6829', '2026-05-20 13:21:01'),
(383, 312, 'Debit', 7.50, '', 0, 'Registration fee for Driver: PRITAM  SINGH', '2026-05-20 13:24:10'),
(384, 349, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UP79AT9904', '2026-05-20 23:35:22'),
(385, 279, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR 61E 9979', '2026-05-21 03:11:03'),
(386, 279, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR 61E 9979', '2026-05-21 03:12:37'),
(387, 390, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR55BC3801', '2026-05-21 05:15:04'),
(388, 391, 'Debit', 7.50, '', 0, 'Registration fee for Driver: PUSHPENDER', '2026-05-21 05:23:59'),
(389, 391, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR87K0831', '2026-05-21 05:25:23'),
(390, 391, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR38AC5433', '2026-05-21 05:25:59'),
(391, 391, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR38AA5143', '2026-05-21 05:28:07'),
(392, 392, 'Debit', 7.50, '', 0, 'Lookup fee for RC: BR01PT3352', '2026-05-21 07:12:37'),
(393, 392, 'Debit', 7.50, '', 0, 'Registration fee for Driver: ISMEET  SINGH', '2026-05-21 07:15:26'),
(394, 29, 'Credit', 500.00, '', 72, 'Refund for Booking ID-2627830 cancelled by Poster', '2026-05-21 09:29:05'),
(395, 369, 'Debit', 7.50, '', 0, 'Registration fee for Driver: NARSI NARESH TILOR', '2026-05-21 10:40:13'),
(396, 29, 'Debit', 150.00, '', 74, 'Commission for Booking ID-2627841', '2026-05-21 11:45:25'),
(397, 29, 'Debit', 200.00, '', 75, 'Commission for Booking ID-2627842', '2026-05-21 11:49:39'),
(398, 28, 'Debit', 800.00, '', 76, 'Commission for Booking ID-2627851', '2026-05-21 14:35:05'),
(399, 397, 'Debit', 7.50, '', 0, 'Lookup fee for RC: GJ05CY8046', '2026-05-21 16:28:54'),
(400, 337, 'Debit', 7.50, '', 0, 'Registration fee for Driver: DILSHAD KHAN', '2026-05-22 12:53:09'),
(401, 337, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UK07TE5546', '2026-05-22 12:54:41'),
(402, 24, 'Debit', 1500.00, 'Penalty', 28, 'Penalty for Cancelling Booking ID-2627660 after 23414 minutes', '2026-05-22 13:17:40'),
(403, 24, 'Credit', 500.00, '', 28, 'Refund for Cancelling Booking ID-2627660', '2026-05-22 13:17:40'),
(404, 29, 'Debit', 300.00, '', NULL, 'Penlty for last-minute booking cancellation ', '2026-05-22 18:02:52'),
(405, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF3323', '2026-05-23 07:00:04'),
(406, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TG3323', '2026-05-23 07:01:29'),
(407, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TG3323', '2026-05-23 07:02:00'),
(408, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TG3323', '2026-05-23 07:02:01'),
(409, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TG3323', '2026-05-23 07:02:01'),
(410, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TG3323', '2026-05-23 07:02:02'),
(411, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TG3323', '2026-05-23 07:02:02'),
(412, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TG3323', '2026-05-23 07:02:03'),
(413, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TG3323', '2026-05-23 07:02:03'),
(414, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TG3323', '2026-05-23 07:02:04'),
(415, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TG3323', '2026-05-23 07:02:04'),
(416, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TG3323', '2026-05-23 07:02:04'),
(417, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TG3323', '2026-05-23 07:02:05'),
(418, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TG3324', '2026-05-23 07:02:08'),
(419, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TG3325', '2026-05-23 07:02:11'),
(420, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TG3324', '2026-05-23 07:02:13'),
(421, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TG3325', '2026-05-23 07:02:15'),
(422, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TG3326', '2026-05-23 07:02:18'),
(423, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:03:46'),
(424, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:03:47'),
(425, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:03:47'),
(426, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:03:47'),
(427, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:03:48'),
(428, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:03:48'),
(429, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:03:49'),
(430, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:03:49'),
(431, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:03:50'),
(432, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:03:51'),
(433, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:03:52'),
(434, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:03:52'),
(435, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:03:52'),
(436, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:03:53'),
(437, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:03:53'),
(438, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:03:54'),
(439, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:03:54'),
(440, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:03:54'),
(441, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:03:55'),
(442, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:03:55'),
(443, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:03:56'),
(444, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:03:56'),
(445, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:03:57'),
(446, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:03:57'),
(447, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:03:58'),
(448, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:03:58'),
(449, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:03:59'),
(450, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:03:59'),
(451, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:00'),
(452, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:00'),
(453, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:00'),
(454, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:00'),
(455, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:01'),
(456, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:01'),
(457, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:01'),
(458, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:02'),
(459, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:02'),
(460, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:03'),
(461, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:03'),
(462, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:04'),
(463, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:04'),
(464, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:04'),
(465, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:05'),
(466, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:05'),
(467, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:05'),
(468, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:06'),
(469, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:06'),
(470, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:06'),
(471, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:07'),
(472, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:07'),
(473, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:08'),
(474, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:08'),
(475, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:09'),
(476, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:09'),
(477, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:10'),
(478, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:10'),
(479, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:10'),
(480, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:11'),
(481, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:11'),
(482, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:12'),
(483, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:12'),
(484, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:12'),
(485, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:13'),
(486, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:13'),
(487, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:14'),
(488, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:14'),
(489, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:14'),
(490, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:15'),
(491, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:15'),
(492, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:15'),
(493, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:16'),
(494, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:16'),
(495, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:16'),
(496, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:17'),
(497, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:17'),
(498, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:17'),
(499, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:18'),
(500, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:18'),
(501, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:18'),
(502, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:19'),
(503, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:19'),
(504, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:20'),
(505, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:20'),
(506, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:20'),
(507, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:21'),
(508, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:21'),
(509, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:21'),
(510, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:22'),
(511, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:22'),
(512, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:23'),
(513, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:23'),
(514, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:23'),
(515, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:24'),
(516, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:24'),
(517, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:25'),
(518, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:26'),
(519, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:26'),
(520, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:26'),
(521, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:27'),
(522, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:27'),
(523, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:28'),
(524, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:28'),
(525, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:28'),
(526, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:29'),
(527, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:29'),
(528, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:29'),
(529, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:30'),
(530, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:30'),
(531, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:30');
INSERT INTO `partner_transactions` (`id`, `partner_id`, `type`, `amount`, `source`, `source_id`, `description`, `created_at`) VALUES
(532, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:31'),
(533, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:31'),
(534, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:31'),
(535, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:32'),
(536, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:32'),
(537, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:33'),
(538, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:33'),
(539, 409, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TF5932', '2026-05-23 07:04:33'),
(540, 410, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UP80KT8624', '2026-05-23 07:10:31'),
(541, 410, 'Debit', 7.50, '', 0, 'Registration fee for Driver: ASHISH DIXIT', '2026-05-23 07:28:02'),
(542, 29, 'Debit', 1500.00, 'Penalty', 75, 'Penalty for Cancelling Booking ID-2627842 after 2673 minutes', '2026-05-23 08:21:45'),
(543, 29, 'Credit', 200.00, '', 75, 'Refund for Cancelling Booking ID-2627842', '2026-05-23 08:21:45'),
(544, 398, 'Debit', 7.50, '', 0, 'Lookup fee for RC: GJ05 CY8046', '2026-05-23 14:09:11'),
(545, 398, 'Debit', 7.50, '', 0, 'Registration fee for Driver: GANESH  SHUKLA', '2026-05-23 14:16:36'),
(546, 14, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR38AG4372', '2026-05-23 18:11:14'),
(547, 359, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UP84BT1186', '2026-05-24 12:02:14'),
(548, 359, 'Debit', 7.50, '', 0, 'Registration fee for Driver: JEEVAN  KUMAR', '2026-05-24 12:04:36'),
(549, 24, 'Credit', 1500.00, '', NULL, 'Pay via rezorpay ', '2026-06-05 11:09:56'),
(550, 28, 'Debit', 200.00, '', 77, 'Commission for Booking ID-2627875', '2026-06-06 12:27:35'),
(551, 65, 'Debit', 80.00, '', 78, 'Commission for Booking ID-2627891', '2026-06-09 03:48:07'),
(552, 65, 'Debit', 80.00, '', 0, 'Commission payment for Booking ID-2627879 via Razorpay', '2026-06-09 03:50:42'),
(553, 14, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ53TA0074', '2026-06-12 19:15:53'),
(554, 464, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR55AG0320', '2026-06-13 11:38:02'),
(555, 464, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR55AV2246', '2026-06-13 11:38:39'),
(556, 464, 'Debit', 7.50, '', 0, 'Registration fee for Driver: HIMANSHU  KUMAR', '2026-06-13 11:40:17'),
(557, 464, 'Debit', 7.50, '', 0, 'Registration fee for Driver: YASH SINGH PARMAR', '2026-06-13 11:41:53'),
(558, 447, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TH3521', '2026-06-13 13:21:47'),
(559, 447, 'Debit', 7.50, '', 0, 'Lookup fee for RC: RJ14TH3521', '2026-06-13 13:23:26'),
(560, 447, 'Debit', 7.50, '', 0, 'Registration fee for Driver: LAXMI NARAYAN  MEENA', '2026-06-13 13:24:45'),
(561, 442, 'Debit', 7.50, '', 0, 'Registration fee for Driver: RAJ KUMAR', '2026-06-13 18:10:43'),
(562, 442, 'Debit', 7.50, '', 0, 'Lookup fee for RC: PB01D4730', '2026-06-13 18:11:27'),
(563, 484, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR55BC5155', '2026-06-13 19:05:39'),
(564, 13, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR55AQ4889', '2026-06-14 04:07:25'),
(565, 511, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UP82AT9927', '2026-06-14 04:13:36'),
(566, 30, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR38AC4502', '2026-06-14 06:33:28'),
(567, 30, 'Debit', 7.50, '', 0, 'Registration fee for Driver: MONU SHARMA', '2026-06-14 06:34:42'),
(568, 504, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR47F7984', '2026-06-14 13:49:06'),
(569, 504, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR38AH0286', '2026-06-14 13:50:33'),
(570, 20, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR66C6536', '2026-06-15 09:51:21'),
(571, 179, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UP60BT5490', '2026-06-15 11:10:19'),
(572, 179, 'Debit', 7.50, '', 0, 'Registration fee for Driver: VIVEK KUMAR SINGH', '2026-06-15 11:12:29'),
(573, 509, 'Debit', 7.50, '', 0, 'Registration fee for Driver: SURAJ', '2026-06-15 19:18:15'),
(574, 509, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UP32TT1161', '2026-06-15 19:18:42'),
(575, 471, 'Debit', 7.50, '', 0, 'Registration fee for Driver: TARSEM SINGH', '2026-06-16 04:57:11'),
(576, 471, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR55AQ5835', '2026-06-16 04:57:32'),
(577, 58, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR47H3593', '2026-06-17 08:02:58'),
(578, 58, 'Debit', 7.50, '', 0, 'Registration fee for Driver: SANDEEP YADAV', '2026-06-17 08:05:29'),
(579, 28, 'Credit', 400.00, 'Deposit', 43, 'Fund added via Razorpay (pay_T2em7484CBIn8e)', '2026-06-17 09:56:57'),
(580, 28, 'Debit', 7.50, '', 0, 'Lookup fee for RC: DL1ZD9277', '2026-06-17 09:57:35'),
(581, 28, 'Debit', 7.50, '', 0, 'Lookup fee for RC: DL1ZD9277', '2026-06-17 10:00:45'),
(582, 514, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UP83DT8226', '2026-06-17 10:51:41'),
(583, 28, 'Credit', 300.00, 'Deposit', 44, 'Fund added via Razorpay (pay_T2fiBxXNMtvfRc)', '2026-06-17 10:51:54'),
(584, 28, 'Debit', 1000.00, '', 80, 'Commission for Booking ID-2627920', '2026-06-17 10:52:04'),
(585, 514, 'Debit', 7.50, '', 0, 'Registration fee for Driver: RAVI KUMAR', '2026-06-17 10:55:04'),
(586, 79, 'Debit', 7.50, '', 0, 'Registration fee for Driver: RAVINDER', '2026-06-17 10:59:59'),
(587, 79, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR845780', '2026-06-17 11:00:21'),
(588, 79, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR845780', '2026-06-17 11:03:13'),
(589, 79, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR845780', '2026-06-17 11:03:14'),
(590, 250, 'Debit', 7.50, '', 0, 'Lookup fee for RC: UP22BK6037', '2026-06-17 11:25:10'),
(591, 79, 'Debit', 7.50, '', 0, 'Lookup fee for RC: HR845780', '2026-06-17 11:56:46');

-- --------------------------------------------------------

--
-- Table structure for table `partner_vehicles`
--

CREATE TABLE `partner_vehicles` (
  `id` int(11) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `car_type` int(11) DEFAULT NULL,
  `rc_number` varchar(20) NOT NULL,
  `owner_name` varchar(150) DEFAULT NULL,
  `maker_description` varchar(150) DEFAULT NULL,
  `maker_model` varchar(150) DEFAULT NULL,
  `body_type` varchar(100) DEFAULT NULL,
  `fuel_type` varchar(50) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `seat_capacity` varchar(10) DEFAULT NULL,
  `vehicle_category_desc` varchar(100) DEFAULT NULL,
  `registration_date` varchar(20) DEFAULT NULL,
  `fit_up_to` varchar(20) DEFAULT NULL,
  `insurance_company` varchar(200) DEFAULT NULL,
  `insurance_policy_number` varchar(100) DEFAULT NULL,
  `insurance_upto` varchar(20) DEFAULT NULL,
  `norms_type` varchar(100) DEFAULT NULL,
  `rc_status` varchar(50) DEFAULT NULL,
  `permit_type` varchar(100) DEFAULT NULL,
  `permit_valid_upto` varchar(20) DEFAULT NULL,
  `raw_rc_data` longtext DEFAULT NULL,
  `front_image` varchar(255) DEFAULT NULL,
  `back_image` varchar(255) DEFAULT NULL,
  `status` enum('Active','Inactive','Pending') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `partner_vehicles`
--

INSERT INTO `partner_vehicles` (`id`, `partner_id`, `car_type`, `rc_number`, `owner_name`, `maker_description`, `maker_model`, `body_type`, `fuel_type`, `color`, `seat_capacity`, `vehicle_category_desc`, `registration_date`, `fit_up_to`, `insurance_company`, `insurance_policy_number`, `insurance_upto`, `norms_type`, `rc_status`, `permit_type`, `permit_valid_upto`, `raw_rc_data`, `front_image`, `back_image`, `status`, `created_at`) VALUES
(2, 9, NULL, 'HR55AQ4889', 'MANISH KUMAR', 'MARUTI SUZUKI INDIA LTD', 'ERTIGA VXI (O) CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2023-06-05', '2027-06-05', 'The New India Assurance Company Limited', '98000031250316715881', '2026-05-04', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2028-08-01', '{\"client_id\":\"rc_znzgalpGNsjiQivYpywg\",\"rc_number\":\"HR55AQ4889\",\"fit_up_to\":\"2027-06-05\",\"registration_date\":\"2023-06-05\",\"owner_name\":\"MANISH KUMAR\",\"father_name\":\"\",\"present_address\":\"H NO 192, BLOCK J GALI NO 7, ASHOK VIHAR PHASE 3 EXT GURGAON, , Gurgaon, Haryana,\",\"permanent_address\":\"H NO 192, BLOCK J GALI NO 7, ASHOK VIHAR PHASE 3 EXT GURGAON, , Gurgaon, Haryana,\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SPD613316\",\"vehicle_engine_number\":\"K15CN9229981\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"ERTIGA VXI (O) CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"CHOLA MANDLAM INV. & FIN. CO. LTD.\",\"financed\":true,\"insurance_company\":\"The New India Assurance Company Limited\",\"insurance_policy_number\":\"98000031250316715881\",\"insurance_upto\":\"2026-05-04\",\"manufacturing_date\":\"4/2023\",\"manufacturing_date_formatted\":\"2023-04\",\"registered_at\":\"RTA, GURGAON, Haryana\",\"latest_by\":\"2026-04-04\",\"less_info\":true,\"tax_upto\":\"2026-06-30\",\"tax_paid_upto\":\"2026-06-30\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1250\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR05502750071200\",\"pucc_upto\":\"2026-08-27\",\"permit_number\":\"HR2023-AITP-9034B\",\"permit_issue_date\":\"2023-08-02\",\"permit_valid_from\":\"2023-08-02\",\"permit_valid_upto\":\"2028-08-01\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"masked_name\":false,\"challan_details\":null,\"variant\":null,\"rto_code\":\"\",\"response_metadata\":{\"masked_chassis\":false,\"masked_engine\":false,\"masked_owner_name\":false}}', 'uploads/vehicles/HR55AQ4889_front_image_1775298204.jpg', 'uploads/vehicles/HR55AQ4889_back_image_1775298204.jpg', 'Active', '2026-04-04 10:23:24'),
(3, 9, NULL, 'HR31H8982', 'MOHAN LAL', 'HONDA MOTORCYCLE AND SCOOTER INDIA (P) LTD', 'DREAM NEO', '', 'PETROL', 'BLACK B', '2', 'M-Cycle/Scooter(2WN)', '2013-08-14', '2028-08-06', 'United India Insurance Co. Ltd.', '1112063125P105266128', '2026-07-01', 'BHARAT STAGE III', 'ACTIVE', '', '', '{\"client_id\":\"rc_jXbgITOjnlidpLwmihjz\",\"rc_number\":\"HR31H8982\",\"fit_up_to\":\"2028-08-06\",\"registration_date\":\"2013-08-14\",\"owner_name\":\"MOHAN LAL\",\"father_name\":\"\",\"present_address\":\"VPO KANDELA, DISTT., JIND, , Haryana,\",\"permanent_address\":\"VPO KANDELA, DISTT., JIND, , Haryana,\",\"mobile_number\":\"\",\"vehicle_category\":\"2WN\",\"vehicle_chasi_number\":\"ME4JC622GD8007358\",\"vehicle_engine_number\":\"JC62E80008018\",\"maker_description\":\"HONDA MOTORCYCLE AND SCOOTER INDIA (P) LTD\",\"maker_model\":\"DREAM NEO\",\"body_type\":null,\"fuel_type\":\"PETROL\",\"color\":\"BLACK B\",\"norms_type\":\"BHARAT STAGE III\",\"financer\":\"\",\"financed\":false,\"insurance_company\":\"United India Insurance Co. Ltd.\",\"insurance_policy_number\":\"1112063125P105266128\",\"insurance_upto\":\"2026-07-01\",\"manufacturing_date\":\"7/2013\",\"manufacturing_date_formatted\":\"2013-07\",\"registered_at\":\"JIND, Haryana\",\"latest_by\":\"2026-04-08\",\"less_info\":true,\"tax_upto\":\"2028-08-06\",\"tax_paid_upto\":\"2028-08-06\",\"cubic_capacity\":\"109.00\",\"vehicle_gross_weight\":\"107\",\"no_cylinders\":\"1\",\"seat_capacity\":\"2\",\"sleeper_capacity\":\"0\",\"standing_capacity\":null,\"wheelbase\":\"0\",\"unladen_weight\":\"105\",\"vehicle_category_description\":\"M-Cycle/Scooter(2WN)\",\"pucc_number\":\"HR05600930009115\",\"pucc_upto\":\"2026-04-20\",\"permit_number\":\"\",\"permit_issue_date\":null,\"permit_valid_from\":null,\"permit_valid_upto\":null,\"permit_type\":\"\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"masked_name\":false,\"challan_details\":null,\"variant\":null,\"rto_code\":\"\",\"response_metadata\":{\"masked_chassis\":false,\"masked_engine\":false,\"masked_owner_name\":false}}', 'uploads/vehicles/HR31H8982_front_image_1775588334.jpg', 'uploads/vehicles/HR31H8982_back_image_1775588334.jpg', 'Active', '2026-04-07 18:58:54'),
(4, 14, 8, 'RJ53TA0074', 'ANIL KUMAR', 'MARUTI SUZUKI INDIA LTD', 'TOUR S STD(O) CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '5', 'Motor Cab(LPV)', '2022-03-10', '2028-03-09', 'The New India Assurance Company Limited', '98000031250317372897', '2026-06-12', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [Taxi Cab]', '2027-03-14', '{\"client_id\":\"rc_wJDqvVXDskzfaFtmEfih\",\"rc_number\":\"RJ53TA0074\",\"fit_up_to\":\"2028-03-09\",\"registration_date\":\"2022-03-10\",\"owner_name\":\"ANIL KUMAR\",\"father_name\":\"\",\"present_address\":\"WARD NO.-5 KALAKHARI, TEH. BUHANA, ., Jhunjhunun, Rajasthan,\",\"permanent_address\":\"WARD NO.-5 KALAKHARI, TEH. BUHANA, ., Jhunjhunun, Rajasthan,\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3EJKD1S00C88671\",\"vehicle_engine_number\":\"K12MN2425807\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR S STD(O) CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"CHOLANAMANDALAM INVEST & FIN CO LTD\",\"financed\":true,\"insurance_company\":\"The New India Assurance Company Limited\",\"insurance_policy_number\":\"98000031250317372897\",\"insurance_upto\":\"2026-06-12\",\"manufacturing_date\":\"2/2022\",\"manufacturing_date_formatted\":\"2022-02\",\"registered_at\":\"KHETRI DTO, Rajasthan\",\"latest_by\":\"2026-04-12\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1480\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2430\",\"unladen_weight\":\"1045\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"UK01800020041455\",\"pucc_upto\":\"2027-02-21\",\"permit_number\":\"RJ2022-AITP-0832A\",\"permit_issue_date\":\"2022-03-15\",\"permit_valid_from\":\"2022-03-15\",\"permit_valid_upto\":\"2027-03-14\",\"permit_type\":\"Tourist Permit [Taxi Cab]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"masked_name\":false,\"challan_details\":null,\"variant\":null,\"rto_code\":\"\",\"response_metadata\":{\"masked_chassis\":false,\"masked_engine\":false,\"masked_owner_name\":false}}', 'uploads/vehicles/RJ53TA0074_front_image_1776008737.jpg', 'uploads/vehicles/RJ53TA0074_back_image_1776008737.jpg', 'Inactive', '2026-04-12 15:45:37'),
(6, 24, NULL, 'HR55BB0491', 'ATINDER PAL SINGH', 'TOYOTA KIRLOSKAR MOTOR PVT LTD', 'INNOVA CRYSTA 2.4G (GX+, MT)', 'STATION WAGON', 'DIESEL', 'SILVER METALLIC', '8', 'Maxi Cab(LPV)', '2026-02-19', '2028-02-18', 'SBI General', '0TSB/000031905', '2027-02-01', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2027-02-24', '{\"client_id\":\"rc_exmMeejMrxingeNyORXM\",\"rc_number\":\"HR55BB0491\",\"fit_up_to\":\"2028-02-18\",\"registration_date\":\"2026-02-19\",\"owner_name\":\"ATINDER PAL SINGH\",\"father_name\":\"\",\"present_address\":\"FLAT A 6 UPPER GROUND FLOOR , PLOT NO 518 BLOCK A 1 VENDASH,APARTMENT NEB SARAI,  -110068\",\"permanent_address\":\"FLAT A 6 UPPER GROUND FLOOR , PLOT NO 518 BLOCK A 1 VENDASH,APARTMENT NEB SARAI,  -110068\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MBJJB8EM201703255~0126\",\"vehicle_engine_number\":\"2GDA931989\",\"maker_description\":\"TOYOTA KIRLOSKAR MOTOR PVT LTD\",\"maker_model\":\"INNOVA CRYSTA 2.4G (GX+, MT)\",\"body_type\":\"STATION WAGON\",\"fuel_type\":\"DIESEL\",\"color\":\"SILVER METALLIC\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"\",\"financed\":false,\"insurance_company\":\"SBI General\",\"insurance_policy_number\":\"0TSB/000031905\",\"insurance_upto\":\"2027-02-01\",\"manufacturing_date\":\"1/2026\",\"manufacturing_date_formatted\":\"2026-01\",\"registered_at\":\"RTA, GURGAON, Haryana\",\"latest_by\":\"2026-05-06\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"2027-01-31\",\"cubic_capacity\":\"2393.00\",\"vehicle_gross_weight\":\"2490\",\"no_cylinders\":\"4\",\"seat_capacity\":\"8\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2750\",\"unladen_weight\":\"1860\",\"vehicle_category_description\":\"Maxi Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2027-02-18\",\"permit_number\":\"HR2026-AITP-3789A\",\"permit_issue_date\":null,\"permit_valid_from\":\"2026-02-20\",\"permit_valid_upto\":\"2027-02-24\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"HR2026-AITP-3789A\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"masked_name\":false,\"challan_details\":null,\"variant\":null,\"rto_code\":\"\",\"response_metadata\":{\"masked_chassis\":false,\"masked_engine\":false,\"masked_owner_name\":false}}', 'uploads/vehicles/HR55BB0491_front_image_1778049818.jpg', 'uploads/vehicles/HR55BB0491_back_image_1778049818.jpg', 'Active', '2026-05-06 06:43:38'),
(7, 24, NULL, 'HR38AH4456', 'ATINDER PAL SINGH', 'MARUTI SUZUKI INDIA LTD', 'ERTIGA VXI (O) CNG', 'SALOON', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2024-11-08', '2026-11-07', 'Bajaj General Insurance Co. Ltd.', 'OG-26-9910-1803-00067706', '2026-10-27', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2029-11-11', '{\"client_id\":\"rc_VccObAYynlfGzouRrmmx\",\"rc_number\":\"HR38AH4456\",\"fit_up_to\":\"2026-11-07\",\"registration_date\":\"2024-11-08\",\"owner_name\":\"ATINDER PAL SINGH\",\"father_name\":\"\",\"present_address\":\"FLAT NO A6 UPPER GROUND FLOOR, PLOT NO 518 BLOCK A1 VENDASH, APARTMENT NEB SARAI, New Delhi, Delhi,\",\"permanent_address\":\"FLAT NO A6 UPPER GROUND FLOOR, PLOT NO 518 BLOCK A1 VENDASH, APARTMENT NEB SARAI, New Delhi, Delhi,\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SRK904134\",\"vehicle_engine_number\":\"K15CN9628558\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"ERTIGA VXI (O) CNG\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"MAHINDRA & MAHINDRA FNCL SRV LTD\",\"financed\":true,\"insurance_company\":\"Bajaj General Insurance Co. Ltd.\",\"insurance_policy_number\":\"OG-26-9910-1803-00067706\",\"insurance_upto\":\"2026-10-27\",\"manufacturing_date\":\"10/2024\",\"manufacturing_date_formatted\":\"2024-10\",\"registered_at\":\"RTA, FARIDABAD, Haryana\",\"latest_by\":\"2026-05-06\",\"less_info\":true,\"tax_upto\":\"2027-09-30\",\"tax_paid_upto\":\"2027-09-30\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1250\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"DL01101540044773\",\"pucc_upto\":\"2026-11-05\",\"permit_number\":\"HR2024-AITP-9402C\",\"permit_issue_date\":\"2024-11-12\",\"permit_valid_from\":\"2024-11-12\",\"permit_valid_upto\":\"2029-11-11\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"masked_name\":false,\"challan_details\":null,\"variant\":null,\"rto_code\":\"\",\"response_metadata\":{\"masked_chassis\":false,\"masked_engine\":false,\"masked_owner_name\":false}}', 'uploads/vehicles/HR38AH4456_front_image_1778053664.jpg', 'uploads/vehicles/HR38AH4456_back_image_1778053664.jpg', 'Active', '2026-05-06 07:47:44'),
(9, 29, NULL, 'RJ01TA5304', 'INDIA 2 WORLD DMC', 'MARUTI SUZUKI INDIA LTD', 'ERTIGA VXI (O) CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'MAGMA GRAY', '7', 'Motor Cab(LPV)', '2023-09-25', '2027-09-24', 'The New India Assurance Company Limited', '98000031250317590980', '2026-09-18', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [Taxi Cab]', '2028-10-10', '{\"client_id\":\"rc_YkmNyZowuCBRllxxqUyJ\",\"rc_number\":\"RJ01TA5304\",\"fit_up_to\":\"2027-09-24\",\"registration_date\":\"2023-09-25\",\"owner_name\":\"INDIA 2 WORLD DMC\",\"father_name\":\"\",\"present_address\":\"SHIV NAGAR, 1447/28 SAAT PIPLI, ADARSH NAGAR, Ajmer, Rajasthan, 305001\",\"permanent_address\":\"SHIV NAGAR, 1447/28 SAAT PIPLI, ADARSH NAGAR, Ajmer, Rajasthan, 305001\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SPJ673224\",\"vehicle_engine_number\":\"K15CN9323941\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"ERTIGA VXI (O) CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"MAGMA GRAY\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"\",\"financed\":false,\"insurance_company\":\"The New India Assurance Company Limited\",\"insurance_policy_number\":\"98000031250317590980\",\"insurance_upto\":\"2026-09-18\",\"manufacturing_date\":\"9/2023\",\"manufacturing_date_formatted\":\"2023-09\",\"registered_at\":\"AJMER RTO, Rajasthan\",\"latest_by\":\"2026-05-06\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1250\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"UP01405030011108\",\"pucc_upto\":\"2026-08-05\",\"permit_number\":\"RJ2023-AITP-6184A\",\"permit_issue_date\":\"2023-10-11\",\"permit_valid_from\":\"2023-10-11\",\"permit_valid_upto\":\"2028-10-10\",\"permit_type\":\"Tourist Permit [Taxi Cab]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"masked_name\":false,\"challan_details\":null,\"variant\":null,\"rto_code\":\"\",\"response_metadata\":{\"masked_chassis\":false,\"masked_engine\":false,\"masked_owner_name\":false}}', 'uploads/vehicles/RJ01TA5304_front_image_1778068849.jpg', 'uploads/vehicles/RJ01TA5304_back_image_1778068849.jpg', 'Active', '2026-05-06 12:00:49'),
(10, 67, NULL, 'HR67E9785', 'MAROOF ALI', 'MARUTI SUZUKI INDIA LTD', 'WAGON R VXI CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'SUPERIOR WHITE', '5', 'Motor Cab(LPV)', '2023-12-07', '2027-12-26', 'Bajaj General Insurance Co. Ltd.', 'OG-26-9910-1803-00079829', '2026-12-01', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2028-12-11', '{\"client_id\":\"rc_azjjsyFOzqxWbroJsjue\",\"rc_number\":\"HR67E9785\",\"fit_up_to\":\"2027-12-26\",\"registration_date\":\"2023-12-07\",\"owner_name\":\"MAROOF ALI\",\"father_name\":\"\",\"present_address\":\"0,POST GARHI BESIK, PATHARGARH, , Panipat, Haryana,\",\"permanent_address\":\"0,POST GARHI BESIK, PATHARGARH, , Panipat, Haryana,\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3JMTB1SPK993018\",\"vehicle_engine_number\":\"K10CNC454732\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"WAGON R VXI CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"SUPERIOR WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"SHRI RAM FINANCE LTD\",\"financed\":true,\"insurance_company\":\"Bajaj General Insurance Co. Ltd.\",\"insurance_policy_number\":\"OG-26-9910-1803-00079829\",\"insurance_upto\":\"2026-12-01\",\"manufacturing_date\":\"10/2023\",\"manufacturing_date_formatted\":\"2023-10\",\"registered_at\":\"RTA, PANIPAT, Haryana\",\"latest_by\":\"2026-05-06\",\"less_info\":true,\"tax_upto\":\"2026-09-30\",\"tax_paid_upto\":\"2026-09-30\",\"cubic_capacity\":\"998.00\",\"vehicle_gross_weight\":\"1340\",\"no_cylinders\":\"3\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2435\",\"unladen_weight\":\"920\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR06700160040651\",\"pucc_upto\":\"2027-03-30\",\"permit_number\":\"HR2023-AITP-9030C\",\"permit_issue_date\":\"2023-12-12\",\"permit_valid_from\":\"2023-12-12\",\"permit_valid_upto\":\"2028-12-11\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"masked_name\":false,\"challan_details\":null,\"variant\":null,\"rto_code\":\"\",\"response_metadata\":{\"masked_chassis\":false,\"masked_engine\":false,\"masked_owner_name\":false}}', 'uploads/vehicles/HR67E9785_front_image_1778076883.jpg', 'uploads/vehicles/HR67E9785_back_image_1778076883.jpg', 'Active', '2026-05-06 14:14:43'),
(11, 21, NULL, 'UP14ST4009', 'SARTAJ SALEEM', 'HYUNDAI MOTOR INDIA LTD', 'AURA 1.2MT CNG S', 'SALOON', 'PETROL/CNG', 'STARRY NIGHT', '5', 'Motor Cab(LPV)', '2025-12-24', '2027-12-23', 'Shriram General Insurance  Co. Ltd.', '108047/31/26/006701', '2026-12-16', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA]', '2030-12-30', '{\"client_id\":\"rc_JtbrmgdsKNnpVazcCoSB\",\"rc_number\":\"UP14ST4009\",\"fit_up_to\":\"2027-12-23\",\"registration_date\":\"2025-12-24\",\"owner_name\":\"SARTAJ SALEEM\",\"father_name\":\"\",\"present_address\":\"Ghaziabad, 201002\",\"permanent_address\":\"Ghaziabad, 201002\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MALB241CLSM428590\",\"vehicle_engine_number\":\"G4LASM610639\",\"maker_description\":\"HYUNDAI MOTOR INDIA LTD\",\"maker_model\":\"AURA 1.2MT CNG S\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"STARRY NIGHT\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"AU SMALL FINANCE BANK LIMITED\",\"financed\":true,\"insurance_company\":\"Shriram General Insurance  Co. Ltd.\",\"insurance_policy_number\":\"108047/31/26/006701\",\"insurance_upto\":\"2026-12-16\",\"manufacturing_date\":\"11/2025\",\"manufacturing_date_formatted\":\"2025-11\",\"registered_at\":\"GHAZIABAD, Uttar Pradesh\",\"latest_by\":\"2026-05-06\",\"less_info\":true,\"tax_upto\":\"2026-11-30\",\"tax_paid_upto\":\"2026-11-30\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1500\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1052\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"UP01603650016736\",\"pucc_upto\":\"2027-03-30\",\"permit_number\":\"UP2025-AITP-4778D\",\"permit_issue_date\":\"2025-12-31\",\"permit_valid_from\":\"2025-12-31\",\"permit_valid_upto\":\"2030-12-30\",\"permit_type\":\"Tourist Permit [ALL INDIA]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"masked_name\":false,\"challan_details\":null,\"variant\":null,\"rto_code\":\"\",\"response_metadata\":{\"masked_chassis\":false,\"masked_engine\":false,\"masked_owner_name\":false}}', 'uploads/vehicles/UP14ST4009_front_image_1778087314.jpg', 'uploads/vehicles/UP14ST4009_back_image_1778087314.jpg', 'Active', '2026-05-06 17:08:34'),
(13, 72, NULL, 'HR55AH1009', 'BALESHWAR SHARMA', 'MARUTI SUZUKI INDIA LTD', 'TOUR M CNG', 'SALOON', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2019-12-10', '2027-12-09', 'Shriram General Insurance  Co. Ltd.', '101023/31/27/000800', '2026-07-16', 'BHARAT STAGE IV', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2026-12-10', '{\"client_id\":\"rc_lzqfigjJrUKMgBcJlzhU\",\"rc_number\":\"HR55AH1009\",\"fit_up_to\":\"2027-12-09\",\"registration_date\":\"2019-12-10\",\"owner_name\":\"BALESHWAR SHARMA\",\"father_name\":\"\",\"present_address\":\"144, NEAR HANUMAN MANDIR, KHANDSA, , Gurgaon, Haryana,\",\"permanent_address\":\"144, NEAR HANUMAN MANDIR, KHANDSA, , Gurgaon, Haryana,\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC22SKL205528\",\"vehicle_engine_number\":\"K15BN1099767\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR M CNG\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE IV\",\"financer\":\"INDO STAR CAPITAL FIN.LTD\",\"financed\":true,\"insurance_company\":\"Shriram General Insurance  Co. Ltd.\",\"insurance_policy_number\":\"101023/31/27/000800\",\"insurance_upto\":\"2026-07-16\",\"manufacturing_date\":\"11/2019\",\"manufacturing_date_formatted\":\"2019-11\",\"registered_at\":\"RTA, GURGAON, Haryana\",\"latest_by\":\"2026-05-07\",\"less_info\":true,\"tax_upto\":\"2026-12-31\",\"tax_paid_upto\":\"2026-12-31\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1795\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1235\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR04500400020714\",\"pucc_upto\":\"2026-12-16\",\"permit_number\":\"HR/55/AITP/LPV/2019/7126\",\"permit_issue_date\":\"2019-12-11\",\"permit_valid_from\":\"2025-12-11\",\"permit_valid_upto\":\"2026-12-10\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"2\",\"rc_status\":\"ACTIVE\",\"masked_name\":false,\"challan_details\":null,\"variant\":null,\"rto_code\":\"\",\"response_metadata\":{\"masked_chassis\":false,\"masked_engine\":false,\"masked_owner_name\":false}}', 'uploads/vehicles/HR55AH1009_front_image_1778131190.jpg', 'uploads/vehicles/HR55AH1009_back_image_1778131190.jpg', 'Active', '2026-05-07 05:19:50'),
(14, 75, NULL, 'HR58C1560', 'MOSEEM RAO', 'MARUTI SUZUKI INDIA LTD', 'TOUR S CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '5', 'Motor Cab(LPV)', '2023-11-16', '2027-11-15', 'Universal Sompo General Insurance  Co. Ltd.', 'AVO/2314/20018069', '2026-07-06', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2028-11-15', '{\"client_id\":\"rc_vHMpJnUcovSUvZHzJBGU\",\"rc_number\":\"HR58C1560\",\"fit_up_to\":\"2027-11-15\",\"registration_date\":\"2023-11-16\",\"owner_name\":\"MOSEEM RAO\",\"father_name\":\"\",\"present_address\":\"5/309, W.NO- 20, PATHANA MOHALLA, TEH- CHHACHHRAULI, Yamunanagar, Haryana,\",\"permanent_address\":\"5/309, W.NO- 20, PATHANA MOHALLA, TEH- CHHACHHRAULI, Yamunanagar, Haryana,\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MBHCZFB3SPJ477271\",\"vehicle_engine_number\":\"K12NP7355302\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR S CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"ICICI BANK LIMITED\",\"financed\":true,\"insurance_company\":\"Universal Sompo General Insurance  Co. Ltd.\",\"insurance_policy_number\":\"AVO/2314/20018069\",\"insurance_upto\":\"2026-07-06\",\"manufacturing_date\":\"9/2023\",\"manufacturing_date_formatted\":\"2023-09\",\"registered_at\":\"RTA, YNR, Haryana\",\"latest_by\":\"2026-05-07\",\"less_info\":true,\"tax_upto\":\"2026-05-31\",\"tax_paid_upto\":\"2026-05-31\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1405\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"970\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"DL01100940036958\",\"pucc_upto\":\"2027-03-31\",\"permit_number\":\"HR2023-AITP-7456C\",\"permit_issue_date\":\"2023-11-16\",\"permit_valid_from\":\"2023-11-16\",\"permit_valid_upto\":\"2028-11-15\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"masked_name\":false,\"challan_details\":null,\"variant\":null,\"rto_code\":\"\",\"response_metadata\":{\"masked_chassis\":false,\"masked_engine\":false,\"masked_owner_name\":false}}', 'uploads/vehicles/HR58C1560_front_image_1778137395.jpg', 'uploads/vehicles/HR58C1560_back_image_1778137395.jpg', 'Active', '2026-05-07 07:03:15'),
(15, 4, 7, 'HR55BC1321', 'A*****R P*L S***H', 'TOYOTA KIRLOSKAR MOTOR PVT LTD', 'INNOVA HYCROSS HYBRID VX(8S)', 'PASSANGER CAR', 'STRONG HYBRID EV', 'SUPER WHITE', '8', 'Maxi Cab(LPV)', '2026-05-05', '2028-05-04', 'SBI General', '0TSB/000074473', '2027-03-30', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2031-05-06', '{\"client_id\":\"rc_v2_gafjJwwWuREutKywSacy\",\"rc_number\":\"HR55BC1321\",\"fit_up_to\":\"2028-05-04\",\"registration_date\":\"2026-05-05\",\"owner_name\":\"A*****R P*L S***H\",\"father_name\":\"\",\"present_address\":\"Gurgaon, 122001\",\"permanent_address\":\"South, 110068\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MBJABBAA001552778*****\",\"vehicle_engine_number\":\"M20ANF*****\",\"maker_description\":\"TOYOTA KIRLOSKAR MOTOR PVT LTD\",\"maker_model\":\"INNOVA HYCROSS HYBRID VX(8S)\",\"body_type\":\"PASSANGER CAR\",\"fuel_type\":\"STRONG HYBRID EV\",\"color\":\"SUPER WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"ICICI BANK LTD\",\"financed\":true,\"insurance_company\":\"SBI General\",\"insurance_policy_number\":\"0TSB/000074473\",\"insurance_upto\":\"2027-03-30\",\"manufacturing_date\":\"2/2026\",\"manufacturing_date_formatted\":\"2026-02\",\"registered_at\":\"RTA, GURGAON, Haryana\",\"latest_by\":\"2026-05-07\",\"less_info\":true,\"tax_upto\":\"2027-03-31\",\"tax_paid_upto\":\"2027-03-31\",\"cubic_capacity\":\"1987.00\",\"vehicle_gross_weight\":\"2320\",\"no_cylinders\":\"4\",\"seat_capacity\":\"8\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2850\",\"unladen_weight\":\"1630\",\"vehicle_category_description\":\"Maxi Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2027-05-04\",\"permit_number\":\"HR2026-AITP-5815B\",\"permit_issue_date\":\"2026-05-07\",\"permit_valid_from\":\"2026-05-07\",\"permit_valid_upto\":\"2031-05-06\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR55BC1321_front_image_1778186580.jpg', 'uploads/vehicles/HR55BC1321_back_image_1778186580.jpg', 'Active', '2026-05-07 20:43:00'),
(16, 117, NULL, 'HR38AF0552', 'A***R A****D', 'HYUNDAI MOTOR INDIA LTD', 'AURA 1.2MT CNG S', 'SALOON', 'PETROL/CNG', 'TITAN GREY', '5', 'Motor Cab(LPV)', '2023-09-08', '2027-09-07', 'IFFCO Tokio General Insurance Co. Ltd.', '56348771', '2026-08-24', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2028-09-21', '{\"client_id\":\"rc_v2_TaobhtJpYCynOhMFYmnL\",\"rc_number\":\"HR38AF0552\",\"fit_up_to\":\"2027-09-07\",\"registration_date\":\"2023-09-08\",\"owner_name\":\"A***R A****D\",\"father_name\":\"\",\"present_address\":\"Faridabad, 121001\",\"permanent_address\":\"East, 110094\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MALB241CLPM2*****\",\"vehicle_engine_number\":\"G4LAPM5*****\",\"maker_description\":\"HYUNDAI MOTOR INDIA LTD\",\"maker_model\":\"AURA 1.2MT CNG S\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"TITAN GREY\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"SHRIRAM FINANCE LTD\",\"financed\":true,\"insurance_company\":\"IFFCO Tokio General Insurance Co. Ltd.\",\"insurance_policy_number\":\"56348771\",\"insurance_upto\":\"2026-08-24\",\"manufacturing_date\":\"6/2023\",\"manufacturing_date_formatted\":\"2023-06\",\"registered_at\":\"RTA, FARIDABAD, Haryana\",\"latest_by\":\"2026-05-08\",\"less_info\":true,\"tax_upto\":\"2026-05-31\",\"tax_paid_upto\":\"2026-05-31\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1500\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1052\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"UP01500530018890\",\"pucc_upto\":\"2026-10-06\",\"permit_number\":\"HR2023-AITP-4320C\",\"permit_issue_date\":\"2023-09-22\",\"permit_valid_from\":\"2023-09-22\",\"permit_valid_upto\":\"2028-09-21\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR38AF0552_front_image_1778206325.jpg', 'uploads/vehicles/HR38AF0552_back_image_1778206325.jpg', 'Active', '2026-05-08 02:12:05'),
(17, 85, 8, 'PB01C2250', 'H*******R S***H', 'HYUNDAI MOTOR INDIA LTD', 'XCENT VTVT PRIME T CNG', 'MOTOR CAB', 'PETROL/CNG', 'POLAR WHITE', '5', 'Motor Cab(LPV)', '2019-03-27', '2027-12-01', 'Universal Sompo General Insurance  Co. Ltd.', 'AVO/2373/20009922', '2026-05-19', 'BHARAT STAGE IV', 'ACTIVE', 'Tourist Permit [TVP(MOTOR CAB)]', '2028-05-01', '{\"client_id\":\"rc_v2_hfdOZizHFGcVusbawnpu\",\"rc_number\":\"PB01C2250\",\"fit_up_to\":\"2027-12-01\",\"registration_date\":\"2019-03-27\",\"owner_name\":\"H*******R S***H\",\"father_name\":\"\",\"present_address\":\"Sahibzada Ajit Singh Nagar, 140308\",\"permanent_address\":\"Sahibzada Ajit Singh Nagar, 140308\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MALA741CLJM3*****\",\"vehicle_engine_number\":\"G4LAJM0*****\",\"maker_description\":\"HYUNDAI MOTOR INDIA LTD\",\"maker_model\":\"XCENT VTVT PRIME T CNG\",\"body_type\":\"MOTOR CAB\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"POLAR WHITE\",\"norms_type\":\"BHARAT STAGE IV\",\"financer\":\"INDUSIND BANK LTD\",\"financed\":true,\"insurance_company\":\"Universal Sompo General Insurance  Co. Ltd.\",\"insurance_policy_number\":\"AVO/2373/20009922\",\"insurance_upto\":\"2026-05-19\",\"manufacturing_date\":\"9/2018\",\"manufacturing_date_formatted\":\"2018-09\",\"registered_at\":\"PUNJAB STA(RAC)/(AITP), Punjab\",\"latest_by\":\"2026-05-08\",\"less_info\":true,\"tax_upto\":\"2026-04-30\",\"tax_paid_upto\":\"2026-04-30\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1450\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2425\",\"unladen_weight\":\"1048\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR03802080022815\",\"pucc_upto\":\"2026-11-16\",\"permit_number\":\"PB/1/AITP/TVP/2019/1039\",\"permit_issue_date\":\"2019-04-03\",\"permit_valid_from\":\"2024-05-02\",\"permit_valid_upto\":\"2028-05-01\",\"permit_type\":\"Tourist Permit [TVP(MOTOR CAB)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/PB01C2250_front_image_1778262963.jpg', 'uploads/vehicles/PB01C2250_back_image_1778262963.jpg', 'Inactive', '2026-05-08 17:56:03'),
(19, 95, 8, 'DL1ZD8581', 'M*******N', 'MARUTI SUZUKI INDIA LTD', 'TOUR S CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '5', 'Motor Cab(LPV)', '2024-12-26', '2026-12-25', 'Shriram General Insurance  Co. Ltd.', '101023/31/26/010861', '2027-01-21', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [TOURIST TAXI(DELUXE)]', '2030-01-12', '{\"client_id\":\"rc_v2_uowOaiWlobeXwioeOZbL\",\"rc_number\":\"DL1ZD8581\",\"fit_up_to\":\"2026-12-25\",\"registration_date\":\"2024-12-26\",\"owner_name\":\"M*******N\",\"father_name\":\"\",\"present_address\":\"New Delhi, 110015\",\"permanent_address\":\"New Delhi, 110015\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3CZFB3SRL9*****\",\"vehicle_engine_number\":\"K12NN11*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR S CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"AU Small Finance Bank Limited\",\"financed\":true,\"insurance_company\":\"Shriram General Insurance  Co. Ltd.\",\"insurance_policy_number\":\"101023/31/26/010861\",\"insurance_upto\":\"2027-01-21\",\"manufacturing_date\":\"11/2024\",\"manufacturing_date_formatted\":\"2024-11\",\"registered_at\":\"BURARI TAXI UNIT, Delhi\",\"latest_by\":\"2026-05-08\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1405\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"970\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"DL01000760091505\",\"pucc_upto\":\"2026-12-24\",\"permit_number\":\"DL2025-AITP-0066A\",\"permit_issue_date\":\"2025-01-14\",\"permit_valid_from\":\"2025-01-13\",\"permit_valid_upto\":\"2030-01-12\",\"permit_type\":\"Tourist Permit [TOURIST TAXI(DELUXE)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/DL1ZD8581_front_image_1778287556.jpg', 'uploads/vehicles/DL1ZD8581_back_image_1778287556.jpg', 'Active', '2026-05-09 00:45:56'),
(20, 77, 0, 'HR38AH6433', 'R*J K***R', 'HYUNDAI MOTOR INDIA LTD', 'AURA 1.2MT CNG S', 'SALOON', 'PETROL/CNG', 'ATLAS WHITE', '5', 'Motor Cab(LPV)', '2024-06-13', '2026-06-12', 'SBI General', 'POCMVPC0100334053', '2026-05-28', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2029-06-19', '{\"client_id\":\"rc_v2_ReklrlXRnEfgAdQeTkdL\",\"rc_number\":\"HR38AH6433\",\"fit_up_to\":\"2026-06-12\",\"registration_date\":\"2024-06-13\",\"owner_name\":\"R*J K***R\",\"father_name\":\"\",\"present_address\":\"Faridabad, 121004\",\"permanent_address\":\"West, 110059\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MALB241CLRM2*****\",\"vehicle_engine_number\":\"G4LARM9*****\",\"maker_description\":\"HYUNDAI MOTOR INDIA LTD\",\"maker_model\":\"AURA 1.2MT CNG S\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"ATLAS WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"AU SMALL FINANCE BANK LTD.\",\"financed\":true,\"insurance_company\":\"SBI General\",\"insurance_policy_number\":\"POCMVPC0100334053\",\"insurance_upto\":\"2026-05-28\",\"manufacturing_date\":\"4/2024\",\"manufacturing_date_formatted\":\"2024-04\",\"registered_at\":\"RTA, FARIDABAD, Haryana\",\"latest_by\":\"2026-05-09\",\"less_info\":true,\"tax_upto\":\"2026-06-30\",\"tax_paid_upto\":\"2026-06-30\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1500\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1052\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"UP01502230047621\",\"pucc_upto\":\"2026-06-11\",\"permit_number\":\"HR2024-AITP-5793B\",\"permit_issue_date\":\"2024-06-20\",\"permit_valid_from\":\"2024-06-20\",\"permit_valid_upto\":\"2029-06-19\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR38AH6433_front_image_1778289169.jpg', 'uploads/vehicles/HR38AH6433_back_image_1778289169.jpg', 'Active', '2026-05-09 01:12:49'),
(21, 101, 0, 'UP85BT5291', 'S***M S****R', 'MARUTI SUZUKI INDIA LTD', 'MARUTI TOUR S DIESEL', 'RIGID (PASSENGER CAR)', 'DIESEL', 'PEARL ARCTIC WHITE', '5', 'Motor Cab(LPV)', '2019-01-14', '2027-01-29', 'Tata AIG General Insurance Co. Ltd.', '63700548820000', '2026-07-03', 'BHARAT STAGE IV', 'ACTIVE', 'Tourist Permit [ALL INDIA]', '2029-01-17', '{\"client_id\":\"rc_v2_JmcdVetsHmueNhHHxPnW\",\"rc_number\":\"UP85BT5291\",\"fit_up_to\":\"2027-01-29\",\"registration_date\":\"2019-01-14\",\"owner_name\":\"S***M S****R\",\"father_name\":\"\",\"present_address\":\"Mathura, 281001\",\"permanent_address\":\"Mathura, 281001\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3FJEB1S00B*****\",\"vehicle_engine_number\":\"D13A-34*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"MARUTI TOUR S DIESEL\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"DIESEL\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE IV\",\"financer\":\"INDUSIND BANK LTD.\",\"financed\":true,\"insurance_company\":\"Tata AIG General Insurance Co. Ltd.\",\"insurance_policy_number\":\"63700548820000\",\"insurance_upto\":\"2026-07-03\",\"manufacturing_date\":\"11/2018\",\"manufacturing_date_formatted\":\"2018-11\",\"registered_at\":\"MATHURA, Uttar Pradesh\",\"latest_by\":\"2026-05-09\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"1248.00\",\"vehicle_gross_weight\":\"1505\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2430\",\"unladen_weight\":\"1045\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"UP08500920003874\",\"pucc_upto\":\"2026-12-06\",\"permit_number\":\"UP/80/AITP/2019/74\",\"permit_issue_date\":\"2019-01-18\",\"permit_valid_from\":\"2024-01-18\",\"permit_valid_upto\":\"2029-01-17\",\"permit_type\":\"Tourist Permit [ALL INDIA]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/UP85BT5291_front_image_1778290288.jpg', 'uploads/vehicles/UP85BT5291_back_image_1778290288.jpg', 'Active', '2026-05-09 01:31:28'),
(22, 127, 0, 'GA03V0728', 'A***H G***I', 'MARUTI SUZUKI INDIA LTD', 'DZIRE LXI', 'SALOON', 'PETROL', 'METALLIC PREMIUM SIL', '5', 'Motor Cab(LPV)', '2023-05-18', '2027-05-21', 'Bajaj General Insurance Co. Ltd.', 'OG-26-9910-1803-00011162', '2026-05-17', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [Tourist Taxi Permit]', '2028-06-12', '{\"client_id\":\"rc_v2_fUSaujjgPrydpXSgdjds\",\"rc_number\":\"GA03V0728\",\"fit_up_to\":\"2027-05-21\",\"registration_date\":\"2023-05-18\",\"owner_name\":\"A***H G***I\",\"father_name\":\"\",\"present_address\":\"North Goa, 403513\",\"permanent_address\":\"North Goa, 403513\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MBHCZFB3SPC4*****\",\"vehicle_engine_number\":\"K12NP72*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"DZIRE LXI\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL\",\"color\":\"METALLIC PREMIUM SIL\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"INDUSIND BANK LTD\",\"financed\":true,\"insurance_company\":\"Bajaj General Insurance Co. Ltd.\",\"insurance_policy_number\":\"OG-26-9910-1803-00011162\",\"insurance_upto\":\"2026-05-17\",\"manufacturing_date\":\"4/2023\",\"manufacturing_date_formatted\":\"2023-04\",\"registered_at\":\"MAPUSA RTO, Goa\",\"latest_by\":\"2026-05-08\",\"less_info\":true,\"tax_upto\":\"2027-03-31\",\"tax_paid_upto\":\"2027-03-31\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1335\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"880\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"GAPUC20242233774\",\"pucc_upto\":\"2025-05-17\",\"permit_number\":\"GA2023-AITP-2851A\",\"permit_issue_date\":\"2023-06-13\",\"permit_valid_from\":\"2023-06-13\",\"permit_valid_upto\":\"2028-06-12\",\"permit_type\":\"Tourist Permit [Tourist Taxi Permit]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/GA03V0728_front_image_1778291275.jpg', 'uploads/vehicles/GA03V0728_back_image_1778291275.jpg', 'Active', '2026-05-09 01:47:55'),
(23, 43, 0, 'HR55BC6289', 'D****K K***R', 'HYUNDAI MOTOR INDIA LTD', 'AURA 1.2MT CNG S', 'SALOON', 'PETROL/CNG', 'ATLAS WHITE', '5', 'Motor Cab(LPV)', '2026-04-07', '2028-04-06', 'SBI General', '0HYNDAIHIIB/1590891', '2027-02-22', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2031-04-23', '{\"client_id\":\"rc_v2_sIyBxknRzpBzxXDvrwEJ\",\"rc_number\":\"HR55BC6289\",\"fit_up_to\":\"2028-04-06\",\"registration_date\":\"2026-04-07\",\"owner_name\":\"D****K K***R\",\"father_name\":\"\",\"present_address\":\"Gurgaon, 122001\",\"permanent_address\":\"South, 110062\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MALB241CLTM4*****\",\"vehicle_engine_number\":\"G4LASM5*****\",\"maker_description\":\"HYUNDAI MOTOR INDIA LTD\",\"maker_model\":\"AURA 1.2MT CNG S\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"ATLAS WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"AU SMALL FINANCE BANK LIMITED\",\"financed\":true,\"insurance_company\":\"SBI General\",\"insurance_policy_number\":\"0HYNDAIHIIB/1590891\",\"insurance_upto\":\"2027-02-22\",\"manufacturing_date\":\"1/2026\",\"manufacturing_date_formatted\":\"2026-01\",\"registered_at\":\"RTA, GURGAON, Haryana\",\"latest_by\":\"2026-05-09\",\"less_info\":true,\"tax_upto\":\"2027-02-28\",\"tax_paid_upto\":\"2027-02-28\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1500\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1052\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2027-04-06\",\"permit_number\":\"HR2026-AITP-4464B\",\"permit_issue_date\":\"2026-04-24\",\"permit_valid_from\":\"2026-04-24\",\"permit_valid_upto\":\"2031-04-23\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR55BC6289_front_image_1778296732.jpg', 'uploads/vehicles/HR55BC6289_back_image_1778296732.jpg', 'Active', '2026-05-09 03:18:52'),
(24, 31, 0, 'DL1ZD2704', 'A*****V', 'MARUTI SUZUKI INDIA LTD', 'TOUR M CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2022-02-28', '2028-02-27', 'Shriram General Insurance  Co. Ltd.', '101047/31/26/028997', '2026-06-22', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [TOURIST TAXI(DELUXE)]', '2027-03-04', '{\"client_id\":\"rc_v2_nbhvbrSpRAAfsdxfVtsU\",\"rc_number\":\"DL1ZD2704\",\"fit_up_to\":\"2028-02-27\",\"registration_date\":\"2022-02-28\",\"owner_name\":\"A*****V\",\"father_name\":\"\",\"present_address\":\"North West, 110034\",\"permanent_address\":\"North West, 110034\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC22SNA4*****\",\"vehicle_engine_number\":\"K15BN92*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR M CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"HINDUJA LEYLAND FINANCE LTD\",\"financed\":true,\"insurance_company\":\"Shriram General Insurance  Co. Ltd.\",\"insurance_policy_number\":\"101047/31/26/028997\",\"insurance_upto\":\"2026-06-22\",\"manufacturing_date\":\"1/2022\",\"manufacturing_date_formatted\":\"2022-01\",\"registered_at\":\"BURARI TAXI UNIT, Delhi\",\"latest_by\":\"2026-05-09\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1795\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1235\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR05506640002706\",\"pucc_upto\":\"2027-04-20\",\"permit_number\":\"DL2022-AITP-0267A\",\"permit_issue_date\":\"2022-03-07\",\"permit_valid_from\":\"2022-03-05\",\"permit_valid_upto\":\"2027-03-04\",\"permit_type\":\"Tourist Permit [TOURIST TAXI(DELUXE)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"2\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/DL1ZD2704_front_image_1778297028.jpg', 'uploads/vehicles/DL1ZD2704_back_image_1778297028.jpg', 'Active', '2026-05-09 03:23:48');
INSERT INTO `partner_vehicles` (`id`, `partner_id`, `car_type`, `rc_number`, `owner_name`, `maker_description`, `maker_model`, `body_type`, `fuel_type`, `color`, `seat_capacity`, `vehicle_category_desc`, `registration_date`, `fit_up_to`, `insurance_company`, `insurance_policy_number`, `insurance_upto`, `norms_type`, `rc_status`, `permit_type`, `permit_valid_upto`, `raw_rc_data`, `front_image`, `back_image`, `status`, `created_at`) VALUES
(26, 53, 0, 'RJ06TA2726', 'S*****R L*L G****R', 'TOYOTA KIRLOSKAR MOTOR PVT LTD', 'TOYOTA GLANZA S CNG [MT]', 'PASSENGER CAR', 'PETROL/CNG', 'GAMING GREY.', '5', 'Motor Cab(LPV)', '2023-12-16', '2028-01-05', 'United India Insurance Co. Ltd.', '1413053125P115041494', '2026-12-26', 'BHARAT STAGE VI', 'ACTIVE', 'Contract Carriage Permit [MOTOR CAB]', '2029-01-02', '{\"client_id\":\"rc_v2_thlGYoOovuqycjQRfJAH\",\"rc_number\":\"RJ06TA2726\",\"fit_up_to\":\"2028-01-05\",\"registration_date\":\"2023-12-16\",\"owner_name\":\"S*****R L*L G****R\",\"father_name\":\"\",\"present_address\":\"Bhilwara, 311001\",\"permanent_address\":\"Bhilwara, 311001\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MBHJWC13SPK5*****\",\"vehicle_engine_number\":\"K12NP43*****\",\"maker_description\":\"TOYOTA KIRLOSKAR MOTOR PVT LTD\",\"maker_model\":\"TOYOTA GLANZA S CNG [MT]\",\"body_type\":\"PASSENGER CAR\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"GAMING GREY.\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"INDUSIND BANK LTD\",\"financed\":true,\"insurance_company\":\"United India Insurance Co. Ltd.\",\"insurance_policy_number\":\"1413053125P115041494\",\"insurance_upto\":\"2026-12-26\",\"manufacturing_date\":\"10/2023\",\"manufacturing_date_formatted\":\"2023-10\",\"registered_at\":\"BHILWARA DTO, Rajasthan\",\"latest_by\":\"2026-05-09\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1450\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2520\",\"unladen_weight\":\"1015\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"RJ05900640007620\",\"pucc_upto\":\"2026-03-09\",\"permit_number\":\"RJ2024-CC-0390A\",\"permit_issue_date\":\"2024-01-03\",\"permit_valid_from\":\"2024-01-03\",\"permit_valid_upto\":\"2029-01-02\",\"permit_type\":\"Contract Carriage Permit [MOTOR CAB]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/RJ06TA2726_front_image_1778323999.jpg', 'uploads/vehicles/RJ06TA2726_back_image_1778323999.jpg', 'Active', '2026-05-09 10:53:19'),
(27, 53, 0, 'RJ14TG4535', 'S*****R L*L G****R', 'TOYOTA KIRLOSKAR MOTOR PVT LTD', 'TOYOTA RUMION S CNG [MT]', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'CAFE WHITE', '7', 'Motor Cab(LPV)', '2025-02-05', '2027-02-04', 'United India Insurance Co. Ltd.', '1403013125P116985605', '2027-02-02', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [Taxi Cab]', '2030-03-11', '{\"client_id\":\"rc_v2_BYnzDzuQzEENcAsKEhHp\",\"rc_number\":\"RJ14TG4535\",\"fit_up_to\":\"2027-02-04\",\"registration_date\":\"2025-02-05\",\"owner_name\":\"S*****R L*L G****R\",\"father_name\":\"\",\"present_address\":\"Jaipur, 302017\",\"permanent_address\":\"Bhilwara, 311803\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3DND62SRK9*****\",\"vehicle_engine_number\":\"K15CN96*****\",\"maker_description\":\"TOYOTA KIRLOSKAR MOTOR PVT LTD\",\"maker_model\":\"TOYOTA RUMION S CNG [MT]\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"CAFE WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"TOYOTA FINANCIAL SERVICES INDIA LTD\",\"financed\":true,\"insurance_company\":\"United India Insurance Co. Ltd.\",\"insurance_policy_number\":\"1403013125P116985605\",\"insurance_upto\":\"2027-02-02\",\"manufacturing_date\":\"10/2024\",\"manufacturing_date_formatted\":\"2024-10\",\"registered_at\":\"JAIPUR (FIRST) RTO, Rajasthan\",\"latest_by\":\"2026-05-09\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1250\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"RJ05100120001920\",\"pucc_upto\":\"2027-02-02\",\"permit_number\":\"RJ2025-AITP-1993A\",\"permit_issue_date\":\"2025-03-12\",\"permit_valid_from\":\"2025-03-12\",\"permit_valid_upto\":\"2030-03-11\",\"permit_type\":\"Tourist Permit [Taxi Cab]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/RJ14TG4535_front_image_1778324151.jpg', 'uploads/vehicles/RJ14TG4535_back_image_1778324151.jpg', 'Active', '2026-05-09 10:55:51'),
(28, 151, 8, 'UK04TC0655', 'D***A D**I', 'MARUTI SUZUKI INDIA LTD', 'TOUR S CNG', 'RIGID (PASSENGER CAR)', 'PETROL(E20)/CNG', 'PEARL ARCTIC WHITE', '5', 'Motor Cab(LPV)', '2026-03-27', '2028-03-26', 'Magma General Insurance Limited', 'P0026200001/4103/558525', '2027-03-11', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit', '2031-04-08', '{\"client_id\":\"rc_v2_rnXfrmZbrVzkJsOgpvGa\",\"rc_number\":\"UK04TC0655\",\"fit_up_to\":\"2028-03-26\",\"registration_date\":\"2026-03-27\",\"owner_name\":\"D***A D**I\",\"father_name\":\"\",\"present_address\":\"Almora, 263623\",\"permanent_address\":\"Almora, 263623\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3ZFDFSKTC4*****\",\"vehicle_engine_number\":\"Z12ENF3*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR S CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL(E20)/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"SBI\",\"financed\":true,\"insurance_company\":\"Magma General Insurance Limited\",\"insurance_policy_number\":\"P0026200001/4103/558525\",\"insurance_upto\":\"2027-03-11\",\"manufacturing_date\":\"3/2026\",\"manufacturing_date_formatted\":\"2026-03\",\"registered_at\":\"HALDWANI RTO, Uttarakhand\",\"latest_by\":\"2026-05-09\",\"less_info\":true,\"tax_upto\":\"2026-05-31\",\"tax_paid_upto\":\"2026-05-31\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1435\",\"no_cylinders\":\"3\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1010\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR04704020001821\",\"pucc_upto\":\"2027-04-17\",\"permit_number\":\"UK2026-AITP-2342A\",\"permit_issue_date\":\"2026-04-09\",\"permit_valid_from\":\"2026-04-09\",\"permit_valid_upto\":\"2031-04-08\",\"permit_type\":\"Tourist Permit\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/UK04TC0655_front_image_1778328366.jpg', 'uploads/vehicles/UK04TC0655_back_image_1778328366.jpg', 'Active', '2026-05-09 12:06:06'),
(29, 107, 0, 'HR55AS5876', 'M***T G***A', 'MARUTI SUZUKI INDIA LTD', 'TOUR M (O) CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2024-03-20', '2028-03-19', 'Bajaj General Insurance Co. Ltd.', 'OG-26-9910-1803-00081531', '2026-12-05', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2029-04-15', '{\"client_id\":\"rc_v2_uswVCYARlhinEgsojFAD\",\"rc_number\":\"HR55AS5876\",\"fit_up_to\":\"2028-03-19\",\"registration_date\":\"2024-03-20\",\"owner_name\":\"M***T G***A\",\"father_name\":\"\",\"present_address\":\"Gurgaon, 122002\",\"permanent_address\":\"Gurgaon, 122002\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SPK6*****\",\"vehicle_engine_number\":\"K15CN93*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR M (O) CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"MAHINDRA & MAHINDRA FINANCIAL SERVI\",\"financed\":true,\"insurance_company\":\"Bajaj General Insurance Co. Ltd.\",\"insurance_policy_number\":\"OG-26-9910-1803-00081531\",\"insurance_upto\":\"2026-12-05\",\"manufacturing_date\":\"10/2023\",\"manufacturing_date_formatted\":\"2023-10\",\"registered_at\":\"RTA, GURGAON, Haryana\",\"latest_by\":\"2026-05-09\",\"less_info\":true,\"tax_upto\":\"2026-06-30\",\"tax_paid_upto\":\"2026-06-30\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1250\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"UK01400230015676\",\"pucc_upto\":\"2027-03-17\",\"permit_number\":\"HR2024-AITP-9504A\",\"permit_issue_date\":\"2024-04-16\",\"permit_valid_from\":\"2024-04-16\",\"permit_valid_upto\":\"2029-04-15\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR55AS5876_front_image_1778334054.jpg', 'uploads/vehicles/HR55AS5876_back_image_1778334054.jpg', 'Active', '2026-05-09 13:40:54'),
(30, 152, 0, 'HR55AV6512', 'S****N K***R', 'MARUTI SUZUKI INDIA LTD', 'DZIRE VXI CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '5', 'Motor Cab(LPV)', '2024-12-06', '2026-12-05', 'Magma General Insurance Limited', 'P0026200001/4103/538578', '2026-11-21', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2029-12-08', '{\"client_id\":\"rc_v2_RLaDJnpWHqpzaAAmvQQx\",\"rc_number\":\"HR55AV6512\",\"fit_up_to\":\"2026-12-05\",\"registration_date\":\"2024-12-06\",\"owner_name\":\"S****N K***R\",\"father_name\":\"\",\"present_address\":\"Gurgaon, 122505\",\"permanent_address\":\"South, 110049\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MBHCZFB3SRJ5*****\",\"vehicle_engine_number\":\"K12NP75*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"DZIRE VXI CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"TOYOTA FINANCIAL SERVICES INDIA LTD\",\"financed\":true,\"insurance_company\":\"Magma General Insurance Limited\",\"insurance_policy_number\":\"P0026200001/4103/538578\",\"insurance_upto\":\"2026-11-21\",\"manufacturing_date\":\"9/2024\",\"manufacturing_date_formatted\":\"2024-09\",\"registered_at\":\"RTA, GURGAON, Haryana\",\"latest_by\":\"2026-05-09\",\"less_info\":true,\"tax_upto\":\"2026-12-31\",\"tax_paid_upto\":\"2026-12-31\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1405\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"990\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"DL00901010037126\",\"pucc_upto\":\"2026-05-31\",\"permit_number\":\"HR2024-AITP-1678D\",\"permit_issue_date\":\"2024-12-09\",\"permit_valid_from\":\"2024-12-09\",\"permit_valid_upto\":\"2029-12-08\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR55AV6512_front_image_1778344951.jpg', 'uploads/vehicles/HR55AV6512_back_image_1778344951.jpg', 'Active', '2026-05-09 16:42:31'),
(31, 168, 9, 'RJ51TA0286', 'G*****I B**Y R****R', 'MARUTI SUZUKI INDIA LTD', 'TOUR M (O)', 'RIGID (PASSENGER CAR)', 'PETROL/HYBRID', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2024-02-05', '2028-02-25', 'The New India Assurance Company Limited', '98000031250318335383', '2026-12-29', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [Taxi Cab]', '2029-02-19', '{\"client_id\":\"rc_v2_kLeShuNGlMufEowVZLwa\",\"rc_number\":\"RJ51TA0286\",\"fit_up_to\":\"2028-02-25\",\"registration_date\":\"2024-02-05\",\"owner_name\":\"G*****I B**Y R****R\",\"father_name\":\"\",\"present_address\":\"Bhilwara, 311022\",\"permanent_address\":\"Ajmer, 305624\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC72SPK7*****\",\"vehicle_engine_number\":\"K15CN72*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR M (O)\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/HYBRID\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"AU SMALL FINANCE BANK LTD\",\"financed\":true,\"insurance_company\":\"The New India Assurance Company Limited\",\"insurance_policy_number\":\"98000031250318335383\",\"insurance_upto\":\"2026-12-29\",\"manufacturing_date\":\"10/2023\",\"manufacturing_date_formatted\":\"2023-10\",\"registered_at\":\"SAHAPURA (BHILWARA) DTO, Rajasthan\",\"latest_by\":\"2026-05-08\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1760\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1170\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"RJ00600020022863\",\"pucc_upto\":\"2027-04-26\",\"permit_number\":\"RJ2024-AITP-1085A\",\"permit_issue_date\":\"2024-02-20\",\"permit_valid_from\":\"2024-02-20\",\"permit_valid_upto\":\"2029-02-19\",\"permit_type\":\"Tourist Permit [Taxi Cab]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/RJ51TA0286_front_image_1778392667.jpg', 'uploads/vehicles/RJ51TA0286_back_image_1778392667.jpg', 'Active', '2026-05-10 05:57:47'),
(32, 176, 0, 'HR38AL6467', 'R*J K***R', 'TOYOTA KIRLOSKAR MOTOR PVT LTD', 'TOYOTA RUMION S CNG [MT]', 'SALOON', 'PETROL(E20)/CNG', 'CAFE WHITE', '7', 'Motor Cab(LPV)', '2026-02-19', '2028-02-18', 'SBI General', '0TSB/000018207', '2027-01-08', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2031-03-09', '{\"client_id\":\"rc_v2_StrNxiAeTtJfnFcUabWU\",\"rc_number\":\"HR38AL6467\",\"fit_up_to\":\"2028-02-18\",\"registration_date\":\"2026-02-19\",\"owner_name\":\"R*J K***R\",\"father_name\":\"\",\"present_address\":\"Faridabad, 121103\",\"permanent_address\":\"Mathura, 281201\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3DND62SSLB*****\",\"vehicle_engine_number\":\"K15CN99*****\",\"maker_description\":\"TOYOTA KIRLOSKAR MOTOR PVT LTD\",\"maker_model\":\"TOYOTA RUMION S CNG [MT]\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL(E20)/CNG\",\"color\":\"CAFE WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"MAHINDRA & MAHINDRA FNCL SRV LTD\",\"financed\":true,\"insurance_company\":\"SBI General\",\"insurance_policy_number\":\"0TSB/000018207\",\"insurance_upto\":\"2027-01-08\",\"manufacturing_date\":\"11/2025\",\"manufacturing_date_formatted\":\"2025-11\",\"registered_at\":\"RTA, FARIDABAD, Haryana\",\"latest_by\":\"2026-05-10\",\"less_info\":true,\"tax_upto\":\"2026-09-30\",\"tax_paid_upto\":\"2026-09-30\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1270\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2027-02-18\",\"permit_number\":\"HR2026-AITP-7290A\",\"permit_issue_date\":\"2026-03-10\",\"permit_valid_from\":\"2026-03-10\",\"permit_valid_upto\":\"2031-03-09\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR38AL6467_front_image_1778396730.jpg', 'uploads/vehicles/HR38AL6467_back_image_1778396730.jpg', 'Active', '2026-05-10 07:05:30'),
(33, 40, 0, 'HR57B5977', 'J****T S***H', 'MARUTI SUZUKI INDIA LTD', 'ERTIGA VXI CNG', 'RIGID (PASSENGER CAR)', 'PETROL(E20)/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2026-03-19', '2028-03-18', 'IFFCO Tokio General Insurance Co. Ltd.', 'MR00283765', '2027-02-22', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2031-03-31', '{\"client_id\":\"rc_v2_hbbBIpMhkCQhncPMghod\",\"rc_number\":\"HR57B5977\",\"fit_up_to\":\"2028-03-18\",\"registration_date\":\"2026-03-19\",\"owner_name\":\"J****T S***H\",\"father_name\":\"\",\"present_address\":\"Sirsa, 125103\",\"permanent_address\":\"Sirsa, 125103\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62STBC*****\",\"vehicle_engine_number\":\"K15CNA0*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"ERTIGA VXI CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL(E20)/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"CHOLAMANDLAM INV. AND FIN. CO. LTD\",\"financed\":true,\"insurance_company\":\"IFFCO Tokio General Insurance Co. Ltd.\",\"insurance_policy_number\":\"MR00283765\",\"insurance_upto\":\"2027-02-22\",\"manufacturing_date\":\"2/2026\",\"manufacturing_date_formatted\":\"2026-02\",\"registered_at\":\"RTA, SIRSA, Haryana\",\"latest_by\":\"2026-05-10\",\"less_info\":true,\"tax_upto\":\"2027-02-28\",\"tax_paid_upto\":\"2027-02-28\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1270\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2027-03-18\",\"permit_number\":\"HR2026-AITP-0508B\",\"permit_issue_date\":\"2026-04-01\",\"permit_valid_from\":\"2026-04-01\",\"permit_valid_upto\":\"2031-03-31\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR57B5977_front_image_1778396790.jpg', 'uploads/vehicles/HR57B5977_back_image_1778396790.jpg', 'Active', '2026-05-10 07:06:30'),
(34, 175, 0, 'UP27CT1815', 'S***J K***R', 'MARUTI SUZUKI INDIA LTD', 'ERTIGA VXI (O) CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2024-06-05', '2026-06-04', 'The New India Assurance Company Limited', '98000031250317334429', '2026-05-29', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA]', '2029-06-18', '{\"client_id\":\"rc_v2_BmfLrtGaewowbsgfihWT\",\"rc_number\":\"UP27CT1815\",\"fit_up_to\":\"2026-06-04\",\"registration_date\":\"2024-06-05\",\"owner_name\":\"S***J K***R\",\"father_name\":\"\",\"present_address\":\"Shahjahanpur, 242306\",\"permanent_address\":\"Shahjahanpur, 242306\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SRE8*****\",\"vehicle_engine_number\":\"K15CN95*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"ERTIGA VXI (O) CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"MAHINDRA & MAHINDRA FINANCIAL SERVI\",\"financed\":true,\"insurance_company\":\"The New India Assurance Company Limited\",\"insurance_policy_number\":\"98000031250317334429\",\"insurance_upto\":\"2026-05-29\",\"manufacturing_date\":\"5/2024\",\"manufacturing_date_formatted\":\"2024-05\",\"registered_at\":\"SAHJAHANPUR, Uttar Pradesh\",\"latest_by\":\"2026-05-10\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1250\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"UP08500660018165\",\"pucc_upto\":\"2026-06-03\",\"permit_number\":\"UP2024-AITP-4629B\",\"permit_issue_date\":\"2024-06-19\",\"permit_valid_from\":\"2024-06-19\",\"permit_valid_upto\":\"2029-06-18\",\"permit_type\":\"Tourist Permit [ALL INDIA]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/UP27CT1815_front_image_1778403886.jpg', 'uploads/vehicles/UP27CT1815_back_image_1778403886.jpg', 'Active', '2026-05-10 09:04:46'),
(35, 112, 0, 'HR84A1704', 'P********R K***R', 'HYUNDAI MOTOR INDIA LTD', 'AURA 1.2MT CNG S', 'SALOON', 'PETROL/CNG', 'ATLAS WHITE', '5', 'Motor Cab(LPV)', '2025-12-23', '2027-12-22', 'Shriram General Insurance  Co. Ltd.', '10003/31/26/503250', '2026-11-13', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2027-01-31', '{\"client_id\":\"rc_v2_hRypwBXBmavVyANEtuhu\",\"rc_number\":\"HR84A1704\",\"fit_up_to\":\"2027-12-22\",\"registration_date\":\"2025-12-23\",\"owner_name\":\"P********R K***R\",\"father_name\":\"\",\"present_address\":\"Bhiwani, 127310\",\"permanent_address\":\"Bhiwani, 127310\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MALB241CLSM4*****\",\"vehicle_engine_number\":\"G4LASM5*****\",\"maker_description\":\"HYUNDAI MOTOR INDIA LTD\",\"maker_model\":\"AURA 1.2MT CNG S\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"ATLAS WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"SHRIRAM FINANCE LTD\",\"financed\":true,\"insurance_company\":\"Shriram General Insurance  Co. Ltd.\",\"insurance_policy_number\":\"10003/31/26/503250\",\"insurance_upto\":\"2026-11-13\",\"manufacturing_date\":\"10/2025\",\"manufacturing_date_formatted\":\"2025-10\",\"registered_at\":\"RTA CHARKI DADRI, Haryana\",\"latest_by\":\"2026-05-10\",\"less_info\":true,\"tax_upto\":\"2026-12-31\",\"tax_paid_upto\":\"2026-12-31\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1500\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1052\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2026-12-22\",\"permit_number\":\"HR2026-AITP-1526A\",\"permit_issue_date\":\"2026-02-01\",\"permit_valid_from\":\"2026-02-01\",\"permit_valid_upto\":\"2027-01-31\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR84A1704_front_image_1778407638.jpg', 'uploads/vehicles/HR84A1704_back_image_1778407638.jpg', 'Active', '2026-05-10 10:07:18'),
(36, 112, 0, 'HR55BC6559', 'A**L K***R', 'TOYOTA KIRLOSKAR MOTOR PVT LTD', 'TOYOTA RUMION S CNG [MT]', 'RIGID (PASSENGER CAR)', 'PETROL(E20)/CNG', 'CAFE WHITE', '7', 'Motor Cab(LPV)', '2026-04-09', '2028-04-08', 'Shriram General Insurance  Co. Ltd.', '10003/31/26/723930', '2027-02-12', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2031-04-09', '{\"client_id\":\"rc_v2_ozMicYbWeflduMWwERpu\",\"rc_number\":\"HR55BC6559\",\"fit_up_to\":\"2028-04-08\",\"registration_date\":\"2026-04-09\",\"owner_name\":\"A**L K***R\",\"father_name\":\"\",\"present_address\":\"Gurgaon, 122103\",\"permanent_address\":\"North West, 110086\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3DND62SSMB*****\",\"vehicle_engine_number\":\"K15CN99*****\",\"maker_description\":\"TOYOTA KIRLOSKAR MOTOR PVT LTD\",\"maker_model\":\"TOYOTA RUMION S CNG [MT]\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL(E20)/CNG\",\"color\":\"CAFE WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"SHRIRAM FINANCE LIMITED\",\"financed\":true,\"insurance_company\":\"Shriram General Insurance  Co. Ltd.\",\"insurance_policy_number\":\"10003/31/26/723930\",\"insurance_upto\":\"2027-02-12\",\"manufacturing_date\":\"12/2025\",\"manufacturing_date_formatted\":\"2025-12\",\"registered_at\":\"RTA, GURGAON, Haryana\",\"latest_by\":\"2026-05-10\",\"less_info\":true,\"tax_upto\":\"2027-02-28\",\"tax_paid_upto\":\"2027-02-28\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1270\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2027-04-08\",\"permit_number\":\"HR2026-AITP-2375B\",\"permit_issue_date\":\"2026-04-10\",\"permit_valid_from\":\"2026-04-10\",\"permit_valid_upto\":\"2031-04-09\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR55BC6559_front_image_1778407741.jpg', 'uploads/vehicles/HR55BC6559_back_image_1778407741.jpg', 'Active', '2026-05-10 10:09:01'),
(37, 50, 0, 'HR66C4142', 'P****N M*L S***I', 'MARUTI SUZUKI INDIA LTD', 'ERTIGA VXI (O) CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2024-02-07', '2028-02-06', 'Royal Sundaram General Insurance Co. Ltd', 'VPV0703864000100', '2026-06-30', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2029-02-07', '{\"client_id\":\"rc_v2_hFyfepjmxgYjsrrbeuNk\",\"rc_number\":\"HR66C4142\",\"fit_up_to\":\"2028-02-06\",\"registration_date\":\"2024-02-07\",\"owner_name\":\"P****N M*L S***I\",\"father_name\":\"\",\"present_address\":\"Mahendragarh, 123001\",\"permanent_address\":\"Mahendragarh, 123001\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SPM7*****\",\"vehicle_engine_number\":\"K15CN94*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"ERTIGA VXI (O) CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"CHOLAMANDALAM INVESTMENT&FIN CO LTD\",\"financed\":true,\"insurance_company\":\"Royal Sundaram General Insurance Co. Ltd\",\"insurance_policy_number\":\"VPV0703864000100\",\"insurance_upto\":\"2026-06-30\",\"manufacturing_date\":\"12/2023\",\"manufacturing_date_formatted\":\"2023-12\",\"registered_at\":\"RTA, MOHINDERGARH, Haryana\",\"latest_by\":\"2026-05-10\",\"less_info\":true,\"tax_upto\":\"2026-05-31\",\"tax_paid_upto\":\"2026-05-31\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1250\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR05500790067105\",\"pucc_upto\":\"2027-02-05\",\"permit_number\":\"HR2024-AITP-3576A\",\"permit_issue_date\":\"2024-02-08\",\"permit_valid_from\":\"2024-02-08\",\"permit_valid_upto\":\"2029-02-07\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR66C4142_front_image_1778409310.jpg', 'uploads/vehicles/HR66C4142_back_image_1778409310.jpg', 'Active', '2026-05-10 10:35:10'),
(38, 50, 0, 'HR842650', 'D******H', 'MARUTI SUZUKI INDIA LTD', 'TOUR S CNG', 'SALOON', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '5', 'Motor Cab(LPV)', '2024-06-07', '2026-06-06', 'Royal Sundaram General Insurance Co. Ltd', 'VPV0699293000100', '2026-06-03', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2029-06-06', '{\"client_id\":\"rc_v2_wvfgeskqzWAycQJKsmcI\",\"rc_number\":\"HR842650\",\"fit_up_to\":\"2026-06-06\",\"registration_date\":\"2024-06-07\",\"owner_name\":\"D******H\",\"father_name\":\"\",\"present_address\":\"Charkhi Dadri, 127310\",\"permanent_address\":\"Charkhi Dadri, 127310\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MBHCZFB3SRD5*****\",\"vehicle_engine_number\":\"K12NP16*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR S CNG\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"CHOLAMANDALAM INV & FIN CO LTD\",\"financed\":true,\"insurance_company\":\"Royal Sundaram General Insurance Co. Ltd\",\"insurance_policy_number\":\"VPV0699293000100\",\"insurance_upto\":\"2026-06-03\",\"manufacturing_date\":\"4/2024\",\"manufacturing_date_formatted\":\"2024-04\",\"registered_at\":\"RTA CHARKI DADRI, Haryana\",\"latest_by\":\"2026-05-10\",\"less_info\":true,\"tax_upto\":\"2026-05-31\",\"tax_paid_upto\":\"2026-05-31\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1405\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"970\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR05505000029144\",\"pucc_upto\":\"2026-07-09\",\"permit_number\":\"HR2024-AITP-4635B\",\"permit_issue_date\":\"2024-06-07\",\"permit_valid_from\":\"2024-06-07\",\"permit_valid_upto\":\"2029-06-06\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR842650_front_image_1778409381.jpg', 'uploads/vehicles/HR842650_back_image_1778409381.jpg', 'Active', '2026-05-10 10:36:21'),
(39, 4, 8, 'HR55BB9183', 'A*****R P*L S***H', 'TOYOTA KIRLOSKAR MOTOR PVT LTD', 'INNOVA CRYSTA 2.4G (GX+, MT)', 'STATION WAGON', 'DIESEL', 'SUPER WHITE', '8', 'Maxi Cab(LPV)', '2026-02-12', '2028-02-11', 'SBI General', 'TSB/000009682', '2026-12-27', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2031-02-12', '{\"client_id\":\"rc_v2_bbJQSapBctRwkPjVmCwr\",\"rc_number\":\"HR55BB9183\",\"fit_up_to\":\"2028-02-11\",\"registration_date\":\"2026-02-12\",\"owner_name\":\"A*****R P*L S***H\",\"father_name\":\"\",\"present_address\":\"Gurgaon, 122001\",\"permanent_address\":\"New Delhi, 110068\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MBJJB8EMX01701821*****\",\"vehicle_engine_number\":\"2GDA9*****\",\"maker_description\":\"TOYOTA KIRLOSKAR MOTOR PVT LTD\",\"maker_model\":\"INNOVA CRYSTA 2.4G (GX+, MT)\",\"body_type\":\"STATION WAGON\",\"fuel_type\":\"DIESEL\",\"color\":\"SUPER WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"TOYOTA FINANCIAL SERVICES INDIA LTD\",\"financed\":true,\"insurance_company\":\"SBI General\",\"insurance_policy_number\":\"TSB/000009682\",\"insurance_upto\":\"2026-12-27\",\"manufacturing_date\":\"12/2025\",\"manufacturing_date_formatted\":\"2025-12\",\"registered_at\":\"RTA, GURGAON, Haryana\",\"latest_by\":\"2026-05-06\",\"less_info\":true,\"tax_upto\":\"2026-12-31\",\"tax_paid_upto\":\"2026-12-31\",\"cubic_capacity\":\"2393.00\",\"vehicle_gross_weight\":\"2490\",\"no_cylinders\":\"4\",\"seat_capacity\":\"8\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2750\",\"unladen_weight\":\"1860\",\"vehicle_category_description\":\"Maxi Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2027-02-11\",\"permit_number\":\"HR2026-AITP-2404A\",\"permit_issue_date\":\"2026-02-13\",\"permit_valid_from\":\"2026-02-13\",\"permit_valid_upto\":\"2031-02-12\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR55BB9183_front_image_1778415143.jpg', 'uploads/vehicles/HR55BB9183_back_image_1778415143.jpg', 'Active', '2026-05-10 12:12:23'),
(40, 83, 0, 'HR841384', 'B******R', 'MARUTI SUZUKI INDIA LTD', 'ERTIGA VXI CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2022-06-07', '2026-06-06', 'Shriram General Insurance  Co. Ltd.', '101046/31/26/015861', '2027-02-28', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2027-06-15', '{\"client_id\":\"rc_v2_ficHoWbvwbrGvbLWhPQx\",\"rc_number\":\"HR841384\",\"fit_up_to\":\"2026-06-06\",\"registration_date\":\"2022-06-07\",\"owner_name\":\"B******R\",\"father_name\":\"\",\"present_address\":\"Charkhi Dadri, 127306\",\"permanent_address\":\"Charkhi Dadri, 127306\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SNE4*****\",\"vehicle_engine_number\":\"K15CN90*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"ERTIGA VXI CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"\",\"financed\":false,\"insurance_company\":\"Shriram General Insurance  Co. Ltd.\",\"insurance_policy_number\":\"101046/31/26/015861\",\"insurance_upto\":\"2027-02-28\",\"manufacturing_date\":\"5/2022\",\"manufacturing_date_formatted\":\"2022-05\",\"registered_at\":\"RTA CHARKI DADRI, Haryana\",\"latest_by\":\"2026-05-10\",\"less_info\":true,\"tax_upto\":\"2027-03-31\",\"tax_paid_upto\":\"2027-03-31\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1250\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR05502950080355\",\"pucc_upto\":\"2026-07-28\",\"permit_number\":\"HR2022-AITP-4887A\",\"permit_issue_date\":\"2022-06-16\",\"permit_valid_from\":\"2022-06-16\",\"permit_valid_upto\":\"2027-06-15\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR841384_front_image_1778419294.jpg', 'uploads/vehicles/HR841384_back_image_1778419294.jpg', 'Active', '2026-05-10 13:21:34'),
(41, 113, 0, 'HR47E5481', 'R*J K***R', 'MARUTI SUZUKI INDIA LTD', 'TOUR M CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2020-02-28', '2028-03-08', 'United India Insurance Co. Ltd.', '1112063125P117994917', '2027-02-21', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2027-03-05', '{\"client_id\":\"rc_v2_ypacfMvdrahebeutdOfE\",\"rc_number\":\"HR47E5481\",\"fit_up_to\":\"2028-03-08\",\"registration_date\":\"2020-02-28\",\"owner_name\":\"R*J K***R\",\"father_name\":\"\",\"present_address\":\"Jind, 126115\",\"permanent_address\":\"Jind, 126115\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC22SLA2*****\",\"vehicle_engine_number\":\"K15BN11*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR M CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"AU SMALL FINANCE BANK LTD.\",\"financed\":true,\"insurance_company\":\"United India Insurance Co. Ltd.\",\"insurance_policy_number\":\"1112063125P117994917\",\"insurance_upto\":\"2027-02-21\",\"manufacturing_date\":\"1/2020\",\"manufacturing_date_formatted\":\"2020-01\",\"registered_at\":\"RTA, JIND, Haryana\",\"latest_by\":\"2026-05-10\",\"less_info\":true,\"tax_upto\":\"2027-03-31\",\"tax_paid_upto\":\"2027-03-31\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1795\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1235\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR07301310003509\",\"pucc_upto\":\"2026-10-17\",\"permit_number\":\"HR2020-AITP-4818A\",\"permit_issue_date\":\"2020-03-06\",\"permit_valid_from\":\"2026-03-06\",\"permit_valid_upto\":\"2027-03-05\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"2\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR47E5481_front_image_1778431904.jpg', 'uploads/vehicles/HR47E5481_back_image_1778431904.jpg', 'Active', '2026-05-10 16:51:44'),
(43, 162, 0, 'HR38AF6490', 'D****H K***R', 'HYUNDAI MOTOR INDIA LTD', 'AURA 1.2MT CNG S', 'SALOON', 'PETROL/CNG', 'ATLAS WHITE', '5', 'Motor Cab(LPV)', '2023-08-02', '2027-08-04', 'United India Insurance Co. Ltd.', '1120003125P103818352', '2026-06-05', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2028-08-20', '{\"client_id\":\"rc_v2_zEyoGuyLJnxpdebpGDqv\",\"rc_number\":\"HR38AF6490\",\"fit_up_to\":\"2027-08-04\",\"registration_date\":\"2023-08-02\",\"owner_name\":\"D****H K***R\",\"father_name\":\"\",\"present_address\":\"Faridabad, 121004\",\"permanent_address\":\"Faridabad, 121004\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MALB241CLPM1*****\",\"vehicle_engine_number\":\"G4LAPM5*****\",\"maker_description\":\"HYUNDAI MOTOR INDIA LTD\",\"maker_model\":\"AURA 1.2MT CNG S\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"ATLAS WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"VASTU FINSERVE INDIA PRIVATE LTD\",\"financed\":true,\"insurance_company\":\"United India Insurance Co. Ltd.\",\"insurance_policy_number\":\"1120003125P103818352\",\"insurance_upto\":\"2026-06-05\",\"manufacturing_date\":\"5/2023\",\"manufacturing_date_formatted\":\"2023-05\",\"registered_at\":\"RTA, FARIDABAD, Haryana\",\"latest_by\":\"2026-05-12\",\"less_info\":true,\"tax_upto\":\"2026-05-31\",\"tax_paid_upto\":\"2026-05-31\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1500\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1052\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"UP01402260079157\",\"pucc_upto\":\"2026-08-22\",\"permit_number\":\"HR2023-AITP-1232C\",\"permit_issue_date\":\"2023-08-21\",\"permit_valid_from\":\"2023-08-21\",\"permit_valid_upto\":\"2028-08-20\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR38AF6490_front_image_1778587557.jpg', 'uploads/vehicles/HR38AF6490_back_image_1778587557.jpg', 'Active', '2026-05-12 12:05:57'),
(44, 227, 0, 'HR55AX2774', 'D********R', 'HYUNDAI MOTOR INDIA LTD', 'AURA 1.2MT CNG S', 'SALOON', 'PETROL/CNG', 'TITAN GREY', '5', 'Motor Cab(LPV)', '2025-06-03', '2027-06-02', 'SBI General', 'POCMVPC0100325057', '2026-05-15', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2030-06-03', '{\"client_id\":\"rc_v2_LyhEwwGZTilfmgiDkkmb\",\"rc_number\":\"HR55AX2774\",\"fit_up_to\":\"2027-06-02\",\"registration_date\":\"2025-06-03\",\"owner_name\":\"D********R\",\"father_name\":\"\",\"present_address\":\"Gurgaon, 122001\",\"permanent_address\":\"Gurgaon, 122001\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MALB241CLSM3*****\",\"vehicle_engine_number\":\"G4LASM2*****\",\"maker_description\":\"HYUNDAI MOTOR INDIA LTD\",\"maker_model\":\"AURA 1.2MT CNG S\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"TITAN GREY\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"AU SMALL FINANCE BANK LTD.\",\"financed\":true,\"insurance_company\":\"SBI General\",\"insurance_policy_number\":\"POCMVPC0100325057\",\"insurance_upto\":\"2026-05-15\",\"manufacturing_date\":\"2/2025\",\"manufacturing_date_formatted\":\"2025-02\",\"registered_at\":\"RTA, GURGAON, Haryana\",\"latest_by\":\"2026-05-12\",\"less_info\":true,\"tax_upto\":\"2026-05-31\",\"tax_paid_upto\":\"2026-05-31\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1500\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1052\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2026-06-02\",\"permit_number\":\"HR2025-AITP-6809B\",\"permit_issue_date\":\"2025-06-04\",\"permit_valid_from\":\"2025-06-04\",\"permit_valid_upto\":\"2030-06-03\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR55AX2774_front_image_1778597617.jpg', 'uploads/vehicles/HR55AX2774_back_image_1778597617.jpg', 'Active', '2026-05-12 14:53:37'),
(45, 145, 0, 'RJ27TB0506', 'P*****K D***I', 'TOYOTA KIRLOSKAR MOTOR PVT LTD', 'INNOVA CRYSTA (GX, MT)', 'STATION WAGON', 'DIESEL', 'SUPER WHITE', '8', 'Maxi Cab(LPV)', '2024-03-31', '2028-03-30', 'National Insurance Co. Ltd.', '38020031256360012923', '2027-03-30', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [Maxi Cab]', '2029-04-14', '{\"client_id\":\"rc_v2_AIatXwcspojwhQBuGJns\",\"rc_number\":\"RJ27TB0506\",\"fit_up_to\":\"2028-03-30\",\"registration_date\":\"2024-03-31\",\"owner_name\":\"P*****K D***I\",\"father_name\":\"\",\"present_address\":\"Udaipur, 313002\",\"permanent_address\":\"Udaipur, 313002\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MBJJB8EM301659332*****\",\"vehicle_engine_number\":\"2GDA7*****\",\"maker_description\":\"TOYOTA KIRLOSKAR MOTOR PVT LTD\",\"maker_model\":\"INNOVA CRYSTA (GX, MT)\",\"body_type\":\"STATION WAGON\",\"fuel_type\":\"DIESEL\",\"color\":\"SUPER WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"AU SMALL FINANCE BANK\",\"financed\":true,\"insurance_company\":\"National Insurance Co. Ltd.\",\"insurance_policy_number\":\"38020031256360012923\",\"insurance_upto\":\"2027-03-30\",\"manufacturing_date\":\"3/2024\",\"manufacturing_date_formatted\":\"2024-03\",\"registered_at\":\"UDAIPUR RTO, Rajasthan\",\"latest_by\":\"2026-05-13\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"2393.00\",\"vehicle_gross_weight\":\"2490\",\"no_cylinders\":\"4\",\"seat_capacity\":\"8\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2750\",\"unladen_weight\":\"1860\",\"vehicle_category_description\":\"Maxi Cab(LPV)\",\"pucc_number\":\"RJ02700680006521\",\"pucc_upto\":\"2027-04-29\",\"permit_number\":\"RJ2024-AITP-2401A\",\"permit_issue_date\":\"2024-04-15\",\"permit_valid_from\":\"2024-04-15\",\"permit_valid_upto\":\"2029-04-14\",\"permit_type\":\"Tourist Permit [Maxi Cab]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/RJ27TB0506_front_image_1778666006.jpg', 'uploads/vehicles/RJ27TB0506_back_image_1778666006.jpg', 'Active', '2026-05-13 09:53:26');
INSERT INTO `partner_vehicles` (`id`, `partner_id`, `car_type`, `rc_number`, `owner_name`, `maker_description`, `maker_model`, `body_type`, `fuel_type`, `color`, `seat_capacity`, `vehicle_category_desc`, `registration_date`, `fit_up_to`, `insurance_company`, `insurance_policy_number`, `insurance_upto`, `norms_type`, `rc_status`, `permit_type`, `permit_valid_upto`, `raw_rc_data`, `front_image`, `back_image`, `status`, `created_at`) VALUES
(46, 145, 0, 'RJ27TA7253', 'S******A S***H R****T', 'TOYOTA KIRLOSKAR MOTOR PVT LTD', 'INNOVA CRYSTA G', 'SALOON', 'DIESEL', 'SILVER MET', '7', 'Motor Cab(LPV)', '2017-09-27', '2027-03-23', 'Shriram General Insurance  Co. Ltd.', '106046/31/26/004062', '2026-09-28', 'BHARAT STAGE IV', 'ACTIVE', 'Contract Carriage Permit [MOTOR CAB]', '2028-06-05', '{\"client_id\":\"rc_v2_ArsoofqGMlsNaRkilKKf\",\"rc_number\":\"RJ27TA7253\",\"fit_up_to\":\"2027-03-23\",\"registration_date\":\"2017-09-27\",\"owner_name\":\"S******A S***H R****T\",\"father_name\":\"\",\"present_address\":\"Udaipur, 313001\",\"permanent_address\":\"Udaipur, 313001\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MBJCB8EM3013*****\",\"vehicle_engine_number\":\"2GDA1*****\",\"maker_description\":\"TOYOTA KIRLOSKAR MOTOR PVT LTD\",\"maker_model\":\"INNOVA CRYSTA G\",\"body_type\":\"SALOON\",\"fuel_type\":\"DIESEL\",\"color\":\"SILVER MET\",\"norms_type\":\"BHARAT STAGE IV\",\"financer\":\"CHOLAMANDALAM INV & FIN CO LTD\",\"financed\":true,\"insurance_company\":\"Shriram General Insurance  Co. Ltd.\",\"insurance_policy_number\":\"106046/31/26/004062\",\"insurance_upto\":\"2026-09-28\",\"manufacturing_date\":\"9/2017\",\"manufacturing_date_formatted\":\"2017-09\",\"registered_at\":\"UDAIPUR RTO, Rajasthan\",\"latest_by\":\"2026-05-13\",\"less_info\":true,\"tax_upto\":\"2032-09-26\",\"tax_paid_upto\":\"2032-09-26\",\"cubic_capacity\":\"2393.00\",\"vehicle_gross_weight\":\"2460\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2750\",\"unladen_weight\":\"1805\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"RJ03800100005047\",\"pucc_upto\":\"2026-09-30\",\"permit_number\":\"RJ2023-CC-4417B\",\"permit_issue_date\":\"2023-06-06\",\"permit_valid_from\":\"2023-06-06\",\"permit_valid_upto\":\"2028-06-05\",\"permit_type\":\"Contract Carriage Permit [MOTOR CAB]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"2\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/RJ27TA7253_front_image_1778666245.jpg', 'uploads/vehicles/RJ27TA7253_back_image_1778666245.jpg', 'Active', '2026-05-13 09:57:25'),
(47, 145, 0, 'RJ59TA0122', 'M***N L*L C*******Y', 'TOYOTA KIRLOSKAR MOTOR PVT LTD', 'INNOVA CRYSTA 2.4G (FLT)', 'SALOON', 'DIESEL', 'SUPER WHITE', '7', 'Motor Cab(LPV)', '2018-03-26', '2028-01-09', 'Shriram General Insurance  Co. Ltd.', '106005/31/26/000905', '2026-07-09', 'BHARAT STAGE IV', 'ACTIVE', 'Contract Carriage Permit [MOTOR CAB]', '2029-08-20', '{\"client_id\":\"rc_v2_QVkgcxwxxowzfchopRpK\",\"rc_number\":\"RJ59TA0122\",\"fit_up_to\":\"2028-01-09\",\"registration_date\":\"2018-03-26\",\"owner_name\":\"M***N L*L C*******Y\",\"father_name\":\"\",\"present_address\":\"Udaipur, 313022\",\"permanent_address\":\"Udaipur, 313022\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MBJJB8EM301536548*****\",\"vehicle_engine_number\":\"2GDA1*****\",\"maker_description\":\"TOYOTA KIRLOSKAR MOTOR PVT LTD\",\"maker_model\":\"INNOVA CRYSTA 2.4G (FLT)\",\"body_type\":\"SALOON\",\"fuel_type\":\"DIESEL\",\"color\":\"SUPER WHITE\",\"norms_type\":\"BHARAT STAGE IV\",\"financer\":\"CHOLAMANDALAM INV. & FIN.CO.LTD.\",\"financed\":true,\"insurance_company\":\"Shriram General Insurance  Co. Ltd.\",\"insurance_policy_number\":\"106005/31/26/000905\",\"insurance_upto\":\"2026-07-09\",\"manufacturing_date\":\"3/2018\",\"manufacturing_date_formatted\":\"2018-03\",\"registered_at\":\"UDAIPUR RTO, Rajasthan\",\"latest_by\":\"2026-05-13\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"2393.00\",\"vehicle_gross_weight\":\"2430\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2750\",\"unladen_weight\":\"1805\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR06601090047888\",\"pucc_upto\":\"2026-08-12\",\"permit_number\":\"RJ2024-CC-7068C\",\"permit_issue_date\":\"2024-08-21\",\"permit_valid_from\":\"2024-08-21\",\"permit_valid_upto\":\"2029-08-20\",\"permit_type\":\"Contract Carriage Permit [MOTOR CAB]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"2\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/RJ59TA0122_front_image_1778666310.jpg', 'uploads/vehicles/RJ59TA0122_back_image_1778666310.jpg', 'Active', '2026-05-13 09:58:30'),
(48, 102, 9, 'HR65A3390', 'B*******R K***R', 'MARUTI SUZUKI INDIA LTD', 'ERTIGA VXI (O) CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2023-03-13', '2027-03-12', 'The New India Assurance Company Limited', '98000031250318497290', '2027-02-09', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2028-04-05', '{\"client_id\":\"rc_v2_umneGKaruzppocndbaqg\",\"rc_number\":\"HR65A3390\",\"fit_up_to\":\"2027-03-12\",\"registration_date\":\"2023-03-13\",\"owner_name\":\"B*******R K***R\",\"father_name\":\"\",\"present_address\":\"Kurukshetra, 136119\",\"permanent_address\":\"Kurukshetra, 136119\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SPB5*****\",\"vehicle_engine_number\":\"K15CN91*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"ERTIGA VXI (O) CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"MAHINDRA AND MAHINDRA FIN SER LTD\",\"financed\":true,\"insurance_company\":\"The New India Assurance Company Limited\",\"insurance_policy_number\":\"98000031250318497290\",\"insurance_upto\":\"2027-02-09\",\"manufacturing_date\":\"2/2023\",\"manufacturing_date_formatted\":\"2023-02\",\"registered_at\":\"RTA, KURUKSHETRA, Haryana\",\"latest_by\":\"2026-05-14\",\"less_info\":true,\"tax_upto\":\"2026-07-31\",\"tax_paid_upto\":\"2026-07-31\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1250\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR06501740012834\",\"pucc_upto\":\"2026-05-18\",\"permit_number\":\"HR2023-AITP-6976A\",\"permit_issue_date\":\"2023-04-06\",\"permit_valid_from\":\"2023-04-06\",\"permit_valid_upto\":\"2028-04-05\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR65A3390_front_image_1778738131.jpg', 'uploads/vehicles/HR65A3390_back_image_1778738131.jpg', 'Active', '2026-05-14 05:55:31'),
(49, 253, 9, 'PB01E5665', 'K****K', 'MARUTI SUZUKI INDIA LTD', 'ERTIGA VXI (O) CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2024-07-01', '2026-06-30', 'United India Insurance Co. Ltd.', '04280031250160081609', '2026-06-07', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [TVP(MOTOR CAB)]', '2029-08-06', '{\"client_id\":\"rc_v2_ImbbAwRkwuvCFgmhCLgq\",\"rc_number\":\"PB01E5665\",\"fit_up_to\":\"2026-06-30\",\"registration_date\":\"2024-07-01\",\"owner_name\":\"K****K\",\"father_name\":\"\",\"present_address\":\"Bathinda, 151301\",\"permanent_address\":\"Bathinda, 151301\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SRE8*****\",\"vehicle_engine_number\":\"K15CN95*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"ERTIGA VXI (O) CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"AU SMALL FINANCE BANK LTD\",\"financed\":true,\"insurance_company\":\"United India Insurance Co. Ltd.\",\"insurance_policy_number\":\"04280031250160081609\",\"insurance_upto\":\"2026-06-07\",\"manufacturing_date\":\"5/2024\",\"manufacturing_date_formatted\":\"2024-05\",\"registered_at\":\"PUNJAB STA(RAC)/(AITP), Punjab\",\"latest_by\":\"2026-05-14\",\"less_info\":true,\"tax_upto\":\"2026-06-30\",\"tax_paid_upto\":\"2026-06-30\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1250\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"PB00300900002428\",\"pucc_upto\":\"2026-09-23\",\"permit_number\":\"PB2024-AITP-8408A\",\"permit_issue_date\":\"2024-08-09\",\"permit_valid_from\":\"2024-08-07\",\"permit_valid_upto\":\"2029-08-06\",\"permit_type\":\"Tourist Permit [TVP(MOTOR CAB)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/PB01E5665_front_image_1778743880.jpg', 'uploads/vehicles/PB01E5665_back_image_1778743880.jpg', 'Active', '2026-05-14 07:31:20'),
(50, 256, 8, 'TN38CU4227', 'S**********R T A', 'TOYOTA KIRLOSKAR MOTOR PVT LTD', 'TOYOTA ETIOS GD', 'SEDAN', 'DIESEL', 'WHITE', '5', 'Motor Cab(LPV)', '2019-11-29', '2027-11-11', 'United India Insurance Co. Ltd.', '1703003125P113614882', '2026-11-26', 'BHARAT STAGE IV', 'ACTIVE', 'Contract Carriage Permit [Motor Cab Permit]', '2029-12-09', '{\"client_id\":\"rc_v2_PaVddogmhpIoukrwqXov\",\"rc_number\":\"TN38CU4227\",\"fit_up_to\":\"2027-11-11\",\"registration_date\":\"2019-11-29\",\"owner_name\":\"S**********R T A\",\"father_name\":\"\",\"present_address\":\"Coimbatore, 641017\",\"permanent_address\":\"Coimbatore, 641017\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MBJB49BT300205314*****\",\"vehicle_engine_number\":\"1ND1B*****\",\"maker_description\":\"TOYOTA KIRLOSKAR MOTOR PVT LTD\",\"maker_model\":\"TOYOTA ETIOS GD\",\"body_type\":\"SEDAN\",\"fuel_type\":\"DIESEL\",\"color\":\"WHITE\",\"norms_type\":\"BHARAT STAGE IV\",\"financer\":\"SHRIRAM FINANCE LIMITED\",\"financed\":true,\"insurance_company\":\"United India Insurance Co. Ltd.\",\"insurance_policy_number\":\"1703003125P113614882\",\"insurance_upto\":\"2026-11-26\",\"manufacturing_date\":\"9/2019\",\"manufacturing_date_formatted\":\"2019-09\",\"registered_at\":\"COIMBATORE (NORTH) RTO, Tamil Nadu\",\"latest_by\":\"2026-05-14\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"1364.00\",\"vehicle_gross_weight\":\"1440\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2550\",\"unladen_weight\":\"1010\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"TN06600200006338\",\"pucc_upto\":\"2026-09-11\",\"permit_number\":\"TN/38/CC/MOTO/2019/570\",\"permit_issue_date\":\"2019-12-10\",\"permit_valid_from\":\"2024-12-10\",\"permit_valid_upto\":\"2029-12-09\",\"permit_type\":\"Contract Carriage Permit [Motor Cab Permit]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"2\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/TN38CU4227_front_image_1778744628.jpg', 'uploads/vehicles/TN38CU4227_back_image_1778744628.jpg', 'Active', '2026-05-14 07:43:48'),
(51, 71, 8, 'DL1ZD9974', 'R***L Y***V', 'HYUNDAI MOTOR INDIA LTD', 'PRIME SD 1.2 MT CNG', 'SALOON', 'PETROL(E20)/CNG', 'ATLAS WHITE', '5', 'Motor Cab(LPV)', '2026-02-07', '2028-02-06', 'IFFCO Tokio General Insurance Co. Ltd.', '56395851', '2027-02-05', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [TOURIST TAXI(DELUXE)]', '2031-02-24', '{\"client_id\":\"rc_v2_wDwHmswIfnkzeuiwdCnx\",\"rc_number\":\"DL1ZD9974\",\"fit_up_to\":\"2028-02-06\",\"registration_date\":\"2026-02-07\",\"owner_name\":\"R***L Y***V\",\"father_name\":\"\",\"present_address\":\"New Delhi, 110026\",\"permanent_address\":\"New Delhi, 110026\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MALB141CLTM4*****\",\"vehicle_engine_number\":\"G4LATM6*****\",\"maker_description\":\"HYUNDAI MOTOR INDIA LTD\",\"maker_model\":\"PRIME SD 1.2 MT CNG\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL(E20)/CNG\",\"color\":\"ATLAS WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"MAHINDRA & MAHINDRA FNCL SRV LTD\",\"financed\":true,\"insurance_company\":\"IFFCO Tokio General Insurance Co. Ltd.\",\"insurance_policy_number\":\"56395851\",\"insurance_upto\":\"2027-02-05\",\"manufacturing_date\":\"1/2026\",\"manufacturing_date_formatted\":\"2026-01\",\"registered_at\":\"BURARI TAXI UNIT, Delhi\",\"latest_by\":\"2026-05-14\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1500\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1049\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2027-02-06\",\"permit_number\":\"DL2026-AITP-0322A\",\"permit_issue_date\":\"2026-02-26\",\"permit_valid_from\":\"2026-02-25\",\"permit_valid_upto\":\"2031-02-24\",\"permit_type\":\"Tourist Permit [TOURIST TAXI(DELUXE)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/DL1ZD9974_front_image_1778748782.jpg', 'uploads/vehicles/DL1ZD9974_back_image_1778748782.jpg', 'Active', '2026-05-14 08:53:02'),
(52, 252, 14, 'HR55AR6271', 'V***Y K***R', 'KIA INDIA PRIVATE LIMITED', 'CARENS D1.5 IMT MDRIVE7', 'STATION WAGON', 'DIESEL', 'CLEAR WHITE', '7', 'Motor Cab(LPV)', '2023-09-13', '2027-09-12', 'The New India Assurance Company Limited', '35380131250300001629', '2026-08-31', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2028-09-19', '{\"client_id\":\"rc_v2_yWjPxlswagtjnPwmkpqE\",\"rc_number\":\"HR55AR6271\",\"fit_up_to\":\"2027-09-12\",\"registration_date\":\"2023-09-13\",\"owner_name\":\"V***Y K***R\",\"father_name\":\"\",\"present_address\":\"Gurgaon, 122001\",\"permanent_address\":\"Gurgaon, 122001\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MZBGA813LPN1*****\",\"vehicle_engine_number\":\"D4FAPM9*****\",\"maker_description\":\"KIA INDIA PRIVATE LIMITED\",\"maker_model\":\"CARENS D1.5 IMT MDRIVE7\",\"body_type\":\"STATION WAGON\",\"fuel_type\":\"DIESEL\",\"color\":\"CLEAR WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"AU SMALL FINANCE BANK LTD\",\"financed\":true,\"insurance_company\":\"The New India Assurance Company Limited\",\"insurance_policy_number\":\"35380131250300001629\",\"insurance_upto\":\"2026-08-31\",\"manufacturing_date\":\"7/2023\",\"manufacturing_date_formatted\":\"2023-07\",\"registered_at\":\"RTA, GURGAON, Haryana\",\"latest_by\":\"2026-05-14\",\"less_info\":true,\"tax_upto\":\"2026-09-30\",\"tax_paid_upto\":\"2026-09-30\",\"cubic_capacity\":\"1493.00\",\"vehicle_gross_weight\":\"2010\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2780\",\"unladen_weight\":\"1391\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR05503520002604\",\"pucc_upto\":\"2026-09-09\",\"permit_number\":\"HR2023-AITP-4048C\",\"permit_issue_date\":\"2023-09-20\",\"permit_valid_from\":\"2023-09-20\",\"permit_valid_upto\":\"2028-09-19\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR55AR6271_front_image_1778750783.jpg', 'uploads/vehicles/HR55AR6271_back_image_1778750783.jpg', 'Active', '2026-05-14 09:26:23'),
(53, 252, 9, 'UP75CT5879', 'R********A R*****T', 'TOYOTA KIRLOSKAR MOTOR PVT LTD', 'TOYOTA RUMION S CNG [MT]', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'CAFE WHITE', '7', 'Motor Cab(LPV)', '2025-02-11', '2027-02-10', 'Tata AIG General Insurance Co. Ltd.', '63700652850000', '2026-08-11', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA]', '2030-03-02', '{\"client_id\":\"rc_v2_wVWQtIsiHvuGWcehySlc\",\"rc_number\":\"UP75CT5879\",\"fit_up_to\":\"2027-02-10\",\"registration_date\":\"2025-02-11\",\"owner_name\":\"R********A R*****T\",\"father_name\":\"\",\"present_address\":\"Etawah, 206127\",\"permanent_address\":\"Etawah, 206127\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3DND62SSA9*****\",\"vehicle_engine_number\":\"K15CN96*****\",\"maker_description\":\"TOYOTA KIRLOSKAR MOTOR PVT LTD\",\"maker_model\":\"TOYOTA RUMION S CNG [MT]\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"CAFE WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"TOYOTA FINANCIAL SERVICES INDIA LTD\",\"financed\":true,\"insurance_company\":\"Tata AIG General Insurance Co. Ltd.\",\"insurance_policy_number\":\"63700652850000\",\"insurance_upto\":\"2026-08-11\",\"manufacturing_date\":\"1/2025\",\"manufacturing_date_formatted\":\"2025-01\",\"registered_at\":\"Etawah, Uttar Pradesh\",\"latest_by\":\"2026-05-14\",\"less_info\":true,\"tax_upto\":\"2027-01-31\",\"tax_paid_upto\":\"2027-01-31\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1250\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR05503930129491\",\"pucc_upto\":\"2026-07-12\",\"permit_number\":\"UP2025-AITP-5516A\",\"permit_issue_date\":\"2025-03-03\",\"permit_valid_from\":\"2025-03-03\",\"permit_valid_upto\":\"2030-03-02\",\"permit_type\":\"Tourist Permit [ALL INDIA]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/UP75CT5879_front_image_1778752508.png', 'uploads/vehicles/UP75CT5879_back_image_1778752508.png', 'Active', '2026-05-14 09:55:08'),
(54, 263, 8, 'MP04WC1701', 'M******A S*****T', 'MARUTI SUZUKI INDIA LTD', 'TOUR S CNG', 'RIGID (PASSENGER CAR)', 'PETROL(E20)/CNG', 'PEARL ARCTIC WHITE', '5', 'Motor Cab(LPV)', '2026-04-16', '2028-04-15', 'National Insurance Co. Ltd.', '32130031261351855074', '2027-04-14', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA TOURIST TAXI]', '2031-05-05', '{\"client_id\":\"rc_v2_vInabNjEIixHtWIDSgEk\",\"rc_number\":\"MP04WC1701\",\"fit_up_to\":\"2028-04-15\",\"registration_date\":\"2026-04-16\",\"owner_name\":\"M******A S*****T\",\"father_name\":\"\",\"present_address\":\"Vidisha, 464001\",\"permanent_address\":\"Vidisha, 464001\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3ZFDFSKTD4*****\",\"vehicle_engine_number\":\"Z12ENF3*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR S CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL(E20)/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"SHRIRAM FINANCE LIMITED\",\"financed\":true,\"insurance_company\":\"National Insurance Co. Ltd.\",\"insurance_policy_number\":\"32130031261351855074\",\"insurance_upto\":\"2027-04-14\",\"manufacturing_date\":\"4/2026\",\"manufacturing_date_formatted\":\"2026-04\",\"registered_at\":\"BHOPAL RTO, Madhya Pradesh\",\"latest_by\":\"2026-05-13\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1435\",\"no_cylinders\":\"3\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1010\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2027-04-15\",\"permit_number\":\"MP2026-AITP-2859A\",\"permit_issue_date\":\"2026-05-06\",\"permit_valid_from\":\"2026-05-06\",\"permit_valid_upto\":\"2031-05-05\",\"permit_type\":\"Tourist Permit [ALL INDIA TOURIST TAXI]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/MP04WC1701_front_image_1778757774.jpg', 'uploads/vehicles/MP04WC1701_back_image_1778757774.jpg', 'Active', '2026-05-14 11:22:54'),
(55, 257, 9, 'HR38AH0462', 'G****D T****I', 'TOYOTA KIRLOSKAR MOTOR PVT LTD', 'TOYOTA RUMION S CNG [MT]', 'SALOON', 'PETROL/CNG', 'CAFE WHITE', '7', 'Motor Cab(LPV)', '2024-08-07', '2026-08-06', 'Shriram General Insurance  Co. Ltd.', '108047/31/26/002877', '2026-07-25', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2029-08-06', '{\"client_id\":\"rc_v2_rPpvQdgjyjmAmstzxclQ\",\"rc_number\":\"HR38AH0462\",\"fit_up_to\":\"2026-08-06\",\"registration_date\":\"2024-08-07\",\"owner_name\":\"G****D T****I\",\"father_name\":\"\",\"present_address\":\"Faridabad, 121003\",\"permanent_address\":\"Ghaziabad, 201014\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3DND62SRF8*****\",\"vehicle_engine_number\":\"K15CN95*****\",\"maker_description\":\"TOYOTA KIRLOSKAR MOTOR PVT LTD\",\"maker_model\":\"TOYOTA RUMION S CNG [MT]\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"CAFE WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"AU SMALL FIN BANK LTD\",\"financed\":true,\"insurance_company\":\"Shriram General Insurance  Co. Ltd.\",\"insurance_policy_number\":\"108047/31/26/002877\",\"insurance_upto\":\"2026-07-25\",\"manufacturing_date\":\"6/2024\",\"manufacturing_date_formatted\":\"2024-06\",\"registered_at\":\"RTA, FARIDABAD, Haryana\",\"latest_by\":\"2026-05-14\",\"less_info\":true,\"tax_upto\":\"2026-06-30\",\"tax_paid_upto\":\"2026-06-30\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1250\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"DL01300290045025\",\"pucc_upto\":\"2026-09-26\",\"permit_number\":\"HR2024-AITP-0505C\",\"permit_issue_date\":\"2024-08-07\",\"permit_valid_from\":\"2024-08-07\",\"permit_valid_upto\":\"2029-08-06\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR38AH0462_front_image_1778764622.png', 'uploads/vehicles/HR38AH0462_back_image_1778764622.png', 'Active', '2026-05-14 13:17:02'),
(56, 106, 8, 'UK06TA7775', 'S**U R*****R', 'MARUTI SUZUKI INDIA LTD', 'TOUR S CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '5', 'Motor Cab(LPV)', '2024-07-23', '2026-07-22', 'Tata AIG General Insurance Co. Ltd.', '63700614390000', '2026-07-24', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit', '2029-07-26', '{\"client_id\":\"rc_v2_bxdqSTsFbkreqyIMdJoX\",\"rc_number\":\"UK06TA7775\",\"fit_up_to\":\"2026-07-22\",\"registration_date\":\"2024-07-23\",\"owner_name\":\"S**U R*****R\",\"father_name\":\"\",\"present_address\":\"Udham Singh Nagar, 263153\",\"permanent_address\":\"Udham Singh Nagar, 263153\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MBHCZFB3SRD5*****\",\"vehicle_engine_number\":\"K12NP16*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR S CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"CHOLA MANDALAM INV & FIN CO LTD\",\"financed\":true,\"insurance_company\":\"Tata AIG General Insurance Co. Ltd.\",\"insurance_policy_number\":\"63700614390000\",\"insurance_upto\":\"2026-07-24\",\"manufacturing_date\":\"4/2024\",\"manufacturing_date_formatted\":\"2024-04\",\"registered_at\":\"UDHAM SINGH NAGAR ARTO, Uttarakhand\",\"latest_by\":\"2026-05-14\",\"less_info\":true,\"tax_upto\":\"2026-07-31\",\"tax_paid_upto\":\"2026-07-31\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1405\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"970\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"UP02200550074258\",\"pucc_upto\":\"2026-08-22\",\"permit_number\":\"UK2024-AITP-5111A\",\"permit_issue_date\":\"2024-07-27\",\"permit_valid_from\":\"2024-07-27\",\"permit_valid_upto\":\"2029-07-26\",\"permit_type\":\"Tourist Permit\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/UK06TA7775_front_image_1778771696.jpg', 'uploads/vehicles/UK06TA7775_back_image_1778771696.jpg', 'Active', '2026-05-14 15:14:56'),
(57, 106, 8, 'UK04TC7775', 'S**U R*****R', 'HYUNDAI MOTOR INDIA LTD', 'AURA 1.2MT CNG S', 'SALOON', 'PETROL/CNG', 'ATLAS WHITE', '5', 'Motor Cab(LPV)', '2026-04-21', '2028-04-20', 'IFFCO Tokio General Insurance Co. Ltd.', '56417700', '2027-04-09', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit', '2031-04-24', '{\"client_id\":\"rc_v2_StladTpWTthnksKpPuKi\",\"rc_number\":\"UK04TC7775\",\"fit_up_to\":\"2028-04-20\",\"registration_date\":\"2026-04-21\",\"owner_name\":\"S**U R*****R\",\"father_name\":\"\",\"present_address\":\"Nainital, 263153\",\"permanent_address\":\"Udham Singh Nagar, 263153\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MALB241CLTM4*****\",\"vehicle_engine_number\":\"G4LATM7*****\",\"maker_description\":\"HYUNDAI MOTOR INDIA LTD\",\"maker_model\":\"AURA 1.2MT CNG S\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"ATLAS WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"MAHINDRA & MAHINDRA FIN. SERV. LTD.\",\"financed\":true,\"insurance_company\":\"IFFCO Tokio General Insurance Co. Ltd.\",\"insurance_policy_number\":\"56417700\",\"insurance_upto\":\"2027-04-09\",\"manufacturing_date\":\"3/2026\",\"manufacturing_date_formatted\":\"2026-03\",\"registered_at\":\"HALDWANI RTO, Uttarakhand\",\"latest_by\":\"2026-05-14\",\"less_info\":true,\"tax_upto\":\"2026-06-30\",\"tax_paid_upto\":\"2026-06-30\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1500\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1052\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2027-04-20\",\"permit_number\":\"UK2026-AITP-2870A\",\"permit_issue_date\":\"2026-04-25\",\"permit_valid_from\":\"2026-04-25\",\"permit_valid_upto\":\"2031-04-24\",\"permit_type\":\"Tourist Permit\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/UK04TC7775_front_image_1778771768.jpg', 'uploads/vehicles/UK04TC7775_back_image_1778771768.jpg', 'Active', '2026-05-14 15:16:08'),
(58, 271, 9, 'RJ14TH0286', 'S****N S***H', 'MARUTI SUZUKI INDIA LTD', 'ERTIGA VXI CNG', 'RIGID (PASSENGER CAR)', 'PETROL(E20)/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2026-01-01', '2027-12-31', 'The New India Assurance Company Limited', '98000031250318387870', '2026-12-31', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [Taxi Cab]', '2031-01-11', '{\"client_id\":\"rc_v2_AlhBzwavmAmnIZaLFpxa\",\"rc_number\":\"RJ14TH0286\",\"fit_up_to\":\"2027-12-31\",\"registration_date\":\"2026-01-01\",\"owner_name\":\"S****N S***H\",\"father_name\":\"\",\"present_address\":\"Jaipur, 302017\",\"permanent_address\":\"Jaipur, 302017\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SSMB*****\",\"vehicle_engine_number\":\"K15CN99*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"ERTIGA VXI CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL(E20)/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"CHOLAMANDALAM INV.& FIN.CO.LIMITED\",\"financed\":true,\"insurance_company\":\"The New India Assurance Company Limited\",\"insurance_policy_number\":\"98000031250318387870\",\"insurance_upto\":\"2026-12-31\",\"manufacturing_date\":\"12/2025\",\"manufacturing_date_formatted\":\"2025-12\",\"registered_at\":\"JAIPUR (FIRST) RTO, Rajasthan\",\"latest_by\":\"2026-05-14\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1270\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2026-12-31\",\"permit_number\":\"RJ2026-AITP-0290A\",\"permit_issue_date\":\"2026-01-12\",\"permit_valid_from\":\"2026-01-12\",\"permit_valid_upto\":\"2031-01-11\",\"permit_type\":\"Tourist Permit [Taxi Cab]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/RJ14TH0286_front_image_1778773599.jpg', 'uploads/vehicles/RJ14TH0286_back_image_1778773599.jpg', 'Active', '2026-05-14 15:46:40'),
(59, 271, 8, 'RJ14TF7725', 'S****N S***H', 'MARUTI SUZUKI INDIA LTD', 'DZIRE VXI CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '5', 'Motor Cab(LPV)', '2024-01-03', '2028-01-02', 'The New India Assurance Company Limited', '98000031250318388553', '2027-01-01', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [Taxi Cab]', '2029-01-09', '{\"client_id\":\"rc_v2_gwpptnpLhEEuWxTbwGhw\",\"rc_number\":\"RJ14TF7725\",\"fit_up_to\":\"2028-01-02\",\"registration_date\":\"2024-01-03\",\"owner_name\":\"S****N S***H\",\"father_name\":\"\",\"present_address\":\"Jaipur, 302017\",\"permanent_address\":\"Jaipur, 302017\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MBHCZFB3SPM5*****\",\"vehicle_engine_number\":\"K12NP74*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"DZIRE VXI CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"CHOLAMANDALAM INVT &FIN CO LTD\",\"financed\":true,\"insurance_company\":\"The New India Assurance Company Limited\",\"insurance_policy_number\":\"98000031250318388553\",\"insurance_upto\":\"2027-01-01\",\"manufacturing_date\":\"12/2023\",\"manufacturing_date_formatted\":\"2023-12\",\"registered_at\":\"JAIPUR (FIRST) RTO, Rajasthan\",\"latest_by\":\"2026-05-14\",\"less_info\":true,\"tax_upto\":\"2039-01-02\",\"tax_paid_upto\":\"2039-01-02\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1405\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"990\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"RJ02900140004662\",\"pucc_upto\":\"2027-01-30\",\"permit_number\":\"RJ2024-AITP-0213A\",\"permit_issue_date\":\"2024-01-10\",\"permit_valid_from\":\"2024-01-10\",\"permit_valid_upto\":\"2029-01-09\",\"permit_type\":\"Tourist Permit [Taxi Cab]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"2\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/RJ14TF7725_front_image_1778773692.jpg', 'uploads/vehicles/RJ14TF7725_back_image_1778773692.jpg', 'Active', '2026-05-14 15:48:12'),
(60, 277, 8, 'PB01E9809', 'S***T K***R', 'HYUNDAI MOTOR INDIA LTD', 'AURA 1.2MT CNG SX', 'SALOON', 'PETROL/CNG', 'ATLAS WHITE', '5', 'Motor Cab(LPV)', '2024-10-23', '2026-10-22', 'United India Insurance Co. Ltd.', '2007013125P109951981', '2026-09-22', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [TVP(MOTOR CAB)]', '2029-12-11', '{\"client_id\":\"rc_v2_IambPMViihrsujciYlQq\",\"rc_number\":\"PB01E9809\",\"fit_up_to\":\"2026-10-22\",\"registration_date\":\"2024-10-23\",\"owner_name\":\"S***T K***R\",\"father_name\":\"\",\"present_address\":\"Hoshiarpur, 144211\",\"permanent_address\":\"Hoshiarpur, 144211\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MALB341CLRM3*****\",\"vehicle_engine_number\":\"G4LARM0*****\",\"maker_description\":\"HYUNDAI MOTOR INDIA LTD\",\"maker_model\":\"AURA 1.2MT CNG SX\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"ATLAS WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"HDFC BANK LTD.\",\"financed\":true,\"insurance_company\":\"United India Insurance Co. Ltd.\",\"insurance_policy_number\":\"2007013125P109951981\",\"insurance_upto\":\"2026-09-22\",\"manufacturing_date\":\"8/2024\",\"manufacturing_date_formatted\":\"2024-08\",\"registered_at\":\"PUNJAB STA(RAC)/(AITP), Punjab\",\"latest_by\":\"2026-05-14\",\"less_info\":true,\"tax_upto\":\"2026-06-30\",\"tax_paid_upto\":\"2026-06-30\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1500\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1055\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR03700320017516\",\"pucc_upto\":\"2026-10-21\",\"permit_number\":\"PB2024-AITP-2582B\",\"permit_issue_date\":\"2024-12-16\",\"permit_valid_from\":\"2024-12-12\",\"permit_valid_upto\":\"2029-12-11\",\"permit_type\":\"Tourist Permit [TVP(MOTOR CAB)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/PB01E9809_front_image_1778774037.jpg', 'uploads/vehicles/PB01E9809_back_image_1778774037.jpg', 'Active', '2026-05-14 15:53:57'),
(61, 276, 8, 'HR55BB8372', 'M****H K***R', 'HYUNDAI MOTOR INDIA LTD', 'AURA 1.2MT CNG S', 'SALOON', 'PETROL/CNG', 'ATLAS WHITE', '5', 'Motor Cab(LPV)', '2026-02-23', '2028-02-22', 'IFFCO Tokio General Insurance Co. Ltd.', '56383932', '2026-12-30', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2031-02-25', '{\"client_id\":\"rc_v2_YlCotHtIhtlcqfXUzrbo\",\"rc_number\":\"HR55BB8372\",\"fit_up_to\":\"2028-02-22\",\"registration_date\":\"2026-02-23\",\"owner_name\":\"M****H K***R\",\"father_name\":\"\",\"present_address\":\"Gurgaon, 122017\",\"permanent_address\":\"New Delhi, 110053\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MALB241CLSM4*****\",\"vehicle_engine_number\":\"G4LASM6*****\",\"maker_description\":\"HYUNDAI MOTOR INDIA LTD\",\"maker_model\":\"AURA 1.2MT CNG S\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"ATLAS WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"MAHINDRA & MAHINDRA FNCL SRV LTD\",\"financed\":true,\"insurance_company\":\"IFFCO Tokio General Insurance Co. Ltd.\",\"insurance_policy_number\":\"56383932\",\"insurance_upto\":\"2026-12-30\",\"manufacturing_date\":\"11/2025\",\"manufacturing_date_formatted\":\"2025-11\",\"registered_at\":\"RTA, GURGAON, Haryana\",\"latest_by\":\"2026-05-14\",\"less_info\":true,\"tax_upto\":\"2026-12-31\",\"tax_paid_upto\":\"2026-12-31\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1500\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1052\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2027-02-22\",\"permit_number\":\"HR2026-AITP-4851A\",\"permit_issue_date\":\"2026-02-26\",\"permit_valid_from\":\"2026-02-26\",\"permit_valid_upto\":\"2031-02-25\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR55BB8372_front_image_1778774257.jpg', 'uploads/vehicles/HR55BB8372_back_image_1778774257.jpg', 'Active', '2026-05-14 15:57:37'),
(62, 88, 9, 'HR58E1326', 'G****N', 'MARUTI SUZUKI INDIA LTD', 'ERTIGA VXI (O) CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2025-01-02', '2027-01-01', 'United India Insurance Co. Ltd.', '2012013125P114657194', '2026-12-18', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2030-01-02', '{\"client_id\":\"rc_v2_SKFSgkudbEhWTkwSOYgm\",\"rc_number\":\"HR58E1326\",\"fit_up_to\":\"2027-01-01\",\"registration_date\":\"2025-01-02\",\"owner_name\":\"G****N\",\"father_name\":\"\",\"present_address\":\"Yamunanagar, 135103\",\"permanent_address\":\"Yamunanagar, 135103\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SRM9*****\",\"vehicle_engine_number\":\"K15CN96*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"ERTIGA VXI (O) CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"ICICI BANK LTD\",\"financed\":true,\"insurance_company\":\"United India Insurance Co. Ltd.\",\"insurance_policy_number\":\"2012013125P114657194\",\"insurance_upto\":\"2026-12-18\",\"manufacturing_date\":\"12/2024\",\"manufacturing_date_formatted\":\"2024-12\",\"registered_at\":\"RTA, YNR, Haryana\",\"latest_by\":\"2026-05-15\",\"less_info\":true,\"tax_upto\":\"2027-03-31\",\"tax_paid_upto\":\"2027-03-31\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1250\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HP06600100017710\",\"pucc_upto\":\"2026-12-30\",\"permit_number\":\"HR2025-AITP-0244A\",\"permit_issue_date\":\"2025-01-03\",\"permit_valid_from\":\"2025-01-03\",\"permit_valid_upto\":\"2030-01-02\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR58E1326_front_image_1778824769.jpg', 'uploads/vehicles/HR58E1326_back_image_1778824769.jpg', 'Active', '2026-05-15 05:59:29'),
(63, 88, 8, 'HR58D1762', 'G****N', 'MARUTI SUZUKI INDIA LTD', 'TOUR S CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '5', 'Motor Cab(LPV)', '2024-01-18', '2028-01-28', 'Shriram General Insurance  Co. Ltd.', '105013/31/26/005381', '2027-01-24', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2029-01-18', '{\"client_id\":\"rc_v2_SUUOwVegfhdQtmanllpZ\",\"rc_number\":\"HR58D1762\",\"fit_up_to\":\"2028-01-28\",\"registration_date\":\"2024-01-18\",\"owner_name\":\"G****N\",\"father_name\":\"\",\"present_address\":\"Yamunanagar, 135103\",\"permanent_address\":\"Yamunanagar, 135103\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MBHCZFB3SPL4*****\",\"vehicle_engine_number\":\"K12NP73*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR S CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"ICICI BANK LTD\",\"financed\":true,\"insurance_company\":\"Shriram General Insurance  Co. Ltd.\",\"insurance_policy_number\":\"105013/31/26/005381\",\"insurance_upto\":\"2027-01-24\",\"manufacturing_date\":\"11/2023\",\"manufacturing_date_formatted\":\"2023-11\",\"registered_at\":\"RTA, YNR, Haryana\",\"latest_by\":\"2026-05-15\",\"less_info\":true,\"tax_upto\":\"2026-05-31\",\"tax_paid_upto\":\"2026-05-31\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1405\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"970\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR05800410012845\",\"pucc_upto\":\"2027-01-27\",\"permit_number\":\"HR2024-AITP-1805A\",\"permit_issue_date\":\"2024-01-19\",\"permit_valid_from\":\"2024-01-19\",\"permit_valid_upto\":\"2029-01-18\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR58D1762_front_image_1778824837.jpg', 'uploads/vehicles/HR58D1762_back_image_1778824837.jpg', 'Active', '2026-05-15 06:00:37'),
(64, 280, 8, 'RJ14TE7349', 'K***L K***R G****J', 'TOYOTA KIRLOSKAR MOTOR PVT LTD', 'TOYOTA ETIOS GD (F)', 'SEDAN', 'DIESEL', 'WHITE', '5', 'Motor Cab(LPV)', '2019-07-22', '2027-09-22', 'Shriram General Insurance  Co. Ltd.', '106004/31/26/001014', '2026-07-19', 'BHARAT STAGE IV', 'ACTIVE', 'Tourist Permit [Taxi Cab]', '2028-07-21', '{\"client_id\":\"rc_v2_evpOjZNeFiUghxotlkcx\",\"rc_number\":\"RJ14TE7349\",\"fit_up_to\":\"2027-09-22\",\"registration_date\":\"2019-07-22\",\"owner_name\":\"K***L K***R G****J\",\"father_name\":\"\",\"present_address\":\"Jaipur, 302039\",\"permanent_address\":\"Jhunjhunun, 333502\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MBJB49BT900199938*****\",\"vehicle_engine_number\":\"1ND1B*****\",\"maker_description\":\"TOYOTA KIRLOSKAR MOTOR PVT LTD\",\"maker_model\":\"TOYOTA ETIOS GD (F)\",\"body_type\":\"SEDAN\",\"fuel_type\":\"DIESEL\",\"color\":\"WHITE\",\"norms_type\":\"BHARAT STAGE IV\",\"financer\":\"ESS KAY FINCORP LTD\",\"financed\":true,\"insurance_company\":\"Shriram General Insurance  Co. Ltd.\",\"insurance_policy_number\":\"106004/31/26/001014\",\"insurance_upto\":\"2026-07-19\",\"manufacturing_date\":\"6/2019\",\"manufacturing_date_formatted\":\"2019-06\",\"registered_at\":\"JAIPUR (FIRST) RTO, Rajasthan\",\"latest_by\":\"2026-05-15\",\"less_info\":true,\"tax_upto\":\"2034-07-17\",\"tax_paid_upto\":\"2034-07-17\",\"cubic_capacity\":\"1364.00\",\"vehicle_gross_weight\":\"1440\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2550\",\"unladen_weight\":\"1035\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"RJ05900730000702\",\"pucc_upto\":\"2027-01-17\",\"permit_number\":\"RJ/14/AITP/TAXI/2019/1377\",\"permit_issue_date\":\"2019-07-26\",\"permit_valid_from\":\"2024-07-26\",\"permit_valid_upto\":\"2028-07-21\",\"permit_type\":\"Tourist Permit [Taxi Cab]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"2\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/RJ14TE7349_front_image_1778825608.jpg', 'uploads/vehicles/RJ14TE7349_back_image_1778825608.jpg', 'Active', '2026-05-15 06:13:28');
INSERT INTO `partner_vehicles` (`id`, `partner_id`, `car_type`, `rc_number`, `owner_name`, `maker_description`, `maker_model`, `body_type`, `fuel_type`, `color`, `seat_capacity`, `vehicle_category_desc`, `registration_date`, `fit_up_to`, `insurance_company`, `insurance_policy_number`, `insurance_upto`, `norms_type`, `rc_status`, `permit_type`, `permit_valid_upto`, `raw_rc_data`, `front_image`, `back_image`, `status`, `created_at`) VALUES
(65, 277, 8, 'PB01F5300', 'K***L T****R', 'HYUNDAI MOTOR INDIA LTD', 'AURA 1.2MT CNG S', 'SALOON17', 'PETROL/CNG', 'ATLAS WHITE', '5', 'Motor Cab(LPV)', '2024-12-26', '2026-12-25', 'United India Insurance Co. Ltd.', '2003083125P105949883', '2026-07-12', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [TVP(MOTOR CAB)]', '2030-02-06', '{\"client_id\":\"rc_v2_pWfjcofuJYBCQRvhGaLs\",\"rc_number\":\"PB01F5300\",\"fit_up_to\":\"2026-12-25\",\"registration_date\":\"2024-12-26\",\"owner_name\":\"K***L T****R\",\"father_name\":\"\",\"present_address\":\"Ludhiana, 141015\",\"permanent_address\":\"Ludhiana, 141015\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MALB241CLRM2*****\",\"vehicle_engine_number\":\"G4LARM9*****\",\"maker_description\":\"HYUNDAI MOTOR INDIA LTD\",\"maker_model\":\"AURA 1.2MT CNG S\",\"body_type\":\"SALOON17\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"ATLAS WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"KOTAK MAHINDRA PRIME LTD\",\"financed\":true,\"insurance_company\":\"United India Insurance Co. Ltd.\",\"insurance_policy_number\":\"2003083125P105949883\",\"insurance_upto\":\"2026-07-12\",\"manufacturing_date\":\"5/2024\",\"manufacturing_date_formatted\":\"2024-05\",\"registered_at\":\"PUNJAB STA(RAC)/(AITP), Punjab\",\"latest_by\":\"2026-05-15\",\"less_info\":true,\"tax_upto\":\"2026-06-30\",\"tax_paid_upto\":\"2026-06-30\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1500\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1052\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR07300450024796\",\"pucc_upto\":\"2027-02-21\",\"permit_number\":\"PB2025-AITP-1891A\",\"permit_issue_date\":\"2025-02-12\",\"permit_valid_from\":\"2025-02-07\",\"permit_valid_upto\":\"2030-02-06\",\"permit_type\":\"Tourist Permit [TVP(MOTOR CAB)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/PB01F5300_front_image_1778839397.jpg', 'uploads/vehicles/PB01F5300_back_image_1778839397.jpg', 'Active', '2026-05-15 10:03:17'),
(66, 135, 8, 'HR55AB9798', 'S***A K****R', 'MARUTI SUZUKI INDIA LTD', 'SWIFT DZIRE LXI', 'SALOON', 'PETROL/CNG', 'PAWHITE', '5', 'Motor Cab(LPV)', '2017-03-28', '2027-04-09', 'SBI General', 'POCMVPC0100344592', '2026-06-11', 'BHARAT STAGE IV', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2027-03-27', '{\"client_id\":\"rc_v2_otxzNdNLXfbwjzBgjnDp\",\"rc_number\":\"HR55AB9798\",\"fit_up_to\":\"2027-04-09\",\"registration_date\":\"2017-03-28\",\"owner_name\":\"S***A K****R\",\"father_name\":\"\",\"present_address\":\"Gurgaon, 122001\",\"permanent_address\":\"Basti, 241125\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3EJKD1S00A*****\",\"vehicle_engine_number\":\"K12MN19*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"SWIFT DZIRE LXI\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PAWHITE\",\"norms_type\":\"BHARAT STAGE IV\",\"financer\":\"\",\"financed\":false,\"insurance_company\":\"SBI General\",\"insurance_policy_number\":\"POCMVPC0100344592\",\"insurance_upto\":\"2026-06-11\",\"manufacturing_date\":\"2/2017\",\"manufacturing_date_formatted\":\"2017-02\",\"registered_at\":\"RTA, GURGAON, Haryana\",\"latest_by\":\"2026-05-15\",\"less_info\":true,\"tax_upto\":\"2026-06-30\",\"tax_paid_upto\":\"2026-06-30\",\"cubic_capacity\":\"0.00\",\"vehicle_gross_weight\":\"1415\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":null,\"wheelbase\":\"0\",\"unladen_weight\":\"940\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR04703470006701\",\"pucc_upto\":\"2027-04-03\",\"permit_number\":\"3844/T/17\",\"permit_issue_date\":\"2017-03-29\",\"permit_valid_from\":\"2026-03-28\",\"permit_valid_upto\":\"2027-03-27\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"2\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR55AB9798_front_image_1778848971.jpg', 'uploads/vehicles/HR55AB9798_back_image_1778848971.jpg', 'Active', '2026-05-15 12:42:51'),
(67, 313, 8, 'DL1ZD7312', 'G****M S***H', 'MARUTI SUZUKI INDIA LTD', 'TOUR S CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '5', 'Motor Cab(LPV)', '2024-04-23', '2028-04-22', 'Oriental Insurance Co. Ltd.', '212203/31/2027/268', '2027-04-20', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [TOURIST TAXI(DELUXE)]', '2029-04-30', '{\"client_id\":\"rc_v2_xVLEvpbpiyjJJdkkAvdd\",\"rc_number\":\"DL1ZD7312\",\"fit_up_to\":\"2028-04-22\",\"registration_date\":\"2024-04-23\",\"owner_name\":\"G****M S***H\",\"father_name\":\"\",\"present_address\":\"South, 110044\",\"permanent_address\":\"South, 110044\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MBHCZFB3SRC5*****\",\"vehicle_engine_number\":\"K12NP74*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR S CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"MAHINDRA & MAHINDRA FNCL SRV LTD\",\"financed\":true,\"insurance_company\":\"Oriental Insurance Co. Ltd.\",\"insurance_policy_number\":\"212203/31/2027/268\",\"insurance_upto\":\"2027-04-20\",\"manufacturing_date\":\"3/2024\",\"manufacturing_date_formatted\":\"2024-03\",\"registered_at\":\"BURARI TAXI UNIT, Delhi\",\"latest_by\":\"2026-05-15\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1405\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"970\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR04601370067371\",\"pucc_upto\":\"2027-04-21\",\"permit_number\":\"DL2024-AITP-1651A\",\"permit_issue_date\":\"2024-05-02\",\"permit_valid_from\":\"2024-05-01\",\"permit_valid_upto\":\"2029-04-30\",\"permit_type\":\"Tourist Permit [TOURIST TAXI(DELUXE)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/DL1ZD7312_front_image_1778859760.jpg', 'uploads/vehicles/DL1ZD7312_back_image_1778859760.jpg', 'Active', '2026-05-15 15:42:40'),
(68, 212, 8, 'UP25FT9896', 'M**D F****M K**N', 'MARUTI SUZUKI INDIA LTD', 'TOUR S CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '5', 'Motor Cab(LPV)', '2023-11-11', '2028-05-11', 'Royal Sundaram General Insurance Co. Ltd', 'VPV0672823000102', '2026-08-10', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA]', '2028-11-22', '{\"client_id\":\"rc_v2_MbkvdtXilGvoSugWQxdL\",\"rc_number\":\"UP25FT9896\",\"fit_up_to\":\"2028-05-11\",\"registration_date\":\"2023-11-11\",\"owner_name\":\"M**D F****M K**N\",\"father_name\":\"\",\"present_address\":\"Bareilly, 243502\",\"permanent_address\":\"Bareilly, 243502\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MBHCZFB3SPL4*****\",\"vehicle_engine_number\":\"K12NP73*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR S CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"CHOLAMANDALAM INVESTMENT&FIN CO LTD\",\"financed\":true,\"insurance_company\":\"Royal Sundaram General Insurance Co. Ltd\",\"insurance_policy_number\":\"VPV0672823000102\",\"insurance_upto\":\"2026-08-10\",\"manufacturing_date\":\"11/2023\",\"manufacturing_date_formatted\":\"2023-11\",\"registered_at\":\"BAREILLY, Uttar Pradesh\",\"latest_by\":\"2026-05-16\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1405\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"970\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"UP02501520021440\",\"pucc_upto\":\"2027-02-23\",\"permit_number\":\"UP2023-AITP-0947C\",\"permit_issue_date\":\"2023-11-23\",\"permit_valid_from\":\"2023-11-23\",\"permit_valid_upto\":\"2028-11-22\",\"permit_type\":\"Tourist Permit [ALL INDIA]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/UP25FT9896_front_image_1778909938.jpg', 'uploads/vehicles/UP25FT9896_back_image_1778909938.jpg', 'Active', '2026-05-16 05:38:58'),
(69, 309, 8, 'KA19AB1800', 'M***F N***R K S', 'TOYOTA KIRLOSKAR MOTOR PVT LTD', 'ETIOS GD(M) BS IV', 'SEDAN', 'DIESEL', 'WHITE', '5', 'Motor Cab(LPV)', '2015-10-28', '2026-10-26', 'The New India Assurance Company Limited', '77000031250150061242', '2026-10-27', 'BHARAT STAGE III', 'ACTIVE', 'Contract Carriage Permit [MOTOR CAB PERMIT]', '2030-11-14', '{\"client_id\":\"rc_v2_DsyPTfMcXKObetdtUUEB\",\"rc_number\":\"KA19AB1800\",\"fit_up_to\":\"2026-10-26\",\"registration_date\":\"2015-10-28\",\"owner_name\":\"M***F N***R K S\",\"father_name\":\"\",\"present_address\":\"Dakshina Kannada, 574142\",\"permanent_address\":\"Dakshina Kannada, 574142\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MBJB49BT10011370*****\",\"vehicle_engine_number\":\"1ND14*****\",\"maker_description\":\"TOYOTA KIRLOSKAR MOTOR PVT LTD\",\"maker_model\":\"ETIOS GD(M) BS IV\",\"body_type\":\"SEDAN\",\"fuel_type\":\"DIESEL\",\"color\":\"WHITE\",\"norms_type\":\"BHARAT STAGE III\",\"financer\":\"SHRIRAM FINANCE LIMITED\",\"financed\":true,\"insurance_company\":\"The New India Assurance Company Limited\",\"insurance_policy_number\":\"77000031250150061242\",\"insurance_upto\":\"2026-10-27\",\"manufacturing_date\":\"10/2015\",\"manufacturing_date_formatted\":\"2015-10\",\"registered_at\":\"MANGALORE  RTO, Karnataka\",\"latest_by\":\"2026-05-16\",\"less_info\":true,\"tax_upto\":\"2026-09-30\",\"tax_paid_upto\":\"2026-09-30\",\"cubic_capacity\":\"1364.00\",\"vehicle_gross_weight\":\"1440\",\"no_cylinders\":\"2\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":null,\"wheelbase\":\"2550\",\"unladen_weight\":\"1015\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"\",\"pucc_upto\":null,\"permit_number\":\"KA2025-CC-2572M\",\"permit_issue_date\":\"2025-11-15\",\"permit_valid_from\":\"2025-11-15\",\"permit_valid_upto\":\"2030-11-14\",\"permit_type\":\"Contract Carriage Permit [MOTOR CAB PERMIT]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"2\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/KA19AB1800_front_image_1778915607.jpg', '', 'Active', '2026-05-16 07:13:27'),
(70, 294, 8, 'UP14RT8731', 'Q****N M*****D', 'HYUNDAI MOTOR INDIA LTD', 'AURA 1.2MT CNG S', 'SALOON', 'PETROL/CNG', 'ATLAS WHITE', '5', 'Motor Cab(LPV)', '2025-08-28', '2027-08-27', 'SBI General', 'HYNDAIHIIB/1483763', '2026-08-19', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA]', '2030-09-08', '{\"client_id\":\"rc_v2_ubuvntvewxrolaOOzfxq\",\"rc_number\":\"UP14RT8731\",\"fit_up_to\":\"2027-08-27\",\"registration_date\":\"2025-08-28\",\"owner_name\":\"Q****N M*****D\",\"father_name\":\"\",\"present_address\":\"Ghaziabad, 201002\",\"permanent_address\":\"Ghaziabad, 201002\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MALB241CLSM3*****\",\"vehicle_engine_number\":\"G4LASM4*****\",\"maker_description\":\"HYUNDAI MOTOR INDIA LTD\",\"maker_model\":\"AURA 1.2MT CNG S\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"ATLAS WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"AU SMALL FINANCE BANK LTD\",\"financed\":true,\"insurance_company\":\"SBI General\",\"insurance_policy_number\":\"HYNDAIHIIB/1483763\",\"insurance_upto\":\"2026-08-19\",\"manufacturing_date\":\"7/2025\",\"manufacturing_date_formatted\":\"2025-07\",\"registered_at\":\"GHAZIABAD, Uttar Pradesh\",\"latest_by\":\"2026-05-16\",\"less_info\":true,\"tax_upto\":\"2026-07-31\",\"tax_paid_upto\":\"2026-07-31\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1500\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1052\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2026-08-27\",\"permit_number\":\"UP2025-AITP-3414C\",\"permit_issue_date\":\"2025-09-09\",\"permit_valid_from\":\"2025-09-09\",\"permit_valid_upto\":\"2030-09-08\",\"permit_type\":\"Tourist Permit [ALL INDIA]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/UP14RT8731_front_image_1778916747.jpg', 'uploads/vehicles/UP14RT8731_back_image_1778916747.jpg', 'Active', '2026-05-16 07:32:27'),
(71, 21, 8, 'UP14RT8489', 'M******D A***F', 'HYUNDAI MOTOR INDIA LTD', 'AURA 1.2MT CNG S', 'SALOON', 'PETROL/CNG', 'ATLAS WHITE', '5', 'Motor Cab(LPV)', '2025-08-23', '2027-08-22', 'Shriram General Insurance  Co. Ltd.', '108047/31/26/003245', '2026-08-04', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA]', '2030-08-24', '{\"client_id\":\"rc_v2_RuTKWfKdhsMiopnhzvQj\",\"rc_number\":\"UP14RT8489\",\"fit_up_to\":\"2027-08-22\",\"registration_date\":\"2025-08-23\",\"owner_name\":\"M******D A***F\",\"father_name\":\"\",\"present_address\":\"Ghaziabad, 201009\",\"permanent_address\":\"Ghaziabad, 201009\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MALB241CLSM3*****\",\"vehicle_engine_number\":\"G4LASM4*****\",\"maker_description\":\"HYUNDAI MOTOR INDIA LTD\",\"maker_model\":\"AURA 1.2MT CNG S\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"ATLAS WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"AU SMALL FINANCE BANK LIMITED\",\"financed\":true,\"insurance_company\":\"Shriram General Insurance  Co. Ltd.\",\"insurance_policy_number\":\"108047/31/26/003245\",\"insurance_upto\":\"2026-08-04\",\"manufacturing_date\":\"7/2025\",\"manufacturing_date_formatted\":\"2025-07\",\"registered_at\":\"GHAZIABAD, Uttar Pradesh\",\"latest_by\":\"2026-05-16\",\"less_info\":true,\"tax_upto\":\"2026-07-31\",\"tax_paid_upto\":\"2026-07-31\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1500\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1052\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"UP01402010045817\",\"pucc_upto\":\"2026-09-14\",\"permit_number\":\"UP2025-AITP-2143C\",\"permit_issue_date\":\"2025-08-25\",\"permit_valid_from\":\"2025-08-25\",\"permit_valid_upto\":\"2030-08-24\",\"permit_type\":\"Tourist Permit [ALL INDIA]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/UP14RT8489_front_image_1778919765.jpg', 'uploads/vehicles/UP14RT8489_back_image_1778919765.jpg', 'Active', '2026-05-16 08:22:45'),
(72, 65, 8, 'UP85DT4657', 'S**V K***R Y***V', 'MARUTI SUZUKI INDIA LTD', 'DZIRE VXI CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'MAGMA GRAY', '5', 'Motor Cab(LPV)', '2023-05-03', '2027-05-13', 'The New India Assurance Company Limited', '98000031260319060670', '2027-04-27', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA]', '2028-05-24', '{\"client_id\":\"rc_v2_tSupKelMbzegyuTcmCmz\",\"rc_number\":\"UP85DT4657\",\"fit_up_to\":\"2027-05-13\",\"registration_date\":\"2023-05-03\",\"owner_name\":\"S**V K***R Y***V\",\"father_name\":\"\",\"present_address\":\"Mathura, 281004\",\"permanent_address\":\"Mathura, 281004\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MBHCZFB3SPD4*****\",\"vehicle_engine_number\":\"K12NP72*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"DZIRE VXI CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"MAGMA GRAY\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"CHOLAMANDALAM INVESTMENT AND FIN CO\",\"financed\":true,\"insurance_company\":\"The New India Assurance Company Limited\",\"insurance_policy_number\":\"98000031260319060670\",\"insurance_upto\":\"2027-04-27\",\"manufacturing_date\":\"4/2023\",\"manufacturing_date_formatted\":\"2023-04\",\"registered_at\":\"MATHURA, Uttar Pradesh\",\"latest_by\":\"2026-05-16\",\"less_info\":true,\"tax_upto\":\"2026-06-30\",\"tax_paid_upto\":\"2026-06-30\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1405\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"990\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"UP08500150035389\",\"pucc_upto\":\"2027-01-20\",\"permit_number\":\"UP2023-AITP-7563A\",\"permit_issue_date\":\"2023-05-25\",\"permit_valid_from\":\"2023-05-25\",\"permit_valid_upto\":\"2028-05-24\",\"permit_type\":\"Tourist Permit [ALL INDIA]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/UP85DT4657_front_image_1778932191.jpg', 'uploads/vehicles/UP85DT4657_back_image_1778932191.jpg', 'Active', '2026-05-16 11:49:51'),
(73, 327, 9, 'UP36AT4645', 'A**T K***R', 'MARUTI SUZUKI INDIA LTD', 'ERTIGA VXI (O) CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2024-11-07', '2026-11-06', 'The New India Assurance Company Limited', '98000031250318741684', '2027-02-26', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA]', '2029-12-23', '{\"client_id\":\"rc_v2_jENBrurolqdEhHziirbu\",\"rc_number\":\"UP36AT4645\",\"fit_up_to\":\"2026-11-06\",\"registration_date\":\"2024-11-07\",\"owner_name\":\"A**T K***R\",\"father_name\":\"\",\"present_address\":\"Rae Bareli, 229001\",\"permanent_address\":\"Rae Bareli, 229001\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SRG8*****\",\"vehicle_engine_number\":\"K15CN95*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"ERTIGA VXI (O) CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"SK FINANCE LIMITED\",\"financed\":true,\"insurance_company\":\"The New India Assurance Company Limited\",\"insurance_policy_number\":\"98000031250318741684\",\"insurance_upto\":\"2027-02-26\",\"manufacturing_date\":\"8/2024\",\"manufacturing_date_formatted\":\"2024-08\",\"registered_at\":\"Amethi ARTO, Uttar Pradesh\",\"latest_by\":\"2026-05-16\",\"less_info\":true,\"tax_upto\":\"2025-09-30\",\"tax_paid_upto\":\"2025-09-30\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1250\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"UP03203100032322\",\"pucc_upto\":\"2027-01-29\",\"permit_number\":\"UP2024-AITP-0401D\",\"permit_issue_date\":\"2024-12-24\",\"permit_valid_from\":\"2024-12-24\",\"permit_valid_upto\":\"2029-12-23\",\"permit_type\":\"Tourist Permit [ALL INDIA]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/UP36AT4645_front_image_1778944220.jpg', 'uploads/vehicles/UP36AT4645_back_image_1778944220.jpg', 'Active', '2026-05-16 15:10:20'),
(74, 334, 9, 'HR37F9609', 'R***T K***R', 'MARUTI SUZUKI INDIA LTD', 'ERTIGA VXI CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2025-09-15', '2027-09-14', 'National Insurance Co. Ltd.', '42050331251351321076', '2026-08-30', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2030-09-29', '{\"client_id\":\"rc_v2_vhlhaSmwwdmVZDXMUNDh\",\"rc_number\":\"HR37F9609\",\"fit_up_to\":\"2027-09-14\",\"registration_date\":\"2025-09-15\",\"owner_name\":\"R***T K***R\",\"father_name\":\"\",\"present_address\":\"Ambala, 134203\",\"permanent_address\":\"Ambala, 134203\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SSHB*****\",\"vehicle_engine_number\":\"K15CN98*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"ERTIGA VXI CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"AU SMALL FIN.BANK  LTD AMBALA\",\"financed\":true,\"insurance_company\":\"National Insurance Co. Ltd.\",\"insurance_policy_number\":\"42050331251351321076\",\"insurance_upto\":\"2026-08-30\",\"manufacturing_date\":\"8/2025\",\"manufacturing_date_formatted\":\"2025-08\",\"registered_at\":\"RTA AMBALA, Haryana\",\"latest_by\":\"2026-05-16\",\"less_info\":true,\"tax_upto\":\"2026-08-31\",\"tax_paid_upto\":\"2026-08-31\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1270\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2026-09-14\",\"permit_number\":\"HR2025-AITP-9067C\",\"permit_issue_date\":\"2025-09-30\",\"permit_valid_from\":\"2025-09-30\",\"permit_valid_upto\":\"2030-09-29\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR37F9609_front_image_1778949597.jpg', 'uploads/vehicles/HR37F9609_back_image_1778949597.jpg', 'Active', '2026-05-16 16:39:57'),
(75, 245, 8, 'PB01C9092', 'G****M S***H', 'HYUNDAI MOTOR INDIA LTD', 'AURA 1.2MT CNG S', 'MOTOR CAB', 'PETROL/CNG', 'POLAR WHITE 2', '5', 'Motor Cab(LPV)', '2022-06-01', '2026-06-03', 'Universal Sompo General Insurance  Co. Ltd.', 'AVO/2314/20010532', '2026-05-24', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [TVP(MOTOR CAB)]', '2027-06-06', '{\"client_id\":\"rc_v2_pqQpDfxkvuSgkjenwWxy\",\"rc_number\":\"PB01C9092\",\"fit_up_to\":\"2026-06-03\",\"registration_date\":\"2022-06-01\",\"owner_name\":\"G****M S***H\",\"father_name\":\"\",\"present_address\":\"Patiala, 147001\",\"permanent_address\":\"Patiala, 147001\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MALB241CLNM1*****\",\"vehicle_engine_number\":\"G4LANM1*****\",\"maker_description\":\"HYUNDAI MOTOR INDIA LTD\",\"maker_model\":\"AURA 1.2MT CNG S\",\"body_type\":\"MOTOR CAB\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"POLAR WHITE 2\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"MAHINDRA & MAHINDRA FINANCIAL SERVI\",\"financed\":true,\"insurance_company\":\"Universal Sompo General Insurance  Co. Ltd.\",\"insurance_policy_number\":\"AVO/2314/20010532\",\"insurance_upto\":\"2026-05-24\",\"manufacturing_date\":\"4/2022\",\"manufacturing_date_formatted\":\"2022-04\",\"registered_at\":\"PUNJAB STA(RAC)/(AITP), Punjab\",\"latest_by\":\"2026-05-16\",\"less_info\":true,\"tax_upto\":\"2026-06-30\",\"tax_paid_upto\":\"2026-06-30\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1500\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1050\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"DL01300180078838\",\"pucc_upto\":\"2026-12-24\",\"permit_number\":\"PB2022-AITP-2278A\",\"permit_issue_date\":\"2022-06-10\",\"permit_valid_from\":\"2022-06-07\",\"permit_valid_upto\":\"2027-06-06\",\"permit_type\":\"Tourist Permit [TVP(MOTOR CAB)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/PB01C9092_front_image_1778950198.jpg', 'uploads/vehicles/PB01C9092_back_image_1778950198.jpg', 'Active', '2026-05-16 16:49:58'),
(76, 339, 7, 'UP30ET0891', 'H*****M S***H', 'HYUNDAI MOTOR INDIA LTD', 'AURA 1.2MT CNG S', 'SALOON', 'PETROL/CNG', 'ATLAS WHITE', '5', 'Motor Cab(LPV)', '2025-10-20', '2027-10-19', 'IFFCO Tokio General Insurance Co. Ltd.', '56361756', '2026-10-16', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA]', '2030-11-05', '{\"client_id\":\"rc_v2_pVRviUMxtyOneyyylvwf\",\"rc_number\":\"UP30ET0891\",\"fit_up_to\":\"2027-10-19\",\"registration_date\":\"2025-10-20\",\"owner_name\":\"H*****M S***H\",\"father_name\":\"\",\"present_address\":\"Hardoi, 241402\",\"permanent_address\":\"Hardoi, 241402\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MALB241CLSM4*****\",\"vehicle_engine_number\":\"G4LASM5*****\",\"maker_description\":\"HYUNDAI MOTOR INDIA LTD\",\"maker_model\":\"AURA 1.2MT CNG S\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"ATLAS WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"BANK OF INDIA\",\"financed\":true,\"insurance_company\":\"IFFCO Tokio General Insurance Co. Ltd.\",\"insurance_policy_number\":\"56361756\",\"insurance_upto\":\"2026-10-16\",\"manufacturing_date\":\"9/2025\",\"manufacturing_date_formatted\":\"2025-09\",\"registered_at\":\"HARDOI, Uttar Pradesh\",\"latest_by\":\"2026-05-17\",\"less_info\":true,\"tax_upto\":\"2026-09-30\",\"tax_paid_upto\":\"2026-09-30\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1500\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1052\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2026-10-19\",\"permit_number\":\"UP2025-AITP-8461C\",\"permit_issue_date\":\"2025-11-06\",\"permit_valid_from\":\"2025-11-06\",\"permit_valid_upto\":\"2030-11-05\",\"permit_type\":\"Tourist Permit [ALL INDIA]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/UP30ET0891_front_image_1779026050.jpg', 'uploads/vehicles/UP30ET0891_back_image_1779026050.jpg', 'Active', '2026-05-17 13:54:10'),
(77, 57, 9, 'UP16RT6135', 'K*****P', 'MARUTI SUZUKI INDIA LTD', 'ERTIGA VXI CNG', 'RIGID (PASSENGER CAR)', 'PETROL(E20)/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2026-01-01', '2027-12-31', 'IFFCO Tokio General Insurance Co. Ltd.', 'MR00092534', '2026-12-27', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA]', '2031-01-20', '{\"client_id\":\"rc_v2_cODCwOUCsaWdCGvDpadj\",\"rc_number\":\"UP16RT6135\",\"fit_up_to\":\"2027-12-31\",\"registration_date\":\"2026-01-01\",\"owner_name\":\"K*****P\",\"father_name\":\"\",\"present_address\":\"Gautam Buddha Nagar, 201301\",\"permanent_address\":\"Gautam Buddha Nagar, 201301\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SSMB*****\",\"vehicle_engine_number\":\"K15CN99*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"ERTIGA VXI CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL(E20)/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"MAHINDRA & MAHINDRA FIN.SER.LTD\",\"financed\":true,\"insurance_company\":\"IFFCO Tokio General Insurance Co. Ltd.\",\"insurance_policy_number\":\"MR00092534\",\"insurance_upto\":\"2026-12-27\",\"manufacturing_date\":\"12/2025\",\"manufacturing_date_formatted\":\"2025-12\",\"registered_at\":\"Noida, Uttar Pradesh\",\"latest_by\":\"2026-05-18\",\"less_info\":true,\"tax_upto\":\"2026-11-30\",\"tax_paid_upto\":\"2026-11-30\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1270\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2026-12-31\",\"permit_number\":\"UP2026-AITP-0850A\",\"permit_issue_date\":\"2026-01-21\",\"permit_valid_from\":\"2026-01-21\",\"permit_valid_upto\":\"2031-01-20\",\"permit_type\":\"Tourist Permit [ALL INDIA]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/UP16RT6135_front_image_1779063244.jpg', 'uploads/vehicles/UP16RT6135_back_image_1779063244.jpg', 'Active', '2026-05-18 00:14:04'),
(78, 314, 9, 'RJ14TG1780', 'G****H P****R', 'MARUTI SUZUKI INDIA LTD', 'ERTIGA ZXI (O) CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2024-08-31', '2026-08-30', 'The New India Assurance Company Limited', '98000031250317612072', '2026-08-30', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [Taxi Cab]', '2029-09-04', '{\"client_id\":\"rc_v2_HastEISyTNlqFZdaUfZt\",\"rc_number\":\"RJ14TG1780\",\"fit_up_to\":\"2026-08-30\",\"registration_date\":\"2024-08-31\",\"owner_name\":\"G****H P****R\",\"father_name\":\"\",\"present_address\":\"Jaipur, 302020\",\"permanent_address\":\"Jaipur, 302020\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SRH8*****\",\"vehicle_engine_number\":\"K15CN95*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"ERTIGA ZXI (O) CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"A U SMALL FINANCE BANK LTD\",\"financed\":true,\"insurance_company\":\"The New India Assurance Company Limited\",\"insurance_policy_number\":\"98000031250317612072\",\"insurance_upto\":\"2026-08-30\",\"manufacturing_date\":\"8/2024\",\"manufacturing_date_formatted\":\"2024-08\",\"registered_at\":\"JAIPUR (FIRST) RTO, Rajasthan\",\"latest_by\":\"2026-05-18\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1255\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"RJ01400580002340\",\"pucc_upto\":\"2026-08-29\",\"permit_number\":\"RJ2024-AITP-6446A\",\"permit_issue_date\":\"2024-09-05\",\"permit_valid_from\":\"2024-09-05\",\"permit_valid_upto\":\"2029-09-04\",\"permit_type\":\"Tourist Permit [Taxi Cab]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/RJ14TG1780_front_image_1779065339.jpg', 'uploads/vehicles/RJ14TG1780_back_image_1779065339.jpg', 'Active', '2026-05-18 00:48:59'),
(79, 269, 8, 'RJ14TF2941', 'M/S M***A T**R A*D T*****S', 'MARUTI SUZUKI INDIA LTD', 'CIAZ SMART HYBRID DELTA', 'RIGID (PASSENGER CAR)', 'PETROL/HYBRID', 'PEARL ARCTIC WHITE', '5', 'Motor Cab(LPV)', '2023-02-13', '2027-05-28', 'Shriram General Insurance  Co. Ltd.', '106021/31/26/010903', '2027-02-03', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [Taxi Cab]', '2028-02-22', '{\"client_id\":\"rc_v2_YkZGfGsofixyGWhFaDFd\",\"rc_number\":\"RJ14TF2941\",\"fit_up_to\":\"2027-05-28\",\"registration_date\":\"2023-02-13\",\"owner_name\":\"M/S M***A T**R A*D T*****S\",\"father_name\":\"\",\"present_address\":\"Jaipur, 302004\",\"permanent_address\":\"Jaipur, 302004\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3EXGL1S004*****\",\"vehicle_engine_number\":\"K15BN13*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"CIAZ SMART HYBRID DELTA\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/HYBRID\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"AU SMALL FINANCE BANK LTD\",\"financed\":true,\"insurance_company\":\"Shriram General Insurance  Co. Ltd.\",\"insurance_policy_number\":\"106021/31/26/010903\",\"insurance_upto\":\"2027-02-03\",\"manufacturing_date\":\"11/2022\",\"manufacturing_date_formatted\":\"2022-11\",\"registered_at\":\"JAIPUR (FIRST) RTO, Rajasthan\",\"latest_by\":\"2026-05-18\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1520\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2650\",\"unladen_weight\":\"1040\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"RJ04200060002278\",\"pucc_upto\":\"2026-05-24\",\"permit_number\":\"RJ2023-AITP-0825A\",\"permit_issue_date\":\"2023-02-23\",\"permit_valid_from\":\"2023-02-23\",\"permit_valid_upto\":\"2028-02-22\",\"permit_type\":\"Tourist Permit [Taxi Cab]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/RJ14TF2941_front_image_1779096877.jpg', 'uploads/vehicles/RJ14TF2941_back_image_1779096877.jpg', 'Active', '2026-05-18 09:34:37'),
(80, 178, 11, 'HR37E6123', 'V****L', 'TOYOTA KIRLOSKAR MOTOR PVT LTD', 'INNOVA CRYSTA (GX, MT)', 'STATION WAGON', 'DIESEL', 'SUPER WHITE', '8', 'Motor Cab(LPV)', '2023-08-01', '2027-07-31', 'Shriram General Insurance  Co. Ltd.', '102014/31/26/001481', '2026-08-11', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2028-08-01', '{\"client_id\":\"rc_v2_eeUsdJzlToZdSIMljDbc\",\"rc_number\":\"HR37E6123\",\"fit_up_to\":\"2027-07-31\",\"registration_date\":\"2023-08-01\",\"owner_name\":\"V****L\",\"father_name\":\"\",\"present_address\":\"Ambala, 134007\",\"permanent_address\":\"Ambala, 134007\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MBJJB8EM401642443*****\",\"vehicle_engine_number\":\"2GDA7*****\",\"maker_description\":\"TOYOTA KIRLOSKAR MOTOR PVT LTD\",\"maker_model\":\"INNOVA CRYSTA (GX, MT)\",\"body_type\":\"STATION WAGON\",\"fuel_type\":\"DIESEL\",\"color\":\"SUPER WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"\",\"financed\":false,\"insurance_company\":\"Shriram General Insurance  Co. Ltd.\",\"insurance_policy_number\":\"102014/31/26/001481\",\"insurance_upto\":\"2026-08-11\",\"manufacturing_date\":\"6/2023\",\"manufacturing_date_formatted\":\"2023-06\",\"registered_at\":\"RTA AMBALA, Haryana\",\"latest_by\":\"2026-05-18\",\"less_info\":true,\"tax_upto\":\"2026-06-30\",\"tax_paid_upto\":\"2026-06-30\",\"cubic_capacity\":\"2393.00\",\"vehicle_gross_weight\":\"2490\",\"no_cylinders\":\"4\",\"seat_capacity\":\"8\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2750\",\"unladen_weight\":\"1860\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR03701480022401\",\"pucc_upto\":\"2027-03-11\",\"permit_number\":\"HR2023-AITP-8903B\",\"permit_issue_date\":\"2023-08-02\",\"permit_valid_from\":\"2023-08-02\",\"permit_valid_upto\":\"2028-08-01\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"2\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR37E6123_front_image_1779107245.jpg', 'uploads/vehicles/HR37E6123_back_image_1779107245.jpg', 'Active', '2026-05-18 12:27:25'),
(81, 96, 9, 'UK07TE1580', 'A****F A*I', 'MARUTI SUZUKI INDIA LTD', 'ERTIGA VXI (O) CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2025-01-13', '2027-01-12', 'United India Insurance Co. Ltd.', '04280031250160144785', '2026-12-20', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit', '2030-01-17', '{\"client_id\":\"rc_v2_PdKbjSHGgKKxQcqhwvkX\",\"rc_number\":\"UK07TE1580\",\"fit_up_to\":\"2027-01-12\",\"registration_date\":\"2025-01-13\",\"owner_name\":\"A****F A*I\",\"father_name\":\"\",\"present_address\":\"Dehradun, 248171\",\"permanent_address\":\"Dehradun, 248171\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SRL9*****\",\"vehicle_engine_number\":\"K15CN96*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"ERTIGA VXI (O) CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"HDB  FINANCIAL SER LTD\",\"financed\":true,\"insurance_company\":\"United India Insurance Co. Ltd.\",\"insurance_policy_number\":\"04280031250160144785\",\"insurance_upto\":\"2026-12-20\",\"manufacturing_date\":\"11/2024\",\"manufacturing_date_formatted\":\"2024-11\",\"registered_at\":\"DEHRADUN RTO, Uttarakhand\",\"latest_by\":\"2026-05-18\",\"less_info\":true,\"tax_upto\":\"2026-05-31\",\"tax_paid_upto\":\"2026-05-31\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1250\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"UK00701020020504\",\"pucc_upto\":\"2027-01-13\",\"permit_number\":\"UK2025-AITP-0434A\",\"permit_issue_date\":\"2025-01-18\",\"permit_valid_from\":\"2025-01-18\",\"permit_valid_upto\":\"2030-01-17\",\"permit_type\":\"Tourist Permit\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/UK07TE1580_front_image_1779107348.jpg', 'uploads/vehicles/UK07TE1580_back_image_1779107348.jpg', 'Active', '2026-05-18 12:29:08'),
(82, 359, 7, 'UP84BT5903', 'S******R K**N', 'HYUNDAI MOTOR INDIA LTD', 'PRIME SD 1.2 MT CNG', 'SALOON', 'PETROL(E20)/CNG', 'ATLAS WHITE', '5', 'Motor Cab(LPV)', '2026-03-24', '2028-03-23', 'IFFCO Tokio General Insurance Co. Ltd.', '56411450', '2027-03-23', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA]', '2031-05-03', '{\"client_id\":\"rc_v2_piiWfmvVirhJjmcPnTqs\",\"rc_number\":\"UP84BT5903\",\"fit_up_to\":\"2028-03-23\",\"registration_date\":\"2026-03-24\",\"owner_name\":\"S******R K**N\",\"father_name\":\"\",\"present_address\":\"Mainpuri, 205264\",\"permanent_address\":\"Mainpuri, 205264\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MALB141CLTM4*****\",\"vehicle_engine_number\":\"G4LATM6*****\",\"maker_description\":\"HYUNDAI MOTOR INDIA LTD\",\"maker_model\":\"PRIME SD 1.2 MT CNG\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL(E20)/CNG\",\"color\":\"ATLAS WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"CHOLAMANDALAM INV. & FIN.COM.LTD\",\"financed\":true,\"insurance_company\":\"IFFCO Tokio General Insurance Co. Ltd.\",\"insurance_policy_number\":\"56411450\",\"insurance_upto\":\"2027-03-23\",\"manufacturing_date\":\"1/2026\",\"manufacturing_date_formatted\":\"2026-01\",\"registered_at\":\"Mainpuri, Uttar Pradesh\",\"latest_by\":\"2026-05-18\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1500\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1049\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2027-03-23\",\"permit_number\":\"UP2026-AITP-1447B\",\"permit_issue_date\":\"2026-05-04\",\"permit_valid_from\":\"2026-05-04\",\"permit_valid_upto\":\"2031-05-03\",\"permit_type\":\"Tourist Permit [ALL INDIA]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/UP84BT5903_front_image_1779118797.jpg', 'uploads/vehicles/UP84BT5903_back_image_1779118797.jpg', 'Active', '2026-05-18 15:39:57'),
(84, 24, 7, 'HR55BC1321', 'A*****R P*L S***H', 'TOYOTA KIRLOSKAR MOTOR PVT LTD', 'INNOVA HYCROSS HYBRID VX(8S)', 'PASSANGER CAR', 'STRONG HYBRID EV', 'SUPER WHITE', '8', 'Maxi Cab(LPV)', '2026-05-05', '2028-05-04', 'SBI General', '0TSB/000074473', '2027-03-30', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2031-05-06', '{\"client_id\":\"rc_v2_POGpLyhPysXWAWefLrpQ\",\"rc_number\":\"HR55BC1321\",\"fit_up_to\":\"2028-05-04\",\"registration_date\":\"2026-05-05\",\"owner_name\":\"A*****R P*L S***H\",\"father_name\":\"\",\"present_address\":\"Gurgaon, 122001\",\"permanent_address\":\"South, 110068\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MBJABBAA001552778*****\",\"vehicle_engine_number\":\"M20ANF*****\",\"maker_description\":\"TOYOTA KIRLOSKAR MOTOR PVT LTD\",\"maker_model\":\"INNOVA HYCROSS HYBRID VX(8S)\",\"body_type\":\"PASSANGER CAR\",\"fuel_type\":\"STRONG HYBRID EV\",\"color\":\"SUPER WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"ICICI BANK LTD\",\"financed\":true,\"insurance_company\":\"SBI General\",\"insurance_policy_number\":\"0TSB/000074473\",\"insurance_upto\":\"2027-03-30\",\"manufacturing_date\":\"2/2026\",\"manufacturing_date_formatted\":\"2026-02\",\"registered_at\":\"RTA, GURGAON, Haryana\",\"latest_by\":\"2026-05-18\",\"less_info\":true,\"tax_upto\":\"2027-03-31\",\"tax_paid_upto\":\"2027-03-31\",\"cubic_capacity\":\"1987.00\",\"vehicle_gross_weight\":\"2320\",\"no_cylinders\":\"4\",\"seat_capacity\":\"8\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2850\",\"unladen_weight\":\"1630\",\"vehicle_category_description\":\"Maxi Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2027-05-04\",\"permit_number\":\"HR2026-AITP-5815B\",\"permit_issue_date\":\"2026-05-07\",\"permit_valid_from\":\"2026-05-07\",\"permit_valid_upto\":\"2031-05-06\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR55BC1321_front_image_1779122936.jpg', 'uploads/vehicles/HR55BC1321_back_image_1779122936.jpg', 'Active', '2026-05-18 16:48:56'),
(85, 24, 7, 'HR55BB9183', 'A*****R P*L S***H', 'TOYOTA KIRLOSKAR MOTOR PVT LTD', 'INNOVA CRYSTA 2.4G (GX+, MT)', 'STATION WAGON', 'DIESEL', 'SUPER WHITE', '8', 'Maxi Cab(LPV)', '2026-02-12', '2028-02-11', 'SBI General', 'TSB/000009682', '2026-12-27', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2031-02-12', '{\"client_id\":\"rc_v2_gZpjtmLEDfAEkPFAQfyz\",\"rc_number\":\"HR55BB9183\",\"fit_up_to\":\"2028-02-11\",\"registration_date\":\"2026-02-12\",\"owner_name\":\"A*****R P*L S***H\",\"father_name\":\"\",\"present_address\":\"Gurgaon, 122001\",\"permanent_address\":\"New Delhi, 110068\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MBJJB8EMX01701821*****\",\"vehicle_engine_number\":\"2GDA9*****\",\"maker_description\":\"TOYOTA KIRLOSKAR MOTOR PVT LTD\",\"maker_model\":\"INNOVA CRYSTA 2.4G (GX+, MT)\",\"body_type\":\"STATION WAGON\",\"fuel_type\":\"DIESEL\",\"color\":\"SUPER WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"TOYOTA FINANCIAL SERVICES INDIA LTD\",\"financed\":true,\"insurance_company\":\"SBI General\",\"insurance_policy_number\":\"TSB/000009682\",\"insurance_upto\":\"2026-12-27\",\"manufacturing_date\":\"12/2025\",\"manufacturing_date_formatted\":\"2025-12\",\"registered_at\":\"RTA, GURGAON, Haryana\",\"latest_by\":\"2026-05-18\",\"less_info\":true,\"tax_upto\":\"2026-12-31\",\"tax_paid_upto\":\"2026-12-31\",\"cubic_capacity\":\"2393.00\",\"vehicle_gross_weight\":\"2490\",\"no_cylinders\":\"4\",\"seat_capacity\":\"8\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2750\",\"unladen_weight\":\"1860\",\"vehicle_category_description\":\"Maxi Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2027-02-11\",\"permit_number\":\"HR2026-AITP-2404A\",\"permit_issue_date\":\"2026-02-13\",\"permit_valid_from\":\"2026-02-13\",\"permit_valid_upto\":\"2031-02-12\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR55BB9183_front_image_1779124059.jpg', 'uploads/vehicles/HR55BB9183_back_image_1779124059.jpg', 'Active', '2026-05-18 17:07:39');
INSERT INTO `partner_vehicles` (`id`, `partner_id`, `car_type`, `rc_number`, `owner_name`, `maker_description`, `maker_model`, `body_type`, `fuel_type`, `color`, `seat_capacity`, `vehicle_category_desc`, `registration_date`, `fit_up_to`, `insurance_company`, `insurance_policy_number`, `insurance_upto`, `norms_type`, `rc_status`, `permit_type`, `permit_valid_upto`, `raw_rc_data`, `front_image`, `back_image`, `status`, `created_at`) VALUES
(86, 24, 7, 'HR55BB6762', 'A*****R P*L S***H', 'TOYOTA KIRLOSKAR MOTOR PVT LTD', 'INNOVA CRYSTA 2.4G (GX+, MT)', 'STATION WAGON', 'DIESEL', 'AVANT GARDE BRONZE', '8', 'Maxi Cab(LPV)', '2026-03-06', '2028-03-05', 'IndusInd General Insurance Co. Ltd', '996592623400000090', '2027-02-24', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2031-03-10', '{\"client_id\":\"rc_v2_MazvwmFgZwGyadtUkard\",\"rc_number\":\"HR55BB6762\",\"fit_up_to\":\"2028-03-05\",\"registration_date\":\"2026-03-06\",\"owner_name\":\"A*****R P*L S***H\",\"father_name\":\"\",\"present_address\":\"Gurgaon, 122001\",\"permanent_address\":\"South, 110068\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MBJJB8EM001704226*****\",\"vehicle_engine_number\":\"2GDA9*****\",\"maker_description\":\"TOYOTA KIRLOSKAR MOTOR PVT LTD\",\"maker_model\":\"INNOVA CRYSTA 2.4G (GX+, MT)\",\"body_type\":\"STATION WAGON\",\"fuel_type\":\"DIESEL\",\"color\":\"AVANT GARDE BRONZE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"TOYOTA FINANCIAL SERVICES INDIA LTD\",\"financed\":true,\"insurance_company\":\"IndusInd General Insurance Co. Ltd\",\"insurance_policy_number\":\"996592623400000090\",\"insurance_upto\":\"2027-02-24\",\"manufacturing_date\":\"1/2026\",\"manufacturing_date_formatted\":\"2026-01\",\"registered_at\":\"RTA, GURGAON, Haryana\",\"latest_by\":\"2026-05-18\",\"less_info\":true,\"tax_upto\":\"2027-02-28\",\"tax_paid_upto\":\"2027-02-28\",\"cubic_capacity\":\"2393.00\",\"vehicle_gross_weight\":\"2490\",\"no_cylinders\":\"4\",\"seat_capacity\":\"8\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2750\",\"unladen_weight\":\"1860\",\"vehicle_category_description\":\"Maxi Cab(LPV)\",\"pucc_number\":\"UP01502750008115\",\"pucc_upto\":\"2027-04-22\",\"permit_number\":\"HR2026-AITP-7648A\",\"permit_issue_date\":\"2026-03-11\",\"permit_valid_from\":\"2026-03-11\",\"permit_valid_upto\":\"2031-03-10\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR55BB6762_front_image_1779126028.jpg', 'uploads/vehicles/HR55BB6762_back_image_1779126028.jpg', 'Active', '2026-05-18 17:40:28'),
(87, 24, 7, 'DL1VC6754', 'A*****R P*L S***H', 'FORCE MOTORS LIMITED', 'URBANIA', 'MINI BUS', 'DIESEL', 'WHITE', '17', 'Bus(LPV)', '2026-02-03', '2028-02-02', 'United India Insurance Co. Ltd.', '0402023125P116620798', '2027-01-23', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2031-02-03', '{\"client_id\":\"rc_v2_UmDYfjqEEoyfKbicopfX\",\"rc_number\":\"DL1VC6754\",\"fit_up_to\":\"2028-02-02\",\"registration_date\":\"2026-02-03\",\"owner_name\":\"A*****R P*L S***H\",\"father_name\":\"\",\"present_address\":\"South, 110068\",\"permanent_address\":\"South, 110068\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MC1M4AAA4TP0*****\",\"vehicle_engine_number\":\"D710*****\",\"maker_description\":\"FORCE MOTORS LIMITED\",\"maker_model\":\"URBANIA\",\"body_type\":\"MINI BUS\",\"fuel_type\":\"DIESEL\",\"color\":\"WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"HDB FINANCIAL SERVICES LTD\",\"financed\":true,\"insurance_company\":\"United India Insurance Co. Ltd.\",\"insurance_policy_number\":\"0402023125P116620798\",\"insurance_upto\":\"2027-01-23\",\"manufacturing_date\":\"1/2026\",\"manufacturing_date_formatted\":\"2026-01\",\"registered_at\":\"RAJPUR ROAD/VIU BURARI, Delhi\",\"latest_by\":\"2026-05-18\",\"less_info\":true,\"tax_upto\":\"2028-03-31\",\"tax_paid_upto\":\"2028-03-31\",\"cubic_capacity\":\"2596.00\",\"vehicle_gross_weight\":\"4610\",\"no_cylinders\":\"4\",\"seat_capacity\":\"17\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"4400\",\"unladen_weight\":\"3185\",\"vehicle_category_description\":\"Bus(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2027-02-02\",\"permit_number\":\"DL2026-AITP-0246A\",\"permit_issue_date\":\"2026-02-05\",\"permit_valid_from\":\"2026-02-04\",\"permit_valid_upto\":\"2031-02-03\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/DL1VC6754_front_image_1779126152.jpg', 'uploads/vehicles/DL1VC6754_back_image_1779126152.jpg', 'Active', '2026-05-18 17:42:32'),
(88, 24, 7, 'HR55BB8005', 'A*****R P*L S***H', 'MARUTI SUZUKI INDIA LTD', 'ERTIGA VXI CNG', 'RIGID (PASSENGER CAR)', 'PETROL(E20)/CNG', 'MAGMA GRAY', '7', 'Motor Cab(LPV)', '2026-02-26', '2028-02-25', 'IFFCO Tokio General Insurance Co. Ltd.', 'MR00122289', '2027-01-04', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2031-03-12', '{\"client_id\":\"rc_v2_WoTyPhFLNtdcNOtYwVoJ\",\"rc_number\":\"HR55BB8005\",\"fit_up_to\":\"2028-02-25\",\"registration_date\":\"2026-02-26\",\"owner_name\":\"A*****R P*L S***H\",\"father_name\":\"\",\"present_address\":\"Gurgaon, 122004\",\"permanent_address\":\"South, 110068\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SSLB*****\",\"vehicle_engine_number\":\"K15CN99*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"ERTIGA VXI CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL(E20)/CNG\",\"color\":\"MAGMA GRAY\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"MAHINDRA & MAHINDRA FNCL SRV LTD\",\"financed\":true,\"insurance_company\":\"IFFCO Tokio General Insurance Co. Ltd.\",\"insurance_policy_number\":\"MR00122289\",\"insurance_upto\":\"2027-01-04\",\"manufacturing_date\":\"11/2025\",\"manufacturing_date_formatted\":\"2025-11\",\"registered_at\":\"RTA, GURGAON, Haryana\",\"latest_by\":\"2026-05-18\",\"less_info\":true,\"tax_upto\":\"2026-12-31\",\"tax_paid_upto\":\"2026-12-31\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1270\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2027-02-25\",\"permit_number\":\"HR2026-AITP-8115A\",\"permit_issue_date\":\"2026-03-13\",\"permit_valid_from\":\"2026-03-13\",\"permit_valid_upto\":\"2031-03-12\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR55BB8005_front_image_1779126250.jpg', 'uploads/vehicles/HR55BB8005_back_image_1779126250.jpg', 'Active', '2026-05-18 17:44:10'),
(89, 24, 7, 'DL1VC6873', 'A*****R P*L S***H', 'FORCE MOTORS LIMITED', 'URBANIA', 'MINI BUS', 'DIESEL', 'GREY', '17', 'Bus(LPV)', '2026-03-16', '2028-03-15', 'United India Insurance Co. Ltd.', '0402023125P118676663', '2027-03-01', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2031-03-18', '{\"client_id\":\"rc_v2_efcWqCqVyDYumLFdoAiY\",\"rc_number\":\"DL1VC6873\",\"fit_up_to\":\"2028-03-15\",\"registration_date\":\"2026-03-16\",\"owner_name\":\"A*****R P*L S***H\",\"father_name\":\"\",\"present_address\":\"South, 110068\",\"permanent_address\":\"South, 110068\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MC1M4AAA0TP0*****\",\"vehicle_engine_number\":\"D710*****\",\"maker_description\":\"FORCE MOTORS LIMITED\",\"maker_model\":\"URBANIA\",\"body_type\":\"MINI BUS\",\"fuel_type\":\"DIESEL\",\"color\":\"GREY\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"POONAWALLA FINCORP LTD\",\"financed\":true,\"insurance_company\":\"United India Insurance Co. Ltd.\",\"insurance_policy_number\":\"0402023125P118676663\",\"insurance_upto\":\"2027-03-01\",\"manufacturing_date\":\"1/2026\",\"manufacturing_date_formatted\":\"2026-01\",\"registered_at\":\"RAJPUR ROAD/VIU BURARI, Delhi\",\"latest_by\":\"2026-05-18\",\"less_info\":true,\"tax_upto\":\"2026-03-31\",\"tax_paid_upto\":\"2026-03-31\",\"cubic_capacity\":\"2596.00\",\"vehicle_gross_weight\":\"4610\",\"no_cylinders\":\"4\",\"seat_capacity\":\"17\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"4400\",\"unladen_weight\":\"3185\",\"vehicle_category_description\":\"Bus(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2027-03-15\",\"permit_number\":\"DL2026-AITP-0608A\",\"permit_issue_date\":\"2026-03-20\",\"permit_valid_from\":\"2026-03-19\",\"permit_valid_upto\":\"2031-03-18\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/DL1VC6873_front_image_1779126308.jpg', 'uploads/vehicles/DL1VC6873_back_image_1779126308.jpg', 'Active', '2026-05-18 17:45:08'),
(90, 24, 7, 'HR55BA2936', 'A*****R P*L S***H', 'MARUTI SUZUKI INDIA LTD', 'ERTIGA ZXI CNG', 'RIGID (PASSENGER CAR)', 'PETROL(E20)/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2025-12-22', '2027-12-21', 'ICICI Lombard General Insurance Co. Ltd.', '3004/MI-16294801/00/000', '2026-12-12', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2030-12-22', '{\"client_id\":\"rc_v2_WyntopGIsBVtfokQprHS\",\"rc_number\":\"HR55BA2936\",\"fit_up_to\":\"2027-12-21\",\"registration_date\":\"2025-12-22\",\"owner_name\":\"A*****R P*L S***H\",\"father_name\":\"\",\"present_address\":\"Gurgaon, 122001\",\"permanent_address\":\"South, 110068\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SSLB*****\",\"vehicle_engine_number\":\"K15CN99*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"ERTIGA ZXI CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL(E20)/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"MAHINDRA & MAHINDRA FNCL SRV LTD\",\"financed\":true,\"insurance_company\":\"ICICI Lombard General Insurance Co. Ltd.\",\"insurance_policy_number\":\"3004/MI-16294801/00/000\",\"insurance_upto\":\"2026-12-12\",\"manufacturing_date\":\"11/2025\",\"manufacturing_date_formatted\":\"2025-11\",\"registered_at\":\"RTA, GURGAON, Haryana\",\"latest_by\":\"2026-05-18\",\"less_info\":true,\"tax_upto\":\"2026-11-30\",\"tax_paid_upto\":\"2026-11-30\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1275\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2026-12-21\",\"permit_number\":\"HR2025-AITP-9125D\",\"permit_issue_date\":\"2025-12-23\",\"permit_valid_from\":\"2025-12-23\",\"permit_valid_upto\":\"2030-12-22\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR55BA2936_front_image_1779126359.jpg', 'uploads/vehicles/HR55BA2936_back_image_1779126359.jpg', 'Active', '2026-05-18 17:45:59'),
(91, 24, 7, 'HR55BA3797', 'A*****R P*L S***H', 'MARUTI SUZUKI INDIA LTD', 'ERTIGA VXI CNG', 'RIGID (PASSENGER CAR)', 'PETROL(E20)/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2025-12-11', '2027-12-10', 'IFFCO Tokio General Insurance Co. Ltd.', 'MR00029416', '2026-12-03', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2030-12-11', '{\"client_id\":\"rc_v2_AZGcseuUaWWGqQXvtxOM\",\"rc_number\":\"HR55BA3797\",\"fit_up_to\":\"2027-12-10\",\"registration_date\":\"2025-12-11\",\"owner_name\":\"A*****R P*L S***H\",\"father_name\":\"\",\"present_address\":\"Gurgaon, 122051\",\"permanent_address\":\"South, 110068\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SSLB*****\",\"vehicle_engine_number\":\"K15CN99*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"ERTIGA VXI CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL(E20)/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"\",\"financed\":false,\"insurance_company\":\"IFFCO Tokio General Insurance Co. Ltd.\",\"insurance_policy_number\":\"MR00029416\",\"insurance_upto\":\"2026-12-03\",\"manufacturing_date\":\"11/2025\",\"manufacturing_date_formatted\":\"2025-11\",\"registered_at\":\"RTA, GURGAON, Haryana\",\"latest_by\":\"2026-05-18\",\"less_info\":true,\"tax_upto\":\"2027-12-31\",\"tax_paid_upto\":\"2027-12-31\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1270\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2026-12-10\",\"permit_number\":\"HR2025-AITP-8096D\",\"permit_issue_date\":\"2025-12-12\",\"permit_valid_from\":\"2025-12-12\",\"permit_valid_upto\":\"2030-12-11\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR55BA3797_front_image_1779126618.jpg', 'uploads/vehicles/HR55BA3797_back_image_1779126618.jpg', 'Active', '2026-05-18 17:50:18'),
(92, 24, 7, 'HR55BB4781', 'A*****R P*L S***H', 'MARUTI SUZUKI INDIA LTD', 'VICTORIS ZXI CNG', 'RIGID (PASSENGER CAR)', 'PETROL(E20)/CNG', 'PEARL ARCTIC WHITE', '5', 'Motor Cab(LPV)', '2026-02-25', '2028-02-24', 'GoDigit General Insurance Ltd.', 'D249253429', '2027-01-26', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2031-03-10', '{\"client_id\":\"rc_v2_QnacNPjbrlpHPIDSffUL\",\"rc_number\":\"HR55BB4781\",\"fit_up_to\":\"2028-02-24\",\"registration_date\":\"2026-02-25\",\"owner_name\":\"A*****R P*L S***H\",\"father_name\":\"\",\"present_address\":\"Gurgaon, 122001\",\"permanent_address\":\"South, 110068\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3YPKCSKSL1*****\",\"vehicle_engine_number\":\"K15CNK0*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"VICTORIS ZXI CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL(E20)/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"TOYOTA FINANCIAL SERVICES INDIA LTD\",\"financed\":true,\"insurance_company\":\"GoDigit General Insurance Ltd.\",\"insurance_policy_number\":\"D249253429\",\"insurance_upto\":\"2027-01-26\",\"manufacturing_date\":\"11/2025\",\"manufacturing_date_formatted\":\"2025-11\",\"registered_at\":\"RTA, GURGAON, Haryana\",\"latest_by\":\"2026-05-18\",\"less_info\":true,\"tax_upto\":\"2027-01-31\",\"tax_paid_upto\":\"2027-01-31\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1695\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2600\",\"unladen_weight\":\"1245\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2027-02-24\",\"permit_number\":\"HR2026-AITP-7809A\",\"permit_issue_date\":\"2026-03-11\",\"permit_valid_from\":\"2026-03-11\",\"permit_valid_upto\":\"2031-03-10\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR55BB4781_front_image_1779127016.jpg', 'uploads/vehicles/HR55BB4781_back_image_1779127016.jpg', 'Active', '2026-05-18 17:56:56'),
(94, 199, 9, 'UP30ET4595', 'M******D S*******Z H****N', 'MARUTI SUZUKI INDIA LTD', 'ERTIGA VXI CNG', 'RIGID (PASSENGER CAR)', 'PETROL(E20)/CNG', 'MAGMA GRAY', '7', 'Motor Cab(LPV)', '2026-04-15', '2028-04-14', 'United India Insurance Co. Ltd.', '04280031260160048236', '2027-04-09', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA]', '2031-04-29', '{\"client_id\":\"rc_v2_itgDTyfMxmLOamhUpyzG\",\"rc_number\":\"UP30ET4595\",\"fit_up_to\":\"2028-04-14\",\"registration_date\":\"2026-04-15\",\"owner_name\":\"M******D S*******Z H****N\",\"father_name\":\"\",\"present_address\":\"Hardoi, 241124\",\"permanent_address\":\"Hardoi, 241124\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62STCC*****\",\"vehicle_engine_number\":\"K15CNA0*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"ERTIGA VXI CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL(E20)/CNG\",\"color\":\"MAGMA GRAY\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"HDFC BANK LIMITED\",\"financed\":true,\"insurance_company\":\"United India Insurance Co. Ltd.\",\"insurance_policy_number\":\"04280031260160048236\",\"insurance_upto\":\"2027-04-09\",\"manufacturing_date\":\"3/2026\",\"manufacturing_date_formatted\":\"2026-03\",\"registered_at\":\"HARDOI, Uttar Pradesh\",\"latest_by\":\"2026-05-19\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1270\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2027-04-14\",\"permit_number\":\"UP2026-AITP-1163B\",\"permit_issue_date\":\"2026-04-30\",\"permit_valid_from\":\"2026-04-30\",\"permit_valid_upto\":\"2031-04-29\",\"permit_type\":\"Tourist Permit [ALL INDIA]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/UP30ET4595_front_image_1779167089.jpg', 'uploads/vehicles/UP30ET4595_back_image_1779167089.jpg', 'Active', '2026-05-19 05:04:49'),
(95, 374, 8, 'RJ14TG3042', 'S*****H', 'HYUNDAI MOTOR INDIA LTD', 'AURA 1.2MT CNG S', 'SALOON', 'PETROL/CNG', 'ATLAS WHITE', '5', 'Motor Cab(LPV)', '2024-11-18', '2026-11-17', 'Oriental Insurance Co. Ltd.', '241100/31/2026/4663', '2026-11-17', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [Taxi Cab]', '2029-12-02', '{\"client_id\":\"rc_v2_WfYvHnhucAEQlCotueEy\",\"rc_number\":\"RJ14TG3042\",\"fit_up_to\":\"2026-11-17\",\"registration_date\":\"2024-11-18\",\"owner_name\":\"S*****H\",\"father_name\":\"\",\"present_address\":\"Jaipur, 302029\",\"permanent_address\":\"Jaipur, 302029\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MALB241CLRM3*****\",\"vehicle_engine_number\":\"G4LARM1*****\",\"maker_description\":\"HYUNDAI MOTOR INDIA LTD\",\"maker_model\":\"AURA 1.2MT CNG S\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"ATLAS WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"AU SMALL BANK LTD\",\"financed\":true,\"insurance_company\":\"Oriental Insurance Co. Ltd.\",\"insurance_policy_number\":\"241100/31/2026/4663\",\"insurance_upto\":\"2026-11-17\",\"manufacturing_date\":\"9/2024\",\"manufacturing_date_formatted\":\"2024-09\",\"registered_at\":\"JAIPUR (FIRST) RTO, Rajasthan\",\"latest_by\":\"2026-05-19\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1500\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1052\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"RJ01400770006315\",\"pucc_upto\":\"2026-11-16\",\"permit_number\":\"RJ2024-AITP-8709A\",\"permit_issue_date\":\"2024-12-03\",\"permit_valid_from\":\"2024-12-03\",\"permit_valid_upto\":\"2029-12-02\",\"permit_type\":\"Tourist Permit [Taxi Cab]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/RJ14TG3042_front_image_1779206862.jpg', 'uploads/vehicles/RJ14TG3042_back_image_1779206862.jpg', 'Active', '2026-05-19 16:07:42'),
(96, 111, 8, 'HR55BC6448', 'MD S****L', 'MARUTI SUZUKI INDIA LTD', 'TOUR S CNG', 'RIGID (PASSENGER CAR)', 'PETROL(E20)/CNG', 'PEARL ARCTIC WHITE', '5', 'Motor Cab(LPV)', '2026-04-17', '2028-04-16', 'Bajaj General Insurance Co. Ltd.', 'OG-27-9910-1803-00001462', '2027-04-06', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2031-04-19', '{\"client_id\":\"rc_v2_ivsCgibLRwFzUctxrciA\",\"rc_number\":\"HR55BC6448\",\"fit_up_to\":\"2028-04-16\",\"registration_date\":\"2026-04-17\",\"owner_name\":\"MD S****L\",\"father_name\":\"\",\"present_address\":\"Gurgaon, 122003\",\"permanent_address\":\"West, 110087\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3ZFDFSKTC4*****\",\"vehicle_engine_number\":\"Z12ENF3*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR S CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL(E20)/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"MAHINDRA & MAHINDRA FNCL SRV LTD\",\"financed\":true,\"insurance_company\":\"Bajaj General Insurance Co. Ltd.\",\"insurance_policy_number\":\"OG-27-9910-1803-00001462\",\"insurance_upto\":\"2027-04-06\",\"manufacturing_date\":\"3/2026\",\"manufacturing_date_formatted\":\"2026-03\",\"registered_at\":\"RTA, GURGAON, Haryana\",\"latest_by\":\"2026-05-19\",\"less_info\":true,\"tax_upto\":\"2027-03-31\",\"tax_paid_upto\":\"2027-03-31\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1435\",\"no_cylinders\":\"3\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1010\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2027-04-16\",\"permit_number\":\"HR2026-AITP-3765B\",\"permit_issue_date\":\"2026-04-20\",\"permit_valid_from\":\"2026-04-20\",\"permit_valid_upto\":\"2031-04-19\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR55BC6448_front_image_1779212911.jpg', 'uploads/vehicles/HR55BC6448_back_image_1779212911.jpg', 'Active', '2026-05-19 17:48:31'),
(97, 377, 8, 'HR55AW4413', 'A**R R*Y', 'MARUTI SUZUKI INDIA LTD', 'TOUR S CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '5', 'Motor Cab(LPV)', '2025-02-28', '2027-02-27', 'The New India Assurance Company Limited', '98000031250318708300', '2027-02-22', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2030-03-09', '{\"client_id\":\"rc_v2_yyYmKqwbDEgmqJqIwxTR\",\"rc_number\":\"HR55AW4413\",\"fit_up_to\":\"2027-02-27\",\"registration_date\":\"2025-02-28\",\"owner_name\":\"A**R R*Y\",\"father_name\":\"\",\"present_address\":\"Gurgaon, 122004\",\"permanent_address\":\"Gurgaon, 122004\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3CZFB3SSB9*****\",\"vehicle_engine_number\":\"K12NN11*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR S CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"MAHINDRA & MAHINDRA FIN SER LTD.\",\"financed\":true,\"insurance_company\":\"The New India Assurance Company Limited\",\"insurance_policy_number\":\"98000031250318708300\",\"insurance_upto\":\"2027-02-22\",\"manufacturing_date\":\"2/2025\",\"manufacturing_date_formatted\":\"2025-02\",\"registered_at\":\"RTA, GURGAON, Haryana\",\"latest_by\":\"2026-05-19\",\"less_info\":true,\"tax_upto\":\"2026-03-31\",\"tax_paid_upto\":\"2026-03-31\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1405\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"970\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR05501510036977\",\"pucc_upto\":\"2026-07-24\",\"permit_number\":\"HR2025-AITP-7669A\",\"permit_issue_date\":\"2025-03-10\",\"permit_valid_from\":\"2025-03-10\",\"permit_valid_upto\":\"2030-03-09\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR55AW4413_front_image_1779256731.jpg', 'uploads/vehicles/HR55AW4413_back_image_1779256731.jpg', 'Active', '2026-05-20 05:58:51'),
(98, 281, 8, 'RJ14TH0466', 'R****N L*L B****A', 'MARUTI SUZUKI INDIA LTD', 'TOUR S CNG', 'RIGID (PASSENGER CAR)', 'PETROL(E20)/CNG', 'PEARL ARCTIC WHITE', '5', 'Motor Cab(LPV)', '2026-01-05', '2028-01-04', 'National Insurance Co. Ltd.', '37130031251151496399', '2026-12-28', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [Taxi Cab]', '2031-01-22', '{\"client_id\":\"rc_v2_HDtisoohedczaboHqpmw\",\"rc_number\":\"RJ14TH0466\",\"fit_up_to\":\"2028-01-04\",\"registration_date\":\"2026-01-05\",\"owner_name\":\"R****N L*L B****A\",\"father_name\":\"\",\"present_address\":\"Dausa, 303304\",\"permanent_address\":\"Dausa, 303304\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3ZFDFSKSL3*****\",\"vehicle_engine_number\":\"Z12ENF2*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR S CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL(E20)/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"SHRIRAM FINANCE LIMITED\",\"financed\":true,\"insurance_company\":\"National Insurance Co. Ltd.\",\"insurance_policy_number\":\"37130031251151496399\",\"insurance_upto\":\"2026-12-28\",\"manufacturing_date\":\"11/2025\",\"manufacturing_date_formatted\":\"2025-11\",\"registered_at\":\"JAIPUR (FIRST) RTO, Rajasthan\",\"latest_by\":\"2026-05-20\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1435\",\"no_cylinders\":\"3\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1010\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2027-01-04\",\"permit_number\":\"RJ2026-AITP-0607A\",\"permit_issue_date\":\"2026-01-23\",\"permit_valid_from\":\"2026-01-23\",\"permit_valid_upto\":\"2031-01-22\",\"permit_type\":\"Tourist Permit [Taxi Cab]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/RJ14TH0466_front_image_1779262472.jpg', 'uploads/vehicles/RJ14TH0466_back_image_1779262472.jpg', 'Active', '2026-05-20 07:34:32'),
(99, 378, 8, 'UP32RT5042', 'S*******U G***A', 'HYUNDAI MOTOR INDIA LTD', 'AURA 1.2MT CNG S', 'SALOON', 'PETROL/CNG', 'ATLAS WHITE', '5', 'Motor Cab(LPV)', '2025-11-05', '2027-11-04', 'IFFCO Tokio General Insurance Co. Ltd.', '56365592', '2026-10-30', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA]', '2030-11-18', '{\"client_id\":\"rc_v2_nnyntBfzskyXfnzZUtjM\",\"rc_number\":\"UP32RT5042\",\"fit_up_to\":\"2027-11-04\",\"registration_date\":\"2025-11-05\",\"owner_name\":\"S*******U G***A\",\"father_name\":\"\",\"present_address\":\"Lucknow, 226022\",\"permanent_address\":\"Pratapgarh, 230139\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MALB241CLSM4*****\",\"vehicle_engine_number\":\"G4LASM5*****\",\"maker_description\":\"HYUNDAI MOTOR INDIA LTD\",\"maker_model\":\"AURA 1.2MT CNG S\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"ATLAS WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"KOTAK MAHINDRA PRIME LIMITED\",\"financed\":true,\"insurance_company\":\"IFFCO Tokio General Insurance Co. Ltd.\",\"insurance_policy_number\":\"56365592\",\"insurance_upto\":\"2026-10-30\",\"manufacturing_date\":\"9/2025\",\"manufacturing_date_formatted\":\"2025-09\",\"registered_at\":\"TRANSPORT NAGAR RTO LUCKNOW (UP32), Uttar Pradesh\",\"latest_by\":\"2026-05-20\",\"less_info\":true,\"tax_upto\":\"2026-09-30\",\"tax_paid_upto\":\"2026-09-30\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1500\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1052\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2026-11-04\",\"permit_number\":\"UP2025-AITP-0642D\",\"permit_issue_date\":\"2025-11-19\",\"permit_valid_from\":\"2025-11-19\",\"permit_valid_upto\":\"2030-11-18\",\"permit_type\":\"Tourist Permit [ALL INDIA]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/UP32RT5042_front_image_1779273845.jpg', 'uploads/vehicles/UP32RT5042_back_image_1779273845.jpg', 'Active', '2026-05-20 10:44:05'),
(100, 316, 8, 'UK07TE3227', 'M******D S****B', 'MARUTI SUZUKI INDIA LTD', 'TOUR S CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '5', 'Motor Cab(LPV)', '2025-05-05', '2027-05-04', 'United India Insurance Co. Ltd.', '04280031260160049240', '2027-04-14', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit', '2030-05-05', '{\"client_id\":\"rc_v2_iECtgYvcKLzGzpeGIANu\",\"rc_number\":\"UK07TE3227\",\"fit_up_to\":\"2027-05-04\",\"registration_date\":\"2025-05-05\",\"owner_name\":\"M******D S****B\",\"father_name\":\"\",\"present_address\":\"Dehradun, 248171\",\"permanent_address\":\"Saharanpur, 247551\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3ZFDFSKSC1*****\",\"vehicle_engine_number\":\"Z12ENF0*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR S CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"S K FINANCE LTD\",\"financed\":true,\"insurance_company\":\"United India Insurance Co. Ltd.\",\"insurance_policy_number\":\"04280031260160049240\",\"insurance_upto\":\"2027-04-14\",\"manufacturing_date\":\"3/2025\",\"manufacturing_date_formatted\":\"2025-03\",\"registered_at\":\"DEHRADUN RTO, Uttarakhand\",\"latest_by\":\"2026-05-20\",\"less_info\":true,\"tax_upto\":\"2026-05-31\",\"tax_paid_upto\":\"2026-05-31\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1435\",\"no_cylinders\":\"3\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1010\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"DL00900760061507\",\"pucc_upto\":\"2027-05-05\",\"permit_number\":\"UK2025-AITP-3306A\",\"permit_issue_date\":\"2025-05-06\",\"permit_valid_from\":\"2025-05-06\",\"permit_valid_upto\":\"2030-05-05\",\"permit_type\":\"Tourist Permit\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/UK07TE3227_front_image_1779281122.jpg', 'uploads/vehicles/UK07TE3227_back_image_1779281122.jpg', 'Active', '2026-05-20 12:45:22'),
(101, 312, 8, 'HR55AD6829', 'P****M S***H', 'HYUNDAI MOTOR INDIA LTD', 'XCENT VTVT E+', 'SALOON', 'PETROL/CNG', 'POLAR WHITE', '5', 'Motor Cab(LPV)', '2018-08-07', '2027-11-15', 'IndusInd General Insurance Co. Ltd', '131622523530002985', '2026-11-13', 'BHARAT STAGE IV', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2026-08-20', '{\"client_id\":\"rc_v2_lHfYwYrJbcknqxKioAYf\",\"rc_number\":\"HR55AD6829\",\"fit_up_to\":\"2027-11-15\",\"registration_date\":\"2018-08-07\",\"owner_name\":\"P****M S***H\",\"father_name\":\"\",\"present_address\":\"Gurgaon, 122001\",\"permanent_address\":\"West, 110045\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MALA741CLJM3*****\",\"vehicle_engine_number\":\"G4LAJM9*****\",\"maker_description\":\"HYUNDAI MOTOR INDIA LTD\",\"maker_model\":\"XCENT VTVT E+\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"POLAR WHITE\",\"norms_type\":\"BHARAT STAGE IV\",\"financer\":\"\",\"financed\":false,\"insurance_company\":\"IndusInd General Insurance Co. Ltd\",\"insurance_policy_number\":\"131622523530002985\",\"insurance_upto\":\"2026-11-13\",\"manufacturing_date\":\"5/2018\",\"manufacturing_date_formatted\":\"2018-05\",\"registered_at\":\"RTA, GURGAON, Haryana\",\"latest_by\":\"2026-05-18\",\"less_info\":true,\"tax_upto\":\"2026-12-31\",\"tax_paid_upto\":\"2026-12-31\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1430\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2425\",\"unladen_weight\":\"993\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR05504210025730\",\"pucc_upto\":\"2026-12-16\",\"permit_number\":\"HR/55/AITP/LPV/2018/5735\",\"permit_issue_date\":\"2018-08-21\",\"permit_valid_from\":\"2023-08-21\",\"permit_valid_upto\":\"2026-08-20\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"2\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR55AD6829_front_image_1779283287.jpg', 'uploads/vehicles/HR55AD6829_back_image_1779283287.jpg', 'Active', '2026-05-20 13:21:27'),
(102, 349, 9, 'UP79AT9904', 'M******D U**R', 'MARUTI SUZUKI INDIA LTD', 'TOUR M (O) CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2024-08-31', '2026-08-30', 'Bajaj General Insurance Co. Ltd.', 'OG-26-9910-1803-00049233', '2026-08-28', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA]', '2029-09-24', '{\"client_id\":\"rc_v2_lmornmsVEfUhxajIvjSq\",\"rc_number\":\"UP79AT9904\",\"fit_up_to\":\"2026-08-30\",\"registration_date\":\"2024-08-31\",\"owner_name\":\"M******D U**R\",\"father_name\":\"\",\"present_address\":\"Auraiya, 206241\",\"permanent_address\":\"Auraiya, 206241\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SRE7*****\",\"vehicle_engine_number\":\"K15CN95*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR M (O) CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"MAHINDRA AND MAHINDRA FIN SER LTD.\",\"financed\":true,\"insurance_company\":\"Bajaj General Insurance Co. Ltd.\",\"insurance_policy_number\":\"OG-26-9910-1803-00049233\",\"insurance_upto\":\"2026-08-28\",\"manufacturing_date\":\"5/2024\",\"manufacturing_date_formatted\":\"2024-05\",\"registered_at\":\"AURAIYA, Uttar Pradesh\",\"latest_by\":\"2026-05-21\",\"less_info\":true,\"tax_upto\":\"2025-07-31\",\"tax_paid_upto\":\"2025-07-31\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1250\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"UP01603840005791\",\"pucc_upto\":\"2027-02-12\",\"permit_number\":\"UP2024-AITP-3232C\",\"permit_issue_date\":\"2024-09-25\",\"permit_valid_from\":\"2024-09-25\",\"permit_valid_upto\":\"2029-09-24\",\"permit_type\":\"Tourist Permit [ALL INDIA]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/UP79AT9904_front_image_1779320210.jpg', 'uploads/vehicles/UP79AT9904_back_image_1779320210.jpg', 'Active', '2026-05-20 23:36:50'),
(103, 279, 9, 'HR61E9979', 'S*****H S***H', 'MARUTI SUZUKI INDIA LTD', 'ERTIGA VXI (O) CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2022-11-07', '2026-11-06', 'United India Insurance Co. Ltd.', '1112833125P119989250', '2027-03-24', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2027-11-14', '{\"client_id\":\"rc_v2_ZQnPBZhghZZzifnMbbjF\",\"rc_number\":\"HR61E9979\",\"fit_up_to\":\"2026-11-06\",\"registration_date\":\"2022-11-07\",\"owner_name\":\"S*****H S***H\",\"father_name\":\"\",\"present_address\":\"Bhiwani, 127201\",\"permanent_address\":\"Bhiwani, 127201\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SNK5*****\",\"vehicle_engine_number\":\"K15CN91*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"ERTIGA VXI (O) CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"HDB FINANCIAL SERVICES LTD\",\"financed\":true,\"insurance_company\":\"United India Insurance Co. Ltd.\",\"insurance_policy_number\":\"1112833125P119989250\",\"insurance_upto\":\"2027-03-24\",\"manufacturing_date\":\"10/2022\",\"manufacturing_date_formatted\":\"2022-10\",\"registered_at\":\"RTA, BHIWANI, Haryana\",\"latest_by\":\"2026-05-21\",\"less_info\":true,\"tax_upto\":\"2026-03-31\",\"tax_paid_upto\":\"2026-03-31\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1250\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"RJ05200050007358\",\"pucc_upto\":\"2027-03-16\",\"permit_number\":\"HR2022-AITP-3105B\",\"permit_issue_date\":\"2022-11-15\",\"permit_valid_from\":\"2022-11-15\",\"permit_valid_upto\":\"2027-11-14\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR61E9979_front_image_1779333191.jpg', 'uploads/vehicles/HR61E9979_back_image_1779333191.jpg', 'Active', '2026-05-21 03:13:11'),
(104, 390, 8, 'HR55BC3801', 'S***J S***H C****E S***H P***R', 'MARUTI SUZUKI INDIA LTD', 'TOUR S CNG', 'RIGID (PASSENGER CAR)', 'PETROL(E20)/CNG', 'PEARL ARCTIC WHITE', '5', 'Motor Cab(LPV)', '2026-03-20', '2028-03-19', 'HDFC ERGO General Insurance Company Ltd', '2314208320988600000', '2027-03-05', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2031-03-19', '{\"client_id\":\"rc_v2_egEeQeYvBQqiKoGnsper\",\"rc_number\":\"HR55BC3801\",\"fit_up_to\":\"2028-03-19\",\"registration_date\":\"2026-03-20\",\"owner_name\":\"S***J S***H C****E S***H P***R\",\"father_name\":\"\",\"present_address\":\"Gurgaon, 122051\",\"permanent_address\":\"Ghaziabad, 201102\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3ZFDFSKTB4*****\",\"vehicle_engine_number\":\"Z12ENF3*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR S CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL(E20)/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"AU SMALL FINANCE BANK LIMITED\",\"financed\":true,\"insurance_company\":\"HDFC ERGO General Insurance Company Ltd\",\"insurance_policy_number\":\"2314208320988600000\",\"insurance_upto\":\"2027-03-05\",\"manufacturing_date\":\"2/2026\",\"manufacturing_date_formatted\":\"2026-02\",\"registered_at\":\"RTA, GURGAON, Haryana\",\"latest_by\":\"2026-05-21\",\"less_info\":true,\"tax_upto\":\"2027-02-28\",\"tax_paid_upto\":\"2027-02-28\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1435\",\"no_cylinders\":\"3\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1010\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2027-03-19\",\"permit_number\":\"HR2026-AITP-9568A\",\"permit_issue_date\":\"2026-03-20\",\"permit_valid_from\":\"2026-03-20\",\"permit_valid_upto\":\"2031-03-19\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR55BC3801_front_image_1779340661.jpg', 'uploads/vehicles/HR55BC3801_back_image_1779340661.jpg', 'Active', '2026-05-21 05:17:41'),
(105, 391, 8, 'HR38AA5143', 'M****H K***R', 'MARUTI SUZUKI INDIA LTD', 'TOUR S CNG', 'SALOON', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '5', 'Motor Cab(LPV)', '2019-07-15', '2027-06-18', 'IndusInd General Insurance Co. Ltd', '920222523530020736', '2026-12-18', 'BHARAT STAGE IV', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2026-07-16', '{\"client_id\":\"rc_v2_cEdfhVdesgNvsIbpTVJa\",\"rc_number\":\"HR38AA5143\",\"fit_up_to\":\"2027-06-18\",\"registration_date\":\"2019-07-15\",\"owner_name\":\"M****H K***R\",\"father_name\":\"\",\"present_address\":\"Faridabad, 121001\",\"permanent_address\":\"New Delhi, 110044\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3EJKD1S00C*****\",\"vehicle_engine_number\":\"K12MN23*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR S CNG\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE IV\",\"financer\":\"MAGMA FINCPRP LTD\",\"financed\":true,\"insurance_company\":\"IndusInd General Insurance Co. Ltd\",\"insurance_policy_number\":\"920222523530020736\",\"insurance_upto\":\"2026-12-18\",\"manufacturing_date\":\"6/2019\",\"manufacturing_date_formatted\":\"2019-06\",\"registered_at\":\"RTA, FARIDABAD, Haryana\",\"latest_by\":\"2026-05-21\",\"less_info\":true,\"tax_upto\":\"2026-03-31\",\"tax_paid_upto\":\"2026-03-31\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1480\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2430\",\"unladen_weight\":\"1045\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR03801560025490\",\"pucc_upto\":\"2026-12-19\",\"permit_number\":\"HR/38/AITP/LPV/2019/2922\",\"permit_issue_date\":\"2019-07-17\",\"permit_valid_from\":\"2025-07-17\",\"permit_valid_upto\":\"2026-07-16\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR38AA5143_front_image_1779341461.jpg', 'uploads/vehicles/HR38AA5143_back_image_1779341461.jpg', 'Active', '2026-05-21 05:31:01');
INSERT INTO `partner_vehicles` (`id`, `partner_id`, `car_type`, `rc_number`, `owner_name`, `maker_description`, `maker_model`, `body_type`, `fuel_type`, `color`, `seat_capacity`, `vehicle_category_desc`, `registration_date`, `fit_up_to`, `insurance_company`, `insurance_policy_number`, `insurance_upto`, `norms_type`, `rc_status`, `permit_type`, `permit_valid_upto`, `raw_rc_data`, `front_image`, `back_image`, `status`, `created_at`) VALUES
(106, 392, 9, 'BR01PT3352', 'A******T S***H', 'RENAULT INDIA PVT LTD', 'RENAULT TRIBER AUTHENTIC MT', 'STATION WAGON', 'PETROL(E20)', 'ICE COOL WHITE', '7', 'Motor Cab(LPV)', '2026-05-06', '2028-05-05', 'National Insurance Co. Ltd.', '17080031266360000369', '2027-04-29', 'BHARAT STAGE VI', 'ACTIVE', 'Contract Carriage Permit [MOTOR CAB PERMIT]', '2031-05-17', '{\"client_id\":\"rc_v2_bQaJnoMmNofGquwkzUvq\",\"rc_number\":\"BR01PT3352\",\"fit_up_to\":\"2028-05-05\",\"registration_date\":\"2026-05-06\",\"owner_name\":\"A******T S***H\",\"father_name\":\"\",\"present_address\":\"Patna, 800001\",\"permanent_address\":\"Patna, 800001\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MEERBC001T42*****\",\"vehicle_engine_number\":\"B4DF424E1*****\",\"maker_description\":\"RENAULT INDIA PVT LTD\",\"maker_model\":\"RENAULT TRIBER AUTHENTIC MT\",\"body_type\":\"STATION WAGON\",\"fuel_type\":\"PETROL(E20)\",\"color\":\"ICE COOL WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"SHRIRAM FINANCE LIMITED\",\"financed\":true,\"insurance_company\":\"National Insurance Co. Ltd.\",\"insurance_policy_number\":\"17080031266360000369\",\"insurance_upto\":\"2027-04-29\",\"manufacturing_date\":\"4/2026\",\"manufacturing_date_formatted\":\"2026-04\",\"registered_at\":\"PATNA, Bihar\",\"latest_by\":\"2026-05-21\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"999.00\",\"vehicle_gross_weight\":\"1538\",\"no_cylinders\":\"3\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2636\",\"unladen_weight\":\"926\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2027-05-05\",\"permit_number\":\"BR2026-CC-1074B\",\"permit_issue_date\":\"2026-05-18\",\"permit_valid_from\":\"2026-05-18\",\"permit_valid_upto\":\"2031-05-17\",\"permit_type\":\"Contract Carriage Permit [MOTOR CAB PERMIT]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/BR01PT3352_front_image_1779347600.jpg', 'uploads/vehicles/BR01PT3352_back_image_1779347600.jpg', 'Active', '2026-05-21 07:13:20'),
(107, 397, 9, 'GJ05CY8046', 'G****H S****A', 'MARUTI SUZUKI INDIA LTD', 'ERTIGA VXI CNG', 'RIGID (PASSENGER CAR)', 'PETROL(E20)/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2026-02-23', '2028-02-22', 'IFFCO Tokio General Insurance Co. Ltd.', 'MR00268118', '2027-02-17', 'BHARAT STAGE VI', 'ACTIVE', 'Contract Carriage Permit [MOTOR CAB PERMIT]', '2031-03-06', '{\"client_id\":\"rc_v2_GrDozYmnGFquCxSxGcBr\",\"rc_number\":\"GJ05CY8046\",\"fit_up_to\":\"2028-02-22\",\"registration_date\":\"2026-02-23\",\"owner_name\":\"G****H S****A\",\"father_name\":\"\",\"present_address\":\"Surat, 394221\",\"permanent_address\":\"Surat, 394221\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SSKB*****\",\"vehicle_engine_number\":\"K15CN99*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"ERTIGA VXI CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL(E20)/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"INDUSIND BANK LTD\",\"financed\":true,\"insurance_company\":\"IFFCO Tokio General Insurance Co. Ltd.\",\"insurance_policy_number\":\"MR00268118\",\"insurance_upto\":\"2027-02-17\",\"manufacturing_date\":\"10/2025\",\"manufacturing_date_formatted\":\"2025-10\",\"registered_at\":\"SURAT, Gujarat\",\"latest_by\":\"2026-05-21\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1270\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2027-02-22\",\"permit_number\":\"GJ2026-CC-3809C\",\"permit_issue_date\":\"2026-03-07\",\"permit_valid_from\":\"2026-03-07\",\"permit_valid_upto\":\"2031-03-06\",\"permit_type\":\"Contract Carriage Permit [MOTOR CAB PERMIT]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/GJ05CY8046_front_image_1779380990.png', 'uploads/vehicles/GJ05CY8046_back_image_1779380990.png', 'Active', '2026-05-21 16:29:50'),
(108, 337, 8, 'UK07TE5546', 'D*****D K**N', 'MARUTI SUZUKI INDIA LTD', 'TOUR S CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '5', 'Motor Cab(LPV)', '2025-10-25', '2027-10-24', 'National Insurance Co. Ltd.', '46100031251351389861', '2026-10-12', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit', '2030-11-05', '{\"client_id\":\"rc_v2_rnAPsbohBaaLcuBxpDwL\",\"rc_number\":\"UK07TE5546\",\"fit_up_to\":\"2027-10-24\",\"registration_date\":\"2025-10-25\",\"owner_name\":\"D*****D K**N\",\"father_name\":\"\",\"present_address\":\"Dehradun, 248001\",\"permanent_address\":\"Bijnor, 246762\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3ZFDFSKSK2*****\",\"vehicle_engine_number\":\"Z12ENF1*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR S CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"KOTAK MAHINDRA PRIME LTD\",\"financed\":true,\"insurance_company\":\"National Insurance Co. Ltd.\",\"insurance_policy_number\":\"46100031251351389861\",\"insurance_upto\":\"2026-10-12\",\"manufacturing_date\":\"10/2025\",\"manufacturing_date_formatted\":\"2025-10\",\"registered_at\":\"DEHRADUN RTO, Uttarakhand\",\"latest_by\":\"2026-05-22\",\"less_info\":true,\"tax_upto\":\"2026-05-31\",\"tax_paid_upto\":\"2026-05-31\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1435\",\"no_cylinders\":\"3\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1010\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"UP08100690025982\",\"pucc_upto\":\"2027-05-19\",\"permit_number\":\"UK2025-AITP-6529A\",\"permit_issue_date\":\"2025-11-06\",\"permit_valid_from\":\"2025-11-06\",\"permit_valid_upto\":\"2030-11-05\",\"permit_type\":\"Tourist Permit\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/UK07TE5546_front_image_1779454601.jpg', 'uploads/vehicles/UK07TE5546_back_image_1779454601.jpg', 'Active', '2026-05-22 12:56:41'),
(110, 410, 8, 'UP80KT8624', 'V***Y K***R T***I', 'MARUTI SUZUKI INDIA LTD', 'TOUR S CNG', 'RIGID (PASSENGER CAR)', 'PETROL(E20)/CNG', 'PEARL ARCTIC WHITE', '5', 'Motor Cab(LPV)', '2025-12-01', '2027-11-30', 'The New India Assurance Company Limited', '98000031250318122217', '2026-11-30', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA]', '2031-01-07', '{\"client_id\":\"rc_v2_MlzkgmeYatlbAoewizqs\",\"rc_number\":\"UP80KT8624\",\"fit_up_to\":\"2027-11-30\",\"registration_date\":\"2025-12-01\",\"owner_name\":\"V***Y K***R T***I\",\"father_name\":\"\",\"present_address\":\"Agra, 283124\",\"permanent_address\":\"Agra, 283124\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3ZFDFSKSK3*****\",\"vehicle_engine_number\":\"Z12ENF2*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR S CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL(E20)/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"KOTAK MAHINDRA PRIME LTD\",\"financed\":true,\"insurance_company\":\"The New India Assurance Company Limited\",\"insurance_policy_number\":\"98000031250318122217\",\"insurance_upto\":\"2026-11-30\",\"manufacturing_date\":\"11/2025\",\"manufacturing_date_formatted\":\"2025-11\",\"registered_at\":\"Agra RTO, Uttar Pradesh\",\"latest_by\":\"2026-05-23\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1435\",\"no_cylinders\":\"3\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1010\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR05504210026885\",\"pucc_upto\":\"2027-01-10\",\"permit_number\":\"UP2026-AITP-0455A\",\"permit_issue_date\":\"2026-01-08\",\"permit_valid_from\":\"2026-01-08\",\"permit_valid_upto\":\"2031-01-07\",\"permit_type\":\"Tourist Permit [ALL INDIA]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/UP80KT8624_front_image_1779520414.jpg', 'uploads/vehicles/UP80KT8624_back_image_1779520414.jpg', 'Active', '2026-05-23 07:13:34'),
(111, 398, 9, 'GJ05CY8046', 'G****H S****A', 'MARUTI SUZUKI INDIA LTD', 'ERTIGA VXI CNG', 'RIGID (PASSENGER CAR)', 'PETROL(E20)/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2026-02-23', '2028-02-22', 'IFFCO Tokio General Insurance Co. Ltd.', 'MR00268118', '2027-02-17', 'BHARAT STAGE VI', 'ACTIVE', 'Contract Carriage Permit [MOTOR CAB PERMIT]', '2031-03-06', '{\"client_id\":\"rc_v2_VjgjhrUdnNimouJkUFKX\",\"rc_number\":\"GJ05CY8046\",\"fit_up_to\":\"2028-02-22\",\"registration_date\":\"2026-02-23\",\"owner_name\":\"G****H S****A\",\"father_name\":\"\",\"present_address\":\"Surat, 394221\",\"permanent_address\":\"Surat, 394221\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SSKB*****\",\"vehicle_engine_number\":\"K15CN99*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"ERTIGA VXI CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL(E20)/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"INDUSIND BANK LTD\",\"financed\":true,\"insurance_company\":\"IFFCO Tokio General Insurance Co. Ltd.\",\"insurance_policy_number\":\"MR00268118\",\"insurance_upto\":\"2027-02-17\",\"manufacturing_date\":\"10/2025\",\"manufacturing_date_formatted\":\"2025-10\",\"registered_at\":\"SURAT, Gujarat\",\"latest_by\":\"2026-05-22\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1270\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2027-02-22\",\"permit_number\":\"GJ2026-CC-3809C\",\"permit_issue_date\":\"2026-03-07\",\"permit_valid_from\":\"2026-03-07\",\"permit_valid_upto\":\"2031-03-06\",\"permit_type\":\"Contract Carriage Permit [MOTOR CAB PERMIT]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/GJ05CY8046_front_image_1779545400.png', 'uploads/vehicles/GJ05CY8046_back_image_1779545400.png', 'Active', '2026-05-23 14:10:00'),
(112, 359, 8, 'UP84BT1186', 'S******R K**N', 'MARUTI SUZUKI INDIA LTD', 'TOUR S CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '5', 'Motor Cab(LPV)', '2025-02-15', '2027-02-14', 'The New India Assurance Company Limited', '98000031250318599008', '2027-02-05', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA]', '2030-03-23', '{\"client_id\":\"rc_v2_tRoodIfdnoRBvqUKcLpQ\",\"rc_number\":\"UP84BT1186\",\"fit_up_to\":\"2027-02-14\",\"registration_date\":\"2025-02-15\",\"owner_name\":\"S******R K**N\",\"father_name\":\"\",\"present_address\":\"Mainpuri, 205264\",\"permanent_address\":\"Mainpuri, 205264\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3CZFB3SSA9*****\",\"vehicle_engine_number\":\"K12NN11*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR S CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"CHOLAMANDLAM INVEST & FIN CO LTD.\",\"financed\":true,\"insurance_company\":\"The New India Assurance Company Limited\",\"insurance_policy_number\":\"98000031250318599008\",\"insurance_upto\":\"2027-02-05\",\"manufacturing_date\":\"1/2025\",\"manufacturing_date_formatted\":\"2025-01\",\"registered_at\":\"Mainpuri, Uttar Pradesh\",\"latest_by\":\"2026-05-24\",\"less_info\":true,\"tax_upto\":\"2026-01-31\",\"tax_paid_upto\":\"2026-01-31\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1405\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"970\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"DL00900370061895\",\"pucc_upto\":\"2027-04-03\",\"permit_number\":\"UP2025-AITP-7409A\",\"permit_issue_date\":\"2025-03-24\",\"permit_valid_from\":\"2025-03-24\",\"permit_valid_upto\":\"2030-03-23\",\"permit_type\":\"Tourist Permit [ALL INDIA]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/UP84BT1186_front_image_1779624171.jpg', 'uploads/vehicles/UP84BT1186_back_image_1779624171.jpg', 'Active', '2026-05-24 12:02:51'),
(113, 464, 8, 'HR55AG0320', 'S*****R S***H', 'MARUTI SUZUKI INDIA LTD', 'TOUR S CNG', 'SALOON CAR', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '5', 'Motor Cab(LPV)', '2019-07-12', '2027-10-29', 'Liberty General Insurance Limited', '201340040226700222700000', '2026-08-18', 'BHARAT STAGE IV', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2026-07-16', '{\"client_id\":\"rc_v2_svmlocxTqKXoeJRksgsb\",\"rc_number\":\"HR55AG0320\",\"fit_up_to\":\"2027-10-29\",\"registration_date\":\"2019-07-12\",\"owner_name\":\"S*****R S***H\",\"father_name\":\"\",\"present_address\":\"Gurgaon, 122001\",\"permanent_address\":\"Gurgaon, 122001\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3EJKD1S00C*****\",\"vehicle_engine_number\":\"K12MN23*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR S CNG\",\"body_type\":\"SALOON CAR\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE IV\",\"financer\":\"MAHINDRA & MAHINDRA FIN SER LTD\",\"financed\":true,\"insurance_company\":\"Liberty General Insurance Limited\",\"insurance_policy_number\":\"201340040226700222700000\",\"insurance_upto\":\"2026-08-18\",\"manufacturing_date\":\"6/2019\",\"manufacturing_date_formatted\":\"2019-06\",\"registered_at\":\"RTA, GURGAON, Haryana\",\"latest_by\":\"2026-06-13\",\"less_info\":true,\"tax_upto\":\"2026-12-31\",\"tax_paid_upto\":\"2026-12-31\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1480\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2430\",\"unladen_weight\":\"1045\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR06600290093838\",\"pucc_upto\":\"2026-11-08\",\"permit_number\":\"HR/55/AITP/LPV/2019/3678\",\"permit_issue_date\":\"2019-07-17\",\"permit_valid_from\":\"2025-07-17\",\"permit_valid_upto\":\"2026-07-16\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR55AG0320_front_image_1781350701.jpg', 'uploads/vehicles/HR55AG0320_back_image_1781350701.jpg', 'Active', '2026-06-13 11:38:21'),
(114, 464, 9, 'HR55AV2246', 'S*****H C***D', 'MARUTI SUZUKI INDIA LTD', 'ERTIGA VXI (O) CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2025-01-04', '2027-01-03', 'Magma General Insurance Limited', 'P0026200001/4103/538974', '2026-11-23', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2030-01-12', '{\"client_id\":\"rc_v2_hbwLcjGsqfkIhhWvfXMv\",\"rc_number\":\"HR55AV2246\",\"fit_up_to\":\"2027-01-03\",\"registration_date\":\"2025-01-04\",\"owner_name\":\"S*****H C***D\",\"father_name\":\"\",\"present_address\":\"Gurgaon, 122102\",\"permanent_address\":\"Gurgaon, 122102\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SRK9*****\",\"vehicle_engine_number\":\"K15CN96*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"ERTIGA VXI (O) CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"AU SMALL FINANCE BANK LTD.\",\"financed\":true,\"insurance_company\":\"Magma General Insurance Limited\",\"insurance_policy_number\":\"P0026200001/4103/538974\",\"insurance_upto\":\"2026-11-23\",\"manufacturing_date\":\"11/2024\",\"manufacturing_date_formatted\":\"2024-11\",\"registered_at\":\"RTA, GURGAON, Haryana\",\"latest_by\":\"2026-06-11\",\"less_info\":true,\"tax_upto\":\"2026-06-30\",\"tax_paid_upto\":\"2026-06-30\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1250\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR05503510022403\",\"pucc_upto\":\"2026-12-30\",\"permit_number\":\"HR2025-AITP-1459A\",\"permit_issue_date\":\"2025-01-13\",\"permit_valid_from\":\"2025-01-13\",\"permit_valid_upto\":\"2030-01-12\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR55AV2246_front_image_1781350738.jpg', 'uploads/vehicles/HR55AV2246_back_image_1781350738.jpg', 'Active', '2026-06-13 11:38:58'),
(116, 447, 7, 'RJ14TH3521', 'L***I N*****M M***A', 'MARUTI SUZUKI INDIA LTD', 'ERTIGA VXI CNG', 'RIGID (PASSENGER CAR)', 'PETROL(E20)/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2026-05-27', '2028-05-26', 'National Insurance Co. Ltd.', '37130031261351905644', '2027-05-25', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [Taxi Cab]', '2031-06-03', '{\"client_id\":\"rc_v2_IuihZxjsFkNUpZWdzczP\",\"rc_number\":\"RJ14TH3521\",\"fit_up_to\":\"2028-05-26\",\"registration_date\":\"2026-05-27\",\"owner_name\":\"L***I N*****M M***A\",\"father_name\":\"\",\"present_address\":\"Jaipur, 302031\",\"permanent_address\":\"Jaipur, 302031\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62STED*****\",\"vehicle_engine_number\":\"K15CNA0*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"ERTIGA VXI CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL(E20)/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"INDUSIND BANK LTD\",\"financed\":true,\"insurance_company\":\"National Insurance Co. Ltd.\",\"insurance_policy_number\":\"37130031261351905644\",\"insurance_upto\":\"2027-05-25\",\"manufacturing_date\":\"5/2026\",\"manufacturing_date_formatted\":\"2026-05\",\"registered_at\":\"JAIPUR (FIRST) RTO, Rajasthan\",\"latest_by\":\"2026-06-13\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1270\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2027-05-26\",\"permit_number\":\"RJ2026-AITP-5633A\",\"permit_issue_date\":\"2026-06-04\",\"permit_valid_from\":\"2026-06-04\",\"permit_valid_upto\":\"2031-06-03\",\"permit_type\":\"Tourist Permit [Taxi Cab]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/RJ14TH3521_front_image_1781357031.jpg', 'uploads/vehicles/RJ14TH3521_back_image_1781357031.jpg', 'Active', '2026-06-13 13:23:51'),
(117, 442, 9, 'PB01D4730', 'R*J K***R', 'MARUTI SUZUKI INDIA LTD', 'TOUR M (O) CNG', 'MOTOR CAB 4730', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2023-05-15', '2027-06-23', 'The New India Assurance Company Limited', '98000031250318776882', '2027-03-17', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [TVP(MOTOR CAB)]', '2028-06-11', '{\"client_id\":\"rc_v2_gfwmxpbeXzjgqGPoCgBx\",\"rc_number\":\"PB01D4730\",\"fit_up_to\":\"2027-06-23\",\"registration_date\":\"2023-05-15\",\"owner_name\":\"R*J K***R\",\"father_name\":\"\",\"present_address\":\"Sahibzada Ajit Singh Nagar, 140603\",\"permanent_address\":\"Sahibzada Ajit Singh Nagar, 140603\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SPC5*****\",\"vehicle_engine_number\":\"K15CN91*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR M (O) CNG\",\"body_type\":\"MOTOR CAB 4730\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"CHOLA MANDALAM INVESTMENT & FINANCE\",\"financed\":true,\"insurance_company\":\"The New India Assurance Company Limited\",\"insurance_policy_number\":\"98000031250318776882\",\"insurance_upto\":\"2027-03-17\",\"manufacturing_date\":\"3/2023\",\"manufacturing_date_formatted\":\"2023-03\",\"registered_at\":\"PUNJAB STA(RAC)/(AITP), Punjab\",\"latest_by\":\"2026-06-13\",\"less_info\":true,\"tax_upto\":\"2026-06-30\",\"tax_paid_upto\":\"2026-06-30\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1250\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"PB06501210038414\",\"pucc_upto\":\"2026-10-10\",\"permit_number\":\"PB2023-AITP-4394A\",\"permit_issue_date\":\"2023-06-20\",\"permit_valid_from\":\"2023-06-12\",\"permit_valid_upto\":\"2028-06-11\",\"permit_type\":\"Tourist Permit [TVP(MOTOR CAB)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/PB01D4730_front_image_1781374321.jpg', 'uploads/vehicles/PB01D4730_back_image_1781374321.jpg', 'Active', '2026-06-13 18:12:01'),
(118, 484, 8, 'HR55BC5155', 'R******A K***R', 'MARUTI SUZUKI INDIA LTD', 'TOUR S CNG', 'RIGID (PASSENGER CAR)', 'PETROL(E20)/CNG', 'BLUISH BLACK', '5', 'Motor Cab(LPV)', '2026-04-16', '2028-04-15', 'HDFC ERGO General Insurance Company Ltd', '2314208422042200000', '2027-03-29', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2031-06-10', '{\"client_id\":\"rc_v2_ZzwnInvcmfwirkUwUsOH\",\"rc_number\":\"HR55BC5155\",\"fit_up_to\":\"2028-04-15\",\"registration_date\":\"2026-04-16\",\"owner_name\":\"R******A K***R\",\"father_name\":\"\",\"present_address\":\"Gurgaon, 122001\",\"permanent_address\":\"Auraiya, 206249\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3ZFDFSKTC4*****\",\"vehicle_engine_number\":\"Z12ENF3*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR S CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL(E20)/CNG\",\"color\":\"BLUISH BLACK\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"SHRIRAM FINANCE LTD\",\"financed\":true,\"insurance_company\":\"HDFC ERGO General Insurance Company Ltd\",\"insurance_policy_number\":\"2314208422042200000\",\"insurance_upto\":\"2027-03-29\",\"manufacturing_date\":\"3/2026\",\"manufacturing_date_formatted\":\"2026-03\",\"registered_at\":\"RTA, GURGAON, Haryana\",\"latest_by\":\"2026-06-14\",\"less_info\":true,\"tax_upto\":\"2027-03-31\",\"tax_paid_upto\":\"2027-03-31\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1435\",\"no_cylinders\":\"3\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1010\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2027-04-15\",\"permit_number\":\"HR2026-AITP-0014C\",\"permit_issue_date\":\"2026-06-11\",\"permit_valid_from\":\"2026-06-11\",\"permit_valid_upto\":\"2031-06-10\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR55BC5155_front_image_1781377600.jpg', 'uploads/vehicles/HR55BC5155_back_image_1781377600.jpg', 'Active', '2026-06-13 19:06:40'),
(119, 511, 8, 'UP82AT9927', 'M**L C*****A', 'MARUTI SUZUKI INDIA LTD', 'DZIRE VXI CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '5', 'Motor Cab(LPV)', '2024-08-29', '2026-08-28', 'The New India Assurance Company Limited', '98000031250317596315', '2026-08-24', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA]', '2029-08-29', '{\"client_id\":\"rc_v2_biizbebtWlxFdqKrfxla\",\"rc_number\":\"UP82AT9927\",\"fit_up_to\":\"2026-08-28\",\"registration_date\":\"2024-08-29\",\"owner_name\":\"M**L C*****A\",\"father_name\":\"\",\"present_address\":\"Etah, 207250\",\"permanent_address\":\"Etah, 207250\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3CZFB3SRH9*****\",\"vehicle_engine_number\":\"K12NN92*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"DZIRE VXI CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"MAHINDRA AND MAHINDRA FIN. SER.LTD\",\"financed\":true,\"insurance_company\":\"The New India Assurance Company Limited\",\"insurance_policy_number\":\"98000031250317596315\",\"insurance_upto\":\"2026-08-24\",\"manufacturing_date\":\"8/2024\",\"manufacturing_date_formatted\":\"2024-08\",\"registered_at\":\"Etah, Uttar Pradesh\",\"latest_by\":\"2026-06-14\",\"less_info\":true,\"tax_upto\":\"2026-07-31\",\"tax_paid_upto\":\"2026-07-31\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1405\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"990\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR05500830058260\",\"pucc_upto\":\"2026-09-15\",\"permit_number\":\"UP2024-AITP-1138C\",\"permit_issue_date\":\"2024-08-30\",\"permit_valid_from\":\"2024-08-30\",\"permit_valid_upto\":\"2029-08-29\",\"permit_type\":\"Tourist Permit [ALL INDIA]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/UP82AT9927_front_image_1781410448.jpg', 'uploads/vehicles/UP82AT9927_back_image_1781410448.jpg', 'Active', '2026-06-14 04:14:08'),
(120, 30, 9, 'HR38AC4502', 'M**U S****A', 'MARUTI SUZUKI INDIA LTD', 'TOUR M CNG', 'SALOON', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2021-09-21', '2027-10-05', 'Shriram General Insurance  Co. Ltd.', '101023/31/26/005885', '2026-10-14', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2026-09-20', '{\"client_id\":\"rc_v2_ehQZaomHBWcfIcribgSs\",\"rc_number\":\"HR38AC4502\",\"fit_up_to\":\"2027-10-05\",\"registration_date\":\"2021-09-21\",\"owner_name\":\"M**U S****A\",\"father_name\":\"\",\"present_address\":\"Faridabad, 121004\",\"permanent_address\":\"Faridabad, 121004\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC22SMJ3*****\",\"vehicle_engine_number\":\"K15BN91*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR M CNG\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"AU SMALL FINANCE BANK\",\"financed\":true,\"insurance_company\":\"Shriram General Insurance  Co. Ltd.\",\"insurance_policy_number\":\"101023/31/26/005885\",\"insurance_upto\":\"2026-10-14\",\"manufacturing_date\":\"9/2021\",\"manufacturing_date_formatted\":\"2021-09\",\"registered_at\":\"RTA, FARIDABAD, Haryana\",\"latest_by\":\"2026-06-14\",\"less_info\":true,\"tax_upto\":\"2026-12-31\",\"tax_paid_upto\":\"2026-12-31\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1795\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1235\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"DL01000700067099\",\"pucc_upto\":\"2027-01-14\",\"permit_number\":\"HR2021-AITP-3077A\",\"permit_issue_date\":\"2021-09-21\",\"permit_valid_from\":\"2021-09-21\",\"permit_valid_upto\":\"2026-09-20\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"2\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR38AC4502_front_image_1781418839.jpg', 'uploads/vehicles/HR38AC4502_back_image_1781418839.jpg', 'Active', '2026-06-14 06:33:59'),
(121, 504, 9, 'HR47F7984', 'S*****V K***R G***A', 'MARUTI SUZUKI INDIA LTD', 'ERTIGA VXI (O) CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2023-11-23', '2027-11-24', 'Shriram General Insurance  Co. Ltd.', '101047/31/26/017774', '2026-11-08', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2028-11-28', '{\"client_id\":\"rc_v2_dlABOneftoqFxCznuyur\",\"rc_number\":\"HR47F7984\",\"fit_up_to\":\"2027-11-24\",\"registration_date\":\"2023-11-23\",\"owner_name\":\"S*****V K***R G***A\",\"father_name\":\"\",\"present_address\":\"Rewari, 123401\",\"permanent_address\":\"West, 110059\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SPL7*****\",\"vehicle_engine_number\":\"K15CN93*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"ERTIGA VXI (O) CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"INDUSIND BANK LTD\",\"financed\":true,\"insurance_company\":\"Shriram General Insurance  Co. Ltd.\",\"insurance_policy_number\":\"101047/31/26/017774\",\"insurance_upto\":\"2026-11-08\",\"manufacturing_date\":\"11/2023\",\"manufacturing_date_formatted\":\"2023-11\",\"registered_at\":\"RTA, REWARI, Haryana\",\"latest_by\":\"2026-06-14\",\"less_info\":true,\"tax_upto\":\"2026-09-30\",\"tax_paid_upto\":\"2026-09-30\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1250\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"DL01002020004775\",\"pucc_upto\":\"2026-11-24\",\"permit_number\":\"HR2023-AITP-8193C\",\"permit_issue_date\":\"2023-11-29\",\"permit_valid_from\":\"2023-11-29\",\"permit_valid_upto\":\"2028-11-28\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR47F7984_front_image_1781444998.jpg', 'uploads/vehicles/HR47F7984_back_image_1781444998.jpg', 'Active', '2026-06-14 13:49:58'),
(122, 504, 8, 'HR38AH0286', 'B*****H G***A', 'MARUTI SUZUKI INDIA LTD', 'DZIRE VXI CNG', 'SALOON', 'PETROL/CNG', 'MAGMA GRAY', '5', 'Motor Cab(LPV)', '2024-09-03', '2026-09-02', 'United India Insurance Co. Ltd.', '2019013125P107267190', '2026-08-08', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2029-09-03', '{\"client_id\":\"rc_v2_arZkayAaKXKAndartwvl\",\"rc_number\":\"HR38AH0286\",\"fit_up_to\":\"2026-09-02\",\"registration_date\":\"2024-09-03\",\"owner_name\":\"B*****H G***A\",\"father_name\":\"\",\"present_address\":\"Faridabad, 121003\",\"permanent_address\":\"South West, 110045\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3CZFB3SRG9*****\",\"vehicle_engine_number\":\"K12NN10*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"DZIRE VXI CNG\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"MAGMA GRAY\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"SHRIRAM FINANCE LIMITED\",\"financed\":true,\"insurance_company\":\"United India Insurance Co. Ltd.\",\"insurance_policy_number\":\"2019013125P107267190\",\"insurance_upto\":\"2026-08-08\",\"manufacturing_date\":\"7/2024\",\"manufacturing_date_formatted\":\"2024-07\",\"registered_at\":\"RTA, FARIDABAD, Haryana\",\"latest_by\":\"2026-06-14\",\"less_info\":true,\"tax_upto\":\"2026-05-31\",\"tax_paid_upto\":\"2026-05-31\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1405\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"990\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"UP01503630004025\",\"pucc_upto\":\"2026-09-03\",\"permit_number\":\"HR2024-AITP-2835C\",\"permit_issue_date\":\"2024-09-04\",\"permit_valid_from\":\"2024-09-04\",\"permit_valid_upto\":\"2029-09-03\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR38AH0286_front_image_1781445167.jpg', 'uploads/vehicles/HR38AH0286_back_image_1781445167.jpg', 'Active', '2026-06-14 13:52:47'),
(123, 179, 8, 'UP60BT5490', 'V***K K***R S***H', 'HYUNDAI MOTOR INDIA LTD', 'AURA 1.2MT CNG SX', 'SALOON', 'PETROL/CNG', 'ATLAS WHITE', '5', 'Motor Cab(LPV)', '2023-09-18', '2027-09-17', 'Shriram General Insurance  Co. Ltd.', '102015/31/26/010934', '2026-09-14', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA]', '2028-10-09', '{\"client_id\":\"rc_v2_faIxdzltbspkarpvxNWb\",\"rc_number\":\"UP60BT5490\",\"fit_up_to\":\"2027-09-17\",\"registration_date\":\"2023-09-18\",\"owner_name\":\"V***K K***R S***H\",\"father_name\":\"\",\"present_address\":\"Ballia, 277001\",\"permanent_address\":\"Ballia, 277001\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MALB341CLPM2*****\",\"vehicle_engine_number\":\"G4LAPM6*****\",\"maker_description\":\"HYUNDAI MOTOR INDIA LTD\",\"maker_model\":\"AURA 1.2MT CNG SX\",\"body_type\":\"SALOON\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"ATLAS WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"MAHINDRA AND MAHINDRA FIN.SER.LTD.\",\"financed\":true,\"insurance_company\":\"Shriram General Insurance  Co. Ltd.\",\"insurance_policy_number\":\"102015/31/26/010934\",\"insurance_upto\":\"2026-09-14\",\"manufacturing_date\":\"6/2023\",\"manufacturing_date_formatted\":\"2023-06\",\"registered_at\":\"Ballia, Uttar Pradesh\",\"latest_by\":\"2026-06-15\",\"less_info\":true,\"tax_upto\":\"2026-08-31\",\"tax_paid_upto\":\"2026-08-31\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1500\",\"no_cylinders\":\"4\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1055\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"UP03203210052549\",\"pucc_upto\":\"2026-09-27\",\"permit_number\":\"UP2023-AITP-7859B\",\"permit_issue_date\":\"2023-10-10\",\"permit_valid_from\":\"2023-10-10\",\"permit_valid_upto\":\"2028-10-09\",\"permit_type\":\"Tourist Permit [ALL INDIA]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/UP60BT5490_front_image_1781521875.jpg', 'uploads/vehicles/UP60BT5490_back_image_1781521875.jpg', 'Active', '2026-06-15 11:11:15'),
(124, 509, 8, 'UP32TT1161', 'S***J', 'MARUTI SUZUKI INDIA LTD', 'DZIRE VXI CNG', 'RIGID (PASSENGER CAR)', 'PETROL(E20)/CNG', 'PEARL ARCTIC WHITE', '5', 'Motor Cab(LPV)', '2026-04-11', '2028-04-10', 'The New India Assurance Company Limited', '98000031260318974749', '2027-04-05', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA]', '2031-05-14', '{\"client_id\":\"rc_v2_wryhAdnjvyfduvzIwSjB\",\"rc_number\":\"UP32TT1161\",\"fit_up_to\":\"2028-04-10\",\"registration_date\":\"2026-04-11\",\"owner_name\":\"S***J\",\"father_name\":\"\",\"present_address\":\"Lucknow, 226010\",\"permanent_address\":\"Ambedkar Nagar, 224129\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3ZFDFSKTD4*****\",\"vehicle_engine_number\":\"Z12ENF3*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"DZIRE VXI CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL(E20)/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"CHOLAMANDALAM INV & FIN CO LTD`\",\"financed\":true,\"insurance_company\":\"The New India Assurance Company Limited\",\"insurance_policy_number\":\"98000031260318974749\",\"insurance_upto\":\"2027-04-05\",\"manufacturing_date\":\"4/2026\",\"manufacturing_date_formatted\":\"2026-04\",\"registered_at\":\"TRANSPORT NAGAR RTO LUCKNOW (UP32), Uttar Pradesh\",\"latest_by\":\"2026-06-16\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"1197.00\",\"vehicle_gross_weight\":\"1435\",\"no_cylinders\":\"3\",\"seat_capacity\":\"5\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2450\",\"unladen_weight\":\"1020\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"Newv4\",\"pucc_upto\":\"2027-04-10\",\"permit_number\":\"UP2026-AITP-2329B\",\"permit_issue_date\":\"2026-05-15\",\"permit_valid_from\":\"2026-05-15\",\"permit_valid_upto\":\"2031-05-14\",\"permit_type\":\"Tourist Permit [ALL INDIA]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/UP32TT1161_front_image_1781551224.jpg', 'uploads/vehicles/UP32TT1161_back_image_1781551224.jpg', 'Active', '2026-06-15 19:20:24'),
(125, 471, 9, 'HR55AQ5835', 'T****M S***H', 'MARUTI SUZUKI INDIA LTD', 'ERTIGA VXI (O) CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2023-06-05', '2027-06-04', 'Shriram General Insurance  Co. Ltd.', '108047/31/27/001513', '2026-08-25', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2028-06-06', '{\"client_id\":\"rc_v2_YvdVGtyySqkdjEUJcevk\",\"rc_number\":\"HR55AQ5835\",\"fit_up_to\":\"2027-06-04\",\"registration_date\":\"2023-06-05\",\"owner_name\":\"T****M S***H\",\"father_name\":\"\",\"present_address\":\"Gurgaon, 122001\",\"permanent_address\":\"Patiala, 147105\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SPE6*****\",\"vehicle_engine_number\":\"K15CN92*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"ERTIGA VXI (O) CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"SK FINANCE LLIMITED.\",\"financed\":true,\"insurance_company\":\"Shriram General Insurance  Co. Ltd.\",\"insurance_policy_number\":\"108047/31/27/001513\",\"insurance_upto\":\"2026-08-25\",\"manufacturing_date\":\"5/2023\",\"manufacturing_date_formatted\":\"2023-05\",\"registered_at\":\"RTA, GURGAON, Haryana\",\"latest_by\":\"2026-06-16\",\"less_info\":true,\"tax_upto\":\"2026-06-30\",\"tax_paid_upto\":\"2026-06-30\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1250\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"DL01001220087714\",\"pucc_upto\":\"2026-08-11\",\"permit_number\":\"HR2023-AITP-2883B\",\"permit_issue_date\":\"2023-06-07\",\"permit_valid_from\":\"2023-06-07\",\"permit_valid_upto\":\"2028-06-06\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"2\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR55AQ5835_front_image_1781609696.jpg', 'uploads/vehicles/HR55AQ5835_back_image_1781609696.jpg', 'Active', '2026-06-16 11:34:56'),
(126, 58, 9, 'HR47H3593', 'S*****P Y***V', 'TOYOTA KIRLOSKAR MOTOR PVT LTD', 'TOYOTA RUMION S CNG [MT]', 'RIGID (PASSENGER CAR)', 'PETROL(E20)/CNG', 'CAFE WHITE', '7', 'Motor Cab(LPV)', '2026-02-19', '2028-02-18', 'Cholamandalam MS General Insurance Co. Ltd.', '3312/00182083/000/00', '2027-02-09', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA PERMIT (LPV)]', '2031-03-02', '{\"client_id\":\"rc_v2_oCglGdFPbggmVhztuwfs\",\"rc_number\":\"HR47H3593\",\"fit_up_to\":\"2028-02-18\",\"registration_date\":\"2026-02-19\",\"owner_name\":\"S*****P Y***V\",\"father_name\":\"\",\"present_address\":\"Rewari, 123401\",\"permanent_address\":\"Rewari, 123401\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3DND62SSMB*****\",\"vehicle_engine_number\":\"K15CN99*****\",\"maker_description\":\"TOYOTA KIRLOSKAR MOTOR PVT LTD\",\"maker_model\":\"TOYOTA RUMION S CNG [MT]\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL(E20)/CNG\",\"color\":\"CAFE WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"INDUSIND BANK LTD\",\"financed\":true,\"insurance_company\":\"Cholamandalam MS General Insurance Co. Ltd.\",\"insurance_policy_number\":\"3312/00182083/000/00\",\"insurance_upto\":\"2027-02-09\",\"manufacturing_date\":\"12/2025\",\"manufacturing_date_formatted\":\"2025-12\",\"registered_at\":\"RTA, REWARI, Haryana\",\"latest_by\":\"2026-06-17\",\"less_info\":true,\"tax_upto\":\"2027-01-31\",\"tax_paid_upto\":\"2027-01-31\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1270\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR04702690020759\",\"pucc_upto\":\"2027-05-17\",\"permit_number\":\"HR2026-AITP-6127A\",\"permit_issue_date\":\"2026-03-03\",\"permit_valid_from\":\"2026-03-03\",\"permit_valid_upto\":\"2031-03-02\",\"permit_type\":\"Tourist Permit [ALL INDIA PERMIT (LPV)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/HR47H3593_front_image_1781683422.jpg', 'uploads/vehicles/HR47H3593_back_image_1781683422.jpg', 'Active', '2026-06-17 08:03:42');
INSERT INTO `partner_vehicles` (`id`, `partner_id`, `car_type`, `rc_number`, `owner_name`, `maker_description`, `maker_model`, `body_type`, `fuel_type`, `color`, `seat_capacity`, `vehicle_category_desc`, `registration_date`, `fit_up_to`, `insurance_company`, `insurance_policy_number`, `insurance_upto`, `norms_type`, `rc_status`, `permit_type`, `permit_valid_upto`, `raw_rc_data`, `front_image`, `back_image`, `status`, `created_at`) VALUES
(127, 28, 9, 'DL1ZD9277', 'Z******H', 'MARUTI SUZUKI INDIA LTD', 'TOUR M CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2025-06-10', '2027-06-09', 'Generali Central Insurance Co. Ltd.', '132/02/21/0627/MTP/3870071306', '2027-06-02', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [TOURIST TAXI(DELUXE)]', '2030-06-25', '{\"client_id\":\"rc_v2_HiAxFnETxRryVpEfYBha\",\"rc_number\":\"DL1ZD9277\",\"fit_up_to\":\"2027-06-09\",\"registration_date\":\"2025-06-10\",\"owner_name\":\"Z******H\",\"father_name\":\"\",\"present_address\":\"East, 110092\",\"permanent_address\":\"East, 110092\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SSEA*****\",\"vehicle_engine_number\":\"K15CN97*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"TOUR M CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"S K FINANCE LTD\",\"financed\":true,\"insurance_company\":\"Generali Central Insurance Co. Ltd.\",\"insurance_policy_number\":\"132/02/21/0627/MTP/3870071306\",\"insurance_upto\":\"2027-06-02\",\"manufacturing_date\":\"5/2025\",\"manufacturing_date_formatted\":\"2025-05\",\"registered_at\":\"TAXI UNIT HQ, Delhi\",\"latest_by\":\"2026-06-17\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1250\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"HR06501900007039\",\"pucc_upto\":\"2027-06-09\",\"permit_number\":\"DL2025-AITP-1205A\",\"permit_issue_date\":\"2025-06-30\",\"permit_valid_from\":\"2025-06-26\",\"permit_valid_upto\":\"2030-06-25\",\"permit_type\":\"Tourist Permit [TOURIST TAXI(DELUXE)]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/DL1ZD9277_front_image_1781690515.jpg', 'uploads/vehicles/DL1ZD9277_back_image_1781690515.jpg', 'Active', '2026-06-17 10:01:55'),
(128, 514, 9, 'UP83DT8226', 'A**P K***R', 'MARUTI SUZUKI INDIA LTD', 'ERTIGA VXI CNG', 'RIGID (PASSENGER CAR)', 'PETROL/CNG', 'PEARL ARCTIC WHITE', '7', 'Motor Cab(LPV)', '2025-05-14', '2027-05-13', 'The New India Assurance Company Limited', '98000031260319130831', '2027-05-11', 'BHARAT STAGE VI', 'ACTIVE', 'Tourist Permit [ALL INDIA]', '2030-05-20', '{\"client_id\":\"rc_v2_kFDsUZoCuLnEhdSXRoav\",\"rc_number\":\"UP83DT8226\",\"fit_up_to\":\"2027-05-13\",\"registration_date\":\"2025-05-14\",\"owner_name\":\"A**P K***R\",\"father_name\":\"\",\"present_address\":\"Firozabad, 205151\",\"permanent_address\":\"Firozabad, 205151\",\"mobile_number\":\"\",\"vehicle_category\":\"LPV\",\"vehicle_chasi_number\":\"MA3BNC62SSEA*****\",\"vehicle_engine_number\":\"K15CN97*****\",\"maker_description\":\"MARUTI SUZUKI INDIA LTD\",\"maker_model\":\"ERTIGA VXI CNG\",\"body_type\":\"RIGID (PASSENGER CAR)\",\"fuel_type\":\"PETROL/CNG\",\"color\":\"PEARL ARCTIC WHITE\",\"norms_type\":\"BHARAT STAGE VI\",\"financer\":\"MAHINDRA & MAHINDRA FIN SER LTD\",\"financed\":true,\"insurance_company\":\"The New India Assurance Company Limited\",\"insurance_policy_number\":\"98000031260319130831\",\"insurance_upto\":\"2027-05-11\",\"manufacturing_date\":\"5/2025\",\"manufacturing_date_formatted\":\"2025-05\",\"registered_at\":\"FEROZABAD, Uttar Pradesh\",\"latest_by\":\"2026-06-17\",\"less_info\":true,\"tax_upto\":null,\"tax_paid_upto\":\"LTT\",\"cubic_capacity\":\"1462.00\",\"vehicle_gross_weight\":\"1820\",\"no_cylinders\":\"4\",\"seat_capacity\":\"7\",\"sleeper_capacity\":\"0\",\"standing_capacity\":\"0\",\"wheelbase\":\"2740\",\"unladen_weight\":\"1250\",\"vehicle_category_description\":\"Motor Cab(LPV)\",\"pucc_number\":\"UP08001020021479\",\"pucc_upto\":\"2026-06-29\",\"permit_number\":\"UP2025-AITP-2686B\",\"permit_issue_date\":\"2025-05-21\",\"permit_valid_from\":\"2025-05-21\",\"permit_valid_upto\":\"2030-05-20\",\"permit_type\":\"Tourist Permit [ALL INDIA]\",\"national_permit_number\":\"\",\"national_permit_upto\":null,\"national_permit_issued_by\":null,\"non_use_status\":null,\"non_use_from\":null,\"non_use_to\":null,\"blacklist_status\":\"\",\"noc_details\":\"\",\"owner_number\":\"1\",\"rc_status\":\"ACTIVE\",\"rto_code\":null,\"response_metadata\":{\"masked_chassis\":true,\"masked_engine\":true,\"masked_owner_name\":true}}', 'uploads/vehicles/UP83DT8226_front_image_1781693520.jpg', 'uploads/vehicles/UP83DT8226_back_image_1781693520.jpg', 'Active', '2026-06-17 10:52:00');

-- --------------------------------------------------------

--
-- Table structure for table `partner_wallet`
--

CREATE TABLE `partner_wallet` (
  `id` int(11) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `balance` decimal(12,2) DEFAULT 0.00,
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `partner_wallet`
--

INSERT INTO `partner_wallet` (`id`, `partner_id`, `balance`, `updated_at`) VALUES
(1, 14, 37932.50, '2026-06-12 19:15:53'),
(26, 4, 14779.00, '2026-05-12 13:20:03'),
(41, 13, 85.00, '2026-06-14 04:07:25'),
(62, 20, 492.50, '2026-06-15 09:51:21'),
(63, 23, 100.00, '2026-05-05 14:55:11'),
(64, 24, 752.50, '2026-06-05 11:09:56'),
(65, 26, 150.00, '2026-05-05 15:00:21'),
(66, 25, 150.00, '2026-05-05 15:05:13'),
(67, 29, -764.50, '2026-05-23 08:21:45'),
(68, 30, 285.00, '2026-06-14 06:34:42'),
(93, 65, 305.00, '2026-06-09 03:48:07'),
(95, 67, -15.00, '2026-05-06 14:13:01'),
(97, 21, -707.50, '2026-05-16 08:22:22'),
(100, 72, -15.00, '2026-05-07 05:21:13'),
(102, 75, -15.00, '2026-05-07 07:01:14'),
(111, 117, -15.00, '2026-05-08 02:11:08'),
(113, 79, 937.50, '2026-06-17 11:56:46'),
(116, 88, 327.50, '2026-05-15 06:17:16'),
(117, 100, -7.50, '2026-05-08 17:32:08'),
(118, 85, 35.00, '2026-05-16 12:26:38'),
(120, 95, 570.00, '2026-05-16 13:55:33'),
(130, 77, -7.50, '2026-05-09 01:11:12'),
(131, 101, -15.00, '2026-05-09 01:24:08'),
(133, 127, -7.50, '2026-05-09 01:46:55'),
(134, 43, -7.50, '2026-05-09 03:17:59'),
(135, 31, -22.50, '2026-05-09 03:22:47'),
(145, 53, -15.00, '2026-05-09 10:53:32'),
(147, 151, -15.00, '2026-05-09 12:05:16'),
(149, 107, -15.00, '2026-05-09 13:39:06'),
(153, 152, -7.50, '2026-05-09 16:40:18'),
(158, 168, -30.00, '2026-05-19 18:06:17'),
(160, 176, -15.00, '2026-05-10 07:04:52'),
(162, 40, -15.00, '2026-05-10 07:05:58'),
(164, 175, -15.00, '2026-05-10 09:07:03'),
(166, 112, -15.00, '2026-05-10 10:08:04'),
(168, 50, 0.00, '2026-05-16 09:41:49'),
(174, 83, -15.00, '2026-05-10 13:13:24'),
(176, 122, -15.00, '2026-05-14 06:00:27'),
(178, 165, -7.50, '2026-05-10 14:53:34'),
(179, 113, -15.00, '2026-05-11 20:36:23'),
(198, 195, -7.50, '2026-05-11 09:29:22'),
(200, 225, -7.50, '2026-05-12 10:42:55'),
(201, 226, -7.50, '2026-05-12 11:01:19'),
(202, 28, 347.50, '2026-06-17 10:52:04'),
(205, 162, -15.00, '2026-05-14 08:32:21'),
(207, 227, -7.50, '2026-05-12 14:52:49'),
(211, 212, -22.50, '2026-05-18 01:09:47'),
(222, 156, -15.00, '2026-05-13 08:21:54'),
(223, 63, -7.50, '2026-05-13 04:11:00'),
(224, 110, -7.50, '2026-05-13 04:57:18'),
(225, 213, -7.50, '2026-05-13 06:45:51'),
(227, 145, -30.00, '2026-05-13 09:58:17'),
(231, 102, 285.00, '2026-05-14 06:11:58'),
(236, 36, -15.00, '2026-05-14 06:38:12'),
(238, 253, -22.50, '2026-05-14 07:29:38'),
(241, 256, -7.50, '2026-05-14 07:40:08'),
(243, 71, -15.00, '2026-05-14 08:59:35'),
(245, 252, 397.50, '2026-05-14 10:19:32'),
(249, 250, -15.00, '2026-06-17 11:25:10'),
(251, 263, -7.50, '2026-05-14 11:21:02'),
(252, 264, -7.50, '2026-05-14 12:04:52'),
(253, 257, -15.00, '2026-05-14 13:21:42'),
(255, 106, -30.00, '2026-05-14 15:15:20'),
(259, 271, -22.50, '2026-05-14 16:00:27'),
(261, 277, 300.00, '2026-05-15 10:42:56'),
(263, 276, -7.50, '2026-05-14 15:56:18'),
(266, 288, -7.50, '2026-05-14 18:45:20'),
(269, 280, -7.50, '2026-05-15 06:12:41'),
(274, 255, -7.50, '2026-05-15 07:49:37'),
(277, 27, 1300.00, '2026-05-15 08:36:10'),
(283, 286, -7.50, '2026-05-15 10:40:37'),
(291, 135, -15.00, '2026-05-15 12:39:00'),
(293, 313, 485.00, '2026-05-15 15:47:38'),
(297, 294, -30.00, '2026-05-16 07:30:25'),
(299, 309, -15.00, '2026-05-16 07:14:39'),
(313, 329, -7.50, '2026-05-16 14:01:54'),
(314, 328, -7.50, '2026-05-16 14:20:13'),
(315, 325, -15.00, '2026-05-16 15:10:45'),
(316, 327, -15.00, '2026-05-16 15:08:48'),
(320, 334, -7.50, '2026-05-16 16:37:49'),
(321, 245, -7.50, '2026-05-16 16:48:41'),
(322, 343, -15.00, '2026-05-17 05:35:12'),
(324, 339, -7.50, '2026-05-17 13:53:21'),
(325, 57, -7.50, '2026-05-18 00:13:14'),
(326, 314, -15.00, '2026-05-18 00:41:53'),
(329, 269, -7.50, '2026-05-18 09:32:53'),
(330, 178, -15.00, '2026-05-18 12:27:55'),
(331, 96, -15.00, '2026-05-18 12:30:41'),
(334, 312, -22.50, '2026-05-20 13:24:10'),
(335, 359, -30.00, '2026-05-24 12:04:36'),
(337, 229, -52.50, '2026-05-18 16:44:23'),
(354, 199, -22.50, '2026-05-19 05:06:04'),
(357, 374, -7.50, '2026-05-19 16:05:48'),
(358, 111, -7.50, '2026-05-19 17:47:50'),
(361, 376, -7.50, '2026-05-19 19:06:30'),
(362, 377, 300.00, '2026-05-20 06:34:05'),
(367, 281, -15.00, '2026-05-20 07:36:04'),
(369, 378, -7.50, '2026-05-20 10:43:13'),
(370, 316, -15.00, '2026-05-20 12:44:17'),
(374, 349, -7.50, '2026-05-20 23:35:22'),
(375, 279, -15.00, '2026-05-21 03:12:37'),
(377, 390, -7.50, '2026-05-21 05:15:04'),
(378, 391, -30.00, '2026-05-21 05:28:07'),
(382, 392, -15.00, '2026-05-21 07:15:26'),
(385, 369, -7.50, '2026-05-21 10:40:13'),
(389, 397, -7.50, '2026-05-21 16:28:54'),
(390, 337, -15.00, '2026-05-22 12:54:41'),
(395, 409, -1012.50, '2026-05-23 07:04:33'),
(530, 410, -15.00, '2026-05-23 07:28:02'),
(534, 398, -15.00, '2026-05-23 14:16:36'),
(543, 464, -30.00, '2026-06-13 11:41:53'),
(547, 447, -22.50, '2026-06-13 13:24:45'),
(550, 442, -15.00, '2026-06-13 18:11:27'),
(552, 484, -7.50, '2026-06-13 19:05:39'),
(560, 179, -15.00, '2026-06-15 11:12:29'),
(562, 509, -15.00, '2026-06-15 19:18:42'),
(564, 471, -15.00, '2026-06-16 04:57:32'),
(566, 58, -15.00, '2026-06-17 08:05:29'),
(571, 514, -15.00, '2026-06-17 10:55:04');

-- --------------------------------------------------------

--
-- Table structure for table `partner_withdrawals`
--

CREATE TABLE `partner_withdrawals` (
  `id` int(11) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` enum('Pending','Processing','In-Process','Paid','Rejected','Success') DEFAULT 'Pending',
  `payout_method` varchar(50) DEFAULT 'Bank Transfer',
  `transaction_id` varchar(100) DEFAULT NULL,
  `admin_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `partner_withdrawals`
--

INSERT INTO `partner_withdrawals` (`id`, `partner_id`, `amount`, `status`, `payout_method`, `transaction_id`, `admin_note`, `created_at`) VALUES
(5, 4, 100.00, 'Pending', 'Bank Transfer', NULL, NULL, '2026-04-04 13:53:08'),
(6, 4, 100.00, 'Pending', 'Bank Transfer', NULL, NULL, '2026-04-04 13:53:36'),
(7, 9, 1000.00, 'Pending', 'Bank Transfer', NULL, NULL, '2026-04-04 14:03:21'),
(8, 4, 5.00, 'Pending', 'Bank Transfer', NULL, NULL, '2026-04-04 16:00:36'),
(9, 4, 100.00, 'Pending', 'Bank Transfer', NULL, NULL, '2026-04-28 18:40:09'),
(10, 4, 50.00, 'Success', 'Bank Transfer', 'UTR7327272HSGS', '', '2026-04-28 19:11:32'),
(11, 4, 50.00, 'Processing', 'Bank Transfer', NULL, NULL, '2026-04-28 19:11:34'),
(12, 4, 50.00, 'Processing', 'Bank Transfer', NULL, NULL, '2026-04-28 19:11:47'),
(13, 4, 100.00, 'Processing', 'Bank Transfer', NULL, NULL, '2026-04-28 19:40:30'),
(14, 4, 50.00, 'Processing', 'Bank Transfer', NULL, NULL, '2026-04-28 19:41:06'),
(15, 4, 55.00, 'Processing', 'Bank Transfer', NULL, NULL, '2026-04-28 19:48:12'),
(16, 21, 570.00, 'Success', 'Bank Transfer', 'UTR: 488369767124', '', '2026-05-09 05:43:18'),
(17, 21, 200.00, 'Success', 'Bank Transfer', 'UTR: 535798622383', '', '2026-05-09 14:29:46'),
(18, 277, 55.00, 'Success', 'Bank Transfer', 'UTR:138525316361', '', '2026-05-15 10:42:56');

-- --------------------------------------------------------

--
-- Table structure for table `payment_settings`
--

CREATE TABLE `payment_settings` (
  `id` int(11) NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_settings`
--

INSERT INTO `payment_settings` (`id`, `setting_key`, `setting_value`, `created_at`, `updated_at`) VALUES
(1, 'razorpay_key_id', 'rzp_live_SWGYDBqRA4TDIj', '2026-03-29 10:42:51', '2026-04-04 13:15:57'),
(2, 'razorpay_key_secret', 'dhSY3r6rncqEtq9SqM6ax1um', '2026-03-29 10:42:51', '2026-04-04 13:15:57'),
(3, 'razorpay_mode', 'live', '2026-03-29 10:42:51', '2026-04-04 13:15:57'),
(4, 'razorpay_status', 'Active', '2026-03-29 10:42:51', '2026-04-04 13:15:57');

-- --------------------------------------------------------

--
-- Table structure for table `payment_test_logs`
--

CREATE TABLE `payment_test_logs` (
  `id` int(11) NOT NULL,
  `razorpay_order_id` varchar(100) DEFAULT NULL,
  `razorpay_payment_id` varchar(100) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `currency` varchar(10) DEFAULT 'INR',
  `status` enum('Pending','Success','Failed') DEFAULT 'Pending',
  `response_data` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_test_logs`
--

INSERT INTO `payment_test_logs` (`id`, `razorpay_order_id`, `razorpay_payment_id`, `amount`, `currency`, `status`, `response_data`, `created_at`) VALUES
(1, 'order_SZQdzOVZxcIsjR', NULL, 1.00, 'INR', 'Pending', NULL, '2026-04-04 13:16:00'),
(2, 'order_SipC9HwynACfW6', NULL, 1.00, 'INR', 'Pending', NULL, '2026-04-28 07:08:00');

-- --------------------------------------------------------

--
-- Table structure for table `search_logs`
--

CREATE TABLE `search_logs` (
  `id` int(11) NOT NULL,
  `main_tab` varchar(50) DEFAULT NULL,
  `trip_type` varchar(50) NOT NULL,
  `pickup` text NOT NULL,
  `drop_location` text DEFAULT NULL,
  `stops` text DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `return_date` date DEFAULT NULL,
  `return_time` time DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `distance_km` decimal(8,2) DEFAULT 0.00,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `search_logs`
--

INSERT INTO `search_logs` (`id`, `main_tab`, `trip_type`, `pickup`, `drop_location`, `stops`, `start_date`, `start_time`, `return_date`, `return_time`, `phone`, `distance_km`, `ip_address`, `created_at`) VALUES
(1, 'Out Station', 'One Way', 'Jind, Haryana, India', 'Delhi, India', NULL, '2026-06-12', '01:02:00', NULL, NULL, '', 142.00, '203.81.243.200', '2026-06-12 19:33:14'),
(2, 'Out Station', 'Round Trip', 'Jind, Haryana, India', 'Ambala, Haryana, India', NULL, '2026-06-12', '01:04:00', '2026-06-24', '01:08:00', '', 314.00, '203.81.243.200', '2026-06-12 19:34:37'),
(3, 'Out Station', 'One Way', 'Jind, Haryana, India', 'Chandigarh, India', NULL, '2026-06-12', '01:07:00', NULL, NULL, '8059982049', 208.00, '203.81.243.200', '2026-06-12 19:37:48'),
(4, 'Out Station', 'One Way', 'Delhi, India', 'Jaipur, Rajasthan, India', NULL, '2026-06-12', '01:13:00', NULL, NULL, '8059982049', 360.00, '203.81.243.200', '2026-06-12 19:43:42'),
(5, 'Out Station', 'One Way', 'Delhi, India', 'Jaipur, Rajasthan, India', NULL, '2026-06-12', '01:13:00', NULL, NULL, '8059982049', 360.00, '203.81.243.200', '2026-06-12 19:46:52'),
(6, 'Out Station', 'One Way', 'Delhi, India', 'Jaipur, Rajasthan, India', NULL, '2026-06-12', '01:26:00', NULL, NULL, '80599825896', 360.00, '203.81.243.200', '2026-06-12 19:56:42'),
(7, 'Out Station', 'Round Trip', 'Delhi, India', 'Jaipur, Rajasthan, India', NULL, '2026-06-12', '01:26:00', '2026-06-13', '01:28:00', '80599825896', 720.00, '203.81.243.200', '2026-06-12 19:58:03'),
(8, 'Out Station', 'Round Trip', 'Jind, Haryana, India', 'Kaithal, Haryana, India', NULL, '2026-06-12', '01:29:00', '2026-06-13', '22:00:00', '8058602516', 130.00, '182.77.76.101', '2026-06-12 19:59:44'),
(9, 'Out Station', 'Round Trip', 'Jind, Haryana, India', 'Kaithal, Haryana, India', NULL, '2026-06-12', '01:28:00', '2026-06-21', '06:29:00', '8059952046', 130.00, '203.81.243.200', '2026-06-12 19:59:45'),
(10, 'Out Station', 'Round Trip', 'Jind, Haryana, India', 'Kaithal, Haryana, India', NULL, '2026-06-12', '01:28:00', '2026-06-13', '06:29:00', '8059952046', 130.00, '203.81.243.200', '2026-06-12 20:00:24'),
(11, 'Out Station', 'Round Trip', 'Jind, Haryana, India', 'Manali, Himachal Pradesh, India', NULL, '2026-06-12', '01:29:00', '2026-06-13', '22:00:00', '8058602516', 994.00, '182.77.76.101', '2026-06-12 20:01:06'),
(12, 'Out Station', 'Round Trip', 'Jind, Haryana, India', 'Manali, Himachal Pradesh, India', NULL, '2026-06-12', '01:28:00', '2026-06-13', '06:29:00', '8059952046', 994.00, '203.81.243.200', '2026-06-12 20:01:39'),
(13, 'Local / Airport', 'Local / Rental', 'Jind, Haryana, India', '', NULL, '2026-06-12', '01:32:00', NULL, NULL, '8059982049', 0.00, '203.81.243.200', '2026-06-12 20:02:51'),
(14, 'Local / Airport', 'Local / Rental', 'Delhi, India', 'Manali, Himachal Pradesh, India', NULL, '2026-06-12', '01:29:00', NULL, NULL, '8058602516', 0.00, '182.77.76.101', '2026-06-12 20:03:08'),
(15, 'Local / Airport', 'Local / Rental', 'Jind, Haryana, India', '', NULL, '2026-06-12', '01:32:00', NULL, NULL, '8059982049', 0.00, '203.81.243.200', '2026-06-12 20:03:35'),
(16, 'Out Station', 'One Way', 'Delhi, India', 'Jaipur, Rajasthan, India', NULL, '2026-06-12', '01:29:00', '2026-06-13', '22:00:00', '8058602516', 360.00, '182.77.76.101', '2026-06-12 20:07:49'),
(17, 'Out Station', 'One Way', 'Delhi, India', 'Jaipur, Rajasthan, India', NULL, '2026-06-12', '01:34:00', NULL, NULL, '8059982049', 360.00, '203.81.243.200', '2026-06-12 20:08:01');

-- --------------------------------------------------------

--
-- Table structure for table `site_settings`
--

CREATE TABLE `site_settings` (
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `site_settings`
--

INSERT INTO `site_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES
('notification_sound', 'chat_notification_sound', '2026-04-27 19:27:18'),
('notification_sound_file', 'chat_notification_sound.wav', '2026-04-28 06:59:33'),
('onesignal_accept_channel', 'dfa595d6-2fc7-43ff-974d-a9cea0b75c9b', '2026-05-06 21:19:39'),
('onesignal_app_id', '8af20809-09e9-4ce1-9377-989b6b4e4600', '2026-04-27 18:08:21'),
('onesignal_cancel_channel', '751fe976-5001-419e-a3b0-c52170fbe367', '2026-05-06 21:19:39'),
('onesignal_channel_id', '77b899ce-0f7e-4734-acf3-73d3423f8e68', '2026-04-27 19:20:55'),
('onesignal_chat_channel', '51668f67-1086-4ea5-a80e-d4ff3915095e', '2026-05-06 21:52:18'),
('onesignal_commission_channel', 'fc61a993-0560-4d3a-bcba-315118481b85', '2026-05-06 21:19:39'),
('onesignal_new_booking_channel', '31ea4096-bd7e-48d1-8754-777b4183c133', '2026-05-06 21:19:39'),
('onesignal_rest_api_key', 'os_v2_app_rlzaqcij5fgode3xtcnwwtsgadesxx5gh4surqnisw5scedf6sclla5lzohurkfwjhuokgmjmwxux2ua73atsivukhpyevluz4byyuy', '2026-06-08 17:17:55'),
('onesignal_trip_status_channel', '97e9422a-8765-43c0-8a19-1581a17e3394', '2026-05-06 21:19:39');

-- --------------------------------------------------------

--
-- Table structure for table `states`
--

CREATE TABLE `states` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `country` varchar(255) DEFAULT 'India',
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `states`
--

INSERT INTO `states` (`id`, `name`, `country`, `status`, `created_at`) VALUES
(1, 'Haryana', 'India', 'Active', '2026-05-22 07:05:36'),
(2, 'Punjab', 'India', 'Active', '2026-05-22 07:05:45'),
(3, 'Gujrat', 'India', 'Active', '2026-05-22 07:06:02'),
(4, 'Himachal pradesh', 'India', 'Active', '2026-05-22 07:06:15'),
(5, 'delhi', 'India', 'Active', '2026-05-25 09:12:38'),
(6, 'uttarakhand', 'India', 'Active', '2026-05-25 09:13:08'),
(7, 'uttar pradesh', 'India', 'Active', '2026-05-25 09:14:47'),
(8, 'Rajasthan', 'India', 'Active', '2026-05-25 09:15:05'),
(9, 'maharashtra', 'India', 'Active', '2026-05-25 09:16:45');

-- --------------------------------------------------------

--
-- Table structure for table `trip_types`
--

CREATE TABLE `trip_types` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `trip_types`
--

INSERT INTO `trip_types` (`id`, `name`, `description`, `status`, `created_at`, `updated_at`) VALUES
(1, 'One Way', 'One way taxi service', 'Active', '2026-03-29 10:43:11', '2026-03-29 10:43:11'),
(2, 'Round Trip', 'Round trip taxi service', 'Active', '2026-03-29 10:43:11', '2026-03-29 10:43:11'),
(3, 'Local', 'Local rental service', 'Active', '2026-03-29 10:43:11', '2026-03-29 10:43:11'),
(4, 'Airport Transfer', 'Airport Transfer', 'Active', '2026-03-29 10:43:11', '2026-04-05 19:01:21'),
(5, 'Local / Rental', NULL, 'Active', '2026-05-22 17:27:33', '2026-05-22 17:27:33');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accepted_bookings`
--
ALTER TABLE `accepted_bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_booking` (`booking_id`),
  ADD KEY `idx_partner` (`partner_id`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `app_notices`
--
ALTER TABLE `app_notices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `booking_chats`
--
ALTER TABLE `booking_chats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_booking_chat` (`booking_id`),
  ADD KEY `idx_chat_performance` (`booking_id`,`sender_id`,`receiver_id`);

--
-- Indexes for table `cars`
--
ALTER TABLE `cars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `brand_id` (`brand_id`),
  ADD KEY `type_id` (`type_id`),
  ADD KEY `trip_type_id` (`trip_type_id`);

--
-- Indexes for table `car_brands`
--
ALTER TABLE `car_brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `car_types`
--
ALTER TABLE `car_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `state_id` (`state_id`);

--
-- Indexes for table `commission_requests`
--
ALTER TABLE `commission_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `partner_id` (`partner_id`),
  ADD KEY `booking_id` (`booking_id`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `drivers`
--
ALTER TABLE `drivers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `license_number` (`license_number`),
  ADD KEY `partner_id` (`partner_id`);

--
-- Indexes for table `driver_locations`
--
ALTER TABLE `driver_locations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `driver_id` (`driver_id`),
  ADD KEY `booking_id` (`booking_id`);

--
-- Indexes for table `driver_trip_logs`
--
ALTER TABLE `driver_trip_logs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `acceptance_id` (`acceptance_id`);

--
-- Indexes for table `hero_slides`
--
ALTER TABLE `hero_slides`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `partners`
--
ALTER TABLE `partners`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mobile` (`mobile`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `aadhaar_number` (`aadhaar_number`);

--
-- Indexes for table `partner_alert_settings`
--
ALTER TABLE `partner_alert_settings`
  ADD PRIMARY KEY (`partner_id`);

--
-- Indexes for table `partner_bank_details`
--
ALTER TABLE `partner_bank_details`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `partner_id` (`partner_id`),
  ADD KEY `partner_id_2` (`partner_id`);

--
-- Indexes for table `partner_bookings`
--
ALTER TABLE `partner_bookings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `partner_booking_popups_seen`
--
ALTER TABLE `partner_booking_popups_seen`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unq_partner_booking` (`partner_id`,`booking_id`);

--
-- Indexes for table `partner_deposits`
--
ALTER TABLE `partner_deposits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `partner_id` (`partner_id`),
  ADD KEY `razorpay_order_id` (`razorpay_order_id`);

--
-- Indexes for table `partner_notices_seen`
--
ALTER TABLE `partner_notices_seen`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unq_partner_notice` (`partner_id`,`notice_id`);

--
-- Indexes for table `partner_ratings`
--
ALTER TABLE `partner_ratings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `one_per_booking` (`reviewer_id`,`reviewed_id`,`booking_id`);

--
-- Indexes for table `partner_subscriptions`
--
ALTER TABLE `partner_subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_partner` (`partner_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `partner_subscription_plans`
--
ALTER TABLE `partner_subscription_plans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `partner_transactions`
--
ALTER TABLE `partner_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `partner_id` (`partner_id`),
  ADD KEY `source_id` (`source_id`);

--
-- Indexes for table `partner_vehicles`
--
ALTER TABLE `partner_vehicles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `partner_wallet`
--
ALTER TABLE `partner_wallet`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `partner_id` (`partner_id`);

--
-- Indexes for table `partner_withdrawals`
--
ALTER TABLE `partner_withdrawals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `partner_id` (`partner_id`);

--
-- Indexes for table `payment_settings`
--
ALTER TABLE `payment_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`);

--
-- Indexes for table `payment_test_logs`
--
ALTER TABLE `payment_test_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `search_logs`
--
ALTER TABLE `search_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `site_settings`
--
ALTER TABLE `site_settings`
  ADD PRIMARY KEY (`setting_key`);

--
-- Indexes for table `states`
--
ALTER TABLE `states`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trip_types`
--
ALTER TABLE `trip_types`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accepted_bookings`
--
ALTER TABLE `accepted_bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `app_notices`
--
ALTER TABLE `app_notices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `booking_chats`
--
ALTER TABLE `booking_chats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1075;

--
-- AUTO_INCREMENT for table `cars`
--
ALTER TABLE `cars`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=177;

--
-- AUTO_INCREMENT for table `car_brands`
--
ALTER TABLE `car_brands`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `car_types`
--
ALTER TABLE `car_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `commission_requests`
--
ALTER TABLE `commission_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `drivers`
--
ALTER TABLE `drivers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=116;

--
-- AUTO_INCREMENT for table `driver_locations`
--
ALTER TABLE `driver_locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `driver_trip_logs`
--
ALTER TABLE `driver_trip_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `hero_slides`
--
ALTER TABLE `hero_slides`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `partners`
--
ALTER TABLE `partners`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=521;

--
-- AUTO_INCREMENT for table `partner_bank_details`
--
ALTER TABLE `partner_bank_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `partner_bookings`
--
ALTER TABLE `partner_bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2627926;

--
-- AUTO_INCREMENT for table `partner_booking_popups_seen`
--
ALTER TABLE `partner_booking_popups_seen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `partner_deposits`
--
ALTER TABLE `partner_deposits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `partner_notices_seen`
--
ALTER TABLE `partner_notices_seen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=378;

--
-- AUTO_INCREMENT for table `partner_ratings`
--
ALTER TABLE `partner_ratings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `partner_subscriptions`
--
ALTER TABLE `partner_subscriptions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `partner_subscription_plans`
--
ALTER TABLE `partner_subscription_plans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `partner_transactions`
--
ALTER TABLE `partner_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=592;

--
-- AUTO_INCREMENT for table `partner_vehicles`
--
ALTER TABLE `partner_vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=129;

--
-- AUTO_INCREMENT for table `partner_wallet`
--
ALTER TABLE `partner_wallet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=581;

--
-- AUTO_INCREMENT for table `partner_withdrawals`
--
ALTER TABLE `partner_withdrawals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `payment_settings`
--
ALTER TABLE `payment_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `payment_test_logs`
--
ALTER TABLE `payment_test_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `search_logs`
--
ALTER TABLE `search_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `states`
--
ALTER TABLE `states`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `trip_types`
--
ALTER TABLE `trip_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accepted_bookings`
--
ALTER TABLE `accepted_bookings`
  ADD CONSTRAINT `accepted_bookings_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `partner_bookings` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `accepted_bookings_ibfk_2` FOREIGN KEY (`partner_id`) REFERENCES `partners` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `booking_chats`
--
ALTER TABLE `booking_chats`
  ADD CONSTRAINT `booking_chats_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `partner_bookings` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cars`
--
ALTER TABLE `cars`
  ADD CONSTRAINT `cars_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `car_brands` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cars_ibfk_2` FOREIGN KEY (`type_id`) REFERENCES `car_types` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cars_ibfk_3` FOREIGN KEY (`trip_type_id`) REFERENCES `trip_types` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cities`
--
ALTER TABLE `cities`
  ADD CONSTRAINT `cities_ibfk_1` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `drivers`
--
ALTER TABLE `drivers`
  ADD CONSTRAINT `drivers_ibfk_1` FOREIGN KEY (`partner_id`) REFERENCES `partners` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `partner_wallet`
--
ALTER TABLE `partner_wallet`
  ADD CONSTRAINT `partner_wallet_ibfk_1` FOREIGN KEY (`partner_id`) REFERENCES `partners` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
