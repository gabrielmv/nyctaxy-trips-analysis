# NYC Taxi Trips Analysis

## Local Mode
### Setup

To create the infrastructure you will need terraform. YOu can install it:

- MacOS

`mkdir ~/terraform`\
`wget https://releases.hashicorp.com/terraform/0.12.21/terraform_0.12.21_darwin_amd64.zip`\
`unzip terraform_0.12.21_darwin_amd64.zip`\
`mv terraform ~/terraform`\
`rm terraform_0.12.21_darwin_amd64.zip`\
`echo 'export PATH="$PATH:~/terraform"' >> .bash_profile`\
`source .bash_profile`

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

Download Data and create infrastructure:

`./setup.sh`

### Run

The analysis run on Jupyter Notebook:

`jupyter notebook`

The notebook `explorarion.ipynb` contains exploratory analysis of the nyctaxi-trips dataset.
