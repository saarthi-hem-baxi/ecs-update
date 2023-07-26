pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'ap-southeast-1'
        ECR_REPO_URL = '607136218464.dkr.ecr.ap-southeast-1.amazonaws.com'
        IMAGE_NAME = 'test-image'
        IMAGE_TAG = 'latest'
        ECS_CLUSTER = 'testcluster'
        ECS_SERVICE = 'new-service-test'

        // AWS Credentials Configuration
        awsAccessKey(credentialsId: 'aws-credentials', accessKeyVariable: 'AWS_ACCESS_KEY_ID')
        awsSecretKey(credentialsId: 'aws-credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')
    }

    stages {
        stage('Login to AWS ECR') {
            steps {
                script {
                    def ecrLoginCmd = "aws ecr get-login-password --region ${env.AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${env.ECR_REPO_URL}"
                    sh ecrLoginCmd
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def dockerBuildCmd = "docker build -t ${env.IMAGE_NAME}:${env.IMAGE_TAG} ."
                    sh dockerBuildCmd
                }
            }
        }

        stage('Tag Docker Image') {
            steps {
                script {
                    def dockerTagCmd = "docker tag ${env.IMAGE_NAME}:${env.IMAGE_TAG} ${env.ECR_REPO_URL}/${env.IMAGE_NAME}:${env.IMAGE_TAG}"
                    sh dockerTagCmd
                }
            }
        }

        stage('Push to ECR') {
            steps {
                script {
                    def dockerPushCmd = "docker push ${env.ECR_REPO_URL}/${env.IMAGE_NAME}:${env.IMAGE_TAG}"
                    sh dockerPushCmd
                }
            }
        }

        stage('Update ECS Service') {
            steps {
                script {
                    def updateServiceCmd = "aws ecs update-service --cluster ${env.ECS_CLUSTER} --service ${env.ECS_SERVICE} --force-new-deployment"
                    sh updateServiceCmd
                }
            }
        }
    }
}

