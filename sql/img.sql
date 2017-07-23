create database db_picture;
use db_picture;

DROP TABLE IF EXISTS IMG_IMAGE_INFORMATION; 
CREATE TABLE IMG_IMAGE_INFORMATION (
    imageId BIGINT auto_increment,
    batchId VARCHAR(64),
    name VARCHAR(256),
    saveName VARCHAR(256),
    fileSize BIGINT,
    uploadSize BIGINT,
    error VARCHAR(1024),
    remoteUrl VARCHAR(256),
    createTime datetime DEFAULT NOW(),
    primary key(imageId)
)ENGINE=InnoDB AUTO_INCREMENT=1018 DEFAULT CHARSET=utf8;
ALTER TABLE `IMG_IMAGE_INFORMATION` ADD unique(`batchId`,`name`);


