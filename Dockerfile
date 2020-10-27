# ----------------------------------
# Environment: ubuntu
# Minimum Panel Version: 0.7.X
# ----------------------------------
FROM  ubuntu:18.04

LABEL author="Ankit Patel" maintainer="ankit@bmghosting.com"

ENV   DEBIAN_FRONTEND noninteractive

## add container user
RUN   useradd -m -d /home/container -s /bin/bash container

## update base packages
RUN   apt update \
 &&   apt upgrade -y \
 &&   apt install -y gcc g++ libgcc1 lib32gcc1 gdb libc6 libstdc++6 git wget curl tar zip unzip binutils xz-utils liblzo2-2 bzip2 zlib1g iproute2 net-tools netcat telnet libatomic1 libsdl1.2debian libsdl2-2.0-0 \
      libfontconfig libicu60 libiculx60 icu-devtools libunwind8 libssl1.0.0 libssl1.0-dev sqlite3 libsqlite3-dev libmariadbclient-dev libduktape202 libzip4 locales ffmpeg apt-transport-https python3 python3-pip

## Steamclient.so Link
RUN ln -s "/home/container/steamcmd/linux64/steamclient.so" "/usr/lib/x86_64-linux-gnu/steamclient.so" 

## configure locale
RUN   update-locale lang=en_US.UTF-8 \
 &&   dpkg-reconfigure --frontend noninteractive locales

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

RUN mkdir /home/container/holdfastnaw-dedicated

COPY ./config.json /home/container/holdfastnaw-dedicated/
COPY ./requirements.txt /home/container/holdfastnaw-dedicated/
COPY ./steam-update-wrapper.py /home/container/holdfastnaw-dedicated

COPY  ./entrypoint.sh /entrypoint.sh
CMD   ["/bin/bash", "/entrypoint.sh"]
