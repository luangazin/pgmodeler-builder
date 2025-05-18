# pgModeler Docker Builder

This repository contains a Dockerfile to build [pgModeler](https://pgmodeler.io/) from source using Ubuntu 24.04 and Qt6.

## Prerequisites

- Docker installed on your system
- Internet connection to download dependencies

## Usage

1. Build the Docker image:
```bash
docker build -t pgmodeler-builder .
```

2. Run the container:
```bash
docker run -it pgmodeler-builder
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

## License

This Dockerfile is provided as-is. pgModeler is licensed under GPL v3. See [pgModeler's repository](https://github.com/pgmodeler/pgmodeler) for more details.