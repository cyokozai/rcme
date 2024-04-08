###################### BUILDER ######################
FROM python:3.10 AS builder

WORKDIR /root

COPY requirements.txt /root/

RUN python -m pip install --upgrade pip &&\
    pip install --upgrade pip &&\
    pip install -r requirements.txt &&\
    mkdir results

    # cd /etc &&\
    # echo "backend : Agg" >> matplotlibrc

###################### PRODUCTION ######################
FROM builder AS production

USER root

WORKDIR /root

# COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.10/site-packages/
COPY *.sh /root/
COPY *.py /root/

# CMD ["bash", "installer.sh"]
