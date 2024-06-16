#!/bin/bash
# Run the cloudflare-ddns command once when the container starts
/usr/bin/cloudflare-ddns ${cf-email} ${cf-global-api} ${cf-domain}

# Create a cron job to run the command every 5 minutes
echo "*/5 * * * * /usr/bin/cloudflare-ddns ${cf-email} ${cf-global-api} ${cf-domain} >> /var/log/cloudflare-ddns.log 2>&1" > /etc/cron.d/cloudflare-ddns

# Give execution rights on the cron job
chmod 0644 /etc/cron.d/cloudflare-ddns

# Apply cron job
crontab /etc/cron.d/cloudflare-ddns

# Create the log file to be able to run tail
touch /var/log/cloudflare-ddns.log

# Start cron
cron

# Keep the container running
tail -f /var/log/cloudflare-ddns.log
