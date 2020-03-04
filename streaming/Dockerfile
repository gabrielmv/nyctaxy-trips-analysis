FROM python:3.7

RUN mkdir /kinesis_producer
WORKDIR /kinesis_producer
COPY kinesis_producer.py /kinesis_producer

RUN pip install boto3

CMD python kinesis_producer.py
