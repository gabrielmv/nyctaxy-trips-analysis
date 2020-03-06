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
  terraform get
  terraform plan -lock=false
  terraform apply -lock=false -auto-approve
)

producer_public_ip="$(python scripts/ec2_ip.py)"

# Remote Script to run the producer

ssh -i "datasprint.pem" -o 'StrictHostKeyChecking no' ubuntu@${producer_public_ip} 'mkdir -p ~/.aws'
scp -r -i "datasprint.pem" -o 'StrictHostKeyChecking no' ~/.aws/config ubuntu@${producer_public_ip}:~/.aws/config
scp -r -i "datasprint.pem" -o 'StrictHostKeyChecking no' ~/.aws/credentials ubuntu@${producer_public_ip}:~/.aws/credentials
ssh -i "datasprint.pem" -o 'StrictHostKeyChecking no' ubuntu@${producer_public_ip} 'bash -s' < scripts/remote.sh

# Remote script to run EMR

emr_public_ip="$(python scripts/emr_ip.py)"

scp -r -i "datasprint.pem" -o 'StrictHostKeyChecking no' analysis_local.ipynb hadoop@${emr_public_ip}:~/analysis_local.ipynb
scp -r -i "datasprint.pem" -o 'StrictHostKeyChecking no' analysis_remote.ipynb hadoop@${emr_public_ip}:~/analysis_local.ipynb
ssh -i "datasprint.pem" -o 'StrictHostKeyChecking no' hadoop@${emr_public_ip} 'bash -s' < scripts/emr.sh
ssh -N -f -L 8888:localhost:8888 -i datasprint.pem hadoop@${emr_public_ip}
