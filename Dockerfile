# Use the official Alpine image as a base
FROM alpine:latest

# Install necessary packages: tailscale, openrc, and bash in a single layer
RUN apk update &&\
    apk add --no-cache cloudflare-ddns bash dcron

# Copy the entrypoint script and set permissions in one layer
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
