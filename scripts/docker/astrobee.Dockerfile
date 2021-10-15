# This will set up an Astrobee melodic docker container using the non-NASA install instructions.
# This image builds on top of the base melodic image building the code.
# You must set the docker context to be the repository root directory

ARG UBUNTU_VERSION=16.04
FROM tammer/astrobee:base-latest-ubuntu${UBUNTU_VERSION}

ENV USERNAME astrobee

COPY . /src/astrobee
RUN /src/astrobee/scripts/configure.sh -l -F -D -T -p /opt/astrobee -b /build/astrobee
RUN cd /build/astrobee && make -j`nproc`

COPY ./astrobee/resources /opt/astrobee/share/astrobee/resources

RUN ln -s /usr/bin/python3 /usr/bin/python

RUN echo "-9.82371e-13,-1.13071e-12,-1.39643e-12 \n-1.80458e-08,-2.20222e-11,-9.01996e-13" > /src/astrobee/astrobee/resources/imu_bias.config \
   $$ chmod a+rw /src/astrobee/astrobee/resources/imu_bias.config