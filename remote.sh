sudo apt upgrade -y
sudo apt update -y
sudo apt install python3-pip -y
sudo apt install python3 --upgrade -y

pip3 install awscli --upgrade
pip3 install boto3

git clone https://github.com/gabrielmv/nyctaxy-trips-analysis.git

python3 nyctaxy-trips-analysis/streaming/kinesis_producer.py
