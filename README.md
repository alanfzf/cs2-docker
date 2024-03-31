# CS2 Docker

Simple CS2 Dockerfile

## Example with Docker Compose

```yaml
services:
  cs2-server:
    container_name: cs2
    build: .
    ports:
      - "27015:27015/udp"
      - "27015:27015/tcp"
    env_file:
      - .env
    volumes:
      - cs2:/home/steam/
volumes:
  cs2:
```

Then you need to create a `env` file to store your `STEAM_TOKEN`

```env
STEAM_TOKEN=YOUR_TOKEN_HERE
```
