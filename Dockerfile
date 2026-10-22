FROM alpine:3.21

# 1. Install curl (Crucial for ZevCloud health check) along with unzip and certs
RUN apk add --no-cache unzip ca-certificates curl

# 2. Download PocketBase
ARG PB_VERSION=0.22.23
ADD https://github.com{PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip

# 3. Unzip and set permissions
RUN unzip /tmp/pb.zip -d /pb/ && rm /tmp/pb.zip && chmod +x /pb/pocketbase

# 4. Expose the port
EXPOSE 8090

# 5. Start PocketBase
CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8090"]
