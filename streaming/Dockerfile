FROM python:3.7

ARG aws_access_key_id
ARG aws_secret_access_key

RUN mkdir /kinesis_producer
WORKDIR /kinesis_producer
COPY kinesis_producer.py /kinesis_producer

RUN pip install boto3

ENV AWS_ACCESS_KEY_ID=${aws_access_key_id}
ENV AWS_SECRET_ACCESS_KEY=${aws_secret_access_key}

CMD python kinesis_producer.py
