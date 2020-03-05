# Download Data
(
  mkdir data
  cd data || exit
  wget https://s3.amazonaws.com/data-sprints-eng-test/data-sample_data-nyctaxi-trips-2009-json_corrigido.json
  wget https://s3.amazonaws.com/data-sprints-eng-test/data-sample_data-nyctaxi-trips-2010-json_corrigido.json
  wget https://s3.amazonaws.com/data-sprints-eng-test/data-sample_data-nyctaxi-trips-2011-json_corrigido.json
  wget https://s3.amazonaws.com/data-sprints-eng-test/data-sample_data-nyctaxi-trips-2012-json_corrigido.json
  wget https://s3.amazonaws.com/data-sprints-eng-test/data-vendor_lookup-csv.csv
  wget https://s3.amazonaws.com/data-sprints-eng-test/data-payment_lookup-csv.csv
)

# Create Infrastructure
(
  cd terraform || exit
  terraform init -lock=false
  terraform refresh -lock=false
  terraform plan -lock=false
  terraform apply -lock=false -auto-approve
)

public_ip="$(python scripts/ec2_ip.py)"

# Remote Script
ssh -i "datasprint.pem" -o 'StrictHostKeyChecking no' ubuntu@${public_ip} 'mkdir -p ~/.aws'
scp -r -i "datasprint.pem" -o 'StrictHostKeyChecking no' ~/.aws/config ubuntu@${public_ip}:~/.aws/config
scp -r -i "datasprint.pem" -o 'StrictHostKeyChecking no' ~/.aws/credentials ubuntu@${public_ip}:~/.aws/credentials
ssh -i "datasprint.pem" -o 'StrictHostKeyChecking no' ubuntu@${public_ip} 'bash -s' < remote.sh
