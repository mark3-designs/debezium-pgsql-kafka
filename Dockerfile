FROM postgres:14

RUN apt-get update -yqq \
  && apt-get install -yq make gcc postgresql-server-dev-14 \
  && apt-get install -f -y software-properties-common build-essential pkg-config

# PostGIS dependency
RUN apt-get install -f -y libproj-dev # liblwgeom-dev

# Protobuf-c dependency (requires a non-stable Debian repo)
RUN add-apt-repository "deb http://ftp.debian.org/debian testing main contrib" && apt-get update
RUN apt-get install -y libprotobuf-c-dev #=1.2.1-1+b1

COPY postgres-decoderbufs /build
WORKDIR /build
RUN make && make install


