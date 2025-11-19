# Docker Setup Guide

This directory contains Docker configurations for the copilot-agent-demo-user application.

## Files

- **Dockerfile**: Multi-stage build for optimized production images with layer caching
- **Dockerfile.simple**: Simple build for pre-built JAR files
- **build-docker-image.sh**: Helper script to build Docker images
- **entrypoint.sh**: Custom entrypoint script for advanced container configuration
- **docker-compose.yml**: Located in root directory for local development

## Building Docker Images

### Option 1: Multi-stage Build (Recommended)

This builds everything inside Docker and creates an optimized layered image:

```bash
docker build -t copilot-agent-demo-user:latest -f docker/Dockerfile .
```

Or use the helper script:

```bash
./docker/build-docker-image.sh
```

### Option 2: Simple Build (Pre-built JAR)

If you've already built the JAR with Gradle:

```bash
./gradlew clean build
./docker/build-docker-image.sh simple
```

### Option 3: Using Gradle Docker Plugin

Build using Gradle tasks:

```bash
./gradlew buildDockerImage
```

## Running the Application

### Using Docker directly

```bash
docker run -d -p 8080:8080 --name copilot-agent-demo-user copilot-agent-demo-user:latest
```

### Using Docker Compose

```bash
docker-compose up -d
```

To stop:

```bash
docker-compose down
```

## Environment Variables

- `SPRING_PROFILES_ACTIVE`: Set the active Spring profile (default: default)
- `JAVA_OPTS`: JVM options (default: -Xmx512m -Xms256m)

Example:

```bash
docker run -d -p 8080:8080 \
  -e SPRING_PROFILES_ACTIVE=prod \
  -e JAVA_OPTS="-Xmx1g -Xms512m" \
  copilot-agent-demo-user:latest
```

## Health Check

The application exposes a health endpoint at:

```
http://localhost:8080/actuator/health
```

Docker health check is configured to use this endpoint.

## GKE Deployment

The multi-stage Dockerfile is optimized for Google Kubernetes Engine (GKE):

- Uses layered JAR approach for better caching
- Includes health check configuration
- Runs as non-root user for security
- Uses Alpine-based images for smaller size

## Troubleshooting

### Check container logs

```bash
docker logs copilot-agent-demo-user
```

### Access container shell

```bash
docker exec -it copilot-agent-demo-user sh
```

### View Docker Compose logs

```bash
docker-compose logs -f
```
