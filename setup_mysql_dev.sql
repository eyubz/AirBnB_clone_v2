-- MySQL setup for development
CREATE DATABASE IF NOT EXISTS hbnb_dev_db;

SELECT EXISTS(SELECT 1 FROM mysql.user WHERE user = 'hbnb_dev' AND host = 'localhost') INTO @exists;
SET @query = IF(@exists, 'SELECT "User already exists";', 'CREATE USER "hbnb_dev"@"localhost" IDENTIFIED BY "hbnb_dev_pwd";');
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

GRANT ALL PRIVILEGES ON hbnb_dev_db.* TO 'hbnb_dev'@'localhost';
GRANT SELECT ON performance_schema.* TO 'hbnb_dev'@'localhost';
FLUSH PRIVILEGES;
