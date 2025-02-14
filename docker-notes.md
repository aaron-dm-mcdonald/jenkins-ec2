High level overview:

1) repo with s3 bucket hcl
2) launch Docker and container
3) install jenkins plugins if needed
4) review groovy script and edit Jenkinsfile
5) IAM user
6) install awscli and terraform
<step 6 and 7 can be swapped>
7) set AWS creds
8) configure pipeline

--------------
Install on EC2 Directions: 

sudo dnf update -y
sudo dnf install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user
docker --version

------------
Grab Jenkins Image: 

sudo docker pull jenkins/jenkins:lts
sudo docker run --name jenkins -d -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts
sudo docker ps
sudo docker exec -it jenkins bash -c "cat /var/jenkins_home/secrets/initialAdminPassword"
---------------
Sign into container: 

$ docker exec -it -u root <container> bash

example: docker exec -it -u root jenkins bash
---------------

Install needed tools: 

1) install aws-cli

$ apt update && apt install -y awscli

2) download terraform binary 

$ curl -fsSL https://releases.hashicorp.com/terraform/1.10.5/terraform_1.10.5_linux_amd64.zip -o ./terraform.zip

$ unzip ./terraform.zip -d /usr/local/bin


3) optional cleanup and check
$ rm ./terraform.zip
$ terraform version

---------------
Teardown without a destroy pipeline:

1) navigate to correct dir

$ docker exec -it --user root <container> bash
$ cd $JENKINS_HOME/workspace/<pipeline name>
$ ls

2) set AWS creds
$ export AWS_ACCESS_KEY_ID="<AKI12345>"
$ export AWS_SECRET_ACCESS_KEY="<LIZZOLOVE123456789>"

3) tear down
$ terraform destroy
----

For resetting security:
https://www.jenkins.io/doc/book/system-administration/admin-password-reset-instructions/

$ docker exec -it --user root <container> bash

$ apt-get update && apt-get install apt-file -y && apt-file update && apt-get install vim -y

$ cd $JENKINS_HOME

$ ls

$ vim config.xml

----------
