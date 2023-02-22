pipeline{
    agent any
    environment {
        PROJECT_ID = "<Project ID>"
        CLUSTER_NAME = "public-cluster"
        LOCATION = "us-central1-a"
        CREDENTIALS_ID = 'Credentials'
    }
    stages{
        stage('Checkout from GitHub') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: '<GitHub URL>']])
            }
        }
        stage('Building Docker file'){
            steps {
                script{
                    sh "docker build -t <Docker Username>/todo_app:${env.BUILD_ID} ."
                }
            }
        }
        stage('Pushing Docker file to DockerHub'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'Docker_Password', variable: 'docker')]){
                    sh 'docker login -u <Docker Username> -p ${docker}'
                    }
                    sh "docker push <Docker Username>/todo_app:${env.BUILD_ID}"
                }
            }
        }
        stage('Deploy to Kubernetes'){
            steps{
                sh "sed -i 's/tagversion/${env.BUILD_ID}/g' Deployment.yaml"
                step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'Deployment.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])   
                }
            }
        }
    }