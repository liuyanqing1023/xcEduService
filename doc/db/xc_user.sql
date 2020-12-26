
CREATE DATABASE /*!32312 IF NOT EXISTS*/`xc_user` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `xc_user`;

/*Table structure for table `oauth_access_token` */

DROP TABLE IF EXISTS `oauth_access_token`;

CREATE TABLE `oauth_access_token` (
  `token_id` varchar(256) DEFAULT NULL,
  `token` blob,
  `authentication_id` varchar(48) NOT NULL,
  `user_name` varchar(256) DEFAULT NULL,
  `client_id` varchar(256) DEFAULT NULL,
  `authentication` blob,
  `refresh_token` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`authentication_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `oauth_access_token` */

/*Table structure for table `oauth_approvals` */

DROP TABLE IF EXISTS `oauth_approvals`;

CREATE TABLE `oauth_approvals` (
  `userId` varchar(256) DEFAULT NULL,
  `clientId` varchar(256) DEFAULT NULL,
  `scope` varchar(256) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `expiresAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `lastModifiedAt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `oauth_approvals` */

/*Table structure for table `oauth_client_details` */

DROP TABLE IF EXISTS `oauth_client_details`;

CREATE TABLE `oauth_client_details` (
  `client_id` varchar(48) NOT NULL,
  `resource_ids` varchar(256) DEFAULT NULL,
  `client_secret` varchar(256) DEFAULT NULL,
  `scope` varchar(256) DEFAULT NULL,
  `authorized_grant_types` varchar(256) DEFAULT NULL,
  `web_server_redirect_uri` varchar(256) DEFAULT NULL,
  `authorities` varchar(256) DEFAULT NULL,
  `access_token_validity` int(11) DEFAULT NULL,
  `refresh_token_validity` int(11) DEFAULT NULL,
  `additional_information` varchar(4096) DEFAULT NULL,
  `autoapprove` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `oauth_client_details` */

insert  into `oauth_client_details`(`client_id`,`resource_ids`,`client_secret`,`scope`,`authorized_grant_types`,`web_server_redirect_uri`,`authorities`,`access_token_validity`,`refresh_token_validity`,`additional_information`,`autoapprove`) values ('app',NULL,'app','app','password,refresh_token',NULL,NULL,NULL,NULL,NULL,NULL),('XcWebApp',NULL,'$2a$10$9bEpZ/hWRQxyr5hn5wHUj.jxFpIrnOmBcWlE/g/0Zp3uNxt9QTh/S','app','authorization_code,password,refresh_token,client_credentials',NULL,NULL,43200,43200,NULL,NULL);

/*Table structure for table `oauth_client_token` */

DROP TABLE IF EXISTS `oauth_client_token`;

CREATE TABLE `oauth_client_token` (
  `token_id` varchar(256) DEFAULT NULL,
  `token` blob,
  `authentication_id` varchar(48) NOT NULL,
  `user_name` varchar(256) DEFAULT NULL,
  `client_id` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`authentication_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `oauth_client_token` */

/*Table structure for table `oauth_code` */

DROP TABLE IF EXISTS `oauth_code`;

CREATE TABLE `oauth_code` (
  `code` varchar(256) DEFAULT NULL,
  `authentication` blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `oauth_code` */

/*Table structure for table `oauth_refresh_token` */

DROP TABLE IF EXISTS `oauth_refresh_token`;
CREATE TABLE `oauth_refresh_token` (
  `token_id` varchar(256) DEFAULT NULL,
  `token` blob,
  `authentication` blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




#
# 用户相关表
#

#
#基础表
#

#用户表
CREATE TABLE `xc_user` (
  `id` varchar(32) NOT NULL,
  `username` varchar(45) NOT NULL COMMENT '用户名',
  `password` varchar(96) NOT NULL COMMENT '密码',
  `salt` varchar(45) DEFAULT NULL COMMENT '盐',
  `name` varchar(45) NOT NULL COMMENT '用户昵称',
  `userpic` varchar(255) DEFAULT NULL COMMENT '头像',
  `utype` varchar(32) NOT NULL COMMENT '用户类型',
  `birthday` datetime DEFAULT NULL,
  `sex` char(1) DEFAULT NULL COMMENT '性别',
  `email` varchar(45) DEFAULT NULL COMMENT '电子邮箱',
  `phone` varchar(45) DEFAULT NULL COMMENT '电话',
  `qq` varchar(32) DEFAULT NULL,
  `status` varchar(32) NOT NULL COMMENT '用户状态',
  `create_time` datetime NOT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';


#用户角色表
DROP TABLE IF EXISTS `xc_user_role`;
CREATE TABLE `xc_user_role` (
  `id` varchar(32) NOT NULL,
  `user_id` varchar(32) DEFAULT NULL COMMENT '用户ID',
  `role_id` varchar(32) DEFAULT NULL NULL COMMENT '角色ID',
  `creator` varchar(255) DEFAULT NULL,
  `status` char(1) NOT NULL  COMMIT  '状态:0-不可用,1-可用',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_xc_user_role_user_id` (`user_id`),
  KEY `fk_xc_user_role_role_id` (`role_id`),
  CONSTRAINT `fk_xc_user_role_role_id` FOREIGN KEY (`role_id`) REFERENCES `xc_role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_xc_user_role_user_id` FOREIGN KEY (`user_id`) REFERENCES `xc_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户-角色表';

#角色表
DROP TABLE IF EXISTS `xc_role`;
CREATE TABLE `xc_role` (
  `id` varchar(32) NOT NULL,
  `role_name` varchar(255) DEFAULT NULL COMMENT '角色名',
  `role_code` varchar(255) DEFAULT NULL COMMENT  '角色码',
  `description` varchar(255) DEFAULT NULL,
  `status` char(1) NOT NULL  COMMENT  '状态:0-不可用,1-可用',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_role_name` (`role_name`),
  UNIQUE KEY `unique_role_value` (`role_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8  COMMENT='角色表';

#角色-权限表
DROP TABLE IF EXISTS `xc_permission`;
CREATE TABLE `xc_permission` (
  `id` varchar(32) NOT NULL,
  `role_id` varchar(32) NOT NULL  COMMENT '角色ID',
  `menu_id` varchar(255) NOT NULL  COMMENT '权限ID',
  `status` char(1) NOT NULL  COMMIT  '状态:0-不可用,1-可用',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `xu_permission_unique` (`role_id`,`menu_id`),
  KEY `fk_xc_permission_menu_id` (`menu_id`),
  CONSTRAINT `fk_xc_permission_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `xc_menu` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_xc_permission_role_id` FOREIGN KEY (`role_id`) REFERENCES `xc_role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色-权限表';

#权限表
DROP TABLE IF EXISTS `xc_menu`;
CREATE TABLE `xc_menu` (
  `id` varchar(64) NOT NULL,
  `code` varchar(255) DEFAULT NULL COMMENT '菜单编码',
  `p_id` varchar(255) DEFAULT NULL COMMENT '父菜单ID',
  `menu_name` varchar(255) DEFAULT NULL COMMENT '名称',
  `url` varchar(255) DEFAULT NULL COMMENT '请求地址',
  `is_menu` char(1) DEFAULT NULL COMMENT '是否是菜单',
  `level` int(11) DEFAULT NULL COMMENT '菜单层级',
  `sort` int(11) DEFAULT NULL COMMENT '菜单排序',
  `status` char(1) NOT NULL  COMMENT  '状态:0-不可用,1-可用',
  `icon` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `FK_CODE` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜单表';


#
# 扩展表
#

#公司表
DROP TABLE IF EXISTS `xc_company`;
CREATE TABLE `xc_company` (
  `id` varchar(32) NOT NULL,
  `linkname` varchar(64) DEFAULT NULL COMMENT '联系人名称',
  `name` varchar(128) NOT NULL COMMENT '名称',
  `mobile` varchar(11) NOT NULL,
  `email` varchar(128) NOT NULL,
  `intro` varchar(512) DEFAULT NULL COMMENT '简介',
  `logo` varchar(128) DEFAULT NULL COMMENT 'logo',
  `identitypic` varchar(128) DEFAULT NULL COMMENT '身份证照片',
  `worktype` varchar(32) DEFAULT NULL COMMENT '工具性质',
  `businesspic` varchar(128) DEFAULT NULL COMMENT '营业执照',
  `status` varchar(32) DEFAULT NULL COMMENT '企业状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '公司表';

# 用户公司表
DROP TABLE IF EXISTS `xc_company_user`;
CREATE TABLE `xc_company_user` (
  `id` varchar(32) NOT NULL,
  `company_id` varchar(32) NOT NULL COMMENT '公司ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `xc_company_user_unique` (`company_id`,`user_id`),
  KEY `FK_xc_company_user_user_id` (`user_id`),
  CONSTRAINT `FK_xc_company_user_company_id` FOREIGN KEY (`company_id`) REFERENCES `xc_company` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_xc_company_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `xc_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8  COMMENT '用户-公司表';


#教师表, 用户表的扩展
DROP TABLE IF EXISTS `xc_teacher`;
CREATE TABLE `xc_teacher` (
  `id` varchar(32) NOT NULL,
  `user_id` varchar(32) NOT NULL COMMENT '用户id',
  `name` varchar(64) NOT NULL COMMENT '称呼',
  `intro` varchar(512) DEFAULT NULL COMMENT '个人简介',
  `resume` varchar(1024) DEFAULT NULL COMMENT '个人简历',
  `pic` varchar(128) DEFAULT NULL COMMENT '老师照片',
  PRIMARY KEY (`id`),
  UNIQUE KEY `xu_teacher_user_id` (`user_id`),
  CONSTRAINT `fk_xc_teacher_user_id` FOREIGN KEY (`user_id`) REFERENCES `xc_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '教师表';




# 用户相关表结束