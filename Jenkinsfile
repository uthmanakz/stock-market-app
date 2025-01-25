pipeline {
    agent any 
        environment {
            AWS_ACCESS_KEY_ID = credentials ('AWS_ACCESS_KEY_ID')
            AWS_SECRET_ACCESS_KEY = credentials ('AWS_SECRET_ACCESS_KEY')
        }

        stages {
            stage ('terraform init') {
                steps {
                    sh '''
                    terraform init
                    '''
                }
            }

                stage ('terraform plan') {
                    steps {
                        sh '''
                        terraform plan
                        '''
                    }
                }

                stage ('terraform apply') {
                    steps {
                        sh '''
                        terraform apply -auto-approve
                        '''
                    }
                }

                stage ('Installing Ansible') {
                    steps {
                        script {
                             ssgagent (credentials : ['SSH_PRIVATE_KEY']) {
                             sh '''
                             ANSIBLE=`terraform output | grep ANSIBLE | awk -F'"' '{print $2}'`
                             ssh -o StrictHostKeyChecking=no ec2-user@$ANSIBLE ' sudo yum install python3 -y ; sudo yum install python3-pip -y ; pip3 install ansible '
                            '''

                        }

                        }

                       
                       
                    }
                }
                stage ('Running playbook for Nginx on web nodes') {
                    steps {
                        script {
                            sshagent (credentials : ['SSH_PRIVATE_KEY']) {
                                sh'''
                                ANSIBLE=`terraform output | grep ANSIBLE | awk -F'"' '{print $2}'` '
                                sudo yum install git -y
                                git clone https://github.com/uthmanakz/pp-inventory.git
                                git clone https://github.com/uthmanakz/paymentplatform.git
                                '''
                            }
                        }
                    }
                }
            }
        }
