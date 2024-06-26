-- MySQL setup for test
CREATE DATABASE IF NOT EXISTS hbnb_test_db;

SELECT EXISTS(SELECT 1 FROM mysql.user WHERE user = 'hbnb_test' AND host = 'localhost') INTO @exists;
SET @query = IF(@exists, 'SELECT "User already exists";', 'CREATE USER "hbnb_test"@"localhost" IDENTIFIED BY "hbnb_test_pwd";');
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

GRANT ALL PRIVILEGES ON hbnb_test_db.* TO 'hbnb_test'@'localhost';
GRANT SELECT ON performance_schema.* TO 'hbnb_test'@'localhost';
FLUSH PRIVILEGES;
