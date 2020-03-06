# NYC Taxi Trips Analysis

## Local Mode
### Setup

To create the infrastructure you will need terraform. You can install it:

https://learn.hashicorp.com/terraform/getting-started/install.html

Create a bucket to store the terraform state
For the same purpose create a DynamoDB table named `terraform-lock` with a primary partition key named `LockID` 
of type string.

export the appropriate environment variables:

`export TF_VAR_aws_region=us-east-1`\
`export TF_VAR_aws_access_key_id=<>`\
`export TF_VAR_aws_secret_access_key=<>`

You will need Python 3.7. You can install it with Conda:

https://docs.conda.io/en/latest/miniconda.html

create an environment for your project:

`conda create -n nyctaxitrips python=3.7`

Also, for Spark you need Java 8. You can install it with the following commands:

- On Linux (Ubuntu):

`sudo apt install openjdk-8-jre-headless`\
`sudo apt install openjdk-8-jdk`

- On MacOS:

`brew cask install adoptopenjdk8`\
`export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home`

Install requirements: 

`pip install -r requirements.txt`


Download Data, create infrastructure and run EMR Cluster:

`bash setup.sh`

After thar run the script below to run the kinesis producer on EC2

`bash setup_producer.sh`

### Run

The analysis run on Jupyter Notebook:

`jupyter notebook`

**Notebooks**

- The notebook `exploration.ipynb` contains exploratory analysis of the nyctaxi-trips dataset.
- The notebook `analysis_local.ipynb` contains the analysis of the nyctaxi-trips dataset.
- The notebook `analysis_remote.ipynb` contains the analysis of the nyctaxi-trips dataset to run on the cloud.

**Kinesis Consumer**

Run the python script to run the kinesis consumer:

`python streaming/kinesis_consumer.py`