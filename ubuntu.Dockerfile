FROM ubuntu:22.04

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

RUN apt update
RUN apt install -y software-properties-common
RUN apt install -y wget
RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test
RUN wget -O- https://apt.corretto.aws/corretto.key | apt-key add -
RUN add-apt-repository 'deb https://apt.corretto.aws stable main'

# Install common dependencies
RUN apt install -y \
        software-properties-common \
        libasound2-dev \
        autoconf2.13 \
        automake \
        bzip2 \
        libcups2-dev \
        file \
        libfontconfig1-dev \
        libfreetype6-dev \
        libgif-dev \
        git \
        libtool \
        libxi-dev \
        libxrandr-dev \
        libxrender-dev \
        libxt-dev \
        libxtst-dev \
        make \
        rsync \
        tar \
        unzip \
        libwayland-dev \
        zip \
        curl \
        gnupg2 \
        --fix-missing

# Install JDK 17
RUN apt-get install -y java-17-amazon-corretto-jdk

RUN apt-get clean -qy

# Install .NET 7
RUN curl -sSL https://dot.net/v1/dotnet-install.sh  \
    | bash /dev/stdin --channel 7.0 --version latest --install-dir /usr/share/dotnet \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

# Export env vars
ENV \
    DOTNET_ROOT="/usr/share/dotnet" \
    PATH="$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools" \
    DOTNET_NOLOGO=true
