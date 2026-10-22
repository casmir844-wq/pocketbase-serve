FROM alpine:3.21

# Install unzip and certificates
RUN apk add --no-cache unzip ca-certificates

# Pin the PocketBase version you want to use
ARG PB_VERSION=0.22.23
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip

# Unzip and clean up
RUN unzip /tmp/pb.zip -d /pb/ && rm /tmp/pb.zip && chmod +x /pb/pocketbase

# Expose PocketBase default port
EXPOSE 8090

# Start PocketBase and bind to all network interfaces
CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8090"]
