/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 50648
 Source Host           : 127.0.0.1:3306
 Source Schema         : grape

 Target Server Type    : MySQL
 Target Server Version : 50648
 File Encoding         : 65001

 Date: 31/01/2021 13:38:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for code_generator_info
-- ----------------------------
DROP TABLE IF EXISTS `code_generator_info`;
CREATE TABLE `code_generator_info`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'id',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `driver_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '驱动名称',
  `url` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'url地址',
  `username` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `base_package_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '生成的基本包名',
  `table_names` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '生成的表名(全部生成则为*, 多个用逗号分隔)',
  `gmt_created` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建时间',
  `author` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '作者名称',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '代码生成者信息' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of code_generator_info
-- ----------------------------
INSERT INTO `code_generator_info` VALUES ('fa86f96a28d170dfdb71af7896a338ed', 'blocks', 'com.mysql.cj.jdbc.Driver', 'jdbc:mysql://127.0.0.1:3306/blocks?useUnicode=true&characterEncoding=utf8&useSSL=false&serverTimezone=UTC', 'root', 'root', 'com.gitee.starblues.grape.repository.databases', '*', '2021-01-13 15:41:58', 'starBlues', NULL);

-- ----------------------------
-- Table structure for dict
-- ----------------------------
DROP TABLE IF EXISTS `dict`;
CREATE TABLE `dict`  (
  `dict_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据字典id',
  `dict_key` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典的唯一key',
  `label` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典标签',
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典值',
  `order_num` int(11) NOT NULL COMMENT '排序(数字越小越靠前)',
  `create_user` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建的用户',
  `gmt_created` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建时间',
  `modified_user` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '修改的用户',
  `gmt_modified` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`dict_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '数据字典' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for login_log
-- ----------------------------
DROP TABLE IF EXISTS `login_log`;
CREATE TABLE `login_log`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'id',
  `username` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `gmt_login_time` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登录时间',
  `gmt_login_timestamp` bigint(20) NOT NULL COMMENT '登录的时间戳',
  `login_ip` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登录ip',
  `login_result` int(1) NOT NULL COMMENT '登录结果(1成功, 2失败)',
  `login_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录地址',
  `login_failure_msg` varchar(2048) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录失败原因',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '登录日志' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `menu_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单id',
  `parent_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '父菜单id,如果是顶级菜单, 则为0',
  `type` int(1) NOT NULL COMMENT '类型(1: 目录、2: 菜单、3: 权限)',
  `title` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `permissions` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限标识, 多个可用逗号分隔',
  `component` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'vue组件名称, 只有类型为1、2才有值',
  `order_num` int(11) NOT NULL DEFAULT 1 COMMENT '排序，数字越小越靠前',
  `icon` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `path` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路径地址(也是路由地址)',
  `enable` int(1) NOT NULL DEFAULT 1 COMMENT '是否启用(1启用,0禁用)',
  `deleted` int(1) NOT NULL DEFAULT 0 COMMENT '是否被删除(1被删除, 0未被删除)',
  `html_target` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'html target 属性(_blank, _self, _parent, _top)',
  `plugin_menu` int(1) NOT NULL DEFAULT 0 COMMENT '是否为插件菜单(1是，0不是)',
  `plugin_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '插件id',
  `plugin_app_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '插件界面app名称',
  `plugin_app_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '插件界面路径',
  `plugin_root_routing` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '插件根路由',
  `create_user` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建的用户',
  `gmt_created` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建时间',
  `modified_user` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '修改的用户',
  `gmt_modified` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单模型表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('100', '0', 1, '系统管理', 'system', 'RouteView', 100, 'tool', '', 1, 0, '', 0, NULL, NULL, NULL, NULL, 'admin', '2021-01-01 08:08:08', 'admin', '2021-01-01 08:08:08');
INSERT INTO `menu` VALUES ('101', '100', 2, '菜单管理', 'menu-mange', 'MenuManage', 101, 'menu', '/system/menu-mange', 1, 0, '', 0, NULL, NULL, NULL, NULL, 'admin', '2021-01-01 08:08:08', 'admin', '2021-01-28 17:10:25');
INSERT INTO `menu` VALUES ('102', '100', 2, '角色管理', 'role-manage', 'RoleManage', 102, 'team', '/system/role-manage', 1, 0, '', 0, NULL, NULL, NULL, NULL, 'admin', '2021-01-01 08:08:08', 'admin', '2021-01-28 17:10:39');
INSERT INTO `menu` VALUES ('103', '100', 2, '用户管理', 'user-mange', 'UserManage', 103, 'user', '/system/user-mange', 1, 0, '', 0, NULL, NULL, NULL, NULL, 'admin', '2021-01-01 08:08:08', 'admin', '2021-01-01 08:08:08');
INSERT INTO `menu` VALUES ('104', '100', 2, '客户端授权', 'oauth-client-manage', 'OAuthClientManage', 104, 'key', '/system/oauth-client-manage', 1, 0, '', 0, NULL, NULL, NULL, NULL, 'admin', '2021-01-01 08:08:08', 'admin', '2021-01-01 08:08:08');
INSERT INTO `menu` VALUES ('105', '100', 2, '登录日志', 'login-log', 'LoginLogManage', 105, 'container', '/system/login-log-manage', 1, 0, '', 0, NULL, NULL, NULL, NULL, 'admin', '2021-01-01 08:08:08', 'admin', '2021-01-01 08:08:08');
INSERT INTO `menu` VALUES ('200', '0', 1, '插件模块', 'plugin', 'RouteView', 200, 'api', NULL, 1, 0, '', 0, NULL, NULL, NULL, NULL, 'admin', '2021-01-01 08:08:08', 'admin', '2021-01-28 17:10:56');
INSERT INTO `menu` VALUES ('201', '200', 2, '插件管理', 'plugin-mange', 'PluginManage', 201, 'pushpin', '/plugin/plugin-manage', 1, 0, '', 0, NULL, NULL, NULL, NULL, 'admin', '2021-01-01 08:08:08', 'admin', '2021-01-28 17:10:56');

-- ----------------------------
-- Table structure for oauth_client_details
-- ----------------------------
DROP TABLE IF EXISTS `oauth_client_details`;
CREATE TABLE `oauth_client_details`  (
  `client_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '客户端ID',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `resource_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资源ID集合,多个资源时用逗号(,)分隔',
  `client_secret` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户端密匙',
  `scope` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户端申请的权限范围',
  `authorized_grant_types` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户端支持的grant_type',
  `web_server_redirect_uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '重定向URI',
  `authorities` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户端所拥有的Spring Security的权限值，多个用逗号(,)分隔',
  `access_token_validity` int(11) NULL DEFAULT NULL COMMENT '访问令牌有效时间值(单位:秒)',
  `refresh_token_validity` int(11) NULL DEFAULT NULL COMMENT '更新令牌有效时间值(单位:秒)',
  `additional_information` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预留字段',
  `autoapprove` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户是否自动Approval操作',
  `create_user` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建用户',
  `gmt_created` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建时间',
  `modified_user` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '修改用户',
  `gmt_modified` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '修改时间',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '授权客户端表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of oauth_client_details
-- ----------------------------
INSERT INTO `oauth_client_details` VALUES ('admin_client', '默认', NULL, '$2a$10$3EDXLXfW1O8ZlJHnqdfTeOG6qEzcGJkIY1tF3d3xnakeztqGqnX.q', 'all', 'authorization_code,refresh_token,password', NULL, NULL, 36000, 36000, NULL, NULL, 'admin', '2021-01-01 08:08:08', 'admin', '2021-01-01 08:08:08', NULL);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `role_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色id',
  `name` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `code` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色编码',
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '帐号状态（1启用, 0停用）',
  `deleted` int(1) NOT NULL COMMENT '删除标记（1删除, 0 正常）',
  `create_user` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建用户',
  `gmt_created` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建时间',
  `modified_user` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '修改用户',
  `gmt_modified` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '修改时间',
  `description` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色描述',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统角色表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', 'admin', 'super_admin', 1, 0, '', '2021-01-01 08:08:08', 'admin', '2021-01-08 15:01:08', '超级管理员');

-- ----------------------------
-- Table structure for role_menu
-- ----------------------------
DROP TABLE IF EXISTS `role_menu`;
CREATE TABLE `role_menu`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'id',
  `role_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色id',
  `menu_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色菜单权限表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of role_menu
-- ----------------------------
INSERT INTO `role_menu` VALUES ('1', '1', '1');
INSERT INTO `role_menu` VALUES ('7136b7316faf4d0faa4cb03583754862', '917d7b3f19da4b0bfd31d747fb5971ad', '102');
INSERT INTO `role_menu` VALUES ('873aefbb44de40819ec3289484e1e0db', '917d7b3f19da4b0bfd31d747fb5971ad', '100');
INSERT INTO `role_menu` VALUES ('ba5128fae2b74be1871d8a1002be49c9', '917d7b3f19da4b0bfd31d747fb5971ad', '101');
INSERT INTO `role_menu` VALUES ('ba77c34d9d144deb9bf146c71b309ac5', '917d7b3f19da4b0bfd31d747fb5971ad', '103');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名称',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码(加密后)',
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '帐号状态（1启用, 0停用）',
  `deleted` int(1) NOT NULL DEFAULT 0 COMMENT '删除标记（1删除, 0 正常）',
  `locked` int(6) NOT NULL DEFAULT 0 COMMENT '是否被锁(小于等于5表示未被锁, 大于5表示被锁)',
  `create_user` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建用户',
  `gmt_created` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建时间',
  `modified_user` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '修改用户',
  `gmt_modified` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '修改时间',
  `avatar` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像地址',
  `last_login_ip` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上一次登录的ip地址',
  `last_gmt_login_time` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上一次登录的时间',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统用户表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', '16666666666', '123@qq.com', 'admin', '$2a$10$IqjSzOzTpMX79DnxS7aBz.A1.uqR.DvuvMtx9TaGmwpsxgJDFW8wS', 1, 0, 0, 'admin', '2021-01-01 08:08:08', 'admin', 'admin', '2e418339355940a9b83f72d597a6da2c.jpg', '127.0.0.1', '2021-01-31 13:25:17');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'id',
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `role_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统用户角色关联表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('1', '1', '1');

SET FOREIGN_KEY_CHECKS = 1;
