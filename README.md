# tborg

This is a very simple Docker Image based on Alpine that creates periodic backups of [our Terraria image](https://github.com/objpatrish/terraria) using [borgbackup](https://borgbackup.org) and [cron](https://en.wikipedia.org/wiki/Cron).

## Usage

If you want to change the frequency of the backups make sure to edit the [crontab](src/crontab.txt) before building the container.

### Docker

```bash
docker run \
    -name=terraria_tborg \
    --restart unless-stopped \
    --detach \
    -v "<backup_target_volume>:/repo"
    -v "<terraria_data_volume>:/archive"
    docker.pkg.github.com/objpatrish/tborg/tborg:latest
```

### Docker-Compose

```yaml
---
version: "3.8"
services:
  backup:
      image: "docker.pkg.github.com/objpatrish/tborg/tborg:latest"
      restart: unless-stopped
      volumes:
        - "terraria_backup:/repo"
        - "terraria_game_data:/archive"


volumes:
  terraria_game_data:
    external: true
  terraria_backup:
    external: true
```
