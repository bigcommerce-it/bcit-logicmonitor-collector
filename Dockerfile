FROM ubuntu:20.04

# NTP is needed for some collector operations
RUN apt-get update \
  && apt-get install --no-install-recommends -y \
  inetutils-traceroute \
  file \
  iputils-ping \
  ntp \
  perl \
  procps \
  xxd \
  wget \
  apt-transport-https \
  software-properties-common \
  && apt-get -y clean \
  && rm -rf /var/lib/apt/lists/*
  
RUN wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb" \
   && sudo dpkg -i packages-microsoft-prod.deb
RUN sudo apt-get update \
    && apt-get install -y powershell


RUN pip install logicmonitor_sdk==1.0.129
RUN mkdir /usr/local/logicmonitor

COPY collector /collector
COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
