# rider-plugin-docker
A Docker image for building Rider plugins with all necessary batteries included

## What's inside:

- OS: Ubuntu 22.10
- .NET SDK: 7.0
- JDK: Amazon Coretto 17

## How to use

### Space Automation

```kotlin
job("Build") {
    container(image = "seclerp.rider-plugin-ubuntu:latest") {
        kotlinScript { api ->
            api.gradle("prepare")
            api.gradle("buildPlugin")
        }
    }
}

job("Deploy to Marketplace")
container(image = "seclerp.rider-plugin-ubuntu:latest") {
    kotlinScript { api ->
        api.gradle("prepare")
        api.gradle("publish")
        // ...
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
