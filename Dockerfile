# set base image (host OS)
FROM arm32v7/python:3.7-alpine3.15

ARG DEBIAN_FRONTEND=noninteractive

# set the working directory in the container
WORKDIR /app

# copy the dependencies file to the working directory

# install dependencies
RUN apk add --no-cache tesseract-ocr python3 py3-numpy && \
    pip3 install --upgrade pip setuptools wheel && \
    apk add --no-cache --virtual .build-deps gcc g++ zlib-dev make git python3-dev py-numpy-dev jpeg-dev && \
    pip3 install matplotlib && \
    apk del .build-deps

# copy the content of the local src directory to the working directory


# Run installation of rpi-grb-led-matrix

RUN git clone https://github.com/hzeller/rpi-rgb-led-matrix.git \
    && cd rpi-rgb-led-matrix\
    && make -C examples-api-use\
    && make build-python PYTHON=$(which python3)\
    && make install-python PYTHON=$(which python3)
