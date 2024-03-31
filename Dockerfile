FROM ubuntu:22.04 as build_phase

# environment variables
ENV DEBIAN_FRONTEND=noninteractive
# steam env variables
ENV STEAM_HOME="/home/steam"
ENV STEAM_CMD_DIR="${STEAM_HOME}/cmd"
ENV STEAM_CS_DIR="${STEAM_HOME}/cs2"

# Define the root user
USER root
RUN echo 'root:steamcmd' | chpasswd

# Intall packages
RUN dpkg --add-architecture i386

RUN apt-get update && apt-get install -y \
      curl \
      libicu-dev \
      sudo \
      lib32gcc-s1

RUN useradd -m -s /bin/bash steam

# download cs
FROM build_phase as cs_server
USER steam

WORKDIR ${STEAM_CMD_DIR}
RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -

# run cs
WORKDIR ${STEAM_CS_DIR}
COPY --chmod=0755 ./scripts/entrpoint.sh "${STEAM_CS_DIR}/entrypoint.sh"
CMD ["bash", "entrypoint.sh"]

EXPOSE 27015/tcp \
  27015/udp \
