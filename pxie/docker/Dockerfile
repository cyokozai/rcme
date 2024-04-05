###################### BUILDER ######################
FROM python:3.9 AS builder

WORKDIR /root

COPY requirements.txt /root/

RUN python -m pip install --upgrade pip &&\
    pip install --upgrade pip &&\
    pip install -r requirements.txt &&\
    mkdir results

    # cd /etc &&\
    # echo "backend : Agg" >> matplotlibrc

###################### PRODUCTION ######################
FROM ubuntu:latest AS production

USER root

WORKDIR /root

COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages/
COPY *.py /root/

RUN apt -y update &&\
    apt -y upgrade &&\
    apt -y install inetutils-ping &&\
    apt -y install tcpdump &&\
    apt -y install iproute2 &&\
    apt -y install netcat

# CMD ["python", "hello.py"]
