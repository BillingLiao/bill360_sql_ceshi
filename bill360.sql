/*
SQLyog Ultimate v11.33 (64 bit)
MySQL - 5.7.17-log : Database - bill
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`bill` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `bill`;

/*Table structure for table `b_acceptance` */

DROP TABLE IF EXISTS `b_acceptance`;

CREATE TABLE `b_acceptance` (
  `_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `_invoice` VARCHAR(255) DEFAULT NULL COMMENT '承兑企业名称（开票企业）',
  `_core` VARCHAR(255) DEFAULT NULL COMMENT '上市主体',
  `_category` VARCHAR(255) DEFAULT NULL COMMENT '企业类别',
  `_nature` VARCHAR(255) DEFAULT NULL COMMENT '企业性质',
  `_type` INT(11) NOT NULL COMMENT '类型0-母公司、1-子公司、2-孙公司',
  `_addr` VARCHAR(255) DEFAULT NULL COMMENT '地址',
  `_area` VARCHAR(255) DEFAULT NULL COMMENT '地区',
  `_is_finish` INT(11) NOT NULL COMMENT '企业信息0-未完善、1-已完善',
  PRIMARY KEY (`_id`)
) ENGINE=INNODB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

/*Data for the table `b_acceptance` */

INSERT  INTO `b_acceptance`(`_id`,`_invoice`,`_core`,`_category`,`_nature`,`_type`,`_addr`,`_area`,`_is_finish`) VALUES (1,'恒大孙公司','恒大','合资','建筑',2,'','华北',1),(2,'恒大湖南','恒大','合资','建筑',1,'','华南',1),(3,'恒大子公司','恒大','独资','工业',1,'','华南',1),(4,'百度贴吧','百度','股份制','工业',1,'','华北',1),(5,'百度ai','百度','股份制','工业',0,'','华北',1),(6,'恒大珠三角','恒大','国有','房地产',1,'','华南',1),(7,'中兴通讯','中兴','合资','建筑',0,'','华南',1),(8,'唯品会','','','',0,'','',0);

/*Table structure for table `b_admin` */

DROP TABLE IF EXISTS `b_admin`;

CREATE TABLE `b_admin` (
  `_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `_name` VARCHAR(255) NOT NULL COMMENT '登录名',
  `_pwd` VARCHAR(255) NOT NULL COMMENT '登录密码',
  PRIMARY KEY (`_id`),
  UNIQUE KEY `name_index` (`_name`)
) ENGINE=INNODB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

/*Data for the table `b_admin` */

INSERT  INTO `b_admin`(`_id`,`_name`,`_pwd`) VALUES (1,'billman','c4644008c86ea3aaa6520b3895722fc4'),(2,'admin','0e40fb451b5f42df86ac880a57ea901f');

/*Table structure for table `b_bill` */

DROP TABLE IF EXISTS `b_bill`;

CREATE TABLE `b_bill` (
  `_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `_acceptance_id` INT(11) NOT NULL COMMENT '承兑企业id',
  `_staff_id` INT(11) NOT NULL COMMENT '对接人id',
  `_ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `_remark` VARCHAR(255) DEFAULT NULL COMMENT '备注',
  `_shortest` INT(11) DEFAULT NULL COMMENT '最短期限(收票起步天数)',
  `_longest` INT(11) DEFAULT NULL COMMENT '最长期限(收票最高天数)',
  `_is_bargain` INT(11) DEFAULT NULL COMMENT '合同0-不是、1-是',
  `_is_invoice` INT(11) DEFAULT NULL COMMENT '发票0-不是（默认）、1-是',
  `_agreement` INT(11) DEFAULT NULL COMMENT '质押协议0-否(默认)、1-是',
  `_is_moneyorback` INT(11) DEFAULT NULL COMMENT '先款先背0-先款（默认）、1-先背',
  `_is_financing` INT(11) DEFAULT NULL COMMENT '融资票0-不是（默认）、1-是',
  `_is_clean` INT(11) DEFAULT NULL COMMENT '光票0-不是（默认）、1-是',
  `_endorse_time` INT(11) DEFAULT NULL COMMENT '背书次数限制',
  `_adjuest` INT(11) DEFAULT NULL COMMENT '调整天数',
  `_rate` DECIMAL(6,2) DEFAULT '0.00' COMMENT '利率',
  `_status` INT(11) DEFAULT '0' COMMENT '状态0-正常（默认）、1-已关闭',
  `_level` INT(11) DEFAULT '0' COMMENT '优先级0-默认',
  `_total` DECIMAL(18,6) DEFAULT '0.000000' COMMENT '总额度',
  `_usable` DECIMAL(18,6) DEFAULT '0.000000' COMMENT '可用额度',
  `_max` VARCHAR(255) DEFAULT NULL COMMENT '票面最大金额（收票单张上限金额(万)）',
  `_min` DECIMAL(18,6) DEFAULT '0.000000' COMMENT '最小金额(收票单张起步金额(万))',
  `_offer` VARCHAR(255) DEFAULT NULL COMMENT '报价方式',
  `_deductions` DECIMAL(14,2) DEFAULT NULL COMMENT '每十万扣费',
  `_direct` DECIMAL(14,2) DEFAULT NULL COMMIT '直接扣费？%',
  PRIMARY KEY (`_id`),
  KEY `FKn1qgpcitx5qm16y0ufkojlbx8` (`_acceptance_id`),
  KEY `FKqkdrjw8g779fsk2l9ot2t0lun` (`_staff_id`),
  CONSTRAINT `FKn1qgpcitx5qm16y0ufkojlbx8` FOREIGN KEY (`_acceptance_id`) REFERENCES `b_acceptance` (`_id`),
  CONSTRAINT `FKqkdrjw8g779fsk2l9ot2t0lun` FOREIGN KEY (`_staff_id`) REFERENCES `b_staff` (`_id`)
) ENGINE=INNODB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

/*Data for the table `b_bill` */

INSERT  INTO `b_bill`(`_id`,`_acceptance_id`,`_staff_id`,`_ctime`,`_remark`,`_shortest`,`_longest`,`_is_bargain`,`_is_invoice`,`_agreement`,`_is_moneyorback`,`_is_financing`,`_is_clean`,`_endorse_time`,`_adjuest`,`_rate`,`_status`,`_level`,`_total`,`_usable`,`_max`,`_min`,`_offer`,`_deductions`) VALUES (1,5,1,'2018-02-01 14:56:55','woiei',100,360,0,0,0,0,0,0,1,3,'7.00',0,3,'5000000.000000','120.230000','500000.00','10000.000000','年化',NULL),(3,3,1,'2018-02-01 15:06:00','wefa',125,360,0,0,0,0,0,0,3,4,'0.60',0,5,'78964400.000000','1254.630000','3652000.00','20000.000000','年化',NULL),(4,1,1,'2018-05-16 18:07:51','test',111,360,1,1,0,0,0,1,1,1,'8.00',0,3,'11.000000','111.000000','11.00','11.000000','年化',NULL),(5,7,1,'2018-05-16 18:10:56','test测试',111,360,1,1,0,1,0,1,2,2,'8.00',0,2,'1123.000000','1.000000','111.00','1.000000','年化',NULL),(6,6,1,'2018-05-19 14:47:55','test',200,360,1,0,0,0,0,0,1,2,'8.00',0,0,NULL,NULL,'541251.00','13341.000000','年化',NULL);

/*Table structure for table `b_card` */

DROP TABLE IF EXISTS `b_card`;

CREATE TABLE `b_card` (
  `_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `_addr` VARCHAR(255) DEFAULT NULL COMMENT '地址',
  `_company` VARCHAR(255) DEFAULT NULL COMMENT '公司名称',
  `_name` VARCHAR(255) NOT NULL COMMENT '姓名',
  `_phone` VARCHAR(13) DEFAULT NULL COMMENT '手机',
  `_tel` VARCHAR(20) DEFAULT NULL COMMENT '固话',
  `_user_id` INT(11) NOT NULL COMMENT '用户id',
  PRIMARY KEY (`_id`),
  UNIQUE KEY `user_index` (`_user_id`),
  CONSTRAINT `FK6hwvo6ucebbkcmpq2r59m38no` FOREIGN KEY (`_user_id`) REFERENCES `b_user` (`_id`)
) ENGINE=INNODB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

/*Data for the table `b_card` */

INSERT  INTO `b_card`(`_id`,`_addr`,`_company`,`_name`,`_phone`,`_tel`,`_user_id`) VALUES (1,'测试地址A','测试公司A','特斯拉','15012341234','12345678',1),(4,'广州大学城厄23123123','广州闻喜信息科技有限公司','卢磊','18620810370','28107743',3),(5,'狗市','刚刚','奔奔','15999931712','966',5),(6,'测试地址0319','测试公司0319','测试用户01','15088888888','12345678',6),(7,'com','wxkj','鞠婧祎','13111122222','4483855',9),(8,NULL,'大象慧云信息技术有限公司','王娜','13011805177',NULL,11),(9,'gz','www','芝芝','13111122222','4483855',12),(10,'gz','albb','东方','13111122222','4483855',18),(11,'广州大学城','广州闻喜信息科技有限公司','陆磊','18620810370','02028107743',23);

/*Table structure for table `b_constant` */

DROP TABLE IF EXISTS `b_constant`;

CREATE TABLE `b_constant` (
  `_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `_name` VARCHAR(255) NOT NULL COMMENT '常量名',
  `_remark` VARCHAR(255) DEFAULT NULL COMMENT '常量名',
  `_value` VARCHAR(255) NOT NULL COMMENT '常量值',
  PRIMARY KEY (`_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

/*Data for the table `b_constant` */

/*Table structure for table `b_datadic` */

DROP TABLE IF EXISTS `b_datadic`;

CREATE TABLE `b_datadic` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `data_Dic_Name` VARCHAR(255) DEFAULT NULL COMMENT '数据字典名',
  `data_Dic_Value` VARCHAR(255) DEFAULT NULL COMMENT '数据字典值',
  PRIMARY KEY (`id`),
  KEY `FK_b_datadic` (`data_Dic_Value`)
) ENGINE=INNODB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `b_datadic` */

INSERT  INTO `b_datadic`(`id`,`data_Dic_Name`,`data_Dic_Value`) VALUES (1,'企业类别','国有'),(2,'企业类别','股份制'),(3,'企业类别','合资'),(4,'企业类别','独资'),(5,'企业性质','房地产'),(6,'企业性质','建筑'),(7,'企业性质','工业');

/*Table structure for table `b_inventory` */

DROP TABLE IF EXISTS `b_inventory`;

CREATE TABLE `b_inventory` (
  `_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `_user_id` INT(11) DEFAULT NULL COMMENT '用户id',
  `_userbyadmin_id` INT(11) DEFAULT NULL COMMENT '管理员建用户id',
  `_company` VARCHAR(255) NOT NULL COMMENT '开票企业名称',
  `_img_front` VARCHAR(255) NOT NULL COMMENT '商票正面',
  `_img_back` VARCHAR(255) DEFAULT NULL COMMENT '背书面',
  `_money` DECIMAL(18,6) NOT NULL DEFAULT '0.000000' COMMENT '金额（万）',
  `_ctime` VARCHAR(255) NOT NULL COMMENT '出票日期',
  `_dtime` VARCHAR(255) NOT NULL COMMENT '到期日期',
  `_ttime` VARCHAR(255) DEFAULT NULL COMMENT '贴现日',
  `_offer` VARCHAR(255) DEFAULT NULL COMMENT '接受价额',
  PRIMARY KEY (`_id`),
  KEY `FKib2f8yto8m3t5xe0jbf8ggj2c` (`_user_id`),
  KEY `FKhlr0sayke0cl3nfkukkunwg7o` (`_userbyadmin_id`),
  CONSTRAINT `FKhlr0sayke0cl3nfkukkunwg7o` FOREIGN KEY (`_userbyadmin_id`) REFERENCES `b_userbyadmin` (`id`),
  CONSTRAINT `FKib2f8yto8m3t5xe0jbf8ggj2c` FOREIGN KEY (`_user_id`) REFERENCES `b_user` (`_id`)
) ENGINE=INNODB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `b_inventory` */

INSERT  INTO `b_inventory`(`_id`,`_user_id`,`_userbyadmin_id`,`_company`,`_img_front`,`_img_back`,`_money`,`_ctime`,`_dtime`,`_ttime`,`_offer`) VALUES (1,1,NULL,'百度','default.jpg','default.jpg','21.101241','2018-01-01','2018-12-30','2018-07-01','1'),(2,5,NULL,'恒大孙公司','no1.jpg','default.jpg','5633.000000','','2018-09-30','2018-01-25','按票面'),(3,3,NULL,'唯品会','1.jpg','default.jpg','12.250000','2017-04-01','2018-09-30','2018-01-25','按票面');

/*Table structure for table `b_order` */

DROP TABLE IF EXISTS `b_order`;

CREATE TABLE `b_order` (
  `_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `_ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `_day` INT(11) NOT NULL DEFAULT '0' COMMENT '计息天数',
  `_img` VARCHAR(255) NOT NULL COMMENT '商票照片',
  `_interest` DECIMAL(14,2) NOT NULL DEFAULT '0.00' COMMENT '保理利息',
  `_money` DECIMAL(14,2) NOT NULL DEFAULT '0.00' COMMENT '保理金额',
  `_status` INT(11) NOT NULL DEFAULT '0' COMMENT '状态0-处理中、1-已处理、2-被驳回',
  `_stime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '处理时间（如果未处理则和创建时间一致）',
  `_subsidy` DECIMAL(14,2) NOT NULL DEFAULT '0.00' COMMENT '保理金额',
  `_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '到期时间',
  `_bill_id` INT(11) NOT NULL COMMENT '票据id',
  `_user_id` INT(11) NOT NULL COMMENT '用户id',
  PRIMARY KEY (`_id`),
  KEY `FKh8oupea67ovk6jvn2wpev721n` (`_bill_id`),
  KEY `FKnpe7fqxvbcwtc2dtu72paeup2` (`_user_id`),
  CONSTRAINT `FKh8oupea67ovk6jvn2wpev721n` FOREIGN KEY (`_bill_id`) REFERENCES `b_bill` (`_id`),
  CONSTRAINT `FKnpe7fqxvbcwtc2dtu72paeup2` FOREIGN KEY (`_user_id`) REFERENCES `b_user` (`_id`)
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

/*Data for the table `b_order` */

INSERT  INTO `b_order`(`_id`,`_ctime`,`_day`, `_img`, `_interest`,`_money`,`_status`,`_stime`,`_subsidy`,`_time`,`_bill_id`,`_user_id`) VALUES 
(1,'2018-05-30 14:04:22',368,'f9f40c4f-5274-4b8d-a005-4676efe8f03715275766600773.jpg','14311.12','200000.00',0,'2018-05-22 16:04:22','10000.00','2019-05-22 16:04:22',1,1);

/*Table structure for table `b_pwd` */

DROP TABLE IF EXISTS `b_pwd`;

CREATE TABLE `b_pwd` (
  `_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `_openid` VARCHAR(255) NOT NULL COMMENT '微信openid',
  `_phone` VARCHAR(13) DEFAULT NULL COMMENT '手机号',
  `_user_id` INT(11) NOT NULL COMMENT '用户id',
  PRIMARY KEY (`_id`),
  UNIQUE KEY `user_index` (`_user_id`),
  UNIQUE KEY `openid_index` (`_openid`),
  CONSTRAINT `FK8lg9rfou6e23fayfyqjid6hyp` FOREIGN KEY (`_user_id`) REFERENCES `b_user` (`_id`)
) ENGINE=INNODB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4;

/*Data for the table `b_pwd` */

INSERT  INTO `b_pwd`(`_id`,`_openid`,`_phone`,`_user_id`) VALUES (1,'test','13888888888',1),(2,'wx0d576ce5f10b4260',NULL,2),(3,'','17612085835',3),(4,'ov0Dq0ODwMS2NE4tUVsEmu6eIuSQ',NULL,4),(5,'null','18775949831',5),(6,'slience','13888888889',6),(9,'olxjW5QP5skqa5IeoPBX2VxdT9zo','17665126221',9),(10,'olxjW5c_bk_6mAzFpgyDYD4z1zaw',NULL,10),(11,'olxjW5bjUoAeesx-HfpQd72BOEuw',NULL,11),(12,'olxjW5R4T2J_NSKDwFvCdSD2fnHw',NULL,12),(13,'olxjW5SQHP7xPodkAh74TJtpacMA',NULL,13),(14,'olxjW5TMYxcCYDW2aXKQyEbN0LM4',NULL,14),(15,'olxjW5ZqLx8s6u9wU1tutUImDxqw',NULL,15),(16,'olxjW5WPeQL4GbO-vl7vI5m0Q3bw',NULL,16),(17,'olxjW5VwUQ7Qqj0Y8hqp-CBANaD8',NULL,17),(18,'olxjW5ctxtP9-v7_F6g1wkpnEmvQ',NULL,18),(19,'olxjW5RKHzwgKLMUvqtPpb9JHd4g',NULL,19),(20,'olxjW5Xcd7PFM8FXBUdifUKKZNhU',NULL,20),(21,'olxjW5aMd1uOyvYb-ZqB9J33Iqus',NULL,21),(22,'olxjW5XOhNTgg-8cZ479sI9DkPnA',NULL,22),(23,'olxjW5ZNRGiPvG--QPku_e4QS7W4','18620810370',23),(24,'olxjW5YRzYQW9c2H9rz42HlVRclg',NULL,24),(25,'olxjW5cmAQdYbX8ckbFdMH6qxlfQ',NULL,25),(26,'olxjW5SbMGRNQlHMhMGIRHqTehVU',NULL,26),(27,'olxjW5c7_Ia1H49G1LBdgqkACYOw',NULL,27),(28,'olxjW5ST8Pt6QUf-6wL36v_1w4RA',NULL,28),(29,'olxjW5fURREHlu0ZgRLRQuJPkEus',NULL,29),(30,'olxjW5ZoWwsv1oSNJWvTl7pK1O5g',NULL,30),(31,'olxjW5S-KDSxpC-VgRuVej1UDjWw',NULL,31),(32,'olxjW5QYBA49jUKHHnXoDhXWfaDY',NULL,32),(33,'olxjW5U0fou5a6WAkr9YL9rX4P7E',NULL,33),(34,'olxjW5XeZ068lqZ1TIJZThXh8CGQ',NULL,34),(35,'olxjW5Qvp6xpSAsEuq5vdjOnBZXw',NULL,35);

/*Table structure for table `b_record` */

DROP TABLE IF EXISTS `b_record`;

CREATE TABLE `b_record` (
  `_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `_word` VARCHAR(255) NOT NULL COMMENT '查询关键字',
  `_user_id` INT(11) NOT NULL COMMENT '用户id',
  PRIMARY KEY (`_id`),
  KEY `FKspd5skq6u21ilsrxfs8dtiw36` (`_user_id`),
  CONSTRAINT `FKspd5skq6u21ilsrxfs8dtiw36` FOREIGN KEY (`_user_id`) REFERENCES `b_user` (`_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

/*Data for the table `b_record` */

/*Table structure for table `b_staff` */

DROP TABLE IF EXISTS `b_staff`;

CREATE TABLE `b_staff` (
  `_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `_name` VARCHAR(255) NOT NULL COMMENT '对接人姓名',
  `_company` VARCHAR(255) NOT NULL COMMENT '公司',
  `_endorse_company` VARCHAR(255) DEFAULT NULL COMMENT '背书公司名',
  `_endorse_account` VARCHAR(255) DEFAULT NULL COMMENT '背书账号',
  `_phone` VARCHAR(255) DEFAULT NULL COMMENT '联系电话',
  `_wechat` VARCHAR(255) DEFAULT NULL COMMENT '微信id',
  `_addr` VARCHAR(255) DEFAULT NULL COMMENT '地址',
  `_area` VARCHAR(255) DEFAULT NULL COMMENT '地区',
  `_business_license` VARCHAR(255) DEFAULT NULL COMMENT '营业执照号',
  `_business_license_photo` VARCHAR(255) DEFAULT NULL COMMENT '营业执照（照片）',
  `_legal_person_name` VARCHAR(255) DEFAULT NULL COMMENT '法人姓名',
  `_id_card_back` VARCHAR(255) DEFAULT NULL COMMENT '法人身份证(反面)',
  `_id_card_front` VARCHAR(255) DEFAULT NULL COMMENT '法人身份证(正面)',
  PRIMARY KEY (`_id`)
) ENGINE=INNODB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4;

/*Data for the table `b_staff` */

INSERT  INTO `b_staff`(`_id`,`_name`,`_company`,`_endorse_account`,`_phone`,`_addr`) VALUES (1,'定韬1','优点尚1','12541554224','13436541235','广州市番禺区1'),(3,'傲宝马','america','387429','13456466542','U.S.A'),(4,'李四','恒大','42654114444','15512456541','广州市天河区'),(5,'王五','优点尚','12541554224','14536541235','广州市番禺区'),(6,'张六','快手','42654114444','15512456541','广州市天河区'),(7,'离奇','优点尚','12541554224','14536541235','广州市番禺区'),(8,'李里报','抖音','42654114444','15512456541','广州市天河区'),(9,'红红','优点尚','12541554224','14536541235','广州市番禺区'),(10,'李思溪','淘宝','42654114444','15512456541','广州市天河区'),(11,'张六炮','优点尚','12541554224','14536541235','广州市番禺区'),(12,'赵倩','阿里巴巴','42654114444','15512456541','广州市天河区'),(13,'前锋','优点尚','12541554224','14536541235','广州市番禺区'),(14,'欠奉','腾讯','42654114444','15512456541','广州市天河区'),(15,'吴韬','优点尚','12541554224','14536541235','广州市番禺区'),(16,'乌基奇','天美工作室','42654114444','15512456541','广州市天河区'),(17,'吴吉吉','优点尚','12541554224','14536541235','广州市番禺区'),(18,'李大炮','yoho','42654114444','15512456541','广州市天河区'),(19,'增小鸟','yoho','42654114444','15512456541','广州市天河区'),(20,'田一发','优点尚','12541554224','14536541235','广州市番禺区'),(21,'田连发','yoho','42654114444','15512456541','广州市天河区'),(22,'kdj','2132','135452145514','13645214125','d11'),(23,'吴沃','测试公司','135452145514','13654126589',NULL),(24,'五五','送送','46684','13654985654','广州市天河区');

/*Table structure for table `b_user` */

DROP TABLE IF EXISTS `b_user`;

CREATE TABLE `b_user` (
  `_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `_card` INT(11) NOT NULL DEFAULT '0' COMMENT '是否上传了名片0-未上传、1-已上传',
  `_head` VARCHAR(255) NOT NULL DEFAULT 'user-head.png' COMMENT '用户头像',
  `_name` VARCHAR(255) NOT NULL DEFAULT '查票360' COMMENT '用户名-微信昵称',
  `_precise` INT(11) NOT NULL DEFAULT '0' COMMENT '精确搜索次数',
  `_reg` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `_status` INT(11) NOT NULL DEFAULT '0' COMMENT '用户状态0-正常（默认）、1-管理员锁定',
  `_type` INT(11) NOT NULL DEFAULT '0' COMMENT '用户类型0-未绑定手机、1-已绑定手机',
  PRIMARY KEY (`_id`)
) ENGINE=INNODB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4;

/*Data for the table `b_user` */

INSERT  INTO `b_user`(`_id`,`_card`,`_head`,`_name`,`_precise`,`_reg`,`_status`,`_type`) VALUES (1,1,'user-head.png','查票360',0,'2018-02-01 15:15:32',0,0),(2,0,'user-head.png','查票360',0,'2018-02-26 16:18:55',0,0),(3,1,'user-head.png','查票360',5,'2018-02-27 16:25:35',0,0),(4,0,'user-head.png','查票360',1,'2018-02-28 09:57:52',0,0),(5,1,'user-head.png','查票360',5,'2018-03-05 16:16:59',0,0),(6,1,'user-head.png','查票360',0,'2018-03-16 09:48:47',0,0),(9,1,'13e5433e-f25b-4e7f-bcd2-75b7634fd4c51521535281982.jpg','ARLEN?',4,'2018-03-20 16:41:22',0,0),(10,0,'f702caff-4a12-4609-a4e8-eb202178b3d21521613804669.jpg','™瘾℡',0,'2018-03-21 14:30:04',0,0),(11,1,'36cad4ba-9efc-458c-b22a-8cba9bf7d8e21521699787231.jpg','娜娜',0,'2018-03-22 14:23:07',0,0),(12,1,'69162e40-4af1-452e-84f4-18f3242199ca1521722614386.jpg','守望者',3,'2018-03-22 20:43:34',0,0),(13,0,'27966990-a4a3-43f8-b419-3ed3a1353e811521777652904.jpg','Dennis张德智',5,'2018-03-23 12:00:53',0,0),(14,0,'user-head.png','rdgztest_HYKEMQ',0,'2018-03-24 01:12:10',0,0),(15,0,'user-head.png','rdgztest_HJVTQF',0,'2018-03-24 10:07:53',0,0),(16,0,'user-head.png','rdgztest_VPOJJJ',0,'2018-03-24 10:07:54',0,0),(17,0,'user-head.png','rdgztest_JVFHTH',0,'2018-03-24 10:07:56',0,0),(18,1,'94b42798-e5e9-408d-931d-2b09fdfcee871521859775435.jpg','你说什么名字咧',5,'2018-03-24 10:49:35',0,0),(19,0,'11ede584-7fd9-4219-91d4-34ed06acc1da1522023294310.jpg','Boom(李定韬)',0,'2018-03-26 08:14:54',0,0),(20,0,'57be8acd-c30a-47e5-a41d-81f9614d37a91522057382779.jpg','悲伤中的沉默',0,'2018-03-26 17:43:02',0,0),(21,0,'23335031-3c01-4554-9ed3-3efad7df5d541522072412591.jpg','A.张老板',0,'2018-03-26 21:53:32',0,0),(22,0,'user-head.png','rdgztest_ZEZUBE',0,'2018-03-27 03:43:25',0,0),(23,1,'59c17590-853f-4435-9979-0b1a5d2ba7611522117225841.jpg','All-App开发',0,'2018-03-27 10:20:26',0,1),(24,0,'a302ac8d-5d02-48a3-a666-977115508ebb1522128313825.jpg','Sandy',0,'2018-03-27 13:25:14',0,0),(25,0,'b2e23c82-a6ad-4db9-89ba-80aa669dfcdb1522133250950.jpg','夸克',0,'2018-03-27 14:47:31',0,0),(26,0,'user-head.png','rdgztest_DWOMTK',0,'2018-03-27 19:14:58',0,0),(27,0,'de42803f-46b6-4d6c-9c4a-4937be8c4fd31522200305353.jpg','乔伊悦',0,'2018-03-28 09:25:05',0,0),(28,0,'a37aba53-4c06-4e6c-bf1d-0b60536a70fd1522304202071.jpg','热爱生活，拥抱人生',0,'2018-03-29 14:16:42',0,0),(29,0,'7d3b0884-e20e-40b1-98e9-5021786e934d1522313163556.jpg','哥こ的小脾气う',0,'2018-03-29 16:46:03',0,0),(30,0,'7e3821e6-bebf-440a-9527-89ac0965f83e1522336867509.jpg','乄古→玩?',0,'2018-03-29 23:21:07',0,0),(31,0,'53f516df-e9be-4ca4-bc8b-f0d8ac6695891522367152056.jpg','　',0,'2018-03-30 07:45:52',0,0),(32,0,'000d2bde-f104-4b0d-a714-4abc8511a7921522432816573.jpg','miss  u',0,'2018-03-31 02:00:16',0,0),(33,0,'8b37fbfe-e75a-4fa9-b8f8-54f950873af31522468380963.jpg','Anne',0,'2018-03-31 11:53:01',0,0),(34,0,'47104615-55fe-40d0-b027-bbf8ad80fd1d1522633456056.jpg','Donte(定韬)',0,'2018-04-02 09:44:16',0,0),(35,0,'a9ec3d0c-92e0-4807-bdb5-2ce606eb9a111522640368837.jpg','L',0,'2018-04-02 11:39:29',0,0);

/*Table structure for table `b_userbyadmin` */

DROP TABLE IF EXISTS `b_userbyadmin`;

CREATE TABLE `b_userbyadmin` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `addr` VARCHAR(255) DEFAULT NULL COMMENT '地址',
  `company` VARCHAR(255) DEFAULT NULL COMMENT '公司名称',
  `name` VARCHAR(255) NOT NULL COMMENT '姓名',
  `phone` VARCHAR(13) DEFAULT NULL COMMENT '手机',
  `wechat` VARCHAR(255) DEFAULT NULL COMMENT '微信号',
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `b_userbyadmin` */

INSERT  INTO `b_userbyadmin`(`id`,`addr`,`company`,`name`,`phone`,`wechat`) VALUES (1,'广州市','广之旅','张生','13546311254','20124400'),(2,'广州市天河区1','yoho1','李里1','13312456541','236411'),(3,'深圳','zhu','朱龙陵','15012354512',NULL),(5,'地方','都放假回家','李刚','13645212365','的');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
