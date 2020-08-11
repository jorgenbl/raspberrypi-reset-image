FROM ubuntu

RUN apt update
RUN apt install -y git wget unzip uuid-runtime sudo parted zip udev

COPY entrypoint.sh .
RUN chmod 755 entrypoint.sh

VOLUME ["/restore"]

ENTRYPOINT ./entrypoint.sh
#ENTRYPOINT ./entrypoint.sh && bash
