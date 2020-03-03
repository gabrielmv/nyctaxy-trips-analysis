# NYC Taxi Trips Analysis

## Local Mode
### Setup

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

Download Data:

`./get_data.sh`

### Run
The analysis run on Jupyter Notebook:

`jupyter notebook`

The notebook `explorarion.ipynb` contains exploratory analysis of the nyctaxi-trips dataset.
