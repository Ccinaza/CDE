# Docker ETL Pipeline Project

This project demonstrates a complete ETL (Extract, Transform, Load) pipeline using Docker containers.

## Architecture
- **ETL Container**: Python application that extracts data from an API, transforms it, and loads it into a database
- **Database Container**: PostgreSQL database running in isolation
- **Docker Network**: Connects the containers securely

## Quick Start

### Prerequisites
- Docker
- Docker Compose

### Running the Pipeline

1. Clone this repository:
```bash
   git clone https://github.com/Ccinaza/CDE.git
   cd docker_assignment