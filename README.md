# copilot-agent-demo-user

A Spring Boot application demonstrating Copilot Agent capabilities with Docker and Gradle build support.

## Features

- Spring Boot 3.5.7 with Java 21
- Docker support with multi-stage builds
- GKE-ready containerization
- Spring Cloud Config integration
- Health check endpoints via Spring Boot Actuator
- Gradle Docker plugin for image management

## Building the Application

### Using Gradle

```bash
./gradlew clean build
```

### Using Docker

See [docker/README.md](docker/README.md) for detailed Docker instructions.

Quick start:

```bash
# Multi-stage build
docker build -t copilot-agent-demo-user:latest -f docker/Dockerfile .

# Or using docker-compose
docker-compose up -d
```

## Running the Application

### Locally with Gradle

```bash
./gradlew bootRun
```

### Using Docker

```bash
docker run -d -p 8080:8080 copilot-agent-demo-user:latest
```

### Using Docker Compose

```bash
docker-compose up -d
```

## Accessing the Application

- Application: http://localhost:8080
- Health Check: http://localhost:8080/actuator/health

## Development

This project uses:
- Gradle 8.14.3
- Java 21
- Spring Boot 3.5.7
- Spring Cloud 2024.0.0

## CI/CD

GitHub Actions workflow is configured to:
- Build the application with Gradle
- Run tests
- Build Docker images
- Test Docker images
- Upload artifacts

See `.github/workflows/docker-build.yml` for details.