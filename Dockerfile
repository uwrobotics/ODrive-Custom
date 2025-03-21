# Clone Ubuntu[Must ENABLE noninteractive]
FROM ubuntu:bionic
ARG DEBIAN_FRONTEND=noninteractive

# TODO: check git-lfs
RUN set -x && \
    apt-get update && \
    apt-get -y install software-properties-common && \
    add-apt-repository ppa:team-gcc-arm-embedded/ppa && \
    add-apt-repository ppa:jonathonf/tup && \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install gcc-arm-embedded openocd tup python3.7 python3-yaml python3-jinja2 python3-jsonschema build-essential git time && \
    # Build step below does not know about debian's python naming schemme
    ln -s /usr/bin/python3.7 /usr/bin/python \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home

ADD . /home

<<<<<<< HEAD
RUN cd Firmware \
    && mkdir -p autogen && \
	python ../tools/odrive/version.py \
	--output autogen/version.c

RUN cd Firmware \
    && tup init \
=======
RUN cd Firmware
>>>>>>> f
    && tup generate build.sh \
    && ./build.sh