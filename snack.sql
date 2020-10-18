/*
 Navicat Premium Data Transfer

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 50716
 Source Host           : 127.0.0.1:3306
 Source Schema         : snack

 Target Server Type    : MySQL
 Target Server Version : 50716
 File Encoding         : 65001

 Date: 18/10/2020 21:25:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for access
-- ----------------------------
DROP TABLE IF EXISTS `access`;
CREATE TABLE `access`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL COMMENT '权限标题',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL COMMENT '对应页面的地址',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1有效，0无效',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_croatian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of access
-- ----------------------------
INSERT INTO `access` VALUES (3, '统计分析', '\"\\/admin\"', 1);
INSERT INTO `access` VALUES (4, '商户订单', '\"\\/admin\\/mt_order\"', 1);
INSERT INTO `access` VALUES (5, '账号相关', '\"\\/admin\\/admin\"', 1);
INSERT INTO `access` VALUES (6, '商户相关', '\"\\/admin\\/merchant\"', 1);
INSERT INTO `access` VALUES (7, '会员相关', '\"\\/admin\\/member\"', 1);
INSERT INTO `access` VALUES (8, '收款相关', '\"\\/admin\\/payment\"', 1);
INSERT INTO `access` VALUES (9, '权限管理', '\"\\/admin\\/rbac\"', 1);
INSERT INTO `access` VALUES (10, '添加权限', '\"\\/admin\\/rbac\\/addAccess\"', 1);
INSERT INTO `access` VALUES (11, '设置角色权限', '\"\\/admin\\/rbac\\/updateRoleAccess\"', 1);
INSERT INTO `access` VALUES (12, '添加角色', '\"\\/admin\\/rbac\\/addRole\"', 1);
INSERT INTO `access` VALUES (13, '编辑角色', '\"\\/admin\\/rbac\\/updateRole\"', 1);
INSERT INTO `access` VALUES (14, '删除角色', '\"\\/admin\\/rbac\\/deleteRole\"', 1);
INSERT INTO `access` VALUES (15, '编辑用户', '\"\\/admin\\/rbac\\/updateAdminRole\"', 1);
INSERT INTO `access` VALUES (16, '删除用户', '\"\\/admin\\/rbac\\/deleteAdmin\"', 1);
INSERT INTO `access` VALUES (17, '修改权限', '\"\\/admin\\/rbac\\/updateAccess\"', 1);
INSERT INTO `access` VALUES (18, '删除权限', '\"\\/admin\\/rbac\\/deleteAccess\"', 1);
INSERT INTO `access` VALUES (19, '角色权限列表', '\"\\/admin\\/rbac\\/roleAccessInfo\"', 1);
INSERT INTO `access` VALUES (20, '启用或删除管理员', '\"\\/admin\\/admin\\/update\"', 1);
INSERT INTO `access` VALUES (21, '修改商户手续费', '\"\\/admin\\/merchant\\/update_ratio\"', 1);
INSERT INTO `access` VALUES (23, '删除商户', '\"\\/admin\\/merchant\\/delete_mt\"', 1);

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '管理员id',
  `admin_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL COMMENT '管理员名称',
  `admin_pwd` varchar(100) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL COMMENT '管理员密码',
  `admin_email` varchar(100) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL COMMENT '管理员邮箱',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `admin_status` tinyint(3) NOT NULL DEFAULT 3 COMMENT '0无效，1有效',
  `is_root` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否为系统默认最高权限的管理员',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `admin_name`(`admin_name`) USING BTREE COMMENT '名称唯一',
  UNIQUE INDEX `admin_email`(`admin_email`) USING BTREE COMMENT '邮箱唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_croatian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'root', 'e10adc3949ba59abbe56e057f20f883e', 'bosen_qe@qq.com', '2020-06-24 16:14:17', 1, 1);
INSERT INTO `admin` VALUES (6, 'demo', 'e10adc3949ba59abbe56e057f20f883e', 'w2390025289@163.com', '2020-07-13 17:52:36', 1, 0);
INSERT INTO `admin` VALUES (7, 'test', 'e10adc3949ba59abbe56e057f20f883e', '2390025289@qq.com', '2020-07-16 22:15:39', 1, 0);

-- ----------------------------
-- Table structure for admin_role
-- ----------------------------
DROP TABLE IF EXISTS `admin_role`;
CREATE TABLE `admin_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NOT NULL COMMENT '管理员id',
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_croatian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_role
-- ----------------------------
INSERT INTO `admin_role` VALUES (1, 1, 2, '2020-07-18 13:43:21');
INSERT INTO `admin_role` VALUES (2, 6, 3, '2020-07-18 13:43:25');
INSERT INTO `admin_role` VALUES (3, 7, 4, '2020-07-18 13:43:32');

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(3) NOT NULL COMMENT '商品1店铺0',
  `mb_id` int(11) NOT NULL COMMENT '用户id',
  `num_id` int(11) NOT NULL COMMENT '商品或店铺的id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_croatian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of collect
-- ----------------------------
INSERT INTO `collect` VALUES (4, 0, 5, 4);
INSERT INTO `collect` VALUES (5, 0, 5, 2);
INSERT INTO `collect` VALUES (7, 0, 5, 3);
INSERT INTO `collect` VALUES (14, 1, 5, 132);
INSERT INTO `collect` VALUES (15, 1, 5, 138);
INSERT INTO `collect` VALUES (16, 1, 5, 144);
INSERT INTO `collect` VALUES (17, 1, 5, 147);
INSERT INTO `collect` VALUES (18, 1, 5, 146);
INSERT INTO `collect` VALUES (19, 1, 5, 145);
INSERT INTO `collect` VALUES (20, 1, 5, 160);
INSERT INTO `collect` VALUES (21, 0, 8, 2);
INSERT INTO `collect` VALUES (22, 0, 8, 3);
INSERT INTO `collect` VALUES (23, 1, 5, 94);

-- ----------------------------
-- Table structure for coupon
-- ----------------------------
DROP TABLE IF EXISTS `coupon`;
CREATE TABLE `coupon`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(3) NOT NULL COMMENT '1满减卷0立减卷',
  `full` float(11, 2) NOT NULL COMMENT '满减条件',
  `sub` float(11, 3) NOT NULL COMMENT '减去的金额',
  `mb_id` int(11) NOT NULL COMMENT '优惠卷持有者id',
  `mt_id` int(11) NOT NULL COMMENT '优惠卷所属店铺',
  `time` int(11) NULL DEFAULT NULL COMMENT '有效期',
  `num` int(11) NOT NULL COMMENT '张数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8 COLLATE = utf8_croatian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of coupon
-- ----------------------------
INSERT INTO `coupon` VALUES (26, 1, 0.03, 0.020, 5, 3, 0, 5);
INSERT INTO `coupon` VALUES (28, 0, 0.00, 0.010, 6, 2, 0, 1);
INSERT INTO `coupon` VALUES (29, 0, 0.00, 0.010, 7, 2, 0, 1);
INSERT INTO `coupon` VALUES (38, 1, 0.02, 0.010, 5, 2, 0, 2);
INSERT INTO `coupon` VALUES (39, 1, 0.02, 0.010, 5, 2, 1598630400, 1);

-- ----------------------------
-- Table structure for evaluate
-- ----------------------------
DROP TABLE IF EXISTS `evaluate`;
CREATE TABLE `evaluate`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `e_mb_id` int(11) NOT NULL COMMENT '评价的用户',
  `e_mt_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL COMMENT '所属商户',
  `e_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL COMMENT '评价的内容',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '评价时间',
  `e_goods_id` int(11) NOT NULL COMMENT '评价的商品id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5954 CHARACTER SET = utf8 COLLATE = utf8_croatian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of evaluate
-- ----------------------------
INSERT INTO `evaluate` VALUES (5534, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:04:58', 92);
INSERT INTO `evaluate` VALUES (5535, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:04:58', 93);
INSERT INTO `evaluate` VALUES (5536, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:04:58', 94);
INSERT INTO `evaluate` VALUES (5537, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:04:58', 95);
INSERT INTO `evaluate` VALUES (5538, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:04:58', 96);
INSERT INTO `evaluate` VALUES (5539, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:04:58', 97);
INSERT INTO `evaluate` VALUES (5540, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:04:58', 98);
INSERT INTO `evaluate` VALUES (5541, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:04:58', 99);
INSERT INTO `evaluate` VALUES (5542, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:04:58', 100);
INSERT INTO `evaluate` VALUES (5543, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:04:58', 101);
INSERT INTO `evaluate` VALUES (5544, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:04:58', 102);
INSERT INTO `evaluate` VALUES (5545, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:04:58', 103);
INSERT INTO `evaluate` VALUES (5546, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:04:58', 104);
INSERT INTO `evaluate` VALUES (5547, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:04:58', 105);
INSERT INTO `evaluate` VALUES (5548, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:04:58', 106);
INSERT INTO `evaluate` VALUES (5549, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:04:58', 107);
INSERT INTO `evaluate` VALUES (5550, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:04:58', 108);
INSERT INTO `evaluate` VALUES (5551, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:04:58', 109);
INSERT INTO `evaluate` VALUES (5552, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:04:58', 110);
INSERT INTO `evaluate` VALUES (5553, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:04:58', 111);
INSERT INTO `evaluate` VALUES (5554, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:04:58', 112);
INSERT INTO `evaluate` VALUES (5555, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:04:58', 113);
INSERT INTO `evaluate` VALUES (5556, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:04:58', 114);
INSERT INTO `evaluate` VALUES (5557, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:04:58', 115);
INSERT INTO `evaluate` VALUES (5558, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:12', 92);
INSERT INTO `evaluate` VALUES (5559, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:12', 93);
INSERT INTO `evaluate` VALUES (5560, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:12', 94);
INSERT INTO `evaluate` VALUES (5561, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:12', 95);
INSERT INTO `evaluate` VALUES (5562, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:12', 96);
INSERT INTO `evaluate` VALUES (5563, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:12', 97);
INSERT INTO `evaluate` VALUES (5564, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:12', 98);
INSERT INTO `evaluate` VALUES (5565, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:12', 99);
INSERT INTO `evaluate` VALUES (5566, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:12', 100);
INSERT INTO `evaluate` VALUES (5567, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:12', 101);
INSERT INTO `evaluate` VALUES (5568, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:12', 102);
INSERT INTO `evaluate` VALUES (5569, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:12', 103);
INSERT INTO `evaluate` VALUES (5570, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:12', 104);
INSERT INTO `evaluate` VALUES (5571, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:12', 105);
INSERT INTO `evaluate` VALUES (5572, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:12', 106);
INSERT INTO `evaluate` VALUES (5573, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:12', 107);
INSERT INTO `evaluate` VALUES (5574, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:12', 108);
INSERT INTO `evaluate` VALUES (5575, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:12', 109);
INSERT INTO `evaluate` VALUES (5576, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:12', 110);
INSERT INTO `evaluate` VALUES (5577, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:12', 111);
INSERT INTO `evaluate` VALUES (5578, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:12', 112);
INSERT INTO `evaluate` VALUES (5579, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:12', 113);
INSERT INTO `evaluate` VALUES (5580, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:12', 114);
INSERT INTO `evaluate` VALUES (5581, 7, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:12', 115);
INSERT INTO `evaluate` VALUES (5582, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:26', 92);
INSERT INTO `evaluate` VALUES (5583, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:26', 93);
INSERT INTO `evaluate` VALUES (5584, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:26', 94);
INSERT INTO `evaluate` VALUES (5585, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:26', 95);
INSERT INTO `evaluate` VALUES (5586, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:26', 96);
INSERT INTO `evaluate` VALUES (5587, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:26', 97);
INSERT INTO `evaluate` VALUES (5588, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:26', 98);
INSERT INTO `evaluate` VALUES (5589, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:26', 99);
INSERT INTO `evaluate` VALUES (5590, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:26', 100);
INSERT INTO `evaluate` VALUES (5591, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:26', 101);
INSERT INTO `evaluate` VALUES (5592, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:26', 102);
INSERT INTO `evaluate` VALUES (5593, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:26', 103);
INSERT INTO `evaluate` VALUES (5594, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:26', 104);
INSERT INTO `evaluate` VALUES (5595, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:26', 105);
INSERT INTO `evaluate` VALUES (5596, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:26', 106);
INSERT INTO `evaluate` VALUES (5597, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:26', 107);
INSERT INTO `evaluate` VALUES (5598, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:26', 108);
INSERT INTO `evaluate` VALUES (5599, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:26', 109);
INSERT INTO `evaluate` VALUES (5600, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:26', 110);
INSERT INTO `evaluate` VALUES (5601, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:26', 111);
INSERT INTO `evaluate` VALUES (5602, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:26', 112);
INSERT INTO `evaluate` VALUES (5603, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:26', 113);
INSERT INTO `evaluate` VALUES (5604, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:26', 114);
INSERT INTO `evaluate` VALUES (5605, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:26', 115);
INSERT INTO `evaluate` VALUES (5606, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:27', 92);
INSERT INTO `evaluate` VALUES (5607, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:27', 93);
INSERT INTO `evaluate` VALUES (5608, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:27', 94);
INSERT INTO `evaluate` VALUES (5609, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:27', 95);
INSERT INTO `evaluate` VALUES (5610, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:27', 96);
INSERT INTO `evaluate` VALUES (5611, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:27', 97);
INSERT INTO `evaluate` VALUES (5612, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:27', 98);
INSERT INTO `evaluate` VALUES (5613, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:27', 99);
INSERT INTO `evaluate` VALUES (5614, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:27', 100);
INSERT INTO `evaluate` VALUES (5615, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:27', 101);
INSERT INTO `evaluate` VALUES (5616, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:27', 102);
INSERT INTO `evaluate` VALUES (5617, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:27', 103);
INSERT INTO `evaluate` VALUES (5618, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:27', 104);
INSERT INTO `evaluate` VALUES (5619, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:27', 105);
INSERT INTO `evaluate` VALUES (5620, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:27', 106);
INSERT INTO `evaluate` VALUES (5621, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:27', 107);
INSERT INTO `evaluate` VALUES (5622, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:27', 108);
INSERT INTO `evaluate` VALUES (5623, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:27', 109);
INSERT INTO `evaluate` VALUES (5624, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:27', 110);
INSERT INTO `evaluate` VALUES (5625, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:27', 111);
INSERT INTO `evaluate` VALUES (5626, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:27', 112);
INSERT INTO `evaluate` VALUES (5627, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:27', 113);
INSERT INTO `evaluate` VALUES (5628, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:27', 114);
INSERT INTO `evaluate` VALUES (5629, 6, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:27', 115);
INSERT INTO `evaluate` VALUES (5630, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 92);
INSERT INTO `evaluate` VALUES (5631, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 93);
INSERT INTO `evaluate` VALUES (5632, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 94);
INSERT INTO `evaluate` VALUES (5633, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 95);
INSERT INTO `evaluate` VALUES (5634, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 96);
INSERT INTO `evaluate` VALUES (5635, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 97);
INSERT INTO `evaluate` VALUES (5636, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 98);
INSERT INTO `evaluate` VALUES (5637, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 99);
INSERT INTO `evaluate` VALUES (5638, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 100);
INSERT INTO `evaluate` VALUES (5639, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 101);
INSERT INTO `evaluate` VALUES (5640, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 102);
INSERT INTO `evaluate` VALUES (5641, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 103);
INSERT INTO `evaluate` VALUES (5642, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 104);
INSERT INTO `evaluate` VALUES (5643, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 105);
INSERT INTO `evaluate` VALUES (5644, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 106);
INSERT INTO `evaluate` VALUES (5645, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 107);
INSERT INTO `evaluate` VALUES (5646, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 108);
INSERT INTO `evaluate` VALUES (5647, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 109);
INSERT INTO `evaluate` VALUES (5648, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 110);
INSERT INTO `evaluate` VALUES (5649, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 111);
INSERT INTO `evaluate` VALUES (5650, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 112);
INSERT INTO `evaluate` VALUES (5651, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 113);
INSERT INTO `evaluate` VALUES (5652, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 114);
INSERT INTO `evaluate` VALUES (5653, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 115);
INSERT INTO `evaluate` VALUES (5654, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 92);
INSERT INTO `evaluate` VALUES (5655, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 93);
INSERT INTO `evaluate` VALUES (5656, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 94);
INSERT INTO `evaluate` VALUES (5657, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 95);
INSERT INTO `evaluate` VALUES (5658, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 96);
INSERT INTO `evaluate` VALUES (5659, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 97);
INSERT INTO `evaluate` VALUES (5660, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 98);
INSERT INTO `evaluate` VALUES (5661, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 99);
INSERT INTO `evaluate` VALUES (5662, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 100);
INSERT INTO `evaluate` VALUES (5663, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 101);
INSERT INTO `evaluate` VALUES (5664, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 102);
INSERT INTO `evaluate` VALUES (5665, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 103);
INSERT INTO `evaluate` VALUES (5666, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 104);
INSERT INTO `evaluate` VALUES (5667, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 105);
INSERT INTO `evaluate` VALUES (5668, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 106);
INSERT INTO `evaluate` VALUES (5669, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 107);
INSERT INTO `evaluate` VALUES (5670, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 108);
INSERT INTO `evaluate` VALUES (5671, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 109);
INSERT INTO `evaluate` VALUES (5672, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 110);
INSERT INTO `evaluate` VALUES (5673, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 111);
INSERT INTO `evaluate` VALUES (5674, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 112);
INSERT INTO `evaluate` VALUES (5675, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 113);
INSERT INTO `evaluate` VALUES (5676, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 114);
INSERT INTO `evaluate` VALUES (5677, 5, '三只松鼠', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '2020-07-05 15:05:34', 115);
INSERT INTO `evaluate` VALUES (5678, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:13', 116);
INSERT INTO `evaluate` VALUES (5679, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:13', 117);
INSERT INTO `evaluate` VALUES (5680, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:13', 118);
INSERT INTO `evaluate` VALUES (5681, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:13', 119);
INSERT INTO `evaluate` VALUES (5682, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:13', 120);
INSERT INTO `evaluate` VALUES (5683, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:13', 121);
INSERT INTO `evaluate` VALUES (5684, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:13', 122);
INSERT INTO `evaluate` VALUES (5685, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:13', 123);
INSERT INTO `evaluate` VALUES (5686, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:13', 124);
INSERT INTO `evaluate` VALUES (5687, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:13', 125);
INSERT INTO `evaluate` VALUES (5688, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:13', 126);
INSERT INTO `evaluate` VALUES (5689, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:13', 127);
INSERT INTO `evaluate` VALUES (5690, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:13', 128);
INSERT INTO `evaluate` VALUES (5691, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:13', 129);
INSERT INTO `evaluate` VALUES (5692, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:13', 130);
INSERT INTO `evaluate` VALUES (5693, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:13', 131);
INSERT INTO `evaluate` VALUES (5694, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:13', 132);
INSERT INTO `evaluate` VALUES (5695, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:13', 133);
INSERT INTO `evaluate` VALUES (5696, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:13', 134);
INSERT INTO `evaluate` VALUES (5697, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:13', 135);
INSERT INTO `evaluate` VALUES (5698, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:13', 136);
INSERT INTO `evaluate` VALUES (5699, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:13', 137);
INSERT INTO `evaluate` VALUES (5700, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:14', 116);
INSERT INTO `evaluate` VALUES (5701, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:14', 117);
INSERT INTO `evaluate` VALUES (5702, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:14', 118);
INSERT INTO `evaluate` VALUES (5703, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:14', 119);
INSERT INTO `evaluate` VALUES (5704, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:14', 120);
INSERT INTO `evaluate` VALUES (5705, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:14', 121);
INSERT INTO `evaluate` VALUES (5706, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:14', 122);
INSERT INTO `evaluate` VALUES (5707, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:14', 123);
INSERT INTO `evaluate` VALUES (5708, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:14', 124);
INSERT INTO `evaluate` VALUES (5709, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:14', 125);
INSERT INTO `evaluate` VALUES (5710, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:14', 126);
INSERT INTO `evaluate` VALUES (5711, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:14', 127);
INSERT INTO `evaluate` VALUES (5712, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:14', 128);
INSERT INTO `evaluate` VALUES (5713, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:14', 129);
INSERT INTO `evaluate` VALUES (5714, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:14', 130);
INSERT INTO `evaluate` VALUES (5715, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:14', 131);
INSERT INTO `evaluate` VALUES (5716, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:14', 132);
INSERT INTO `evaluate` VALUES (5717, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:14', 133);
INSERT INTO `evaluate` VALUES (5718, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:14', 134);
INSERT INTO `evaluate` VALUES (5719, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:14', 135);
INSERT INTO `evaluate` VALUES (5720, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:14', 136);
INSERT INTO `evaluate` VALUES (5721, 5, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:14', 137);
INSERT INTO `evaluate` VALUES (5722, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 116);
INSERT INTO `evaluate` VALUES (5723, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 117);
INSERT INTO `evaluate` VALUES (5724, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 118);
INSERT INTO `evaluate` VALUES (5725, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 119);
INSERT INTO `evaluate` VALUES (5726, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 120);
INSERT INTO `evaluate` VALUES (5727, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 121);
INSERT INTO `evaluate` VALUES (5728, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 122);
INSERT INTO `evaluate` VALUES (5729, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 123);
INSERT INTO `evaluate` VALUES (5730, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 124);
INSERT INTO `evaluate` VALUES (5731, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 125);
INSERT INTO `evaluate` VALUES (5732, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 126);
INSERT INTO `evaluate` VALUES (5733, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 127);
INSERT INTO `evaluate` VALUES (5734, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 128);
INSERT INTO `evaluate` VALUES (5735, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 129);
INSERT INTO `evaluate` VALUES (5736, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 130);
INSERT INTO `evaluate` VALUES (5737, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 131);
INSERT INTO `evaluate` VALUES (5738, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 132);
INSERT INTO `evaluate` VALUES (5739, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 133);
INSERT INTO `evaluate` VALUES (5740, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 134);
INSERT INTO `evaluate` VALUES (5741, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 135);
INSERT INTO `evaluate` VALUES (5742, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 136);
INSERT INTO `evaluate` VALUES (5743, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 137);
INSERT INTO `evaluate` VALUES (5744, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 116);
INSERT INTO `evaluate` VALUES (5745, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 117);
INSERT INTO `evaluate` VALUES (5746, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 118);
INSERT INTO `evaluate` VALUES (5747, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 119);
INSERT INTO `evaluate` VALUES (5748, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 120);
INSERT INTO `evaluate` VALUES (5749, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 121);
INSERT INTO `evaluate` VALUES (5750, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 122);
INSERT INTO `evaluate` VALUES (5751, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 123);
INSERT INTO `evaluate` VALUES (5752, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 124);
INSERT INTO `evaluate` VALUES (5753, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 125);
INSERT INTO `evaluate` VALUES (5754, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 126);
INSERT INTO `evaluate` VALUES (5755, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 127);
INSERT INTO `evaluate` VALUES (5756, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 128);
INSERT INTO `evaluate` VALUES (5757, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 129);
INSERT INTO `evaluate` VALUES (5758, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 130);
INSERT INTO `evaluate` VALUES (5759, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 131);
INSERT INTO `evaluate` VALUES (5760, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 132);
INSERT INTO `evaluate` VALUES (5761, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 133);
INSERT INTO `evaluate` VALUES (5762, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 134);
INSERT INTO `evaluate` VALUES (5763, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 135);
INSERT INTO `evaluate` VALUES (5764, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 136);
INSERT INTO `evaluate` VALUES (5765, 6, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:20', 137);
INSERT INTO `evaluate` VALUES (5766, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 116);
INSERT INTO `evaluate` VALUES (5767, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 117);
INSERT INTO `evaluate` VALUES (5768, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 118);
INSERT INTO `evaluate` VALUES (5769, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 119);
INSERT INTO `evaluate` VALUES (5770, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 120);
INSERT INTO `evaluate` VALUES (5771, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 121);
INSERT INTO `evaluate` VALUES (5772, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 122);
INSERT INTO `evaluate` VALUES (5773, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 123);
INSERT INTO `evaluate` VALUES (5774, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 124);
INSERT INTO `evaluate` VALUES (5775, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 125);
INSERT INTO `evaluate` VALUES (5776, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 126);
INSERT INTO `evaluate` VALUES (5777, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 127);
INSERT INTO `evaluate` VALUES (5778, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 128);
INSERT INTO `evaluate` VALUES (5779, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 129);
INSERT INTO `evaluate` VALUES (5780, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 130);
INSERT INTO `evaluate` VALUES (5781, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 131);
INSERT INTO `evaluate` VALUES (5782, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 132);
INSERT INTO `evaluate` VALUES (5783, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 133);
INSERT INTO `evaluate` VALUES (5784, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 134);
INSERT INTO `evaluate` VALUES (5785, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 135);
INSERT INTO `evaluate` VALUES (5786, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 136);
INSERT INTO `evaluate` VALUES (5787, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 137);
INSERT INTO `evaluate` VALUES (5788, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 116);
INSERT INTO `evaluate` VALUES (5789, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 117);
INSERT INTO `evaluate` VALUES (5790, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 118);
INSERT INTO `evaluate` VALUES (5791, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 119);
INSERT INTO `evaluate` VALUES (5792, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 120);
INSERT INTO `evaluate` VALUES (5793, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 121);
INSERT INTO `evaluate` VALUES (5794, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 122);
INSERT INTO `evaluate` VALUES (5795, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 123);
INSERT INTO `evaluate` VALUES (5796, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 124);
INSERT INTO `evaluate` VALUES (5797, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 125);
INSERT INTO `evaluate` VALUES (5798, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 126);
INSERT INTO `evaluate` VALUES (5799, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 127);
INSERT INTO `evaluate` VALUES (5800, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 128);
INSERT INTO `evaluate` VALUES (5801, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 129);
INSERT INTO `evaluate` VALUES (5802, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 130);
INSERT INTO `evaluate` VALUES (5803, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 131);
INSERT INTO `evaluate` VALUES (5804, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 132);
INSERT INTO `evaluate` VALUES (5805, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 133);
INSERT INTO `evaluate` VALUES (5806, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 134);
INSERT INTO `evaluate` VALUES (5807, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 135);
INSERT INTO `evaluate` VALUES (5808, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 136);
INSERT INTO `evaluate` VALUES (5809, 7, '乐事', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '2020-07-05 15:07:23', 137);
INSERT INTO `evaluate` VALUES (5810, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:42', 138);
INSERT INTO `evaluate` VALUES (5811, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:42', 139);
INSERT INTO `evaluate` VALUES (5812, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:42', 140);
INSERT INTO `evaluate` VALUES (5813, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:42', 141);
INSERT INTO `evaluate` VALUES (5814, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:42', 142);
INSERT INTO `evaluate` VALUES (5815, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:42', 143);
INSERT INTO `evaluate` VALUES (5816, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:42', 144);
INSERT INTO `evaluate` VALUES (5817, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:42', 145);
INSERT INTO `evaluate` VALUES (5818, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:42', 146);
INSERT INTO `evaluate` VALUES (5819, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:42', 147);
INSERT INTO `evaluate` VALUES (5820, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:42', 148);
INSERT INTO `evaluate` VALUES (5821, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:42', 149);
INSERT INTO `evaluate` VALUES (5822, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:42', 150);
INSERT INTO `evaluate` VALUES (5823, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:42', 151);
INSERT INTO `evaluate` VALUES (5824, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:42', 152);
INSERT INTO `evaluate` VALUES (5825, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:42', 153);
INSERT INTO `evaluate` VALUES (5826, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:42', 154);
INSERT INTO `evaluate` VALUES (5827, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:42', 155);
INSERT INTO `evaluate` VALUES (5828, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:42', 156);
INSERT INTO `evaluate` VALUES (5829, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:42', 157);
INSERT INTO `evaluate` VALUES (5830, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:42', 158);
INSERT INTO `evaluate` VALUES (5831, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:42', 159);
INSERT INTO `evaluate` VALUES (5832, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:42', 160);
INSERT INTO `evaluate` VALUES (5833, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:42', 161);
INSERT INTO `evaluate` VALUES (5834, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:43', 138);
INSERT INTO `evaluate` VALUES (5835, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:43', 139);
INSERT INTO `evaluate` VALUES (5836, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:43', 140);
INSERT INTO `evaluate` VALUES (5837, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:43', 141);
INSERT INTO `evaluate` VALUES (5838, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:43', 142);
INSERT INTO `evaluate` VALUES (5839, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:43', 143);
INSERT INTO `evaluate` VALUES (5840, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:43', 144);
INSERT INTO `evaluate` VALUES (5841, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:43', 145);
INSERT INTO `evaluate` VALUES (5842, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:43', 146);
INSERT INTO `evaluate` VALUES (5843, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:43', 147);
INSERT INTO `evaluate` VALUES (5844, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:43', 148);
INSERT INTO `evaluate` VALUES (5845, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:43', 149);
INSERT INTO `evaluate` VALUES (5846, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:43', 150);
INSERT INTO `evaluate` VALUES (5847, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:43', 151);
INSERT INTO `evaluate` VALUES (5848, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:43', 152);
INSERT INTO `evaluate` VALUES (5849, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:43', 153);
INSERT INTO `evaluate` VALUES (5850, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:43', 154);
INSERT INTO `evaluate` VALUES (5851, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:43', 155);
INSERT INTO `evaluate` VALUES (5852, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:43', 156);
INSERT INTO `evaluate` VALUES (5853, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:43', 157);
INSERT INTO `evaluate` VALUES (5854, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:43', 158);
INSERT INTO `evaluate` VALUES (5855, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:43', 159);
INSERT INTO `evaluate` VALUES (5856, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:43', 160);
INSERT INTO `evaluate` VALUES (5857, 6, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:43', 161);
INSERT INTO `evaluate` VALUES (5858, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 138);
INSERT INTO `evaluate` VALUES (5859, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 139);
INSERT INTO `evaluate` VALUES (5860, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 140);
INSERT INTO `evaluate` VALUES (5861, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 141);
INSERT INTO `evaluate` VALUES (5862, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 142);
INSERT INTO `evaluate` VALUES (5863, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 143);
INSERT INTO `evaluate` VALUES (5864, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 144);
INSERT INTO `evaluate` VALUES (5865, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 145);
INSERT INTO `evaluate` VALUES (5866, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 146);
INSERT INTO `evaluate` VALUES (5867, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 147);
INSERT INTO `evaluate` VALUES (5868, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 148);
INSERT INTO `evaluate` VALUES (5869, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 149);
INSERT INTO `evaluate` VALUES (5870, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 150);
INSERT INTO `evaluate` VALUES (5871, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 151);
INSERT INTO `evaluate` VALUES (5872, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 152);
INSERT INTO `evaluate` VALUES (5873, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 153);
INSERT INTO `evaluate` VALUES (5874, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 154);
INSERT INTO `evaluate` VALUES (5875, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 155);
INSERT INTO `evaluate` VALUES (5876, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 156);
INSERT INTO `evaluate` VALUES (5877, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 157);
INSERT INTO `evaluate` VALUES (5878, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 158);
INSERT INTO `evaluate` VALUES (5879, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 159);
INSERT INTO `evaluate` VALUES (5880, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 160);
INSERT INTO `evaluate` VALUES (5881, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 161);
INSERT INTO `evaluate` VALUES (5882, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 138);
INSERT INTO `evaluate` VALUES (5883, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 139);
INSERT INTO `evaluate` VALUES (5884, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 140);
INSERT INTO `evaluate` VALUES (5885, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 141);
INSERT INTO `evaluate` VALUES (5886, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 142);
INSERT INTO `evaluate` VALUES (5887, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 143);
INSERT INTO `evaluate` VALUES (5888, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 144);
INSERT INTO `evaluate` VALUES (5889, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 145);
INSERT INTO `evaluate` VALUES (5890, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 146);
INSERT INTO `evaluate` VALUES (5891, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 147);
INSERT INTO `evaluate` VALUES (5892, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 148);
INSERT INTO `evaluate` VALUES (5893, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 149);
INSERT INTO `evaluate` VALUES (5894, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 150);
INSERT INTO `evaluate` VALUES (5895, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 151);
INSERT INTO `evaluate` VALUES (5896, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 152);
INSERT INTO `evaluate` VALUES (5897, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 153);
INSERT INTO `evaluate` VALUES (5898, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 154);
INSERT INTO `evaluate` VALUES (5899, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 155);
INSERT INTO `evaluate` VALUES (5900, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 156);
INSERT INTO `evaluate` VALUES (5901, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 157);
INSERT INTO `evaluate` VALUES (5902, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 158);
INSERT INTO `evaluate` VALUES (5903, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 159);
INSERT INTO `evaluate` VALUES (5904, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 160);
INSERT INTO `evaluate` VALUES (5905, 7, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:49', 161);
INSERT INTO `evaluate` VALUES (5906, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 138);
INSERT INTO `evaluate` VALUES (5907, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 139);
INSERT INTO `evaluate` VALUES (5908, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 140);
INSERT INTO `evaluate` VALUES (5909, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 141);
INSERT INTO `evaluate` VALUES (5910, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 142);
INSERT INTO `evaluate` VALUES (5911, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 143);
INSERT INTO `evaluate` VALUES (5912, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 144);
INSERT INTO `evaluate` VALUES (5913, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 145);
INSERT INTO `evaluate` VALUES (5914, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 146);
INSERT INTO `evaluate` VALUES (5915, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 147);
INSERT INTO `evaluate` VALUES (5916, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 148);
INSERT INTO `evaluate` VALUES (5917, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 149);
INSERT INTO `evaluate` VALUES (5919, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 151);
INSERT INTO `evaluate` VALUES (5920, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 152);
INSERT INTO `evaluate` VALUES (5921, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 153);
INSERT INTO `evaluate` VALUES (5922, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 154);
INSERT INTO `evaluate` VALUES (5923, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 155);
INSERT INTO `evaluate` VALUES (5924, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 156);
INSERT INTO `evaluate` VALUES (5925, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 157);
INSERT INTO `evaluate` VALUES (5926, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 158);
INSERT INTO `evaluate` VALUES (5927, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 159);
INSERT INTO `evaluate` VALUES (5928, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 160);
INSERT INTO `evaluate` VALUES (5929, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 161);
INSERT INTO `evaluate` VALUES (5930, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 138);
INSERT INTO `evaluate` VALUES (5931, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 139);
INSERT INTO `evaluate` VALUES (5932, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 140);
INSERT INTO `evaluate` VALUES (5933, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 141);
INSERT INTO `evaluate` VALUES (5934, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 142);
INSERT INTO `evaluate` VALUES (5935, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 143);
INSERT INTO `evaluate` VALUES (5936, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 144);
INSERT INTO `evaluate` VALUES (5937, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 145);
INSERT INTO `evaluate` VALUES (5938, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 146);
INSERT INTO `evaluate` VALUES (5939, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 147);
INSERT INTO `evaluate` VALUES (5940, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 148);
INSERT INTO `evaluate` VALUES (5941, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 149);
INSERT INTO `evaluate` VALUES (5942, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 150);
INSERT INTO `evaluate` VALUES (5943, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 151);
INSERT INTO `evaluate` VALUES (5944, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 152);
INSERT INTO `evaluate` VALUES (5945, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 153);
INSERT INTO `evaluate` VALUES (5946, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 154);
INSERT INTO `evaluate` VALUES (5947, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 155);
INSERT INTO `evaluate` VALUES (5948, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 156);
INSERT INTO `evaluate` VALUES (5949, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 157);
INSERT INTO `evaluate` VALUES (5950, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 158);
INSERT INTO `evaluate` VALUES (5951, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 159);
INSERT INTO `evaluate` VALUES (5952, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 160);
INSERT INTO `evaluate` VALUES (5953, 5, '旺旺', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '2020-07-05 15:08:53', 161);

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `goods_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL COMMENT '商品名称',
  `goods_price` float(11, 2) NOT NULL COMMENT '商品价格',
  `goods_img` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL COMMENT '商品图示',
  `goods_describe` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL COMMENT '商品简述',
  `goods_merchant` varchar(100) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL COMMENT '所属店铺',
  `goods_stocks` int(11) NOT NULL DEFAULT 0 COMMENT '商品库存',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 162 CHARACTER SET = utf8 COLLATE = utf8_croatian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (92, '三只松鼠坚果礼包', 0.03, '/static/data/goods/1593930205305554.jpg', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '三只松鼠', 0);
INSERT INTO `goods` VALUES (93, '三只松鼠坚果礼包', 0.02, '/static/data/goods/1593930223949957.jpg', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '三只松鼠', 0);
INSERT INTO `goods` VALUES (94, '三只松鼠坚果礼包', 0.01, '/static/data/goods/1593930241564419.jpg', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '三只松鼠', 3);
INSERT INTO `goods` VALUES (95, '三只松鼠坚果礼包', 0.01, '/static/data/goods/1593930266523193.jpg', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '三只松鼠', 0);
INSERT INTO `goods` VALUES (96, '三只松鼠坚果礼包', 0.01, '/static/data/goods/1593930283563293.jpg', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '三只松鼠', 0);
INSERT INTO `goods` VALUES (97, '三只松鼠坚果礼包', 0.01, '/static/data/goods/1593930301821774.jpg', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '三只松鼠', 0);
INSERT INTO `goods` VALUES (98, '三只松鼠坚果礼包', 0.01, '/static/data/goods/1593930311167236.jpg', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '三只松鼠', 0);
INSERT INTO `goods` VALUES (99, '三只松鼠坚果礼包', 0.01, '/static/data/goods/1593930323786618.jpg', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '三只松鼠', 0);
INSERT INTO `goods` VALUES (100, '三只松鼠坚果礼包', 0.01, '/static/data/goods/1593930337850503.jpg', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '三只松鼠', 0);
INSERT INTO `goods` VALUES (101, '三只松鼠坚果礼包', 0.01, '/static/data/goods/1593930349431100.jpg', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '三只松鼠', 0);
INSERT INTO `goods` VALUES (102, '三只松鼠坚果礼包', 0.01, '/static/data/goods/1593930848991513.jpg', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '三只松鼠', 0);
INSERT INTO `goods` VALUES (106, '三只松鼠坚果礼包', 0.01, '/static/data/goods/1593930908505450.jpg', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '三只松鼠', 0);
INSERT INTO `goods` VALUES (107, '三只松鼠坚果礼包', 0.01, '/static/data/goods/1593930919191763.jpg', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '三只松鼠', 0);
INSERT INTO `goods` VALUES (108, '三只松鼠坚果礼包', 0.01, '/static/data/goods/1593930935539288.jpg', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '三只松鼠', 0);
INSERT INTO `goods` VALUES (109, '三只松鼠坚果礼包', 0.01, '/static/data/goods/1593930952864675.jpg', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '三只松鼠', 0);
INSERT INTO `goods` VALUES (111, '三只松鼠坚果礼包', 0.01, '/static/data/goods/1593930980814907.jpg', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '三只松鼠', 0);
INSERT INTO `goods` VALUES (112, '三只松鼠坚果礼包', 0.01, '/static/data/goods/1593930996430523.jpg', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '三只松鼠', 0);
INSERT INTO `goods` VALUES (113, '三只松鼠坚果礼包', 0.01, '/static/data/goods/1593931008452468.jpg', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '三只松鼠', 0);
INSERT INTO `goods` VALUES (114, '三只松鼠坚果礼包', 0.01, '/static/data/goods/1593931020645993.jpg', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '三只松鼠', 0);
INSERT INTO `goods` VALUES (115, '三只松鼠坚果礼包', 0.01, '/static/data/goods/1594626976782992.jpg', '三只松鼠每日坚果大礼包 孕妇零食节日礼物送女友混合干果礼盒榛子腰果巴旦木葡萄干核桃仁开心果 750g/30袋', '三只松鼠', 3);
INSERT INTO `goods` VALUES (116, '乐事薯片', 0.02, '/static/data/goods/1593931090868191.jpg', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '乐事', 0);
INSERT INTO `goods` VALUES (117, '乐事薯片', 0.01, '/static/data/goods/1593931111308218.jpg', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '乐事', 0);
INSERT INTO `goods` VALUES (118, '乐事薯片', 0.01, '/static/data/goods/1593931126759674.jpg', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '乐事', 0);
INSERT INTO `goods` VALUES (119, '乐事薯片', 0.01, '/static/data/goods/1593931137312860.jpg', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '乐事', 0);
INSERT INTO `goods` VALUES (120, '乐事薯片', 0.01, '/static/data/goods/1593931156608666.jpg', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '乐事', 0);
INSERT INTO `goods` VALUES (121, '乐事薯片', 0.01, '/static/data/goods/1593931168836276.jpg', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '乐事', 0);
INSERT INTO `goods` VALUES (122, '乐事薯片', 0.01, '/static/data/goods/1593931180132244.jpg', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '乐事', 0);
INSERT INTO `goods` VALUES (123, '乐事薯片', 0.01, '/static/data/goods/1593931193104064.jpg', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '乐事', 0);
INSERT INTO `goods` VALUES (124, '乐事薯片', 0.01, '/static/data/goods/1593931208483917.jpg', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '乐事', 0);
INSERT INTO `goods` VALUES (125, '乐事薯片', 0.01, '/static/data/goods/1593931221805706.jpg', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '乐事', 0);
INSERT INTO `goods` VALUES (126, '乐事薯片', 0.01, '/static/data/goods/1593931234309344.jpg', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '乐事', 0);
INSERT INTO `goods` VALUES (127, '乐事薯片', 0.01, '/static/data/goods/1593931245578482.jpg', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '乐事', 0);
INSERT INTO `goods` VALUES (128, '乐事薯片', 0.01, '/static/data/goods/1593931257886923.jpg', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '乐事', 0);
INSERT INTO `goods` VALUES (129, '乐事薯片', 0.01, '/static/data/goods/1593931268978741.jpg', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '乐事', 0);
INSERT INTO `goods` VALUES (130, '乐事薯片', 0.01, '/static/data/goods/1593931279298962.jpg', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '乐事', 0);
INSERT INTO `goods` VALUES (131, '乐事薯片', 0.01, '/static/data/goods/1593931297294650.jpg', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '乐事', 0);
INSERT INTO `goods` VALUES (132, '乐事薯片', 0.01, '/static/data/goods/1593931310355487.jpg', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '乐事', 0);
INSERT INTO `goods` VALUES (133, '乐事薯片', 0.01, '/static/data/goods/1593931322199920.jpg', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '乐事', 0);
INSERT INTO `goods` VALUES (134, '乐事薯片', 0.01, '/static/data/goods/1593931338478506.jpg', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '乐事', 0);
INSERT INTO `goods` VALUES (135, '乐事薯片', 0.01, '/static/data/goods/1593931350188632.jpg', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '乐事', 0);
INSERT INTO `goods` VALUES (136, '乐事薯片', 0.01, '/static/data/goods/1593931360442388.jpg', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '乐事', 0);
INSERT INTO `goods` VALUES (137, '乐事薯片', 0.01, '/static/data/goods/1593931370168170.jpg', '乐事（Lay\'s）薯片 休闲食品 番茄炒蛋礼包 真脆薯条 百事食品', '乐事', 0);
INSERT INTO `goods` VALUES (138, '旺旺小零食', 0.01, '/static/data/goods/1593931454965145.jpg', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '旺旺', 0);
INSERT INTO `goods` VALUES (139, '旺旺小零食', 0.01, '/static/data/goods/1593931471869976.jpg', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '旺旺', 0);
INSERT INTO `goods` VALUES (140, '旺旺小零食', 0.01, '/static/data/goods/1593931481553955.jpg', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '旺旺', 0);
INSERT INTO `goods` VALUES (141, '旺旺小零食', 0.01, '/static/data/goods/1593931491525637.jpg', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '旺旺', 0);
INSERT INTO `goods` VALUES (142, '旺旺小零食', 0.01, '/static/data/goods/1593931525914910.jpg', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '旺旺', 0);
INSERT INTO `goods` VALUES (143, '旺旺小零食', 0.01, '/static/data/goods/1593931539499545.jpg', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '旺旺', 0);
INSERT INTO `goods` VALUES (144, '旺旺小零食', 0.01, '/static/data/goods/1593931549704522.jpg', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '旺旺', 0);
INSERT INTO `goods` VALUES (145, '旺旺小零食', 0.01, '/static/data/goods/1593931560373889.jpg', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '旺旺', 0);
INSERT INTO `goods` VALUES (146, '旺旺小零食', 0.01, '/static/data/goods/1593931569896536.jpg', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '旺旺', 0);
INSERT INTO `goods` VALUES (147, '旺旺小零食', 0.01, '/static/data/goods/1593931579207803.jpg', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '旺旺', 0);
INSERT INTO `goods` VALUES (148, '旺旺小零食', 0.01, '/static/data/goods/1593931593486032.jpg', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '旺旺', 0);
INSERT INTO `goods` VALUES (149, '旺旺小零食', 0.01, '/static/data/goods/1593931602481555.jpg', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '旺旺', 0);
INSERT INTO `goods` VALUES (151, '旺旺小零食', 0.01, '/static/data/goods/1593931657266799.jpg', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '旺旺', 0);
INSERT INTO `goods` VALUES (152, '旺旺小零食', 0.01, '/static/data/goods/1593931668916201.jpg', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '旺旺', 0);
INSERT INTO `goods` VALUES (153, '旺旺小零食', 0.01, '/static/data/goods/1593931681475979.jpg', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '旺旺', 0);
INSERT INTO `goods` VALUES (154, '旺旺小零食', 0.01, '/static/data/goods/1593931692918344.jpg', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '旺旺', 0);
INSERT INTO `goods` VALUES (155, '旺旺小零食', 0.01, '/static/data/goods/1593931700230792.jpg', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '旺旺', 0);
INSERT INTO `goods` VALUES (156, '旺旺小零食', 0.01, '/static/data/goods/1593931711211785.jpg', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '旺旺', 0);
INSERT INTO `goods` VALUES (157, '旺旺小零食', 0.01, '/static/data/goods/1593931721338320.jpg', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '旺旺', 0);
INSERT INTO `goods` VALUES (158, '旺旺小零食', 0.01, '/static/data/goods/1593931733664395.jpg', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '旺旺', 0);
INSERT INTO `goods` VALUES (159, '旺旺小零食', 0.01, '/static/data/goods/1593931766325933.jpg', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '旺旺', 0);
INSERT INTO `goods` VALUES (160, '旺旺小零食', 0.01, '/static/data/goods/1593931783291107.jpg', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '旺旺', 0);
INSERT INTO `goods` VALUES (161, '旺旺小零食', 0.01, '/static/data/goods/1593931792778735.jpg', '旺旺 棒棒冰 雪糕冰淇淋 果味饮料 综合口味 (家庭号) 1.56L', '旺旺', 0);

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '会员id',
  `mb_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL COMMENT '会员名称',
  `mb_pwd` varchar(100) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL COMMENT '会员密码',
  `mb_create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `mb_head_img` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL DEFAULT '/static/img/head_img.jpg' COMMENT '会员头像',
  `mb_email` varchar(100) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL COMMENT '会员邮箱',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `mb_name`(`mb_name`) USING BTREE COMMENT '名称唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_croatian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES (5, 'test', 'e10adc3949ba59abbe56e057f20f883e', '2020-06-29 13:38:10', '/static/data/mb_head_img/1593266188175201.jpg', '2390025289@qq.com');
INSERT INTO `member` VALUES (6, 'test2', 'e10adc3949ba59abbe56e057f20f883e', '2020-06-28 00:45:13', '/static/data/mb_head_img/1593276313932269.jpg', 'bosen_qe@qq.com');
INSERT INTO `member` VALUES (7, 'test3', 'e10adc3949ba59abbe56e057f20f883e', '2020-06-28 00:49:33', '/static/data/mb_head_img/1593276573546264.jpg', 'w2390025289@163.com');
INSERT INTO `member` VALUES (11, 'test4', 'e10adc3949ba59abbe56e057f20f883e', '2020-09-01 14:39:30', '/static/img/head_img.jpg', 'w2390025289@163.com');
INSERT INTO `member` VALUES (13, 'test5', 'e10adc3949ba59abbe56e057f20f883e', '2020-09-01 14:39:48', '/static/img/head_img.jpg', 'w2390025289@163.com');
INSERT INTO `member` VALUES (14, 'test6', 'e10adc3949ba59abbe56e057f20f883e', '2020-09-01 14:39:56', '/static/img/head_img.jpg', 'w2390025289@163.com');
INSERT INTO `member` VALUES (15, 'test7', 'e10adc3949ba59abbe56e057f20f883e', '2020-09-01 14:40:06', '/static/img/head_img.jpg', 'w2390025289@163.com');
INSERT INTO `member` VALUES (16, 'test8', 'e10adc3949ba59abbe56e057f20f883e', '2020-09-01 14:40:12', '/static/img/head_img.jpg', 'w2390025289@163.com');
INSERT INTO `member` VALUES (17, 'test9', 'e10adc3949ba59abbe56e057f20f883e', '2020-09-01 14:40:18', '/static/img/head_img.jpg', 'w2390025289@163.com');
INSERT INTO `member` VALUES (18, 'test10', 'e10adc3949ba59abbe56e057f20f883e', '2020-09-01 14:40:24', '/static/img/head_img.jpg', 'w2390025289@163.com');
INSERT INTO `member` VALUES (19, 'test11', 'e10adc3949ba59abbe56e057f20f883e', '2020-09-01 14:40:30', '/static/img/head_img.jpg', 'w2390025289@163.com');
INSERT INTO `member` VALUES (20, 'test12', 'e10adc3949ba59abbe56e057f20f883e', '2020-09-01 14:40:37', '/static/img/head_img.jpg', 'w2390025289@163.com');
INSERT INTO `member` VALUES (21, 'test13', 'e10adc3949ba59abbe56e057f20f883e', '2020-09-01 14:40:46', '/static/img/head_img.jpg', 'w2390025289@163.com');
INSERT INTO `member` VALUES (22, 'test14', 'e10adc3949ba59abbe56e057f20f883e', '2020-09-01 14:40:53', '/static/img/head_img.jpg', 'w2390025289@163.com');
INSERT INTO `member` VALUES (23, 'test15', 'e10adc3949ba59abbe56e057f20f883e', '2020-09-01 14:41:01', '/static/img/head_img.jpg', 'w2390025289@163.com');

-- ----------------------------
-- Table structure for merchant
-- ----------------------------
DROP TABLE IF EXISTS `merchant`;
CREATE TABLE `merchant`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mt_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL COMMENT '商户名称',
  `mt_pwd` varchar(100) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL COMMENT '商户密码',
  `mt_email` varchar(100) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL COMMENT '商户邮箱',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `mt_ratio` float(10, 2) NOT NULL DEFAULT 0.10 COMMENT '支付比率',
  `mt_head_img` varchar(200) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '商户头像',
  `mt_status` tinyint(3) NOT NULL DEFAULT 0 COMMENT '0待审核1审核通过2可运营3停用',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `mt_name`(`mt_name`) USING BTREE COMMENT '唯一名称',
  UNIQUE INDEX `mt_email`(`mt_email`) USING BTREE COMMENT '唯一邮箱'
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_croatian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of merchant
-- ----------------------------
INSERT INTO `merchant` VALUES (2, '三只松鼠', 'e10adc3949ba59abbe56e057f20f883e', '2390025289@qq.com', '2020-06-22 13:04:08', 0.10, '/static/data/mt_head_img/songshu.jpg', 2);
INSERT INTO `merchant` VALUES (3, '乐事', 'e10adc3949ba59abbe56e057f20f883e', 'bosen_qe@qq.com', '2020-06-22 14:09:02', 0.10, '/static/data/mt_head_img/leshi.jpg', 2);
INSERT INTO `merchant` VALUES (4, '旺旺', 'e10adc3949ba59abbe56e057f20f883e', 'w2390025289@163.com', '2020-06-23 13:22:38', 0.10, '/static/data/mt_head_img/wangwang.jpg', 2);
INSERT INTO `merchant` VALUES (6, '测试', 'e10adc3949ba59abbe56e057f20f883e', '13416263336@163.com', '2020-07-13 13:41:46', 0.10, '/static/data/mt_head_img/1594628929285202.jpg', 2);

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mb_id` int(11) NOT NULL COMMENT '接受通知的用户id',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL COMMENT '通知标题',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL COMMENT '通知内容',
  `is_read` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1已读，0未读',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '通知时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26118 CHARACTER SET = utf8 COLLATE = utf8_croatian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (25956, 3, '测试标题', '测试内容', 0, '2020-09-01 13:59:53');
INSERT INTO `notice` VALUES (25957, 3, '测试标题', '测试内容', 0, '2020-09-01 14:00:01');
INSERT INTO `notice` VALUES (25958, 3, '测试标题', '测试内容', 0, '2020-09-01 14:00:43');
INSERT INTO `notice` VALUES (25959, 3, '测试标题', '测试内容', 0, '2020-09-01 14:00:44');
INSERT INTO `notice` VALUES (25960, 3, '测试标题', '测试内容', 0, '2020-09-01 14:00:44');
INSERT INTO `notice` VALUES (25961, 3, '测试标题', '测试内容', 0, '2020-09-01 14:00:45');
INSERT INTO `notice` VALUES (25962, 3, '测试标题', '测试内容', 0, '2020-09-01 14:00:46');
INSERT INTO `notice` VALUES (25963, 3, '测试标题', '测试内容', 0, '2020-09-01 14:00:47');
INSERT INTO `notice` VALUES (25964, 3, '测试标题', '测试内容', 0, '2020-09-01 14:00:48');
INSERT INTO `notice` VALUES (25965, 3, '测试标题', '测试内容', 0, '2020-09-01 14:00:49');
INSERT INTO `notice` VALUES (25966, 3, '测试标题', '测试内容', 0, '2020-09-01 14:00:50');
INSERT INTO `notice` VALUES (25967, 3, '测试标题', '测试内容', 0, '2020-09-01 14:00:51');
INSERT INTO `notice` VALUES (25968, 3, '测试标题', '测试内容', 0, '2020-09-01 14:00:51');
INSERT INTO `notice` VALUES (25969, 3, '测试标题', '测试内容', 0, '2020-09-01 14:00:52');
INSERT INTO `notice` VALUES (25970, 3, '测试标题', '测试内容', 0, '2020-09-01 14:00:52');
INSERT INTO `notice` VALUES (25971, 3, '测试标题', '测试内容', 0, '2020-09-01 14:00:53');
INSERT INTO `notice` VALUES (25972, 3, '测试标题', '测试内容', 0, '2020-09-01 14:00:53');
INSERT INTO `notice` VALUES (25973, 3, '测试标题', '测试内容', 0, '2020-09-01 14:00:54');
INSERT INTO `notice` VALUES (25974, 3, '测试标题', '测试内容', 0, '2020-09-01 14:00:54');
INSERT INTO `notice` VALUES (25975, 3, '测试标题', '测试内容', 0, '2020-09-01 14:00:55');
INSERT INTO `notice` VALUES (25976, 3, '测试标题', '测试内容', 0, '2020-09-01 14:00:55');
INSERT INTO `notice` VALUES (25977, 3, '测试标题', '测试内容', 0, '2020-09-01 14:00:56');
INSERT INTO `notice` VALUES (25978, 3, '测试标题', '测试内容', 0, '2020-09-01 14:00:56');
INSERT INTO `notice` VALUES (25979, 3, '测试标题', '测试内容', 0, '2020-09-01 14:00:57');
INSERT INTO `notice` VALUES (25980, 3, '测试标题', '测试内容', 0, '2020-09-01 14:00:57');
INSERT INTO `notice` VALUES (25981, 3, '测试标题', '测试内容', 0, '2020-09-01 14:00:58');
INSERT INTO `notice` VALUES (25982, 3, '测试标题', '测试内容', 0, '2020-09-01 14:00:58');
INSERT INTO `notice` VALUES (25983, 3, '测试标题', '测试内容', 0, '2020-09-01 14:00:59');
INSERT INTO `notice` VALUES (25984, 3, '测试标题', '测试内容', 0, '2020-09-01 14:00:59');
INSERT INTO `notice` VALUES (25985, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:00');
INSERT INTO `notice` VALUES (25986, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:00');
INSERT INTO `notice` VALUES (25987, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:01');
INSERT INTO `notice` VALUES (25988, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:01');
INSERT INTO `notice` VALUES (25989, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:02');
INSERT INTO `notice` VALUES (25990, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:02');
INSERT INTO `notice` VALUES (25991, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:03');
INSERT INTO `notice` VALUES (25992, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:03');
INSERT INTO `notice` VALUES (25993, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:04');
INSERT INTO `notice` VALUES (25994, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:04');
INSERT INTO `notice` VALUES (25995, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:05');
INSERT INTO `notice` VALUES (25996, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:05');
INSERT INTO `notice` VALUES (25997, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:06');
INSERT INTO `notice` VALUES (25998, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:06');
INSERT INTO `notice` VALUES (25999, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:07');
INSERT INTO `notice` VALUES (26000, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:07');
INSERT INTO `notice` VALUES (26001, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:08');
INSERT INTO `notice` VALUES (26002, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:08');
INSERT INTO `notice` VALUES (26003, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:09');
INSERT INTO `notice` VALUES (26004, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:09');
INSERT INTO `notice` VALUES (26005, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:10');
INSERT INTO `notice` VALUES (26006, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:10');
INSERT INTO `notice` VALUES (26007, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:11');
INSERT INTO `notice` VALUES (26008, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:11');
INSERT INTO `notice` VALUES (26009, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:12');
INSERT INTO `notice` VALUES (26010, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:12');
INSERT INTO `notice` VALUES (26011, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:13');
INSERT INTO `notice` VALUES (26012, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:13');
INSERT INTO `notice` VALUES (26013, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:14');
INSERT INTO `notice` VALUES (26014, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:14');
INSERT INTO `notice` VALUES (26015, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:15');
INSERT INTO `notice` VALUES (26016, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:15');
INSERT INTO `notice` VALUES (26017, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:16');
INSERT INTO `notice` VALUES (26018, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:16');
INSERT INTO `notice` VALUES (26019, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:17');
INSERT INTO `notice` VALUES (26020, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:17');
INSERT INTO `notice` VALUES (26021, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:18');
INSERT INTO `notice` VALUES (26022, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:18');
INSERT INTO `notice` VALUES (26023, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:19');
INSERT INTO `notice` VALUES (26024, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:19');
INSERT INTO `notice` VALUES (26025, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:20');
INSERT INTO `notice` VALUES (26026, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:20');
INSERT INTO `notice` VALUES (26027, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:21');
INSERT INTO `notice` VALUES (26028, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:21');
INSERT INTO `notice` VALUES (26029, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:22');
INSERT INTO `notice` VALUES (26030, 3, '测试标题', '测试内容', 0, '2020-09-01 14:01:47');
INSERT INTO `notice` VALUES (26031, 4, '测试标题', '测试内容', 0, '2020-09-01 14:02:40');
INSERT INTO `notice` VALUES (26032, 5, '测试标题', '测试内容', 0, '2020-09-01 14:02:51');
INSERT INTO `notice` VALUES (26033, 6, '测试标题', '测试内容', 0, '2020-09-01 14:03:03');
INSERT INTO `notice` VALUES (26034, 7, '测试标题', '测试内容', 0, '2020-09-01 14:03:22');
INSERT INTO `notice` VALUES (26035, 8, '测试标题', '测试内容', 0, '2020-09-01 14:03:23');
INSERT INTO `notice` VALUES (26036, 9, '测试标题', '测试内容', 0, '2020-09-01 14:03:23');
INSERT INTO `notice` VALUES (26037, 10, '测试标题', '测试内容', 0, '2020-09-01 14:03:24');
INSERT INTO `notice` VALUES (26038, 1, '测试标题', '测试内容', 0, '2020-09-01 14:03:35');
INSERT INTO `notice` VALUES (26039, 2, '测试标题', '测试内容', 0, '2020-09-01 14:03:36');
INSERT INTO `notice` VALUES (26040, 3, '测试标题', '测试内容', 0, '2020-09-01 14:03:37');
INSERT INTO `notice` VALUES (26041, 4, '测试标题', '测试内容', 0, '2020-09-01 14:03:38');
INSERT INTO `notice` VALUES (26042, 5, '测试标题', '测试内容', 0, '2020-09-01 14:03:39');
INSERT INTO `notice` VALUES (26043, 6, '测试标题', '测试内容', 0, '2020-09-01 14:03:40');
INSERT INTO `notice` VALUES (26044, 7, '测试标题', '测试内容', 0, '2020-09-01 14:03:41');
INSERT INTO `notice` VALUES (26045, 8, '测试标题', '测试内容', 0, '2020-09-01 14:03:42');
INSERT INTO `notice` VALUES (26046, 9, '测试标题', '测试内容', 0, '2020-09-01 14:03:43');
INSERT INTO `notice` VALUES (26047, 10, '测试标题', '测试内容', 0, '2020-09-01 14:03:44');
INSERT INTO `notice` VALUES (26048, 1, '测试标题', '测试内容', 0, '2020-09-01 14:04:12');
INSERT INTO `notice` VALUES (26049, 2, '测试标题', '测试内容', 0, '2020-09-01 14:04:13');
INSERT INTO `notice` VALUES (26050, 3, '测试标题', '测试内容', 0, '2020-09-01 14:04:13');
INSERT INTO `notice` VALUES (26051, 4, '测试标题', '测试内容', 0, '2020-09-01 14:04:14');
INSERT INTO `notice` VALUES (26052, 5, '测试标题', '测试内容', 0, '2020-09-01 14:04:15');
INSERT INTO `notice` VALUES (26053, 6, '测试标题', '测试内容', 0, '2020-09-01 14:04:16');
INSERT INTO `notice` VALUES (26054, 7, '测试标题', '测试内容', 0, '2020-09-01 14:04:17');
INSERT INTO `notice` VALUES (26055, 8, '测试标题', '测试内容', 0, '2020-09-01 14:04:18');
INSERT INTO `notice` VALUES (26056, 9, '测试标题', '测试内容', 0, '2020-09-01 14:04:19');
INSERT INTO `notice` VALUES (26057, 10, '测试标题', '测试内容', 0, '2020-09-01 14:04:20');
INSERT INTO `notice` VALUES (26058, 1, '测试标题', '测试内容', 0, '2020-09-01 14:04:27');
INSERT INTO `notice` VALUES (26059, 2, '测试标题', '测试内容', 0, '2020-09-01 14:04:28');
INSERT INTO `notice` VALUES (26060, 3, '测试标题', '测试内容', 0, '2020-09-01 14:04:29');
INSERT INTO `notice` VALUES (26061, 4, '测试标题', '测试内容', 0, '2020-09-01 14:04:30');
INSERT INTO `notice` VALUES (26062, 5, '测试标题', '测试内容', 0, '2020-09-01 14:04:31');
INSERT INTO `notice` VALUES (26063, 6, '测试标题', '测试内容', 0, '2020-09-01 14:04:32');
INSERT INTO `notice` VALUES (26064, 7, '测试标题', '测试内容', 0, '2020-09-01 14:04:33');
INSERT INTO `notice` VALUES (26065, 8, '测试标题', '测试内容', 0, '2020-09-01 14:04:34');
INSERT INTO `notice` VALUES (26066, 9, '测试标题', '测试内容', 0, '2020-09-01 14:04:35');
INSERT INTO `notice` VALUES (26067, 10, '测试标题', '测试内容', 0, '2020-09-01 14:04:36');
INSERT INTO `notice` VALUES (26068, 1, '测试标题', '测试内容', 0, '2020-09-01 14:05:07');
INSERT INTO `notice` VALUES (26069, 2, '测试标题', '测试内容', 0, '2020-09-01 14:05:08');
INSERT INTO `notice` VALUES (26070, 3, '测试标题', '测试内容', 0, '2020-09-01 14:05:09');
INSERT INTO `notice` VALUES (26071, 4, '测试标题', '测试内容', 0, '2020-09-01 14:05:10');
INSERT INTO `notice` VALUES (26072, 5, '测试标题', '测试内容', 0, '2020-09-01 14:05:11');
INSERT INTO `notice` VALUES (26073, 6, '测试标题', '测试内容', 0, '2020-09-01 14:05:12');
INSERT INTO `notice` VALUES (26074, 7, '测试标题', '测试内容', 0, '2020-09-01 14:05:13');
INSERT INTO `notice` VALUES (26075, 8, '测试标题', '测试内容', 0, '2020-09-01 14:05:14');
INSERT INTO `notice` VALUES (26076, 9, '测试标题', '测试内容', 0, '2020-09-01 14:05:15');
INSERT INTO `notice` VALUES (26077, 10, '测试标题', '测试内容', 0, '2020-09-01 14:05:16');
INSERT INTO `notice` VALUES (26078, 1, '测试标题', '测试内容', 0, '2020-09-01 14:06:21');
INSERT INTO `notice` VALUES (26079, 2, '测试标题', '测试内容', 0, '2020-09-01 14:06:22');
INSERT INTO `notice` VALUES (26080, 3, '测试标题', '测试内容', 0, '2020-09-01 14:06:23');
INSERT INTO `notice` VALUES (26081, 4, '测试标题', '测试内容', 0, '2020-09-01 14:06:24');
INSERT INTO `notice` VALUES (26082, 5, '测试标题', '测试内容', 0, '2020-09-01 14:06:25');
INSERT INTO `notice` VALUES (26083, 6, '测试标题', '测试内容', 0, '2020-09-01 14:06:26');
INSERT INTO `notice` VALUES (26084, 7, '测试标题', '测试内容', 0, '2020-09-01 14:06:27');
INSERT INTO `notice` VALUES (26085, 8, '测试标题', '测试内容', 0, '2020-09-01 14:06:28');
INSERT INTO `notice` VALUES (26086, 9, '测试标题', '测试内容', 0, '2020-09-01 14:06:29');
INSERT INTO `notice` VALUES (26087, 10, '测试标题', '测试内容', 0, '2020-09-01 14:06:30');
INSERT INTO `notice` VALUES (26088, 1, '测试标题', '测试内容', 0, '2020-09-01 14:09:27');
INSERT INTO `notice` VALUES (26089, 2, '测试标题', '测试内容', 0, '2020-09-01 14:09:27');
INSERT INTO `notice` VALUES (26090, 3, '测试标题', '测试内容', 0, '2020-09-01 14:09:27');
INSERT INTO `notice` VALUES (26091, 4, '测试标题', '测试内容', 0, '2020-09-01 14:09:27');
INSERT INTO `notice` VALUES (26092, 5, '测试标题', '测试内容', 0, '2020-09-01 14:09:27');
INSERT INTO `notice` VALUES (26093, 6, '测试标题', '测试内容', 0, '2020-09-01 14:09:27');
INSERT INTO `notice` VALUES (26094, 7, '测试标题', '测试内容', 0, '2020-09-01 14:09:27');
INSERT INTO `notice` VALUES (26095, 8, '测试标题', '测试内容', 0, '2020-09-01 14:09:27');
INSERT INTO `notice` VALUES (26096, 9, '测试标题', '测试内容', 0, '2020-09-01 14:09:28');
INSERT INTO `notice` VALUES (26097, 10, '测试标题', '测试内容', 0, '2020-09-01 14:09:29');
INSERT INTO `notice` VALUES (26098, 1, '测试标题', '测试内容', 0, '2020-09-01 14:09:32');
INSERT INTO `notice` VALUES (26099, 2, '测试标题', '测试内容', 0, '2020-09-01 14:09:33');
INSERT INTO `notice` VALUES (26100, 3, '测试标题', '测试内容', 0, '2020-09-01 14:09:34');
INSERT INTO `notice` VALUES (26101, 4, '测试标题', '测试内容', 0, '2020-09-01 14:09:35');
INSERT INTO `notice` VALUES (26102, 5, '测试标题', '测试内容', 0, '2020-09-01 14:09:36');
INSERT INTO `notice` VALUES (26103, 6, '测试标题', '测试内容', 0, '2020-09-01 14:09:37');
INSERT INTO `notice` VALUES (26104, 7, '测试标题', '测试内容', 0, '2020-09-01 14:09:38');
INSERT INTO `notice` VALUES (26105, 8, '测试标题', '测试内容', 0, '2020-09-01 14:09:39');
INSERT INTO `notice` VALUES (26106, 9, '测试标题', '测试内容', 0, '2020-09-01 14:09:40');
INSERT INTO `notice` VALUES (26107, 10, '测试标题', '测试内容', 0, '2020-09-01 14:09:41');
INSERT INTO `notice` VALUES (26108, 1, '测试标题', '测试内容', 0, '2020-09-01 14:10:29');
INSERT INTO `notice` VALUES (26109, 2, '测试标题', '测试内容', 0, '2020-09-01 14:10:30');
INSERT INTO `notice` VALUES (26110, 3, '测试标题', '测试内容', 0, '2020-09-01 14:10:31');
INSERT INTO `notice` VALUES (26111, 4, '测试标题', '测试内容', 0, '2020-09-01 14:10:32');
INSERT INTO `notice` VALUES (26112, 5, '测试标题', '测试内容', 0, '2020-09-01 14:10:33');
INSERT INTO `notice` VALUES (26113, 6, '测试标题', '测试内容', 0, '2020-09-01 14:10:34');
INSERT INTO `notice` VALUES (26114, 7, '测试标题', '测试内容', 0, '2020-09-01 14:10:35');
INSERT INTO `notice` VALUES (26115, 8, '测试标题', '测试内容', 0, '2020-09-01 14:10:36');
INSERT INTO `notice` VALUES (26116, 9, '测试标题', '测试内容', 0, '2020-09-01 14:10:37');
INSERT INTO `notice` VALUES (26117, 10, '测试标题', '测试内容', 0, '2020-09-01 14:10:38');

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_num` varchar(100) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL COMMENT '订单号',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `order_price` float(10, 2) NOT NULL COMMENT '订单金额',
  `pay_time` timestamp(0) NULL DEFAULT NULL COMMENT '支付时间',
  `pay_status` tinyint(3) NOT NULL DEFAULT 0 COMMENT '0未支付/1微信支付/2支付宝支付',
  `order_mb_id` int(11) NOT NULL COMMENT '用户名',
  `order_mt` varchar(100) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL COMMENT '商户名',
  `goods_id` int(11) NOT NULL COMMENT '商品id',
  `mt_ratio` float(3, 2) NOT NULL COMMENT '收取商户',
  `year` varchar(10) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL COMMENT '年',
  `month` varchar(10) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL COMMENT '月',
  `day` varchar(10) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL COMMENT '日',
  `goods_num` int(11) UNSIGNED NOT NULL DEFAULT 1 COMMENT '商品件数',
  `shop_id` tinyint(3) NULL DEFAULT NULL COMMENT '对应在购物车的id，默认为空',
  `coupon_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_croatian_ci NULL DEFAULT NULL COMMENT '优惠卷的id，默认为0',
  `shop_num` varchar(100) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL COMMENT '批量支付时回调凭证',
  `time` int(11) NOT NULL DEFAULT 0 COMMENT '订单过期时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4229 CHARACTER SET = utf8 COLLATE = utf8_croatian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (230, '15937020453377', '2020-07-12 18:22:17', 0.01, '2020-07-03 16:14:05', 1, 5, '乐事', 109, 0.10, '2020', '2020-07', '2020-07-02', 1, NULL, NULL, '15937020453377', 0);
INSERT INTO `order` VALUES (264, '15937911661478', '2020-07-12 18:22:17', 0.01, '2020-07-04 00:20:26', 1, 5, '三只松鼠', 109, 0.10, '2020', '2020-07', '2020-07-03', 1, NULL, NULL, '15937020453377', 0);
INSERT INTO `order` VALUES (265, '15937914248319', '2020-07-12 18:22:17', 0.01, '2020-07-04 00:25:03', 1, 5, '三只松鼠', 109, 0.10, '2020', '2020-07', '2020-07-03', 1, NULL, NULL, '15937020453377', 0);
INSERT INTO `order` VALUES (278, '15937922863880', '2020-07-12 18:22:17', 0.01, '2020-07-04 00:10:22', 1, 5, '三只松鼠', 109, 0.10, '2020', '2020-07', '2020-07-04', 1, NULL, NULL, '15937020453377', 0);
INSERT INTO `order` VALUES (279, '15937926144735', '2020-07-12 18:22:17', 0.01, '2020-07-04 00:10:39', 1, 5, '三只松鼠', 109, 0.10, '2020', '2020-07', '2020-07-04', 1, NULL, NULL, '15937020453377', 0);
INSERT INTO `order` VALUES (295, '15938437903340', '2020-07-12 18:22:17', 0.01, '2020-07-04 14:23:25', 1, 5, '三只松鼠', 109, 0.10, '2020', '2020-07', '2020-07-04', 1, 9, NULL, '15937020453377', 0);
INSERT INTO `order` VALUES (301, '15938444296152', '2020-07-12 18:22:17', 0.01, '2020-07-04 14:23:25', 2, 5, '三只松鼠', 109, 0.10, '2020', '2020-07', '2020-07-04', 1, NULL, NULL, '15937020453377', 0);
INSERT INTO `order` VALUES (302, '15938445263034', '2020-07-12 18:22:17', 0.01, '2020-07-04 14:23:25', 2, 5, '三只松鼠', 109, 0.10, '2020', '2020-07', '2020-07-04', 1, NULL, NULL, '15937020453377', 0);
INSERT INTO `order` VALUES (303, '15938447955366', '2020-07-12 18:22:17', 0.01, '2020-07-04 14:54:46', 2, 5, '三只松鼠', 109, 0.10, '2020', '2020-07', '2020-07-04', 1, NULL, NULL, '15937020453377', 0);
INSERT INTO `order` VALUES (305, '15938455442502', '2020-07-12 18:22:17', 0.01, '2020-07-04 14:52:55', 2, 5, '三只松鼠', 109, 0.10, '2020', '2020-07', '2020-07-04', 1, NULL, NULL, '15937020453377', 0);
INSERT INTO `order` VALUES (328, '15938702322835', '2020-07-12 18:22:17', 0.01, '2020-07-04 21:44:12', 1, 5, '三只松鼠', 109, 0.10, '2020', '2020-07', '2020-07-04', 1, NULL, NULL, '15937020453377', 0);
INSERT INTO `order` VALUES (329, '15938704094645', '2020-07-12 18:22:17', 0.01, '2020-07-04 21:47:09', 2, 5, '三只松鼠', 109, 0.10, '2020', '2020-07', '2020-07-04', 1, NULL, NULL, '15937020453377', 0);
INSERT INTO `order` VALUES (442, '15938778746447', '2020-07-12 18:22:17', 0.02, '2020-07-04 23:51:57', 1, 5, '三只松鼠', 109, 0.10, '2020', '2020-07', '2020-07-04', 1, NULL, NULL, '15937020453377', 0);
INSERT INTO `order` VALUES (447, '15939187281884', '2020-07-12 18:22:17', 0.02, '2020-07-05 11:16:33', 1, 5, '三只松鼠', 93, 0.10, '2020', '2020-07', '2020-07-05', 1, NULL, NULL, '15937020453377', 0);
INSERT INTO `order` VALUES (449, '15939189101372', '2020-07-12 18:22:17', 0.01, '2020-07-05 11:15:25', 1, 5, '三只松鼠', 92, 0.10, '2020', '2020-07', '2020-07-05', 1, NULL, NULL, '15937020453377', 0);
INSERT INTO `order` VALUES (450, '15939192578589', '2020-07-12 18:22:17', 0.01, '2020-07-05 11:21:11', 1, 5, '三只松鼠', 94, 0.10, '2020', '2020-07', '2020-07-05', 1, NULL, NULL, '15937020453377', 0);
INSERT INTO `order` VALUES (451, '15939192872902', '2020-07-12 18:22:17', 0.01, '2020-07-05 11:21:44', 1, 5, '三只松鼠', 98, 0.10, '2020', '2020-07', '2020-07-05', 1, NULL, NULL, '15937020453377', 0);
INSERT INTO `order` VALUES (456, '15939198712843', '2020-07-12 18:22:17', 0.01, '2020-07-05 11:31:34', 2, 5, '三只松鼠', 96, 0.10, '2020', '2020-07', '2020-07-05', 1, NULL, NULL, '15937020453377', 0);
INSERT INTO `order` VALUES (2344, '15941899216591', '2020-07-12 18:22:17', 0.01, '2020-07-08 14:32:36', 1, 5, '三只松鼠', 95, 0.10, '2020', '2020-07', '2020-07-08', 1, 26, NULL, '15941899216591', 0);
INSERT INTO `order` VALUES (2345, '15941899218443', '2020-07-12 18:22:17', 0.01, '2020-07-08 14:32:36', 1, 5, '三只松鼠', 94, 0.10, '2020', '2020-07', '2020-07-08', 1, 25, NULL, '15941899216591', 0);
INSERT INTO `order` VALUES (2350, '15941901716946', '2020-07-12 18:22:17', 0.02, '2020-07-08 14:36:25', 1, 5, '三只松鼠', 99, 0.10, '2020', '2020-07', '2020-07-08', 1, 31, NULL, '15941901716946', 0);
INSERT INTO `order` VALUES (2351, '15941901711809', '2020-07-12 18:22:17', 0.01, '2020-07-08 14:36:25', 1, 5, '三只松鼠', 94, 0.10, '2020', '2020-07', '2020-07-08', 1, 30, NULL, '15941901716946', 0);
INSERT INTO `order` VALUES (2352, '15941910127101', '2020-07-12 18:22:17', 0.01, '2020-07-08 14:50:25', 1, 5, '三只松鼠', 94, 0.10, '2020', '2020-07', '2020-07-08', 1, 40, NULL, '15941910127101', 0);
INSERT INTO `order` VALUES (2353, '15941911027119', '2020-07-12 18:22:17', 0.01, '2020-07-08 14:51:54', 1, 5, '乐事', 123, 0.10, '2020', '2020-07', '2020-07-08', 1, 0, NULL, '15941911027119', 0);
INSERT INTO `order` VALUES (2370, '15941927022318', '2020-07-12 18:22:17', 0.01, '2020-07-08 15:18:41', 1, 5, '三只松鼠', 93, 0.10, '2020', '2020-07', '2020-07-08', 1, 0, NULL, '15941927022318', 0);
INSERT INTO `order` VALUES (2381, '15941932934366', '2020-07-12 18:22:17', 0.02, '2020-07-08 15:29:20', 2, 5, '三只松鼠', 101, 0.10, '2020', '2020-07', '2020-07-08', 1, 43, NULL, '15941932934366', 0);
INSERT INTO `order` VALUES (2382, '15941932939078', '2020-07-12 18:22:17', 0.01, '2020-07-08 15:29:20', 2, 5, '三只松鼠', 99, 0.10, '2020', '2020-07', '2020-07-08', 1, 42, NULL, '15941932934366', 0);
INSERT INTO `order` VALUES (4109, '15945605641995', '2020-07-12 21:29:31', 0.00, '2020-07-12 21:29:31', 1, 5, '三只松鼠', 94, 0.10, '2020', '2020-07', '2020-07-12', 1, 0, '27', '15945605641995', 0);
INSERT INTO `order` VALUES (4173, '15945620334877', '2020-07-12 21:54:48', 0.02, '2020-07-12 21:54:48', 1, 5, '三只松鼠', 93, 0.10, '2020', '2020-07', '2020-07-12', 1, 57, '27,33,27', '15945620334877', 0);
INSERT INTO `order` VALUES (4174, '15945620337190', '2020-07-12 21:54:48', 0.01, '2020-07-12 21:54:48', 1, 5, '三只松鼠', 94, 0.10, '2020', '2020-07', '2020-07-12', 1, 56, NULL, '15945620334877', 0);
INSERT INTO `order` VALUES (4175, '15945620339887', '2020-07-12 21:54:48', 0.01, '2020-07-12 21:54:48', 1, 5, '三只松鼠', 95, 0.10, '2020', '2020-07', '2020-07-12', 1, 55, NULL, '15945620334877', 0);
INSERT INTO `order` VALUES (4184, '15945629232067', '2020-07-12 22:09:01', 0.02, '2020-07-12 22:09:01', 1, 5, '三只松鼠', 93, 0.10, '2020', '2020-07', '2020-07-12', 1, 59, '36', '15945629232067', 0);
INSERT INTO `order` VALUES (4185, '15945629232272', '2020-07-12 22:09:01', 0.01, '2020-07-12 22:09:01', 1, 5, '三只松鼠', 94, 0.10, '2020', '2020-07', '2020-07-12', 1, 58, NULL, '15945629232067', 0);
INSERT INTO `order` VALUES (4186, '15945629778091', '2020-07-12 22:09:53', 0.01, '2020-07-12 22:09:53', 1, 5, '三只松鼠', 93, 0.10, '2020', '2020-07', '2020-07-12', 1, 61, '36', '15945629778091', 0);
INSERT INTO `order` VALUES (4187, '15946095518854', '2020-07-13 11:05:51', 0.02, NULL, 0, 5, '三只松鼠', 93, 0.10, '2020', '2020-07', '2020-07-13', 1, 0, NULL, '15946095518854', 0);
INSERT INTO `order` VALUES (4188, '15946095782703', '2020-07-13 11:06:19', 0.02, NULL, 0, 5, '三只松鼠', 93, 0.10, '2020', '2020-07', '2020-07-13', 1, 0, NULL, '15946095782703', 0);
INSERT INTO `order` VALUES (4189, '15946096443770', '2020-07-13 11:07:24', 0.02, NULL, 0, 5, '三只松鼠', 93, 0.10, '2020', '2020-07', '2020-07-13', 1, 0, NULL, '15946096443770', 0);
INSERT INTO `order` VALUES (4190, '15946096678128', '2020-07-13 11:07:47', 0.02, NULL, 0, 5, '三只松鼠', 93, 0.10, '2020', '2020-07', '2020-07-13', 1, 0, NULL, '15946096678128', 0);
INSERT INTO `order` VALUES (4191, '15946097333006', '2020-07-13 11:08:58', 0.02, NULL, 0, 5, '三只松鼠', 93, 0.10, '2020', '2020-07', '2020-07-13', 1, 0, '38,37', '15946097333006', 0);
INSERT INTO `order` VALUES (4192, '15946097912440', '2020-07-13 11:15:34', 0.02, NULL, 0, 5, '三只松鼠', 93, 0.10, '2020', '2020-07', '2020-07-13', 1, 0, '38', '15946097912440', 0);
INSERT INTO `order` VALUES (4193, '15946101655976', '2020-07-13 11:16:05', 0.01, NULL, 0, 5, '三只松鼠', 94, 0.10, '2020', '2020-07', '2020-07-13', 1, 0, NULL, '15946101655976', 0);
INSERT INTO `order` VALUES (4194, '15946102125451', '2020-07-13 11:26:22', 0.01, '2020-07-13 11:26:22', 1, 5, '三只松鼠', 94, 0.10, '2020', '2020-07', '2020-07-13', 1, 0, '37', '15946102125451', 0);
INSERT INTO `order` VALUES (4195, '15946109009248', '2020-07-13 11:28:24', 0.00, '2020-07-13 11:28:24', 1, 5, '三只松鼠', 94, 0.10, '2020', '2020-07', '2020-07-13', 1, 0, '37', '15946109009248', 0);
INSERT INTO `order` VALUES (4196, '15946109815915', '2020-07-13 11:29:46', 0.02, NULL, 0, 5, '三只松鼠', 93, 0.10, '2020', '2020-07', '2020-07-13', 1, 0, '38', '15946109815915', 0);
INSERT INTO `order` VALUES (4197, '15946111583837', '2020-07-13 11:33:32', 0.02, '2020-07-13 11:33:32', 1, 5, '三只松鼠', 93, 0.10, '2020', '2020-07', '2020-07-13', 1, 0, '38', '15946111583837', 0);
INSERT INTO `order` VALUES (4198, '15946112733467', '2020-07-13 11:34:47', 0.01, '2020-07-13 11:34:47', 1, 5, '三只松鼠', 93, 0.10, '2020', '2020-07', '2020-07-13', 1, 0, '38', '15946112733467', 0);
INSERT INTO `order` VALUES (4199, '15946116355464', '2020-07-13 11:42:07', 0.01, '2020-07-13 11:42:07', 1, 5, '三只松鼠', 93, 0.10, '2020', '2020-07', '2020-07-13', 1, 0, '38', '15946116355464', 0);
INSERT INTO `order` VALUES (4200, '15946322889142', '2020-07-13 17:25:19', 0.01, '2020-07-13 17:25:19', 1, 8, '三只松鼠', 94, 0.10, '2020', '2020-07', '2020-07-13', 1, 0, NULL, '15946322889142', 0);
INSERT INTO `order` VALUES (4201, '15946334914928', '2020-07-13 17:44:51', 0.01, NULL, 0, 7, '乐事', 118, 0.10, '2020', '2020-07', '2020-07-13', 1, 0, NULL, '15946334914928', 0);
INSERT INTO `order` VALUES (4202, '15946945844007', '2020-07-14 10:43:04', 0.01, NULL, 0, 5, '三只松鼠', 115, 0.10, '2020', '2020-07', '2020-07-14', 1, 66, NULL, '15946945844007', 0);
INSERT INTO `order` VALUES (4203, '15946945842163', '2020-07-14 10:43:04', 0.01, NULL, 0, 5, '三只松鼠', 98, 0.10, '2020', '2020-07', '2020-07-14', 1, 65, NULL, '15946945844007', 0);
INSERT INTO `order` VALUES (4204, '15946945845639', '2020-07-14 10:43:04', 0.01, NULL, 0, 5, '三只松鼠', 96, 0.10, '2020', '2020-07', '2020-07-14', 1, 64, NULL, '15946945844007', 0);
INSERT INTO `order` VALUES (4217, '15947004692373', '2020-07-14 12:21:09', 0.01, NULL, 0, 5, '三只松鼠', 94, 0.10, '2020', '2020-07', '2020-07-14', 1, 0, NULL, '15947004692373', 0);
INSERT INTO `order` VALUES (4218, '15955780208964', '2020-07-24 16:07:00', 0.01, NULL, 0, 5, '三只松鼠', 94, 0.10, '2020', '2020-07', '2020-07-24', 1, 0, NULL, '15955780208964', 0);
INSERT INTO `order` VALUES (4219, '15982431204065', '2020-08-24 12:25:20', 0.01, NULL, 0, 5, '三只松鼠', 94, 0.10, '2020', '2020-08', '2020-08-24', 1, 0, NULL, '15982431204065', 0);
INSERT INTO `order` VALUES (4223, '15982794521214', '2020-08-24 22:30:52', 0.03, NULL, 0, 5, '三只松鼠', 92, 0.10, '2020', '2020-08', '2020-08-24', 1, 0, NULL, '15982794521214', 0);
INSERT INTO `order` VALUES (4224, '15982804846544', '2020-08-24 22:48:04', 0.01, NULL, 0, 5, '三只松鼠', 94, 0.10, '2020', '2020-08', '2020-08-24', 1, 0, NULL, '15982804846544', 0);
INSERT INTO `order` VALUES (4225, '15987041385877', '2020-08-29 20:28:58', 0.01, NULL, 0, 111, '三只松鼠', 94, 0.10, '2020', '2020-08', '2020-08-29', 1, 0, NULL, '15987041385877', 1598704168);
INSERT INTO `order` VALUES (4226, '15988872822525', '2020-08-31 23:21:22', 0.01, NULL, 0, 111, '三只松鼠', 94, 0.10, '2020', '2020-08', '2020-08-31', 1, 0, NULL, '15988872822525', 1598887312);
INSERT INTO `order` VALUES (4227, '15988877035635', '2020-08-31 23:28:23', 0.03, NULL, 0, 111, '三只松鼠', 92, 0.10, '2020', '2020-08', '2020-08-31', 1, 0, NULL, '15988877035635', 1598887733);
INSERT INTO `order` VALUES (4228, '15994633456547', '2020-09-07 15:22:25', 0.01, NULL, 0, 5, '三只松鼠', 94, 0.10, '2020', '2020-09', '2020-09-07', 1, 0, NULL, '15994633456547', 1599463375);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL COMMENT '角色名称',
  `role_status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1有效，0无效',
  `create_time` varchar(100) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_croatian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (2, '超级管理员', 1, '2020-07-20 16:24:47', '2020-07-20 16:24:47');
INSERT INTO `role` VALUES (3, '普通管理员', 1, '2020-07-18 13:28:15', '2020-07-18 13:29:27');
INSERT INTO `role` VALUES (4, '待审核的管理员', 1, '2020-07-18 13:28:15', '2020-07-18 13:55:30');

-- ----------------------------
-- Table structure for role_access
-- ----------------------------
DROP TABLE IF EXISTS `role_access`;
CREATE TABLE `role_access`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `access_id` int(11) NOT NULL COMMENT '权限id',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 264 CHARACTER SET = utf8 COLLATE = utf8_croatian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_access
-- ----------------------------
INSERT INTO `role_access` VALUES (231, 2, 3, '2020-07-21 11:06:54');
INSERT INTO `role_access` VALUES (232, 2, 4, '2020-07-21 11:06:54');
INSERT INTO `role_access` VALUES (233, 2, 5, '2020-07-21 11:06:54');
INSERT INTO `role_access` VALUES (234, 2, 6, '2020-07-21 11:06:54');
INSERT INTO `role_access` VALUES (235, 2, 7, '2020-07-21 11:06:54');
INSERT INTO `role_access` VALUES (236, 2, 8, '2020-07-21 11:06:54');
INSERT INTO `role_access` VALUES (237, 2, 9, '2020-07-21 11:06:54');
INSERT INTO `role_access` VALUES (238, 2, 10, '2020-07-21 11:06:54');
INSERT INTO `role_access` VALUES (239, 2, 11, '2020-07-21 11:06:54');
INSERT INTO `role_access` VALUES (240, 2, 12, '2020-07-21 11:06:54');
INSERT INTO `role_access` VALUES (241, 2, 13, '2020-07-21 11:06:54');
INSERT INTO `role_access` VALUES (242, 2, 14, '2020-07-21 11:06:54');
INSERT INTO `role_access` VALUES (243, 2, 15, '2020-07-21 11:06:54');
INSERT INTO `role_access` VALUES (244, 2, 16, '2020-07-21 11:06:54');
INSERT INTO `role_access` VALUES (245, 2, 17, '2020-07-21 11:06:54');
INSERT INTO `role_access` VALUES (246, 2, 18, '2020-07-21 11:06:54');
INSERT INTO `role_access` VALUES (247, 2, 19, '2020-07-21 11:06:54');
INSERT INTO `role_access` VALUES (248, 2, 20, '2020-07-21 11:06:54');
INSERT INTO `role_access` VALUES (249, 2, 21, '2020-07-21 11:06:54');
INSERT INTO `role_access` VALUES (250, 2, 23, '2020-07-21 11:06:54');
INSERT INTO `role_access` VALUES (251, 4, 3, '2020-07-21 11:13:38');
INSERT INTO `role_access` VALUES (252, 4, 4, '2020-07-21 11:13:38');
INSERT INTO `role_access` VALUES (253, 4, 5, '2020-07-21 11:13:38');
INSERT INTO `role_access` VALUES (254, 4, 6, '2020-07-21 11:13:38');
INSERT INTO `role_access` VALUES (255, 4, 7, '2020-07-21 11:13:38');
INSERT INTO `role_access` VALUES (256, 4, 8, '2020-07-21 11:13:38');
INSERT INTO `role_access` VALUES (257, 3, 3, '2020-07-21 13:55:28');
INSERT INTO `role_access` VALUES (258, 3, 4, '2020-07-21 13:55:28');
INSERT INTO `role_access` VALUES (259, 3, 5, '2020-07-21 13:55:28');
INSERT INTO `role_access` VALUES (260, 3, 7, '2020-07-21 13:55:28');
INSERT INTO `role_access` VALUES (261, 3, 8, '2020-07-21 13:55:28');
INSERT INTO `role_access` VALUES (262, 3, 9, '2020-07-21 13:55:28');
INSERT INTO `role_access` VALUES (263, 3, 10, '2020-07-21 13:55:28');

-- ----------------------------
-- Table structure for shop_car
-- ----------------------------
DROP TABLE IF EXISTS `shop_car`;
CREATE TABLE `shop_car`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL COMMENT '商品id',
  `mb_id` int(11) NOT NULL COMMENT '用户id',
  `num` int(11) NULL DEFAULT 1 COMMENT '商品数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 67 CHARACTER SET = utf8 COLLATE = utf8_croatian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shop_car
-- ----------------------------
INSERT INTO `shop_car` VALUES (62, 94, 5, 1);
INSERT INTO `shop_car` VALUES (63, 95, 5, 1);
INSERT INTO `shop_car` VALUES (64, 96, 5, 1);
INSERT INTO `shop_car` VALUES (65, 98, 5, 1);
INSERT INTO `shop_car` VALUES (66, 115, 5, 1);

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `con` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `joint_index`(`id`, `con`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_croatian_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of test
-- ----------------------------
INSERT INTO `test` VALUES (13, 0);

SET FOREIGN_KEY_CHECKS = 1;
