#!/bin/bash
# Run the cloudflare-ddns command once when the container starts
/usr/bin/cloudflare-ddns ${CF_EMAIL} ${CF_GLOBAL_API} ${CF_DOMAIN}

# Create a cron job to run the command every 5 minutes
echo "*/5 * * * * /usr/bin/cloudflare-ddns ${CF_EMAIL} ${CF_GLOBAL_API} ${CF_DOMAIN} >> /var/log/cloudflare-ddns.log 2>&1" >> /etc/crontabs/root

# Give execution rights on the cron job
chmod +x /etc/crontabs/root

# Create the log file to be able to run tail
touch /var/log/cloudflare-ddns.log

# Start cron
crond

# Keep the container running
tail -f /var/log/cloudflare-ddns.log
