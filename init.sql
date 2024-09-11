-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS providence;

-- Create the user if it doesn't exist
CREATE USER IF NOT EXISTS 'providence'@'%' IDENTIFIED BY 'password';

-- Grant privileges to the user
GRANT ALL PRIVILEGES ON providence.* TO 'providence'@'%';

-- Flush privileges to ensure they take effect
FLUSH PRIVILEGES;