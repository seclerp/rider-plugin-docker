FROM ubuntu:22.10

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

# Install dependencies
RUN apt update
RUN apt-get install -y wget
RUN apt-get install -y curl
RUN apt-get install -y gnupg2
RUN apt-get install -y software-properties-common

# Add Amazon Coretto repository
RUN wget -O- https://apt.corretto.aws/corretto.key | apt-key add - 
RUN add-apt-repository 'deb https://apt.corretto.aws stable main'

# Update Ubuntu Software repository
RUN apt update

# Install JDK 17 (Amazon Coretto)
RUN apt-get install -y java-17-amazon-corretto-jdk

# Install .NET 7
RUN curl -sSL https://dot.net/v1/dotnet-install.sh  \
    | bash /dev/stdin --channel 7.0 --version latest --install-dir /usr/share/dotnet \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

# Export env vars
ENV \
    DOTNET_ROOT="/usr/share/dotnet" \
    PATH="$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools" \
    DOTNET_NOLOGO=true

RUN dotnet --info