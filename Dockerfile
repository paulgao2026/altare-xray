FROM alpine:3.23
RUN apk add --no-cache curl unzip ca-certificates
RUN mkdir -p /usr/local/bin /etc/xray && \
    cd /tmp && \
    curl -L -o xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip -o xray.zip -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/xray && \
    rm -f xray.zip
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
