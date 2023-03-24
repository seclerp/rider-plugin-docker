# rider-plugin-docker

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/seclerp/rider-efcore/build.yml?logo=github&style=for-the-badge)
![Docker Image Version (latest by date)](https://img.shields.io/docker/v/seclerp/rider-plugin-ubuntu?color=blue&label=image&logo=docker&sort=date&style=for-the-badge)

A Docker image for building Rider plugins with all necessary batteries included

## What's inside:

- OS: Ubuntu 22.10
- .NET SDK: 7.0.202
- JDK: Amazon Coretto 17

## How to use

### Space Automation

```kotlin
job("Build") {
    container(image = "seclerp.rider-plugin-ubuntu:latest") {
        kotlinScript { api ->
            api.gradlew("prepare")
            api.gradlew("testPlugin")
            api.gradlew("buildPlugin")
        }
    }
}

job("Deploy to Marketplace") {
    container(image = "seclerp.rider-plugin-ubuntu:latest") {
        kotlinScript { api ->
            api.gradlew("publish")
            // ...
        }
    }
}

```

### Docker build
It's possible to use this image for building plugin inside child Dockerfile:

```dockerfile
FROM seclerp.rider-plugin-ubuntu:latest AS build

COPY . .
RUN ./gradlew :prepare
RUN ./gradlew :buildPlugin

FROM seclerp.rider-plugin-ubuntu:latest AS deploy

COPY . .
RUN ./gradlew :prepare
RUN ./gradlew :publish
# ...

```
