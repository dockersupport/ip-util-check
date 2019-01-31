FROM golang:1.11.0-alpine

RUN apk add --no-cache --update bash ca-certificates curl make git openssh-client unzip jq docker

# should stay consistent with the version in .circleci/config.yml
ARG PROTOC_VERSION=3.6.1
# download and install protoc binary and .proto files
RUN curl --silent --show-error --location --output protoc.zip \
  https://github.com/google/protobuf/releases/download/v$PROTOC_VERSION/protoc-$PROTOC_VERSION-linux-x86_64.zip \
  && unzip -d /usr/local protoc.zip include/\* bin/\* \
  && rm -f protoc.zip
WORKDIR /go/src/github.com/docker
RUN git clone https://github.com/docker/swarmkit.git swarmkit && cd swarmkit && make bin/swarmctl && cp bin/swarmctl /usr/bin/swarmctl && rm -rf /go/src/github.com/docker/swarmkit

COPY ip-util-check /usr/bin
CMD [ "/usr/bin/ip-util-check" ]
