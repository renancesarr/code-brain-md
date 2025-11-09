# Integrações CI/CD — Preflight

## GitHub Actions

```yaml
# .github/workflows/preflight.yml
name: Preflight Checks

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  preflight:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci

      - name: Validate Docs (YAML/Markdown)
        run: code-brain/scripts/validate-docs.sh
      
      - name: Run Preflight
        run: |
          ./preflight.sh check-all
        env:
          PREFLIGHT_CI: true
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      
      - name: Upload Results
        if: always()
        uses: actions/upload-artifact@v3
        with:
          name: preflight-results
          path: ./preflight-report/

  deploy:
    needs: preflight
    runs-on: ubuntu-latest
    if: success() && github.ref == 'refs/heads/main'
    
    steps:
      - name: Deploy
        run: ./preflight.sh deploy --env=prod
```

## GitLab CI

```yaml
# .gitlab-ci.yml
variables:
  PREFLIGHT_CI: "true"

stages:
  - preflight
  - test
  - deploy

preflight:
  stage: preflight
  image: node:18
  script:
    - npm ci
    - code-brain/scripts/validate-docs.sh
    - ./preflight.sh check-all
  artifacts:
    paths:
      - preflight-report/
    reports:
      junit: preflight-report/junit.xml
  rules:
    - if: $CI_PIPELINE_SOURCE == "merge_request_event"
    - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH

test:
  stage: test
  needs: [preflight]
  script:
    - npm test
  only:
    - merge_requests
    - main
    - develop

deploy:
  stage: deploy
  script:
    - ./preflight.sh deploy --env=prod
  only:
    - main
  when: manual
```

## Jenkins Pipeline

```groovy
// Jenkinsfile
pipeline {
    agent any
    
    environment {
        PREFLIGHT_CI = 'true'
        NODE_VERSION = '18'
    }
    
    stages {
        stage('Setup') {
            steps {
                sh 'nvm install $NODE_VERSION'
                sh 'nvm use $NODE_VERSION'
                sh 'npm ci'
                sh 'code-brain/scripts/validate-docs.sh'
            }
        }
        
        stage('Preflight') {
            steps {
                script {
                    try {
                        sh './preflight.sh check-all'
                    } catch (err) {
                        currentBuild.result = 'FAILURE'
                        error("Preflight checks failed")
                    }
                }
            }
            post {
                always {
                    archiveArtifacts artifacts: 'preflight-report/**/*'
                    junit 'preflight-report/junit.xml'
                }
            }
        }
        
        stage('Test') {
            when {
                expression { currentBuild.result == null }
            }
            steps {
                sh 'npm test'
            }
        }
        
        stage('Deploy') {
            when {
                allOf {
                    branch 'main'
                    expression { currentBuild.result == null }
                }
            }
            steps {
                input "Deploy to production?"
                sh './preflight.sh deploy --env=prod'
            }
        }
    }
    
    post {
        failure {
            script {
                def report = sh(script: './preflight.sh generate-report', returnStdout: true)
                emailext body: report,
                    subject: "Pipeline Failed: ${currentBuild.fullDisplayName}",
                    to: 'team@example.com'
            }
        }
    }
}
```
## Recursos adicionais

- Variáveis, flags e templates avançados estão em `code-brain/templates/preflight-special-templates.md`.
- Para detalhamento de notificações, métricas e bypass consulte `code-brain/guidelines/preflight.md` e `preflight-advanced-troubleshooting.md`.
- Scripts locais (setup, reports, notify) devem ser gerados a partir dos templates citados acima para evitar drift.
