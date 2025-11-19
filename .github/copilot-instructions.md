````markdown
# Copilot Instructions for Issue-Based Automation

## Trigger Condition
Execute these steps when an issue is created in this repository requesting:
- Adding or updating Docker-related files and configurations.
- Updating Gradle build files to align with standards from the reference repository.

**Reference Repository:**  
`https://github.com/vartikadhawan16/copilot-agent-demo-org`

**Target Repository:**  
`https://github.com/vartikadhawan16/copilot-agent-demo-user`

---

## Detailed Steps and Commands

### 1. Checkout Reference Repository
Clone the reference repository into a folder named `reference-repo` using the Personal Access Token (PAT):

```bash
git clone https://x-access-token:${GH_PAT}@github.com/vartikadhawan16/copilot-agent-demo-org reference-repo
````

***

### 2. Prepare Target Repository

Ensure you are in the target repository (`copilot-agent-demo-user`).

Create a `docker` directory if it does not exist:

```bash
mkdir -p docker
```

***

### 3. Copy Required Files from Reference Repo

Copy the following files from the reference repo:

```bash
cp reference-repo/docker/Dockerfile ./docker/Dockerfile || true
cp reference-repo/build.gradle ./build.gradle || true
```

Optional: If `docker-compose.yml` or `.env` files exist in the reference repo, copy them too:

```bash
cp reference-repo/docker-compose.yml ./docker-compose.yml || true
cp reference-repo/.env ./ || true
```

***

### 4. Create a New Branch

Create and switch to a new branch:

```bash
git checkout -b sync-docker-gradle
```

Stage and commit changes:

```bash
git add .
git commit -m "Synced Docker and Gradle configurations from reference repo"
```

***

### 5. Push Branch to Remote

Push the branch using PAT for authentication:

```bash
git push https://x-access-token:${GH_PAT}@github.com/vartikadhawan16/copilot-agent-demo-user.git sync-docker-gradle
```

***

### 6. Create a Pull Request

Open a PR from `sync-docker-gradle` to `main`:

**Title:**

    Sync Docker and Gradle Configurations

**Body:**

    Automated update based on reference repo:
    - Dockerfile and related configurations added/updated
    - build.gradle and settings.gradle aligned with reference standards
    - Gradle wrapper and scripts synced

Using GitHub CLI:

```bash
gh pr create --title "Sync Docker and Gradle Configurations" \
  --body "Automated update based on reference repo:
- Dockerfile and related configurations added/updated
- build.gradle and settings.gradle aligned with reference standards
- Gradle wrapper and scripts synced" \
  --base main --head sync-docker-gradle
```

***

## Notes

*   Do NOT validate Docker or Gradle builds.
*   Maintain original structure of copied files.
*   Use PAT stored in `GH_PAT` for authentication.
*   If issue mentions `docker-compose` or `.env`, copy those files as well.
*   Add Copilot, vartikadhawan16 and vipulmahajan1988 as Reviewer in the PR.

```


