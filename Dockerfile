FROM alpine:3.18

# Install base dependencies for network calls and unzipping binaries
RUN apk add --no-cache ca-certificates curl unzip openssh

# 1. Download and install PocketBase
ENV PB_VERSION=0.22.20
RUN wget https://github.com{PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip \
    && unzip pocketbase_${PB_VERSION}_linux_amd64.zip -d /usr/local/bin/ \
    && rm pocketbase_${PB_VERSION}_linux_amd64.zip

# 2. Download and install Litestream for continuous DB replication
ENV LITESTREAM_VERSION=v0.3.13
RUN wget https://github.com{LITESTREAM_VERSION}/litestream-${LITESTREAM_VERSION}-linux-amd64.tar.gz \
    && tar -xvzf litestream-${LITESTREAM_VERSION}-linux-amd64.tar.gz -C /usr/local/bin/ \
    && rm litestream-${LITESTREAM_VERSION}-linux-amd64.tar.gz

# 3. Establish application layout
WORKDIR /pb
RUN mkdir -p /pb/pb_data

# 4. Bind orchestrator configuration templates
COPY litestream.yml /etc/litestream.yml
COPY run.sh /pb/run.sh

# Grant execution rights to initialization sequence
RUN chmod +x /pb/run.sh

# Expose network edge target port
EXPOSE 8080

# Execute entrypoint initialization script
CMD ["/pb/run.sh"]
