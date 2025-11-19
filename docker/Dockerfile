# Multi-stage build for optimized Docker image

# Build stage
FROM eclipse-temurin:21.0.4_7-jdk-alpine AS builder
WORKDIR /workspace/app

# Copy gradle wrapper and build files
COPY gradle gradle
COPY gradlew .
COPY build.gradle .
COPY settings.gradle .
COPY gradle.properties .

# Download dependencies (cached layer)
RUN ./gradlew dependencies --no-daemon || true

# Copy source code
COPY src src

# Build the application
RUN ./gradlew clean build --no-daemon -x test

# Extract layers for better caching
RUN java -Djarmode=tools -jar build/libs/*.jar extract --layers --launcher --destination build/extracted

# Runtime stage
FROM eclipse-temurin:21.0.4_7-jre-alpine

# Add non-root user for security
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

# Create a directory for the app
WORKDIR /app

# Copy extracted layers from builder stage
COPY --from=builder --chown=spring:spring /workspace/app/build/extracted/dependencies/ ./
COPY --from=builder --chown=spring:spring /workspace/app/build/extracted/spring-boot-loader/ ./
COPY --from=builder --chown=spring:spring /workspace/app/build/extracted/snapshot-dependencies/ ./
COPY --from=builder --chown=spring:spring /workspace/app/build/extracted/application/ ./

# Copy entrypoint script (optional, for advanced use)
COPY --chown=spring:spring docker/entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Provide a hook into the webapp
EXPOSE 8080

# Health check for GKE compatibility
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8080/actuator/health || exit 1

# Run the application using Spring Boot's layered jar approach
ENTRYPOINT ["java", "org.springframework.boot.loader.launch.JarLauncher"]
