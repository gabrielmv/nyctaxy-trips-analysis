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

# Create ECR repository and push kinesys_provider
aws create-repository --repository-name "datasprint"
(
  cd streaming || exit
  docker build . -t datasprint --build-arg aws_access_key_id=${TF_VAR_aws_access_key_id} --build-arg aws_secret_access_key=${TF_VAR_aws_secret_access_key}
  aws ecr get-login-password | docker login --username AWS --password-stdin 635255901326.dkr.ecr.us-east-1.amazonaws.com/datasprint
  docker tag datasprint:latest 635255901326.dkr.ecr.us-east-1.amazonaws.com/datasprint:latest
  docker push 635255901326.dkr.ecr.us-east-1.amazonaws.com/datasprint:latest
)

# Create Infrastructure
(
  cd terraform || exit
  terraform init
  terraform refresh
  terraform plan
  terraform apply
)
