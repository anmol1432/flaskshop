-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 18, 2020 at 08:51 AM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.2.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `flaskshop`
--

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `sno` int(11) NOT NULL,
  `name` varchar(80) NOT NULL,
  `email` varchar(40) NOT NULL,
  `textmsg` varchar(200) NOT NULL,
  `datetime` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`sno`, `name`, `email`, `textmsg`, `datetime`) VALUES
(1, 'anmol', 'qq@gmail.com', 'hiiii', '2020-09-20 16:14:32.817584'),
(2, 'anmol', 'harman1231@gmail.com', 'hello', '2020-09-20 16:18:51.669816'),
(3, 'anmol', 'harman1231@gmail.com', 'hello', '2020-09-20 16:19:08.863025'),
(4, 'love', 'love@gmail.com', 'hiiidiocus', '2020-09-20 16:22:02.042661'),
(5, 'k', 'love@gmail.com', 'hiiidiocus', '2020-09-20 16:22:41.085737'),
(6, 'k', 'love@gmail.com', 'hiiidiocus', '2020-09-20 16:22:52.679902'),
(7, 'k', 'love@gmail.com', 'hiiidiocus', '2020-09-20 16:28:33.320712'),
(8, 'k', 'love@gmail.com', 'hiiidiocus', '2020-09-20 16:28:39.835220'),
(9, '', 'noor@gmail.com', '12331hiilo', '2020-10-09 04:02:08.141281'),
(10, '', 'noor@gmail.com', '12331hiilo', '2020-10-09 04:03:24.877457'),
(11, 'hello', 'noor@gmail.com', '12331hiilo', '2020-10-09 04:03:42.951691'),
(12, 'hello', 'noor@gmail.com', '12331hiilo', '2020-10-09 04:04:36.419273'),
(13, 'post', 'noor@gmail.com', 'why post request is not working', '2020-10-11 03:23:45.860340'),
(14, 'hoo', 'anmol@gmail.com', 'hoooo', '2020-10-16 15:42:30.571813'),
(15, 'hoo', 'anmol@gmail.com', 'hoooo', '2020-10-16 15:43:11.426822'),
(16, 'hoo', 'anmol@gmail.com', 'hoooo', '2020-10-16 15:43:24.802011'),
(17, 'hoo', 'anmol@gmail.com', 'hoooo', '2020-10-16 15:43:44.937937'),
(18, 'hoo', 'anmol@gmail.com', 'hoooo', '2020-10-16 15:44:07.556122'),
(19, 'hoo', 'anmol@gmail.com', 'hoooo', '2020-10-16 15:44:50.180251'),
(20, 'hoo', 'anmol@gmail.com', 'hoooo', '2020-10-16 15:45:06.286316'),
(21, 'hii', 'anmol@gmail.com', 'uhu', '2020-10-16 15:46:46.932496'),
(22, 'hii', 'anmol@gmail.com', 'uhu', '2020-10-16 15:47:52.926665'),
(23, 'hii', 'anmol@gmail.com', 'uhu', '2020-10-16 15:47:55.928867'),
(24, 'hii', 'anmol@gmail.com', 'uhu', '2020-10-16 15:48:14.750026');

-- --------------------------------------------------------

--
-- Table structure for table `kidproduct`
--

CREATE TABLE `kidproduct` (
  `p_id` int(11) NOT NULL,
  `p_name` varchar(70) NOT NULL,
  `p_price` int(70) NOT NULL,
  `p_img` varchar(80) NOT NULL,
  `p_discription` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kidproduct`
--

INSERT INTO `kidproduct` (`p_id`, `p_name`, `p_price`, `p_img`, `p_discription`) VALUES
(1, 'hat', 10, '/static/img/kid.jpg', 'happy kid'),
(2, 'anything', 0, '/static/img/pink-.jpg', 'anything testing purpose');

-- --------------------------------------------------------

--
-- Table structure for table `menproduct`
--

CREATE TABLE `menproduct` (
  `p_id` int(11) NOT NULL,
  `p_name` text NOT NULL,
  `p_price` int(10) NOT NULL,
  `p_img` varchar(80) NOT NULL,
  `p_discription` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `menproduct`
--

INSERT INTO `menproduct` (`p_id`, `p_name`, `p_price`, `p_img`, `p_discription`) VALUES
(4, 'SHOES', 150, '/static/img/men-shoe.jpg', 'Best shoe  from India'),
(5, 'Men\'s Denim Jacket', 80, '/static/img/men-jacket.jpg', 'denim jacket with soft fur');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_email` varchar(70) NOT NULL,
  `user_name` varchar(70) NOT NULL,
  `p_name` text NOT NULL,
  `p_price` int(30) NOT NULL,
  `quantity` int(11) NOT NULL,
  `p_discription` text NOT NULL,
  `date` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `user_email`, `user_name`, `p_name`, `p_price`, `quantity`, `p_discription`, `date`) VALUES
(57, 58, 'name@gmail.com', 'name', 'SHOES', 150, 1, 'Best shoe  from India', '2020-10-15 22:37:37.738914'),
(58, 58, 'name@gmail.com', 'name', 'Black jacket', 299, 1, 'Leather jacket', '2020-10-15 22:37:47.819255');

-- --------------------------------------------------------

--
-- Table structure for table `usertable`
--

CREATE TABLE `usertable` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `phone_no` int(20) NOT NULL,
  `useremail` varchar(30) NOT NULL,
  `userpassword` varchar(100) NOT NULL,
  `date` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `usertable`
--

INSERT INTO `usertable` (`user_id`, `username`, `phone_no`, `useremail`, `userpassword`, `date`) VALUES
(56, 'hp', 0, 'hp@gmail.com', 'hp', '2020-10-12 15:18:07.352639'),
(57, 'anmol singh', 9886447, 'anmol@gmail.com', '12345', '2020-10-13 15:36:58.336280'),
(58, 'name', 2147483647, 'name@gmail.com', '1234', '2020-10-15 16:56:48.105604'),
(59, 'new', 20923030, 'new@gmail.com', '123', '2020-10-15 17:16:45.606100');

-- --------------------------------------------------------

--
-- Table structure for table `womenproduct`
--

CREATE TABLE `womenproduct` (
  `p_id` int(11) NOT NULL,
  `p_name` text NOT NULL,
  `p_price` int(10) NOT NULL,
  `p_img` varchar(70) NOT NULL,
  `p_discription` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `womenproduct`
--

INSERT INTO `womenproduct` (`p_id`, `p_name`, `p_price`, `p_img`, `p_discription`) VALUES
(2, 'Black jacket', 299, '/static/img/Jacket-black.jpg', 'Leather jacket');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `kidproduct`
--
ALTER TABLE `kidproduct`
  ADD PRIMARY KEY (`p_id`);

--
-- Indexes for table `menproduct`
--
ALTER TABLE `menproduct`
  ADD PRIMARY KEY (`p_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `usertable`
--
ALTER TABLE `usertable`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `womenproduct`
--
ALTER TABLE `womenproduct`
  ADD PRIMARY KEY (`p_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `kidproduct`
--
ALTER TABLE `kidproduct`
  MODIFY `p_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `menproduct`
--
ALTER TABLE `menproduct`
  MODIFY `p_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `usertable`
--
ALTER TABLE `usertable`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `womenproduct`
--
ALTER TABLE `womenproduct`
  MODIFY `p_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usertable` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
