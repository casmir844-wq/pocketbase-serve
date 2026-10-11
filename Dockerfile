FROM alpine:3.18

RUN apk add --no-cache ca-certificates curl unzip

ENV PB_VERSION=0.22.20
ENV LITESTREAM_VERSION=v0.3.13

# Install PocketBase
RUN set -eux; \
    wget -O /tmp/pocketbase.zip \
      "https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip"; \
    unzip -o /tmp/pocketbase.zip -d /usr/local/bin/; \
    rm -f /tmp/pocketbase.zip

# Install Litestream
RUN set -eux; \
    wget -O /tmp/litestream.tar.gz \
      "https://github.com/benbjohnson/litestream/releases/download/${LITESTREAM_VERSION}/litestream_${LITESTREAM_VERSION#v}_linux_amd64.tar.gz"; \
    tar -xzf /tmp/litestream.tar.gz -C /usr/local/bin/; \
    rm -f /tmp/litestream.tar.gz

# Application layout
WORKDIR /pb
RUN mkdir -p /pb/pb_data

COPY litestream.yml /etc/litestream.yml
COPY run.sh /pb/run.sh
RUN chmod +x /pb/run.sh

EXPOSE 8080
CMD ["/pb/run.sh"]
