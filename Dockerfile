FROM ubuntu:22.04 AS build

USER root

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV STEAM_HOME="/home/steam"
ENV STEAM_CMD_DIR="${STEAM_HOME}/cmd"
ENV STEAM_CS_DIR="${STEAM_HOME}/cs2"

# Install required packages
RUN echo 'root:steamcmd' | chpasswd \
      && useradd -ms /bin/bash steam \
      && dpkg --add-architecture i386 \
      && apt-get update && apt-get install -y --no-install-recommends \
      curl ca-certificates libicu-dev sudo lib32gcc-s1 \
      && rm -rf /var/lib/apt/lists/*

FROM build AS cs2

USER steam

# Install SteamCMD
WORKDIR ${STEAM_CMD_DIR}
RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -

# Set up the CS server
WORKDIR ${STEAM_CS_DIR}
COPY --chmod=0755 scripts/entrypoint.sh ./entrypoint.sh

EXPOSE 27015/tcp \
       27015/udp

CMD ["bash", "entrypoint.sh"]
