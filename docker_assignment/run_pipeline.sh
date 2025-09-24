#!/bin/bash

echo "========================================="
echo "STARTING DOCKER ETL PIPELINE"
echo "========================================="

# Clean up any existing containers
echo "Cleaning up existing containers..."
docker-compose down -v

# Build and start containers
echo "Building and starting containers..."
docker-compose up --build -d database

# Wait for database to be ready
echo "Waiting for database to be ready..."
sleep 10

# Run ETL pipeline
echo "Running ETL pipeline..."
docker-compose up --build etl

# Show results
echo "========================================="
echo "CHECKING RESULTS"
echo "========================================="

# Query the database to show results
docker-compose exec database psql -U user -d etldb -c "SELECT * FROM users LIMIT 10;"

echo "========================================="
echo "PIPELINE EXECUTION COMPLETED"
echo "========================================="

# Keep containers running for inspection
echo "Containers are still running. Use 'docker-compose down' to stop them."