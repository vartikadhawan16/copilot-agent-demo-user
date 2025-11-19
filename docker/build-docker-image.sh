#!/bin/bash
# Script to build the Docker image for copilot-agent-demo-user
# Usage: ./docker/build-docker-image.sh [simple|multi-stage]

set -e

BUILD_TYPE="${1:-multi-stage}"

if [ "$BUILD_TYPE" = "simple" ]; then
    echo "Building with simple Dockerfile (pre-built JAR)..."
    
    echo "Building Gradle project..."
    ./gradlew clean build --no-daemon

    echo "Copying JAR file to docker directory..."
    cp build/libs/user-0.0.1-SNAPSHOT.jar docker/

    echo "Building Docker image..."
    docker build -t copilot-agent-demo-user:latest -f docker/Dockerfile.simple docker/

    echo "Cleaning up temporary JAR file..."
    rm docker/user-0.0.1-SNAPSHOT.jar
else
    echo "Building with multi-stage Dockerfile..."
    docker build -t copilot-agent-demo-user:latest -f docker/Dockerfile .
fi

echo "Docker image built successfully!"
docker images | grep copilot-agent-demo-user
