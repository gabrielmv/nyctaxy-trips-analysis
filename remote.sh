### Install Docker on remote machine
export AWS_ACCESS_KEY_ID=${TF_VAR_aws_access_key_id}
export AWS_SECRET_ACCESS_KEY=${TF_VAR_aws_secret_access_key}

sudo apt upgrade -y
sudo apt update -y
sudo apt install python3-pip -y
sudo apt install python3 --upgrade -y

pip3 install awscli --upgrade
pip3 install boto3
#aws configure

git clone https://github.com/gabrielmv/nyctaxy-trips-analysis.git

python3 nyctaxy-trips-analysis/streaming/kinesis_producer.py


