FROM openjdk:14-ea-8-jdk-alpine3.10

RUN apk update && apk --no-cache add gcc libc6-compat zlib-dev

ENV GRAAL_VERSION 19.2.0

ENV GRAAL_TARGET_FOLDER /usr/lib
ENV GRAAL_FILENAME graalvm-ce-linux-amd64-${GRAAL_VERSION}.tar.gz
ENV GRAALVM_HOME ${GRAAL_TARGET_FOLDER}/graalvm-ce-${GRAAL_VERSION}

RUN wget https://github.com/oracle/graal/releases/download/vm-${GRAAL_VERSION}/${GRAAL_FILENAME} -O /tmp/${GRAAL_FILENAME}
RUN tar -xzvf /tmp/${GRAAL_FILENAME} -C ${GRAAL_TARGET_FOLDER}
RUN rm -rf /tmp/*

RUN ${GRAALVM_HOME}/bin/gu install native-image

ENTRYPOINT ["${GRAALVM_HOME}/bin/native-image"]