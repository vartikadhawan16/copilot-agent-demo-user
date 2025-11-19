# Copilot Instructions for Issue-Based Automation

## Trigger Condition
Run these steps when an issue is created requesting:
- Adding or updating Docker-related files and configurations.
- Updating Gradle build files to align with standards from the reference repository.

**Reference Repository:**  
`https://github.com/vartikadhawan16/copilot-agent-demo-org`

**Target Repository:**  
`https://github.com/vartikadhawan16/copilot-agent-demo-user`

---

## Commands to Execute

```bash
# Clone reference repository
git clone https://x-access-token:${GH_PAT}@github.com/vartikadhawan16/copilot-agent-demo-org reference-repo

# Create docker directory if missing
mkdir -p docker

# Copy required files
cp reference-repo/docker/Dockerfile ./docker/Dockerfile || true
cp reference-repo/build.gradle ./build.gradle || true
cp reference-repo/settings.gradle ./settings.gradle || true
cp -r reference-repo/gradle ./gradle || true
cp reference-repo/gradlew ./gradlew || true
cp reference-repo/gradlew.bat ./gradlew.bat || true
cp reference-repo/docker-compose.yml ./docker-compose.yml || true
cp reference-repo/.env ./ || true

# Create new branch
git checkout -b sync-docker-gradle

# Commit changes
git add .
git commit -m "Synced Docker and Gradle configurations from reference repo"

# Push branch using PAT
git push https://x-access-token:${GH_PAT}@github.com/vartikadhawan16/copilot-agent-demo-user.git sync-docker-gradle

# Create Pull Request
gh pr create --title "Sync Docker and Gradle Configurations" \
  --body "Automated update based on reference repo:
- Dockerfile and related configurations added/updated
- build.gradle and settings.gradle aligned with reference standards
- Gradle wrapper and scripts synced" \
  --base main --head sync-docker-gradle
