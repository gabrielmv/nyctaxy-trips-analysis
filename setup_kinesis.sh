producer_public_ip="$(python scripts/ec2_ip.py)"

# Remote Script to run the producer

ssh -i "datasprint.pem" -o 'StrictHostKeyChecking no' ubuntu@${producer_public_ip} 'mkdir -p ~/.aws'
scp -r -i "datasprint.pem" -o 'StrictHostKeyChecking no' ~/.aws/config ubuntu@${producer_public_ip}:~/.aws/config
scp -r -i "datasprint.pem" -o 'StrictHostKeyChecking no' ~/.aws/credentials ubuntu@${producer_public_ip}:~/.aws/credentials
ssh -i "datasprint.pem" -o 'StrictHostKeyChecking no' ubuntu@${producer_public_ip} 'bash -s' < scripts/producer.sh