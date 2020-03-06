sudo sed -i -e '$a\export PYSPARK_PYTHON=/usr/bin/python3' /etc/spark/conf/spark-env.sh
export PYTHONPATH="/home/hadoop/.local/lib/python3.6/site-packages:$PYTHONPATH"
export PYSPARK_DRIVER_PYTHON=/home/hadoop/.local/bin/jupyter
export PYSPARK_DRIVER_PYTHON_OPTS='notebook --no-browser'
echo $PYTHONPATH
echo $PYSPARK_DRIVER_PYTHON
echo $PYSPARK_DRIVER_PYTHON_OPTS

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py

export PATH="$PATH:~/.local/bin"

pip3 install --user jupyter
pip3 install --user ipython
pip3 install --user pandas
pip3 install --user plotly
pip3 install --user boto3

pyspark
