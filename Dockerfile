FROM node:20-bookworm

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update -y && apt install -y -q \
        jq \
        wget \
        libasound2 \
        bzip2 \
        curl \
        pipewire-audio \
        alsa-utils

ENV WORKDIR /home/root
RUN mkdir -p $WORKDIR
WORKDIR $WORKDIR
RUN wget -q "$(curl -s "https://plexamp.plex.tv/headless/version$1.json" | jq -r '.updateUrl')" -O plexamp.tar.bz2
RUN tar xfj plexamp.tar.bz2
ENV WORKDIR $WORKDIR/plexamp
WORKDIR $WORKDIR
ENTRYPOINT node $WORKDIR/js/index.js
