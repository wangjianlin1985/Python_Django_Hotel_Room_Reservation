/*
 Navicat Premium Data Transfer

 Source Server         : mysql5.6
 Source Server Type    : MySQL
 Source Server Version : 50620
 Source Host           : localhost:3306
 Source Schema         : room_order_db

 Target Server Type    : MySQL
 Target Server Version : 50620
 File Encoding         : 65001

 Date: 04/04/2021 15:16:48
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_admin
-- ----------------------------
DROP TABLE IF EXISTS `t_admin`;
CREATE TABLE `t_admin`  (
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `t_admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for t_bookorder
-- ----------------------------
DROP TABLE IF EXISTS `t_bookorder`;
CREATE TABLE `t_bookorder`  (
  `orderId` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `roomObj` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '预订房间',
  `liveDate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '入住日期',
  `leaveDate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '离开日期',
  `totalMoney` float NOT NULL COMMENT '订单总价',
  `orderState` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单状态',
  `orderMemo` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单备注',
  `userObj` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '预订人',
  `telephone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '联系电话',
  `orderTime` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预订时间',
  PRIMARY KEY (`orderId`) USING BTREE,
  INDEX `roomObj`(`roomObj`) USING BTREE,
  INDEX `userObj`(`userObj`) USING BTREE,
  CONSTRAINT `t_bookorder_ibfk_1` FOREIGN KEY (`roomObj`) REFERENCES `t_room` (`roomNo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_bookorder_ibfk_2` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_bookorder
-- ----------------------------
INSERT INTO `t_bookorder` VALUES (2, '202', '2021-04-16', '2021-04-18', 704, '已支付', '我和女朋友要来旅游，入住2晚', 'user2', '13508121234', '2021-04-04 14:22:33');
INSERT INTO `t_bookorder` VALUES (3, '205', '2021-04-22', '2021-04-23', 299, '待支付', '出差需要住一晚', 'user1', '13590129342', '2021-04-04 15:07:25');

-- ----------------------------
-- Table structure for t_leaveword
-- ----------------------------
DROP TABLE IF EXISTS `t_leaveword`;
CREATE TABLE `t_leaveword`  (
  `leaveWordId` int(11) NOT NULL AUTO_INCREMENT COMMENT '留言id',
  `leaveTitle` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '留言标题',
  `leaveContent` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '留言内容',
  `userObj` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '留言人',
  `leaveTime` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '留言时间',
  `replyContent` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '管理回复',
  `replyTime` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '回复时间',
  PRIMARY KEY (`leaveWordId`) USING BTREE,
  INDEX `userObj`(`userObj`) USING BTREE,
  CONSTRAINT `t_leaveword_ibfk_1` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_leaveword
-- ----------------------------
INSERT INTO `t_leaveword` VALUES (1, '管理员好啊，你们酒店在哪里啊', '我想和女朋友去成都旅游，可以预定吗', 'user1', '2021-04-04 10:45:23', '我们就在成都，来吧！', '2021-04-04 10:45:29');
INSERT INTO `t_leaveword` VALUES (2, 'aaaa', 'bbbbb', 'user3', '2021-04-04 15:01:09', 'dddddd', '2021-04-04 15:01:12');

-- ----------------------------
-- Table structure for t_notice
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice`  (
  `noticeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告id',
  `title` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `content` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公告内容',
  `hitNum` int(11) NOT NULL COMMENT '点击率',
  `publishDate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`noticeId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_notice
-- ----------------------------
INSERT INTO `t_notice` VALUES (1, '酒店客房预定网成立了', '<p>朋友们需要预定房间可以来我们网站，带放时间冲突验证的哦！</p>', 2, '2021-04-04 10:45:39');

-- ----------------------------
-- Table structure for t_room
-- ----------------------------
DROP TABLE IF EXISTS `t_room`;
CREATE TABLE `t_room`  (
  `roomNo` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'roomNo',
  `roomTypeObj` int(11) NOT NULL COMMENT '房间类型',
  `roomPhoto` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '房间图片',
  `roomPrice` float NOT NULL COMMENT '价格(每天)',
  `floorNum` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '楼层',
  `area` float NOT NULL COMMENT '面积',
  `roomDesc` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '房间描述',
  PRIMARY KEY (`roomNo`) USING BTREE,
  INDEX `roomTypeObj`(`roomTypeObj`) USING BTREE,
  CONSTRAINT `t_room_ibfk_1` FOREIGN KEY (`roomTypeObj`) REFERENCES `t_roomtype` (`roomTypeId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_room
-- ----------------------------
INSERT INTO `t_room` VALUES ('103', 2, 'img/room2.jpg', 428, '3', 52, '<p><span style=\"color: #2c3e50; font-family: \'Microsoft YaHei\'; background-color: #f9f9f9;\">吃货们来到成都吃当然是重要的啦 好啦这些都是周边的美食！</span><br style=\"color: #2c3e50; font-family: \'Microsoft YaHei\'; background-color: #f9f9f9;\" /><span style=\"color: #2c3e50; font-family: \'Microsoft YaHei\'; background-color: #f9f9f9;\">楼下就是龙湖天街，吃的非常多，吃完了就可以去旁边金牛万达逛街啦，下楼步行300米就是人民北路地铁口B站，去玩也是非常方便。如果看熊猫的话，旁边文殊院也有直达车，简直不要太幸福~</span></p>');
INSERT INTO `t_room` VALUES ('202', 1, 'img/room1.jpg', 352, '3', 45, '<h4 style=\"margin: 0px; padding: 0px; font-size: 24px; font-weight: normal; line-height: 26px; color: #2c3e50; font-family: \'Microsoft YaHei\'; background-color: #f5f5f5;\"><span style=\"font-size: 14px; background-color: #ffffff;\">位于航空港，近机场川大，打车10分钟可达机场，20分钟可达环球中心、时代奥特莱斯、海滨城，30分钟可达锦里、太古里、黄龙溪古镇。也可选择公交地铁出行，91、121直达火车东站，途经南站宜家、锦华路伊藤等；806、816可到双流；804到石羊场公交站，转车可到欢乐谷；548可到时代奥特莱斯、海滨城；304到火车南站，转车可到熊猫基地；s18直达黄龙溪。近华兴地铁站，到各景点更便捷。另外，去乐山，峨眉山也十分方便，在机场乘坐高铁1小时可达。</span></h4>');
INSERT INTO `t_room` VALUES ('205', 3, 'img/room3.jpg', 299, '2', 28, '<ul class=\"pt_list clearfix\" style=\"margin: 0px; padding: 0px; list-style: outside none none; color: #2c3e50; font-family: \'Microsoft YaHei\';\">\r\n<li class=\"s_ico_shower\" style=\"margin: 0px 0px 12px; padding: 0px 0px 0px 30px; background: url(\'http://jci.xiaozhustatic1.com/e20210329/images/detail/sprice.png\') 0px -850px no-repeat; float: left; height: 21px; line-height: 21px; width: 285px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;\">热水淋浴</li>\r\n<li class=\"s_ico_wirelessnetwork\" style=\"margin: 0px 0px 12px; padding: 0px 0px 0px 30px; background: url(\'http://jci.xiaozhustatic1.com/e20210329/images/detail/sprice.png\') 0px -1056px no-repeat; float: left; height: 21px; line-height: 21px; width: 285px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;\">无线网络</li>\r\n<li class=\"s_ico_aircondition\" style=\"margin: 0px 0px 12px; padding: 0px 0px 0px 30px; background: url(\'http://jci.xiaozhustatic1.com/e20210329/images/detail/sprice.png\') 0px -934px no-repeat; float: left; height: 21px; line-height: 21px; width: 285px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;\">空调</li>\r\n<li class=\"s_ico_elevator\" style=\"margin: 0px 0px 12px; padding: 0px 0px 0px 30px; background: url(\'http://jci.xiaozhustatic1.com/e20210329/images/detail/sprice.png\') 0px -1132px no-repeat; float: left; height: 21px; line-height: 21px; width: 285px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;\">电梯</li>\r\n<li class=\"s_ico_accesssys\" style=\"margin: 0px 0px 12px; padding: 0px 0px 0px 30px; background: url(\'http://jci.xiaozhustatic1.com/e20210329/images/detail/sprice.png\') 0px -1164px no-repeat; float: left; height: 21px; line-height: 21px; width: 285px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;\">门禁系统</li>\r\n<li class=\"s_ico_washer\" style=\"margin: 0px 0px 12px; padding: 0px 0px 0px 30px; background: url(\'http://jci.xiaozhustatic1.com/e20210329/images/detail/sprice.png\') 0px -964px no-repeat; float: left; height: 21px; line-height: 21px; width: 285px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;\">洗衣机</li>\r\n<li class=\"s_ico_drinking\" style=\"margin: 0px 0px 12px; padding: 0px 0px 0px 30px; background: url(\'http://jci.xiaozhustatic1.com/e20210329/images/detail/sprice.png\') 0px -1025px no-repeat; float: left; height: 21px; line-height: 21px; width: 285px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;\">饮水设备</li>\r\n<li class=\"s_ico_slippers\" style=\"margin: 0px 0px 12px; padding: 0px 0px 0px 30px; background: url(\'http://jci.xiaozhustatic1.com/e20210329/images/detail/sprice.png\') 0px -822px no-repeat; float: left; height: 21px; line-height: 21px; width: 285px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;\">拖鞋</li>\r\n<li class=\"s_ico_toiletpaper\" style=\"margin: 0px 0px 12px; padding: 0px 0px 0px 30px; background: url(\'http://jci.xiaozhustatic1.com/e20210329/images/detail/sprice.png\') 0px -793px no-repeat; float: left; height: 21px; line-height: 21px; width: 285px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;\">手纸</li>\r\n<li class=\"s_ico_brush\" style=\"margin: 0px 0px 12px; padding: 0px 0px 0px 30px; background: url(\'http://jci.xiaozhustatic1.com/e20210329/images/detail/sprice.png\') 0px -682px no-repeat; float: left; height: 21px; line-height: 21px; width: 285px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;\">牙具</li>\r\n<li class=\"s_ico_toiletries\" style=\"margin: 0px 0px 12px; padding: 0px 0px 0px 30px; background: url(\'http://jci.xiaozhustatic1.com/e20210329/images/detail/sprice.png\') 0px -763px no-repeat; float: left; height: 21px; line-height: 21px; width: 285px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;\">浴液 洗发水</li>\r\n<li class=\"s_ico_soap\" style=\"margin: 0px 0px 12px; padding: 0px 0px 0px 30px; background: url(\'http://jci.xiaozhustatic1.com/e20210329/images/detail/sprice.png\') 0px -710px no-repeat; float: left; height: 21px; line-height: 21px; width: 285px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;\">香皂</li>\r\n<li class=\"s_ico_suitableforinfant\" style=\"margin: 0px 0px 12px; padding: 0px 0px 0px 30px; float: left; height: 21px; line-height: 21px; width: 285px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;\">适宜婴幼儿</li>\r\n<li class=\"s_ico_suitableforchildren\" style=\"margin: 0px 0px 12px; padding: 0px 0px 0px 30px; background: url(\'http://jci.xiaozhustatic1.com/e20210329/images/pubsysV2/icon_children.png\') no-repeat; float: left; height: 21px; line-height: 21px; width: 285px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;\">适宜儿童</li>\r\n</ul>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;<br /><br /></p>');

-- ----------------------------
-- Table structure for t_roomtype
-- ----------------------------
DROP TABLE IF EXISTS `t_roomtype`;
CREATE TABLE `t_roomtype`  (
  `roomTypeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '类型id',
  `roomTypeName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '房间类型',
  `roomTypeDesc` varchar(8000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型介绍',
  PRIMARY KEY (`roomTypeId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_roomtype
-- ----------------------------
INSERT INTO `t_roomtype` VALUES (1, '豪华情侣间', '<p>给情侣使用的！</p>');
INSERT INTO `t_roomtype` VALUES (2, '标准双人间', '<p>提供wifi,电视，空调</p>');
INSERT INTO `t_roomtype` VALUES (3, '精品单人间', '<p>独享私人空间</p>');

-- ----------------------------
-- Table structure for t_userinfo
-- ----------------------------
DROP TABLE IF EXISTS `t_userinfo`;
CREATE TABLE `t_userinfo`  (
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'user_name',
  `password` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登录密码',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `gender` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '性别',
  `userPhoto` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户照片',
  `birthDate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出生日期',
  `cardNumber` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '身份证号',
  `telephone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '邮箱',
  `address` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '家庭地址',
  `regTime` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '注册时间',
  PRIMARY KEY (`user_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_userinfo
-- ----------------------------
INSERT INTO `t_userinfo` VALUES ('user1', '123', '王天宝', '男', 'img/3.jpg', '2021-04-06', '513030199611202988', '13508083908', 'xiaoteng@126.com', '四川成都春熙路', '2021-04-04 10:43:11');
INSERT INTO `t_userinfo` VALUES ('user2', '123', '张晓婷', '女', 'img/1.jpg', '2021-04-02', '513030199611201293', '13058129342', 'tesat@163.com', '四川成都红星路', '2021-04-02 11:04:48');
INSERT INTO `t_userinfo` VALUES ('user3', '123', '李小双', '女', 'img/14.jpg', '2021-04-08', '513030199611202988', '13508102342', 'dashen@126.com', '四川成都红星路5号', '2021-04-04 11:04:48');

SET FOREIGN_KEY_CHECKS = 1;
