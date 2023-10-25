FROM pegi3s/docker

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get install wget

COPY main /opt
COPY simulate_data /opt

WORKDIR /opt
