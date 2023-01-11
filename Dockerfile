FROM ubuntu:18.04

RUN apt-get -y update
RUN apt-get -y install git wget gcc

ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh
RUN /bin/bash /tmp/miniconda.sh -b -p /opt/conda

ENV PATH=$CONDA_DIR/bin:$PATH
RUN conda init bash

ADD sst_py/ /code/sst_py

RUN conda init bash
RUN conda env create -f=/code/sst_py/environment.yaml
RUN pip install -e /code/sst_py/

WORKDIR /code
