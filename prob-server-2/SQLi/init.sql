CREATE DATABASE IF NOT EXISTS sqli_lab;
USE sqli_lab;

CREATE USER IF NOT EXISTS 'whsRoot'@'%' IDENTIFIED BY 'Rootpass123';
GRANT ALL PRIVILEGES ON sqli_lab.* TO 'whsRoot'@'%';
FLUSH PRIVILEGES;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255),
    password VARCHAR(255)
);

DELETE FROM users;
INSERT INTO users (username, password) VALUES ('admin', '745231e111e916ceb1f20a0daeb464b90cbad450127195b98d27ff1993230e12');
INSERT INTO users (username, password) VALUES ('guest', 'guest');
