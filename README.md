# Discord-Status

Simple docker container to keep a bot online with a status

You can start it with this docker compose:

```yml
services:
  discord-status:
    image: ghcr.io/caramelfur/discord-status:latest
    container_name: discord-status
    environment:
      DISCORD_KEY: "Your bot key"
      DISCORD_MESSAGE: "Hello World"
    restart: unless-stopped
```
