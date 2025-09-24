-- Create database if it doesn't exist
CREATE DATABASE IF NOT EXISTS etldb;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(50),
    processed_at TIMESTAMP
);

-- Grant permissions
GRANT ALL PRIVILEGES ON DATABASE etldb TO user;