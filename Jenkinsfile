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
                             sshagent (credentials : ['SSH_PRIVATE_KEY']) {
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
                                ANSIBLE=`terraform output | grep ANSIBLE | awk -F'"' '{print $2}'`
                                ssh -o StrictHostKeyChecking=no ec2-user@$ANSIBLE '
                                sudo yum install git -y ;
                                if [ ! -d "pp-inventory" ] ;
                                then
                                   git clone https://github.com/uthmanakz/pp-inventory.git ;
                                else
                                   cd pp-inventory ; git pull ;
                                   cd .. ;
                                   echo "pp-inventory.ini directory already exists - git pulling instead :)" ;
                                fi
                                if [ ! -d "paymentplatform" ] ;
                                then
                                   git clone https://github.com/uthmanakz/paymentplatform.git ;
                                else
                                  cd paymentplatform ; git pull ;
                                  cd .. ;
                                  echo "paymentplatform directory already exists - git pulling instead :)" ;
                                fi'
                                '''
                            }
                        }
                    }
                }

                stage ('Inserting web hosts inside in file') {
                    steps {
                        script {
                            sshagent (credentials : ['SSH_PRIVATE_KEY']) {
                                sh '''
                                ANSIBLE=`terraform output | grep ANSIBLE | awk -F'"' '{print $2}'`
                                WEB_AMAZON=`terraform output | grep WEB-AMAZON | awk -F '"' '{print $2}'`
                                WEB_UBUNTU=`terraform output | grep WEB-UBUNTU | awk -F '"' '{print $2}'`
                                ssh -o StrictHostKeyChecking=no ec2-user@$ANSIBLE " 
                                echo "[webs]" > pp-inventory/inventory.ini ;
                                echo "$WEB_AMAZON" >> pp-inventory/inventory.ini ;
                                echo "$WEB_UBUNTU ansible_user=ubuntu" >>  pp-inventory/inventory.ini"
                                scp -o StrictHostKeyChecking=no ansible.cfg ec2-user@$ANSIBLE:~
                                '''
                            }
                        }
                    }
                }


                stage ('Inserting app hosts inside in file') {
                    steps {
                        script {
                            sshagent (credentials : ['SSH_PRIVATE_KEY']) {
                                sh '''
                                ANSIBLE=`terraform output | grep ANSIBLE | awk -F'"' '{print $2}'`
                                APP_AMAZON=`terraform output | grep APP-AMAZON | awk -F '"' '{print $2}'`
                                APP_UBUNTU=`terraform output | grep APP-UBUNTU | awk -F '"' '{print $2}'`
                                ssh -o StrictHostKeyChecking=no ec2-user@$ANSIBLE " 
                                echo "[apps]" >> pp-inventory/inventory.ini ;
                                echo "$APP_AMAZON" >> pp-inventory/inventory.ini ;
                                echo "$APP_UBUNTU ansible_user=ubuntu" >>  pp-inventory/inventory.ini"
                                '''
                            }
                        }
                    }
                }

                stage ('Deploying web-nodes playbook')  {
                    steps {
                        script {
                            sshagent (credentials : ['SSH_PRIVATE_KEY']) {
                                sh '''
                                ANSIBLE=`terraform output | grep ANSIBLE | awk -F'"' '{print $2}'`
                                ssh -o StrictHostKeyChecking=no ec2-user@$ANSIBLE ' ansible-playbook -i pp-inventory/inventory.ini paymentplatform/web_playbook.yml'
                                '''
                            }
                        }
                    }
                }

                stage ('Deploying app-nodes playbook') {
                    steps {
                        script {
                            sshagent ( credentials : ['SSH_PRIVATE_KEY']) {
                                sh'''
                                 ANSIBLE=`terraform output | grep ANSIBLE | awk -F'"' '{print $2}'`
                                 ssh -o StrcitHostKeyChecking=no ec2-user@ANSIBLE ' ansible-playbook -i pp-inventory/inventory.ini paymentplatform/app_playbook.yml'
                                '''
                            }
                        }
                    }
                }
            }
        }
