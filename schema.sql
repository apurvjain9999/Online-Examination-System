/*
SQLyog Community Edition- MySQL GUI v5.22a
Host - 5.0.19-nt : Database - onlineexam
*********************************************************************
Server version : 5.0.19-nt
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

create database if not exists `onlineexam`;

USE `onlineexam`;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `id` varchar(100) default NULL,
  `pwd` varchar(100) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `admin` */

insert  into `admin`(`id`,`pwd`) values ('admin','admin'),('udit','10123');

/*Table structure for table `auto_id` */

DROP TABLE IF EXISTS `auto_id`;

CREATE TABLE `auto_id` (
  `form_name` varchar(100) NOT NULL,
  `prefix` varchar(50) default NULL,
  PRIMARY KEY  (`form_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `auto_id` */

insert  into `auto_id`(`form_name`,`prefix`) values ('question','Q-00009'),('student','S-00007'),('teacher','T-00006');

/*Table structure for table `exam_schedule` */

DROP TABLE IF EXISTS `exam_schedule`;

CREATE TABLE `exam_schedule` (
  `subject` varchar(100) default NULL,
  `QuesLimit` varchar(100) default NULL,
  `date` varchar(100) default NULL,
  `time` varchar(100) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `exam_schedule` */

insert  into `exam_schedule`(`subject`,`QuesLimit`,`date`,`time`) values ('JAVA','2','29-04-2011','6:00 PM to8:00 PM'),('C','5','29-04-2011','4:00 PM to6:00 PM'),('Java','2','29-04-2011','10:00 PM to 10:30 PM'),('Java','2','27-04-2011','08:00 AM to 08:00 AM'),('Java','3','30-04-2011','11:00 AM to01:00 PM');

/*Table structure for table `onlineresult` */

DROP TABLE IF EXISTS `onlineresult`;

CREATE TABLE `onlineresult` (
  `id` varchar(100) default NULL,
  `total` varchar(100) default NULL,
  `obtain` varchar(100) default NULL,
  `division` varchar(100) default NULL,
  `subject` varchar(100) default NULL,
  `date` date default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `onlineresult` */

insert  into `onlineresult`(`id`,`total`,`obtain`,`division`,`subject`,`date`) values ('admin','8','4','SECOND DIVISION','java','2011-04-30'),('admin','8','4','SECOND DIVISION','java','2011-04-30'),('admin','8','0','FAIL',NULL,'2011-04-30');

/*Table structure for table `question_master` */

DROP TABLE IF EXISTS `question_master`;

CREATE TABLE `question_master` (
  `teacher_id` varchar(100) default NULL,
  `ques_id` varchar(50) NOT NULL,
  `sub_id` varchar(50) NOT NULL,
  `question` varchar(200) NOT NULL,
  `answer` varchar(100) NOT NULL,
  `option1` varchar(100) NOT NULL,
  `option2` varchar(100) NOT NULL,
  `option3` varchar(100) NOT NULL,
  `option4` varchar(100) NOT NULL,
  `status` int(10) default '0',
  PRIMARY KEY  (`ques_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `question_master` */

insert  into `question_master`(`teacher_id`,`ques_id`,`sub_id`,`question`,`answer`,`option1`,`option2`,`option3`,`option4`,`status`) values (NULL,'Q-00006','Java','ab','a','f','a','d','d',0),(NULL,'Q-00007','Java','abc','a','ff','a','d','d',0),(NULL,'Q-00008','Java','What is Operators?','ABC','AAA','BBB','CCC','ABC',0),(NULL,'Q-00009','Java','What is Bollean Operators?','BBB','ABC','TTT','BBB','CCC',0);

/*Table structure for table `student` */

DROP TABLE IF EXISTS `student`;

CREATE TABLE `student` (
  `id` varchar(100) NOT NULL,
  `pwd` varchar(100) default NULL,
  `name` varchar(100) default NULL,
  `class` varchar(100) default NULL,
  `section` varchar(100) default NULL,
  `gender` varchar(100) default NULL,
  `dob` varchar(100) default NULL,
  `telephone` varchar(100) default NULL,
  `mobile` varchar(100) default NULL,
  `email` varchar(100) default NULL,
  `father` varchar(100) default NULL,
  `occupation` varchar(100) default NULL,
  `present` varchar(100) default NULL,
  `permanent` varchar(100) default NULL,
  `state` varchar(100) default NULL,
  `city` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `student` */

insert  into `student`(`id`,`pwd`,`name`,`class`,`section`,`gender`,`dob`,`telephone`,`mobile`,`email`,`father`,`occupation`,`present`,`permanent`,`state`,`city`) values ('admin','admin','Raju','null','A','Male','09-03-2011','01125456565','9555821757','kant975@gmail.com','NA','NA','NAaaaa',NULL,'na','Delhi'),('S-00001','123','kamalaknt','Mca','A','Male','01-02-2011','01124565545','456465465','kant975@gmail.com','Na','Na','Na','Na','Andhra Pradesh','Delhi'),('S-00003','rahul','Udit','Mca','na','Male','09-03-2011','464654654','4654646','udit217@gmail.com','na','na','na','na','New Delhi','na');

/*Table structure for table `teacher` */

DROP TABLE IF EXISTS `teacher`;

CREATE TABLE `teacher` (
  `id` varchar(100) NOT NULL,
  `pwd` varchar(100) default NULL,
  `name` varchar(100) default NULL,
  `gender` varchar(100) default NULL,
  `dob` varchar(100) default NULL,
  `telephone` varchar(100) default NULL,
  `mobile` varchar(100) default NULL,
  `course` varchar(100) default NULL,
  `email` varchar(100) default NULL,
  `father` varchar(100) default NULL,
  `occupation` varchar(100) default NULL,
  `present` varchar(100) default NULL,
  `permanent` varchar(100) default NULL,
  `state` varchar(100) default NULL,
  `city` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `teacher` */

insert  into `teacher`(`id`,`pwd`,`name`,`gender`,`dob`,`telephone`,`mobile`,`course`,`email`,`father`,`occupation`,`present`,`permanent`,`state`,`city`) values ('admin','admin','Promod Singh','Male','45689789','0112568965','0112456565','null','Promod@gmail.com','NA','NA','Uttam Nagaraaaaaaaa','Bihar','Nagaland','select'),('T-00001','Promod ','kamal','Male','16-02-2011','011111111','4565456545','na','kamal@gmail.com','Na','Na','Na','Na','na','Delhi'),('T-00002','kamal','kamal kant','Male','04-03-1986','012456545','356898989','Biology','kant975@gmail.com','DR. G.C.Sahu','Doctor','Bihar','New Delhi','New Delhi','Delhi');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
