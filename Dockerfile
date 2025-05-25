FROM ubuntu:24.04

ARG PGMODELER_VERSION=v1.2.0
ARG MAKE_JOBS=8

WORKDIR /usr/local/src/

# Setting timezone to America/Sao_Paulo, updating the system, and installing dependencies
RUN ln -snf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && echo 'America/Sao_Paulo' > /etc/timezone \
  && DEBIAN_FRONTEND=noninteractive \
  && apt-get update && apt-get install -y software-properties-common \
  && add-apt-repository universe \
  && apt-get update \
  && apt-get -y install --no-install-recommends wget ca-certificates qmake6 build-essential libxml2-dev libpq-dev pkg-config cmake \
    qtdeclarative5-dev libqt6core6 libqt6svg6 qttools5-dev qttools5-dev-tools postgresql-server-dev-all qt6-base-dev libqt6svg6-dev

ENV PATH="/usr/lib/qt6/bin:$PATH"

#Downloading and extracting pgmodeler
RUN wget https://github.com/pgmodeler/pgmodeler/archive/refs/tags/${PGMODELER_VERSION}.tar.gz -O pgmodeler.tar.gz && \
    tar -xzf pgmodeler.tar.gz --strip 1 && \
    rm -rf pgmodeler.tar.gz

# Building pgmodeler
# The -j16 flag is used to speed up the build process by using 16 threads
RUN qmake pgmodeler.pro \
  && make -j${MAKE_JOBS} && make install \
  && mkdir -p /usr/local/lib/pgmodeler/plugins \
  && chmod 777 /usr/local/lib/pgmodeler/plugins

# Clean unnecessary packages
RUN apt-get remove --purge -y wget qmake6 build-essential libxml2-dev libpq-dev pkg-config cmake \
  && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/local/bin/pgmodeler"]