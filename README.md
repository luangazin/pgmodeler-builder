# pgModeler Docker Builder

This repository contains a Dockerfile to build [pgModeler](https://pgmodeler.io/) from source using Ubuntu 24.04 and Qt6.

## Prerequisites

- Docker installed on your system
- Internet connection to download dependencies

## Usage

### Option 1: Build and Install Locally (Recommended)

Use the `local-build` script to build pgModeler in Docker and install it directly on your machine:

```bash
chmod +x local-build
./local-build
```

This will:
- Build pgModeler v1.2.3 in a Docker container
- Extract the binary, libraries, and dependencies
- Install to your system (`/usr/local/bin`, `/usr/local/lib`, `/usr/local/share`)
- Set up a desktop entry with icon
- Configure all environment variables

After installation, run pgModeler directly:
```bash
pgmodeler
```

Or launch it from your applications menu!

**Customization:**
- Edit `PGMODELER_VERSION` to change the version (e.g., `v1.2.2`)
- Edit `MAKE_JOBS` to adjust parallel build threads (default: 16)
- Uses `Dockerfile.localbuild` for the build

**Installed locations:**
- Binary: `/usr/local/bin/pgmodeler` (wrapper script)
- Libraries: `/usr/local/lib/pgmodeler/` and `/usr/local/lib/pgmodeler-libs/`
- Resources: `/usr/local/share/pgmodeler/`
- Configuration: `~/.config/pgmodeler-1.2/`
- Desktop entry: `~/.local/share/applications/pgmodeler.desktop`

### Option 2: Run in Docker Container

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
docker run --rm -ti -e DISPLAY=$DISPLAY -v /opt/pgmodeler/:/root/.config/ -v /tmp/.X11-unix:/tmp/.X11-unix luangazin/pgmodeler:1.2.2
```

# Configuring PgModeler desktop environment

## Syncing pgModeler data
```bash
sudo mkdir -p /opt/pgmodeler
xhost +si:localuser:root
sudo wget https://pgmodeler.io/img/pgmodeler_logo.png -O /opt/pgmodeler/pgmodeler_logo.png
mkdir -p ~/workspace/pgmodeler
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
Exec=sh -c "xhost +si:localuser:root && docker run --rm -e DISPLAY=$DISPLAY -v ~/workspace/pgmodeler:/root/pgmodeler -v /opt/pgmodeler/:/root/.config/ -v /tmp/.X11-unix:/tmp/.X11-unix --network host luangazin/pgmodeler:1.2.2"
Icon=/opt/pgmodeler/pgmodeler_logo.png
Terminal=false
Categories=Development;Database;
MimeType=application/x-pgmodeler;
StartupNotify=true
StartupWMClass=pgmodeler' > ~/.local/share/applications/pgmodeler-docker.desktop && chmod +x ~/.local/share/applications/pgmodeler-docker.desktop
```

## Details

- Base image: Ubuntu 24.04
- pgModeler version: 1.2.2
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

## License
This Dockerfile is provided as-is. pgModeler is licensed under GPL v3. See [pgModeler's repository](https://github.com/pgmodeler/pgmodeler) for more details.

