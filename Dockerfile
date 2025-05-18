FROM ubuntu:24.04

ARG PGMODELER_VERSION=v1.2.0

WORKDIR /pgmodeler

RUN ln -snf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && echo 'America/Sao_Paulo' > /etc/timezone
RUN apt update && apt upgrade -y && \
    apt install wget g++ build-essential cmake libpq-dev libxml2-dev pkg-config qt6-base-dev qt6-declarative-dev qt6-tools-dev qt6-tools-dev-tools qtchooser libqt6svg6-dev libxext-dev libx11-dev libgl1-mesa-dev -y
#     # apt install wget make g++ qt5-qmake libxml2-dev libpq-dev pkg-config libqt5svg5-dev qttools5-dev libqt5svg5 qtbase5-dev qtchooser qtbase5-dev-tools -y

RUN wget https://github.com/pgmodeler/pgmodeler/archive/refs/tags/${PGMODELER_VERSION}.tar.gz -O pgmodeler.tar.gz && \
    tar -xzf pgmodeler.tar.gz --strip 1 && \
    rm -rf pgmodeler.tar.gz

RUN qmake6 pgmodeler.pro && \
    make -j8 && \
    make install

CMD [ "bash" ]