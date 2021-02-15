CREATE DATABASE IF NOT EXISTS eugene_test;
USE eugene_test;

CREATE TABLE IF NOT EXISTS `facebook_friends` (
`id` int(11) unsigned NOT NULL AUTO_INCREMENT,
`user_id` bigint(20) DEFAULT NULL,
`friend_id` bigint(20) DEFAULT NULL,
`friend_name` varchar(255) DEFAULT NULL,
PRIMARY KEY (`id`),
KEY `user_id` (`user_id`),
KEY `friend_id` (`friend_id`),
UNIQUE KEY `user_id_2` (`user_id`,`friend_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- DROP FUNCTION IF EXISTS get_fb_friends;
-- DELIMITER $$
-- CREATE FUNCTION get_fb_friends(_userId INT, _friendId INT, _depth INT ) RETURNS VARCHAR(255) CHARSET utf8
-- BEGIN

--     set @ret = '';
--     WITH RECURSIVE
--     recurs
--     AS
--     (
--     SELECT ff.friend_id,
--         concat(ff.user_id, ':', ff.friend_id) result,
--         1 depth
--         FROM facebook_friends ff
--         WHERE ff.user_id = _userId
--     UNION ALL
--     SELECT ff.friend_id,
--         concat(r.result, ':', ff.friend_id) result,
--         r.depth + 1 depth
--         FROM recurs r
--                 INNER JOIN facebook_friends ff
--                         ON ff.user_id = r.friend_id
--         WHERE r.friend_id <> _friendId and depth < _depth
--     )
--     SELECT r.result
--         INTO @ret
--         FROM recurs r
--         WHERE r.friend_id = _friendId
--         ORDER BY r.depth
--         LIMIT 1;
    
--     return @ret;
-- END; 
-- $$
-- DELIMITER ;


INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (101, '13', '87', 'numquam');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (102, '36', '25', 'ut');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (103, '41', '11', 'quia');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (104, '52', '35', 'repudiandae');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (105, '89', '71', 'vero');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (106, '99', '15', 'alias');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (107, '62', '66', 'sed');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (108, '92', '17', 'quam');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (109, '7', '73', 'tempore');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (110, '2', '76', 'id');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (111, '81', '66', 'alias');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (112, '48', '84', 'et');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (113, '16', '77', 'quo');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (114, '24', '2', 'facere');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (115, '97', '49', 'aliquid');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (116, '86', '98', 'non');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (117, '28', '2', 'perferendis');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (118, '49', '56', 'est');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (119, '36', '53', 'quae');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (120, '63', '6', 'facilis');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (121, '90', '44', 'dolores');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (122, '69', '74', 'aliquid');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (123, '2', '61', 'aut');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (124, '46', '86', 'et');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (125, '95', '2', 'est');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (126, '32', '10', 'praesentium');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (127, '67', '46', 'adipisci');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (128, '50', '76', 'quisquam');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (129, '31', '13', 'et');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (130, '9', '82', 'consequatur');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (131, '22', '6', 'est');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (132, '64', '88', 'magni');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (133, '92', '75', 'pariatur');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (134, '93', '38', 'modi');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (135, '27', '42', 'laborum');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (136, '94', '55', 'dicta');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (137, '83', '33', 'consequuntur');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (138, '33', '3', 'est');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (139, '71', '21', 'dicta');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (140, '49', '85', 'ex');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (141, '80', '67', 'minima');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (142, '2', '66', 'labore');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (143, '58', '81', 'commodi');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (144, '96', '69', 'dolor');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (145, '31', '96', 'sed');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (146, '16', '58', 'ratione');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (147, '88', '46', 'adipisci');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (148, '42', '4', 'est');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (149, '27', '40', 'qui');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (150, '25', '78', 'nobis');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (151, '73', '47', 'praesentium');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (152, '37', '39', 'soluta');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (153, '91', '68', 'culpa');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (154, '22', '73', 'reprehenderit');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (156, '58', '71', 'quisquam');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (157, '86', '91', 'aliquid');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (158, '78', '13', 'eum');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (159, '13', '66', 'iure');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (160, '29', '61', 'sunt');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (161, '75', '53', 'earum');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (162, '18', '19', 'odit');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (163, '1', '73', 'beatae');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (164, '78', '46', 'rem');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (165, '70', '37', 'culpa');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (166, '26', '19', 'perferendis');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (167, '18', '1', 'ut');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (168, '6', '6', 'impedit');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (169, '88', '40', 'dicta');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (170, '10', '63', 'doloremque');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (171, '48', '2', 'explicabo');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (172, '20', '33', 'aut');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (173, '59', '91', 'et');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (174, '4', '94', 'provident');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (175, '13', '31', 'placeat');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (176, '7', '66', 'fugit');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (177, '74', '54', 'cumque');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (178, '94', '57', 'facilis');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (179, '83', '64', 'illum');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (180, '21', '28', 'molestias');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (181, '83', '88', 'deleniti');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (182, '45', '54', 'unde');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (183, '84', '79', 'corrupti');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (184, '87', '92', 'qui');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (185, '94', '25', 'neque');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (186, '31', '50', 'eligendi');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (187, '37', '76', 'voluptate');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (188, '90', '72', 'pariatur');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (189, '34', '18', 'dolores');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (190, '67', '67', 'sint');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (191, '38', '82', 'voluptatem');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (192, '52', '13', 'sed');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (193, '97', '65', 'id');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (194, '90', '77', 'sit');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (195, '88', '5', 'fuga');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (196, '41', '31', 'iure');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (197, '7', '7', 'commodi');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (198, '77', '51', 'expedita');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (199, '69', '82', 'optio');
INSERT IGNORE INTO `facebook_friends` (`id`, `user_id`, `friend_id`, `friend_name`) VALUES (200, '69', '39', 'quia');
