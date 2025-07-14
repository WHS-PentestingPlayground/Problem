USE vulunchDB;
CREATE TABLE IF NOT EXISTS hint (
  id INT AUTO_INCREMENT PRIMARY KEY,
  location VARCHAR(255)
);
INSERT INTO hint (location) VALUES ('/flag/flag.txt');

GRANT FILE ON *.* TO 'vulunch'@'%';
FLUSH PRIVILEGES; 