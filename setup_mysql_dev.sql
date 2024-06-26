-- MySQL setup for development
CREATE DATABASE IF NOT EXISTS hbnb_dev_db;

-- Create user only if it doesn't already exist
SELECT EXISTS(SELECT 1 FROM mysql.user WHERE user = 'hbnb_dev' AND host = 'localhost') INTO @exists;
SET @query = IF(@exists, 'SELECT "User already exists";', 'CREATE USER "hbnb_dev"@"localhost" IDENTIFIED BY "hbnb_dev_pwd";');
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Grant all privileges on hbnb_dev_db to hbnb_dev
GRANT ALL PRIVILEGES ON hbnb_dev_db.* TO 'hbnb_dev'@'localhost';

-- Grant SELECT privilege on performance_schema to hbnb_dev
GRANT SELECT ON performance_schema.* TO 'hbnb_dev'@'localhost';

-- Apply the changes
FLUSH PRIVILEGES;
