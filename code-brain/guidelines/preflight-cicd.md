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

## Azure DevOps

```yaml
# azure-pipelines.yml
trigger:
  - main
  - develop

pool:
  vmImage: 'ubuntu-latest'

variables:
  PREFLIGHT_CI: true
  NODE_VERSION: '18.x'

stages:
- stage: Preflight
  jobs:
  - job: RunPreflightChecks
    steps:
    - task: NodeTool@0
      inputs:
        versionSpec: $(NODE_VERSION)
      displayName: 'Install Node.js'
    
    - script: npm ci
      displayName: 'Install dependencies'
    
    - script: |
        ./preflight.sh check-all
      displayName: 'Run Preflight'
      env:
        AZURE_TOKEN: $(System.AccessToken)
    
    - task: PublishTestResults@2
      inputs:
        testResultsFormat: 'JUnit'
        testResultsFiles: 'preflight-report/junit.xml'
        failTaskOnFailedTests: true
      displayName: 'Publish Test Results'
    
    - task: PublishBuildArtifacts@1
      inputs:
        PathtoPublish: 'preflight-report'
        ArtifactName: 'PreflightReport'
      displayName: 'Publish Report'

- stage: Test
  dependsOn: Preflight
  condition: succeeded()
  jobs:
  - job: RunTests
    steps:
    - script: npm test
      displayName: 'Run Tests'

- stage: Deploy
  dependsOn: Test
  condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/main'))
  jobs:
  - deployment: Production
    environment: 'production'
    strategy:
      runOnce:
        deploy:
          steps:
          - script: ./preflight.sh deploy --env=prod
            displayName: 'Deploy to Production'
```

## Configurações Comuns

### 1. Variáveis de Ambiente

```bash
# Configurações CI/CD
export PREFLIGHT_CI=true           # Ativa modo CI
export PREFLIGHT_STRICT=true       # Falha rápido em erros
export PREFLIGHT_REPORT=true       # Gera relatórios detalhados
export PREFLIGHT_TIMEOUT=300       # Timeout em segundos

# Tokens e Credenciais
export PREFLIGHT_TOKEN=xxx         # Token de autenticação
export PREFLIGHT_API_KEY=xxx       # Chave API para integrações
```

### 2. Flags de CLI

```bash
# Opções comuns para CI/CD
preflight.sh check-all \
  --ci \                           # Modo CI
  --strict \                       # Validação estrita
  --report-format=junit \          # Formato do relatório
  --timeout=300 \                  # Timeout global
  --notify=slack \                 # Notificações
  --metrics=true                   # Coleta métricas
```

### 3. Arquivo de Configuração

```yaml
# preflight-ci.yaml
ci:
  mode: strict
  timeout: 300
  report:
    format: junit
    path: ./preflight-report
    
  notifications:
    - type: slack
      channel: "#ci-alerts"
    - type: email
      to: "team@example.com"
      
  metrics:
    enabled: true
    provider: datadog
    
  cache:
    enabled: true
    key: ${CI_COMMIT_SHA}
    paths:
      - node_modules/
      - .preflight-cache/
```

## Scripts de Suporte

### 1. Setup do Ambiente CI

```bash
#!/bin/bash
# ci-setup.sh

echo "🔧 Configurando ambiente CI..."

# 1. Instalar dependências
npm ci

# 2. Configurar credenciais
./preflight.sh configure-ci \
  --token="$PREFLIGHT_TOKEN" \
  --api-key="$PREFLIGHT_API_KEY"

# 3. Validar setup
./preflight.sh verify-ci-setup
```

### 2. Geração de Relatórios

```bash
#!/bin/bash
# generate-reports.sh

echo "📊 Gerando relatórios..."

# 1. Relatório JUnit
./preflight.sh report --format=junit

# 2. Coverage
./preflight.sh coverage-report

# 3. Métricas
./preflight.sh metrics-report

# 4. Consolidar
./preflight.sh consolidate-reports
```

### 3. Notificações

```bash
#!/bin/bash
# notify.sh

echo "📢 Enviando notificações..."

# 1. Status do build
./preflight.sh notify-status \
  --channel="#ci-alerts" \
  --status="$CI_STATUS"

# 2. Métricas importantes
./preflight.sh notify-metrics \
  --channel="#metrics"

# 3. Alertas críticos
./preflight.sh notify-alerts \
  --priority=high \
  --notify-on=failure
```