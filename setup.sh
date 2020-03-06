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

# Created copying the AWS CLI export

aws emr create-cluster --auto-scaling-role EMR_AutoScaling_DefaultRole \
                       --applications Name=Hadoop Name=Hive Name=Pig Name=Hue Name=Spark Name=Zeppelin Name=JupyterHub Name=Livy \
                       --ebs-root-volume-size 10 \
                       --ec2-attributes '{"KeyName":"datasprint","InstanceProfile":"EMR_EC2_DefaultRole","SubnetId":"subnet-193bdd7f","EmrManagedSlaveSecurityGroup":"sg-06b2f746576d0be8a","EmrManagedMasterSecurityGroup":"sg-0eea594e66f5de84c"}' \
                       --service-role EMR_DefaultRole \
                       --enable-debugging \
                       --release-label emr-5.29.0 \
                       --log-uri 's3n://aws-logs-635255901326-us-east-1/elasticmapreduce/' \
                       --name 'Cluster' \
                       --instance-groups '[{"InstanceCount":1,"EbsConfiguration":{"EbsBlockDeviceConfigs":[{"VolumeSpecification":{"SizeInGB":20,"VolumeType":"gp2"},"VolumesPerInstance":1}],"EbsOptimized":true},"InstanceGroupType":"MASTER","InstanceType":"m4.large","Name":"Master - 1"},{"InstanceCount":1,"EbsConfiguration":{"EbsBlockDeviceConfigs":[{"VolumeSpecification":{"SizeInGB":20,"VolumeType":"gp2"},"VolumesPerInstance":1}],"EbsOptimized":true},"InstanceGroupType":"CORE","InstanceType":"m4.large","Name":"Core - 2"}]' \
                       --scale-down-behavior TERMINATE_AT_TASK_COMPLETION \
                       --region us-east-1
aws ec2 authorize-security-group-ingress --group-id sg-0eea594e66f5de84c --protocol tcp --port 22 --cidr 0.0.0.0/0

# Remote script to run EMR

emr_public_ip="$(python scripts/emr_ip.py)"

scp -r -i "datasprint.pem" -o 'StrictHostKeyChecking no' analysis_remote.ipynb hadoop@${emr_public_ip}:~/analysis_remote.ipynb
ssh -N -f -L 8889:localhost:8889 -i datasprint.pem -o 'StrictHostKeyChecking no' hadoop@${emr_public_ip}
ssh -i "datasprint.pem" -o 'StrictHostKeyChecking no' hadoop@${emr_public_ip} 'bash -s' < scripts/emr.sh
