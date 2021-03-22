# set base image (host OS)
FROM arm32v7/python:3.7-slim-buster

ARG DEBIAN_FRONTEND=noninteractive

# set the working directory in the container
WORKDIR /app

# copy the dependencies file to the working directory


# install dependencies
RUN apt-get update \
    && apt-get -y install sudo \
    && apt-get -y install apt-utils  \
    && apt-get install make \
    && apt-get install build-essential -y \
    && apt-get install libyaml-dev python3-setuptools git python3-matplotlib -y


# copy the content of the local src directory to the working directory


# Run installation of rpi-grb-led-matrix

RUN git clone https://github.com/hzeller/rpi-rgb-led-matrix.git \
    && cd rpi-rgb-led-matrix\
    && make -C examples-api-use\
    && make build-python PYTHON=$(which python3)\
    && make install-python PYTHON=$(which python3)

WORKDIR /app

RUN git clone https://github.com/breiti78/infopanel.git\
    && cd infopanel\
    && python3 setup.py install