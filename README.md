# pgModeler Docker Builder

This repository contains a Dockerfile to build [pgModeler](https://pgmodeler.io/) from source using Ubuntu 24.04 and Qt6.

## Prerequisites

- Docker installed on your system
- Internet connection to download dependencies

## Usage

1. Build the Docker image:
```bash
docker build -t pgmodeler .
```

2. Run the container:
```bash
docker run --rm -ti -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix pgmodeler
```

# Running pgModeler in Docker

Run the container with a volume to sync pgModeler data:
```bash
docker run --rm -ti -e DISPLAY=$DISPLAY -v /opt/pgmodeler/:/root/.config/ -v /tmp/.X11-unix:/tmp/.X11-unix luangazin/pgmodeler:1.2.0
```

# Configuring PgModeler desktop environment

## Syncing pgModeler data
```bash
mkdir -p /opt/pgmodeler
mkdir -p ~/workspace/pgmodeler
```

wget https://pgmodeler.io/img/pgmodeler_logo.png /opt/pgmodeler/pgmodeler_logo.png
```

## Creating a Desktop Entry
To create a desktop entry for pgModeler, you can use the following command:
```bash
echo '[Desktop Entry]
Version=1.0
Type=Application
Name=PG Modeler
GenericName=PostgreSQL Database Modeler
Comment=PostgreSQL Database Modeler running in Docker
Exec=sh -c "xhost +si:localuser:root && docker run --rm -e DISPLAY=$DISPLAY -v ~/workspace/pgmodeler:/root/pgmodeler -v /opt/pgmodeler/:/root/.config/ -v /tmp/.X11-unix:/tmp/.X11-unix --network host luangazin/pgmodeler:1.2.0"
Icon=/opt/pgmodeler/pgmodeler_logo.png
Terminal=false
Categories=Development;Database;
MimeType=application/x-pgmodeler;
StartupNotify=true
StartupWMClass=pgmodeler' > ~/.local/share/applications/pgmodeler-docker.desktop && chmod +x ~/.local/share/applications/pgmodeler-docker.desktop
```

## Details

- Base image: Ubuntu 24.04
- pgModeler version: 1.2.0
- Qt version: 6
- Build dependencies:
  - g++
  - build-essential
  - cmake
  - libpq-dev
  - libxml2-dev
  - Qt6 development packages
  - Other system libraries

## Environment

The container is configured with:
- Timezone: America/Sao_Paulo
- Working directory: /pgmodeler

```bash
## License
This Dockerfile is provided as-is. pgModeler is licensed under GPL v3. See [pgModeler's repository](https://github.com/pgmodeler/pgmodeler) for more details.

