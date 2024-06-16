# Use the official Alpine image as a base
FROM --platform=linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64,linux/ppc64le alpine:latest

# Install necessary packages: tailscale, openrc, and bash in a single layer
RUN apk update &&\
    apk add --no-cache cloudflare-ddns bash dcron

# Copy the entrypoint script and set permissions in one layer
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
