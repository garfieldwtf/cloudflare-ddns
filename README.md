# Cloudflare DDNS Docker Container

A lightweight Docker container that automatically updates Cloudflare DNS records with your dynamic IP address. The container runs on Alpine Linux and updates your DNS record every 5 minutes.

## Features

- **Automatic DNS Updates**: Updates Cloudflare DNS records with your current IP address
- **Lightweight**: Built on Alpine Linux for minimal resource usage
- **Scheduled Updates**: Runs every 5 minutes via cron
- **Logging**: Comprehensive logging of all DNS update attempts
- **Easy Configuration**: Simple environment variable setup

## Prerequisites

- Docker installed on your system
- A Cloudflare account with a domain configured
- Cloudflare API key with DNS edit permissions

## Quick Start

1. **Get your Cloudflare API key:**
   - Log in to your Cloudflare account
   - Go to My Profile → API Tokens
   - Create a token with "Zone.DNS Edit" permissions

2. **Run the container:**
   ```bash
   docker run -d \
     --name cloudflare-ddns \
     -e CF_EMAIL=your-email@example.com \
     -e CF_GLOBAL_API=your_global_api_key \
     -e CF_DOMAIN=yourdomain.com \
     --restart unless-stopped \
     yourusername/cloudflare-ddns
   ```

## Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `CF_EMAIL` | Your Cloudflare account email address | Yes |
| `CF_GLOBAL_API` | Your Cloudflare Global API Key | Yes |
| `CF_DOMAIN` | The domain you want to update (e.g., example.com) | Yes |

## Building the Image

To build the Docker image yourself:

```bash
git clone https://github.com/yourusername/cloudflare-ddns.git
cd cloudflare-ddns
docker build -t cloudflare-ddns .
```

## Docker Compose Example

```yaml
version: '3.8'
services:
  cloudflare-ddns:
    build: .
    container_name: cloudflare-ddns
    environment:
      - CF_EMAIL=your-email@example.com
      - CF_GLOBAL_API=your_global_api_key
      - CF_DOMAIN=yourdomain.com
    restart: unless-stopped
```

## How It Works

1. **Container Startup**: The DNS record is updated immediately when the container starts
2. **Scheduled Updates**: A cron job runs every 5 minutes to check and update the DNS record if needed
3. **Logging**: All update attempts are logged to `/var/log/cloudflare-ddns.log` inside the container
4. **Persistence**: The container runs continuously with `tail -f` to keep the process alive

## Viewing Logs

To check the DNS update logs:

```bash
docker logs cloudflare-ddns
```

## Security Notes

- 🔒 **Never commit your API keys** to version control
- 🔒 Use Docker secrets or environment files for production deployments
- 🔒 Consider using Cloudflare API tokens with limited permissions instead of global API keys

## Troubleshooting

**Common issues:**

1. **Permission denied errors**: Ensure your API key has DNS edit permissions
2. **Domain not found**: Verify the domain exists in your Cloudflare account
3. **Container exits immediately**: Check that all required environment variables are set

**Check container status:**
```bash
docker ps -a | grep cloudflare-ddns
```

**View detailed logs:**
```bash
docker logs cloudflare-ddns
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Support

If you encounter any problems or have questions, please open an issue on GitHub.
