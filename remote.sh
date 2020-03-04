### Install Docker on remote machine
export AWS_ACCESS_KEY_ID=${TF_VAR_aws_access_key_id}
export AWS_SECRET_ACCESS_KEY=${TF_VAR_aws_secret_access_key}

sudo apt install python3-pip
pip3 install awscli --upgrade
aws configure
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.dsudo apt install docker-ceocker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce -y
sudo apt upgrade -y
aws ecr get-login-password | docker login --username AWS --password-stdin 635255901326.dkr.ecr.us-east-1.amazonaws.com/datasprint
docker run -e AWS_ACCESS_KEY -e AWS_SECRET_ACCESS_KEY 635255901326.dkr.ecr.us-east-1.amazonaws.com/datasprint
