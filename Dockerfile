FROM ctelfer/swarmctl:latest
RUN apk add --update bash docker jq
COPY ip-util-check /usr/bin
ENTRYPOINT [ "/usr/bin/ip-util-check" ]
