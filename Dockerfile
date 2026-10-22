FROM alpine:3.21

# 1. Install curl, unzip, and certs
RUN apk add --no-cache unzip ca-certificates curl

# 2. Pin PocketBase version
ARG PB_VERSION=0.22.23

# 3. FIXED DOWNLOAD URL (Added missing '$' and '/')
ADD https://github.com{PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip

# 4. Unzip and set permissions
RUN unzip /tmp/pb.zip -d /pb/ && rm /tmp/pb.zip && chmod +x /pb/pocketbase

# 5. Expose port 8090
EXPOSE 8090

# 6. Start PocketBase
CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8090"]
