ARG BUILDER=golang:1.22-alpine3.19
ARG PROD=alpine:3.19
ARG CLOAK_VER=v2.10.0

FROM $BUILDER as builder
RUN apk add make git

# Build
RUN target=/go/pkg \
    set -ex \
    && cd /go/src \
    && git clone https://github.com/cbeuw/Cloak \
    && cd Cloak \
    && git checkout $CLOAK_VER \
    && go get ./... \
    && make \
    && pwd \
    && ls ./build


FROM $PROD as prod

# Copy bins and config
COPY --from=builder /go/src/Cloak/build/ck-* /usr/bin/
COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

WORKDIR /opt/cloak

ENTRYPOINT ["/entrypoint.sh"]
