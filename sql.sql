/*
SQLyog Community v13.1.6 (64 bit)
MySQL - 5.7.9 : Database - counterfeit
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`counterfeit` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `counterfeit`;

/*Table structure for table `booking` */

DROP TABLE IF EXISTS `booking`;

CREATE TABLE `booking` (
  `booking_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `medicine_id` int(11) DEFAULT NULL,
  `amt` varchar(100) DEFAULT NULL,
  `date` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`booking_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `booking` */

insert  into `booking`(`booking_id`,`user_id`,`medicine_id`,`amt`,`date`,`status`) values 
(1,NULL,1,'400','2023-04-09','Paid'),
(2,2,1,'400','2023-04-09','Paid');

/*Table structure for table `bookingpayment` */

DROP TABLE IF EXISTS `bookingpayment`;

CREATE TABLE `bookingpayment` (
  `payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `booking_id` int(11) DEFAULT NULL,
  `amount` varchar(100) DEFAULT NULL,
  `date` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`payment_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `bookingpayment` */

insert  into `bookingpayment`(`payment_id`,`user_id`,`booking_id`,`amount`,`date`) values 
(1,2,2,'400','2023-04-09'),
(2,2,2,'400','2023-04-09'),
(3,2,2,'400','2023-04-09'),
(4,2,2,'400','2023-04-09'),
(5,2,1,'400','2023-04-09');

/*Table structure for table `distributor` */

DROP TABLE IF EXISTS `distributor`;

CREATE TABLE `distributor` (
  `distributer_id` int(11) NOT NULL AUTO_INCREMENT,
  `login_id` int(11) DEFAULT NULL,
  `fname` varchar(100) DEFAULT NULL,
  `lname` varchar(100) DEFAULT NULL,
  `place` varchar(100) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`distributer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `distributor` */

insert  into `distributor`(`distributer_id`,`login_id`,`fname`,`lname`,`place`,`phone`,`email`) values 
(1,1,'anju','amal','kaloor','3214569874','anjuamal@gmail.com'),
(2,2,'anju','amal','kaloor','3214569874','anjuamal@gmail.com'),
(3,9,'Nithya','ab','ekm','8523697412','nithya@gmail.com'),
(4,21,'harry','5f5f','kerala','4521369875','harry@gmail.com');

/*Table structure for table `feedback` */

DROP TABLE IF EXISTS `feedback`;

CREATE TABLE `feedback` (
  `feedback_id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(100) DEFAULT NULL,
  `feedback` varchar(500) DEFAULT NULL,
  `date` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`feedback_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `feedback` */

insert  into `feedback`(`feedback_id`,`user`,`feedback`,`date`) values 
(1,'12','good','12/5/22');

/*Table structure for table `login` */

DROP TABLE IF EXISTS `login`;

CREATE TABLE `login` (
  `login_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `usertype` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`login_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

/*Data for the table `login` */

insert  into `login`(`login_id`,`username`,`password`,`usertype`) values 
(1,'anju','amal','distributor'),
(2,'anju','amal','blocked'),
(3,'aparna','aparna','manufacturer'),
(4,'admin','admin','admin'),
(6,'medic','medic','user'),
(7,'medic','medic','user'),
(8,'medic','medic','user'),
(9,'nithya','nithya','distributor'),
(10,'sandra','sandra','blocked'),
(11,'neelima','neelima','blocked'),
(12,'anjuva','anjuva','user'),
(13,'medic','medic','pending'),
(14,'dollo','dollo','pending'),
(15,'dollo','dollo','pending'),
(16,'nithya','nithya1','manufacture'),
(17,'anjulabs','anjulabs','pharmacy'),
(18,NULL,NULL,NULL),
(19,'niall','niall','manufacturer'),
(20,'linda','linda','manufacturer'),
(21,'harry','harry','distributor'),
(22,'pulari','pulari','pharmacy'),
(23,'hdj','hdi','student'),
(24,'hai','hai','user'),
(25,'hi','hi','user');

/*Table structure for table `manufacture` */

DROP TABLE IF EXISTS `manufacture`;

CREATE TABLE `manufacture` (
  `manufacture_id` int(11) NOT NULL AUTO_INCREMENT,
  `login_id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `place` varchar(100) DEFAULT NULL,
  `dis` varchar(100) DEFAULT NULL,
  `path` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`manufacture_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `manufacture` */

insert  into `manufacture`(`manufacture_id`,`login_id`,`name`,`phone`,`email`,`place`,`dis`,`path`) values 
(1,3,'Aleena','9630011203','aleena@gmail.com','kochi','Ernakulam','/static/20220629114642.jpeg'),
(2,19,'Niall Horan','3254169874','niall@gmail.com','Irland','mullingar','/static/20220927114835.png'),
(3,20,'lindapharmacy','8521479632','linda@gmail.com','kerala','ernakulam','/static/20221003133645.png');

/*Table structure for table `medicine` */

DROP TABLE IF EXISTS `medicine`;

CREATE TABLE `medicine` (
  `medicine_id` int(11) NOT NULL AUTO_INCREMENT,
  `manufacture_id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `ty` varchar(100) DEFAULT NULL,
  `a` varchar(100) DEFAULT NULL,
  `cn` varchar(100) DEFAULT NULL,
  `n` varchar(100) DEFAULT NULL,
  `ul` varchar(100) DEFAULT NULL,
  `se` varchar(100) DEFAULT NULL,
  `s` varchar(100) DEFAULT NULL,
  `ed` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`medicine_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `medicine` */

insert  into `medicine`(`medicine_id`,`manufacture_id`,`name`,`ty`,`a`,`cn`,`n`,`ul`,`se`,`s`,`ed`) values 
(1,1,'jhkj','fdsf','400','fsf','dfdsf','dsfs','dsfs','sfsf','dsfsd');

/*Table structure for table `payment` */

DROP TABLE IF EXISTS `payment`;

CREATE TABLE `payment` (
  `payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `pharmacy_id` int(11) DEFAULT NULL,
  `stock_id` int(11) DEFAULT NULL,
  `amount` varchar(100) DEFAULT NULL,
  `date` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`payment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `payment` */

insert  into `payment`(`payment_id`,`pharmacy_id`,`stock_id`,`amount`,`date`) values 
(4,17,2,'2000','2022-10-03');

/*Table structure for table `pharmacy` */

DROP TABLE IF EXISTS `pharmacy`;

CREATE TABLE `pharmacy` (
  `pharmacy_id` int(11) NOT NULL AUTO_INCREMENT,
  `login_id` int(11) DEFAULT NULL,
  `pharmacy_name` varchar(100) DEFAULT NULL,
  `place` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `license` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`pharmacy_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `pharmacy` */

insert  into `pharmacy`(`pharmacy_id`,`login_id`,`pharmacy_name`,`place`,`city`,`email`,`phone`,`license`) values 
(1,10,'sandra','melbin','ekm','sandra@gmail.com','7896541235','kl0708'),
(2,11,'neelima','ekm','edappally','neelima@gmail.com','4563217896','hw852'),
(3,17,'anjulabs','kaloor','ekm','anjulabs@gmail.com','8542136974','1kl2u3h'),
(4,22,'pularimedicals','kerala','eranakulam','pulari@gmail.com','1236547892','static/8300b92f-a71a-417f-9f13-40efe2ec6b7475a6079c-889b-4aa2-acef-6334fd9eb696plicense1.png');

/*Table structure for table `request` */

DROP TABLE IF EXISTS `request`;

CREATE TABLE `request` (
  `request_id` int(11) NOT NULL AUTO_INCREMENT,
  `pharmacy_id` int(11) DEFAULT NULL,
  `distributer_id` int(11) DEFAULT NULL,
  `manufacture_id` int(11) DEFAULT NULL,
  `quantity` varchar(100) DEFAULT NULL,
  `medicine_id` int(11) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `request` */

insert  into `request`(`request_id`,`pharmacy_id`,`distributer_id`,`manufacture_id`,`quantity`,`medicine_id`,`status`) values 
(2,17,1,3,'20',1,'Paid'),
(5,22,1,0,'30',23,'pending'),
(6,22,21,3,'30',23,'Send to Manufacture'),
(8,17,1,20,'10',23,'Provided'),
(9,22,1,3,'50',28,'Provided');

/*Table structure for table `stock` */

DROP TABLE IF EXISTS `stock`;

CREATE TABLE `stock` (
  `stock_id` int(11) NOT NULL AUTO_INCREMENT,
  `medicine_id` int(11) DEFAULT NULL,
  `manufacture_id` int(11) DEFAULT NULL,
  `distributer_id` int(11) DEFAULT NULL,
  `pharmacy_id` int(11) DEFAULT NULL,
  `stock` varchar(100) DEFAULT NULL,
  `mfg` varchar(100) DEFAULT NULL,
  `date` varchar(100) DEFAULT NULL,
  `QR_code` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`stock_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

/*Data for the table `stock` */

insert  into `stock`(`stock_id`,`medicine_id`,`manufacture_id`,`distributer_id`,`pharmacy_id`,`stock`,`mfg`,`date`,`QR_code`) values 
(3,1,19,1,22,'95','2022-09-27','2024-09-27','static/qrcode/24.png'),
(4,1,3,0,17,'15','2022-10-04','2024-06-05',''),
(5,23,20,0,17,'10','2022-10-12','2025-10-03',''),
(6,23,20,0,17,'10','2022-10-04','2024-10-16',''),
(7,23,20,0,17,'10','2022-10-04','2024-10-16',''),
(8,23,20,0,17,'10','2022-10-04','2024-06-13',''),
(9,23,20,0,17,'10','2022-10-04','2024-06-13',''),
(10,23,20,0,17,'10','2022-10-04','2022-10-29',''),
(11,23,20,0,17,'10','2022-10-04','2022-10-29',''),
(12,23,20,0,17,'10','2022-10-04','2022-10-29',''),
(13,23,20,0,17,'10','2022-10-18','2022-10-26',''),
(14,23,20,1,17,'10','2022-10-04','2022-11-04','static/qrcode/27.png'),
(15,23,20,0,17,'10','2022-10-18','2022-10-20',''),
(16,23,20,0,17,'10','2022-10-04','2022-10-20',''),
(17,23,20,1,17,'10','2022-10-04','2022-10-27',''),
(18,28,3,1,22,'50','2022-10-08','2023-10-11',''),
(19,28,3,1,22,'50','2022-10-08','2023-10-11','static/qrcode/30.png');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `login_id` int(11) DEFAULT NULL,
  `fname` varchar(100) DEFAULT NULL,
  `lname` varchar(100) DEFAULT NULL,
  `dob` varchar(100) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `place` varchar(100) DEFAULT NULL,
  `district` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `user` */

insert  into `user`(`user_id`,`login_id`,`fname`,`lname`,`dob`,`phone`,`email`,`place`,`district`) values 
(1,12,'anju','va','05/061995','8547963214','anjuva@gmail.com','kerala','ekm'),
(2,25,'Renuka Kamath','Renuka Kamath','12/74/1275','1234567890','renukakamath2@gmail.com','fij','fzkjm');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
