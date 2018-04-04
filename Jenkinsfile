
pipeline {
    agent any

    environment {
        CONTAINER_NAME = 'ffmodule_web_1'
        CONTAINER_DB_NAME = 'ffmodule_db_1'
        CONTAINER_USER = 'www-data'
        BRANCH_NAME = 'develop'
    }

    stages {
        stage('Start docker-compose') {
            steps {
                sh 'docker-compose up -d'

                // Wait for MySQL running
                sh 'docker exec ${CONTAINER_DB_NAME} bash ./mysql.sh'
            }
        }

        stage('Install Magento') {
            steps {
                sh 'docker exec ${CONTAINER_NAME} install-magento'
            }
        }

        stage('Install FF module') {
            steps {
                sh 'docker exec -u ${CONTAINER_USER} ${CONTAINER_NAME} curl https://codeload.github.com/FACT-Finder-Web-Components/magento2-module/tar.gz/${BRANCH_NAME} -o magento2-module.tar.gz'
                sh 'docker exec -u ${CONTAINER_USER} ${CONTAINER_NAME} tar xvf magento2-module.tar.gz'
                sh 'docker exec -u ${CONTAINER_USER} ${CONTAINER_NAME} rm -R magento2-module.tar.gz'
                sh 'docker exec -u ${CONTAINER_USER} ${CONTAINER_NAME} mv magento2-module-${BRANCH_NAME}/Omikron/ app/code'
                sh 'docker exec -u ${CONTAINER_USER} ${CONTAINER_NAME} rm -R magento2-module-${BRANCH_NAME}'
                sh 'docker exec -u ${CONTAINER_USER} ${CONTAINER_NAME} php -f bin/magento setup:upgrade'
                sh 'docker exec -u ${CONTAINER_USER} ${CONTAINER_NAME} php -f bin/magento setup:di:compile'
                sh 'docker exec -u ${CONTAINER_USER} ${CONTAINER_NAME} php -f bin/magento cache:flush'
                sh 'docker exec -u ${CONTAINER_USER} ${CONTAINER_NAME} php -f bin/magento module:status'
            }
        }

        stage('Adjust Magento 2') {
            steps {
                sh 'docker exec -u ${CONTAINER_USER} ${CONTAINER_NAME} php bin/magento setup:static-content:deploy'
                sh 'docker exec -u ${CONTAINER_USER} ${CONTAINER_NAME} php bin/magento deploy:mode:set developer'
            }
        }
    }
}
