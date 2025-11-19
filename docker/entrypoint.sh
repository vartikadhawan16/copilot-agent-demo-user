#!/bin/sh
# Entrypoint script for Docker container

set -e

# Allow passing additional Java options via environment variable
JAVA_OPTS="${JAVA_OPTS:--Xmx512m -Xms256m}"

# Allow passing Spring profiles via environment variable
SPRING_PROFILES="${SPRING_PROFILES_ACTIVE:-default}"

echo "Starting application with profile: $SPRING_PROFILES"
echo "Java options: $JAVA_OPTS"

exec java $JAVA_OPTS -Dspring.profiles.active=$SPRING_PROFILES -jar /app/copilot-agent-demo-user.jar "$@"
