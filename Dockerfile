FROM alpine:3.10
RUN echo "**** install Python3 ****" && \
    apk add --no-cache python3 python3-dev py3-zmq build-base && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    echo "**** install pip ****" && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    echo "**** install locustio ****" && \
    pip install locustio pyzmq && \
    rm -rf /var/cache/apk/* && \
    mkdir /locust

WORKDIR /locust
ADD run-tests.sh /bin

ONBUILD ADD . /locust
ONBUILD RUN test -f requirements.txt && pip install -r requirements.txt; exit 0

EXPOSE 8089 5557 5558
ENTRYPOINT [ "/bin/run-tests.sh" ]
