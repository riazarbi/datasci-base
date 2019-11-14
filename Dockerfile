# Lock to a particular Ubuntu image
ARG BASE_CONTAINER=ubuntu:bionic-20190612@sha256:9b1702dcfe32c873a770a32cfd306dd7fc1c4fd134adfb783db68defc8894b3c
FROM $BASE_CONTAINER

LABEL authors="Riaz Arbi,Gordon Inggs"

# BASE ==========================================

# Set the timezone
ENV TZ="Africa/Johannesburg"

# Let's make it a bit more functional
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get clean && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get install -y \
    vim \
    nano \
    htop \
    bash \
    cmake \
    make \
    gcc \
    wget \
    apt-utils \
    git \
    sudo \
    locales \
    dnsutils \
    curl \
    screen \
    python3 \
    python3-pip \
# Jupyter-specific
 && apt-get update \
 && apt-get install -yq --no-install-recommends \
    wget \
    bzip2 \
    ca-certificates \
    sudo \
    locales \
    fonts-liberation \
    npm \
    libffi-dev \
# R-specific
    libapparmor1 \
    libedit2 \
    lsb-release \
    psmisc \
    libssl1.0.0 \
    gnupg \
    apt-transport-https \
 && echo $TZ > /etc/timezone \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y tzdata \
 && rm /etc/localtime \
 && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
 && dpkg-reconfigure -f noninteractive tzdata \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
# Define en_ZA
 && DEBIAN_FRONTEND=noninteractive \
    locale-gen en_ZA && \
    locale-gen en_ZA.UTF-8 && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale

ENV LANGUAGE en_ZA.UTF-8
ENV LANG en_ZA.UTF-8
ENV LC_ALL en_ZA.UTF-8
ENV LC_CTYPE en_ZA.UTF-8
ENV LC_MESSAGES en_ZA.UTF-8

