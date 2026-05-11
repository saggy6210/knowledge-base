# Jenkins and SonarQube Tasks

## Table of Contents

- [Common Issues and Solutions](#common-issues-and-solutions)
- [Security Configuration](#security-configuration)
- [Parameterized Builds](#parameterized-builds)
- [Git Webhook Integration](#git-webhook-integration)

---

## Common Issues and Solutions

### Issue 1: SonarQube in Pending State

**Problem:** SonarQube analysis remains in pending state when triggered from Jenkins.

**Solution:** Update the webhook URL in SonarQube:

1. Go to **SonarQube Administration** → **Webhooks**
2. Update to correct Jenkins SonarQube webhook URL
3. Save changes

### Issue 2: Jenkins Accessible Without Login

**Problem:** Jenkins is accessible without authentication.

**Solution:** Remove anonymous user access:

1. Go to **Jenkins** → **Manage Jenkins** → **Configure Global Security**
2. Under **Authorization**, select **Matrix-based security**
3. Remove or restrict Anonymous user permissions
4. Save changes

## Security Configuration

### Securing Jenkins

- Enable CSRF protection
- Use HTTPS
- Implement role-based access control
- Regularly rotate credentials

## Parameterized Builds

### Using Parameters in Jenkinsfile

```groovy
pipeline {
    agent any
    
    parameters {
        choice(
            name: 'env',
            choices: ['dev', 'test', 'prod'],
            description: 'Select deployment environment'
        )
        string(
            name: 'creds_id',
            defaultValue: 'cli_creds',
            description: 'Credentials ID'
        )
    }
    
    stages {
        stage('Deploy') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: params.creds_id,
                        usernameVariable: 'USERNAME',
                        passwordVariable: 'PASSWORD'
                    )
                ]) {
                    sh '''#!/bin/bash
                        set +xv
                        your-cli login --username=${USERNAME} --password=${PASSWORD}
                    '''
                }
            }
        }
    }
}
```

> **Security Note:** Always use `set +xv` when handling credentials to prevent them from being logged.

## Git Webhook Integration

### Configuring GitLab Webhook

1. In Jenkins, enable **Build Triggers**:
   - Check "Build when a change is pushed to GitLab"

2. In GitLab, add webhook:
   - Go to **Settings** → **Webhooks**
   - Add webhook URL with credentials

### Webhook URL Format

Use credential-based authentication in webhook URLs:

```
https://<USERNAME>:<API_TOKEN>@<JENKINS_URL>/project/<PROJECT_NAME>
```

> **Security Warning:** 
> - Use API tokens instead of passwords
> - Store credentials securely
> - Use HTTPS for all webhook URLs
> - Avoid embedding plain-text passwords in URLs

### Best Practices

1. Use Jenkins API tokens instead of passwords
2. Enable webhook secret tokens for verification
3. Restrict webhook endpoints by IP if possible
4. Enable SSL/TLS for all communications
