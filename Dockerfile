FROM adoptopenjdk/openjdk11

RUN apt-get update && \
    apt-get -y install gcc libc6-dev zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

ENV GRAAL_VERSION 19.2.0

ENV GRAAL_TARGET_FOLDER /usr/lib
ENV GRAAL_FILENAME graalvm-ce-linux-amd64-${GRAAL_VERSION}.tar.gz
ENV GRAALVM_HOME ${GRAAL_TARGET_FOLDER}/graalvm-ce-${GRAAL_VERSION}

RUN curl -4 -L https://github.com/oracle/graal/releases/download/vm-${GRAAL_VERSION}/${GRAAL_FILENAME} -o /tmp/${GRAAL_FILENAME}
RUN tar -xzvf /tmp/${GRAAL_FILENAME} -C ${GRAAL_TARGET_FOLDER}
RUN rm -rf /tmp/*

RUN ${GRAALVM_HOME}/bin/gu install native-image

ENTRYPOINT ["${GRAALVM_HOME}/bin/native-image"]