# synology-media-converter

> [!NOTE]
> This project is not officially affiliated with Synology.

Since DSM version 7.2.2 Synology has removed the ability to generate thumbnails, transcode videos to H264 and display HEIC files in Synology Photos due to licensing restrictions. As an official solution they provide a tool called Synology Image Assistant which requires a computer and is only available for Windows and macOS. This project aims to restore the old way how Photos worked by providing a script that can be directly run on the NAS (or any other device that supports Docker) and automatically converts newly added media every night.

## Installation

**Container Manager:**\
You can easily install the service via the [Container manager](https://www.synology.com/de-de/dsm/feature/container-manager) by importing the file `ContainerManager_synology-media-converter.json` in the GUI. By default the script expects there to be a volume called docker that contains the synology-media-converter.json config described in [Configuration](#configuration). You can edit the host volume path at the very bottom of the preset file before importing it.

**Docker CLI:**
```bash
docker run -d --name=synology-media-converter \
    --network=host \
    -v <config_file>:/app/config.json \
    -e TZ=<timezone>
    -e CRON_INTERVAL="0 1 * * *" \
    ghcr.io/1randomdev/synology-media-converter
```

## Configuration
Example config for 2 users on the same device:
```json
{
    "accounts": [
        {
            "url": "http://192.168.1.10:5000",
            "username": "user1",
            "password": "secret"
        },
        {
            "url": "http://192.168.1.10:5000",
            "username": "user2",
            "password": "secret"
        }
    ]
}

```

## Environment Variables

| Variable | Description | Default |
| -------- | ----------- | ------- |
| CRON_INTERVAL | Crontab interval that defines how often the script will be executed. [Crontab Generator](https://crontab.guru/) | `0 1 * * *` (Every day at 1am) |
