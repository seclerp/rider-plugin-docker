FROM ubuntu:22.10

# LABEL about the custom image
LABEL maintainer="contact@seclerp.me"
LABEL version="1.0.0-pre1"
LABEL description="AboutA Docker image for automate Rider plugins building with all necessary batteries included."

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

# Add Amazon Coretto repository
wget -O- https://apt.corretto.aws/corretto.key | sudo apt-key add - 
RUN add-apt-repository 'deb https://apt.corretto.aws stable main'

# Update Ubuntu Software repository
RUN apt update

# Install JDK 17 (Amazon Coretto)
RUN apt-get install -y java-17-amazon-corretto-jdk

# Install .NET 7
RUN apt-get install -y dotnet-sdk-7.0
