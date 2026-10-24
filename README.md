# OpenWrt Printing Packages

Build and host custom OpenWrt printing packages using the official OpenWrt SDK inside a container.

## Packages

This feed provides the following packages:
- CUPS: printing service and command-line tools
- cups-filters: document conversion and print filtering
- SpliX: printer driver for supported Samsung SPL (Samsung Printer Language) printers
- Supporting libraries and dependencies required by the printing stack

The current configuration is intended for printers supported by SpliX. Other printers may require a different driver and additional configuration.

## Requirements

- Podman or Docker
- An [OpenWrt SDK](https://hub.docker.com/r/openwrt/sdk/tags) compatible with your router firmware
- This repository added to `feeds.conf.default`

## 1. Start the build container

Example using the OpenWrt 23.05.6 SDK for BCM63xx SMP:

```sh
podman run -it --user=0 \
  --volume=./local:/builder/bin \
  --publish 8000:8000 \
  --name=openwrt \
  docker.io/openwrt/sdk:bcm63xx-smp-23.05.6 bash
```

The host directory `./local` is mounted at `/builder/bin` inside the container.

## 2. Add the printing feed

Inside the container, add this repository to `feeds.conf.default`:

```sh
echo "src-git printing https://github.com/eskander/openwrt-printing.git" >> feeds.conf.default
./scripts/feeds update printing
```

## 3. Build the packages

Run the setup script inside the container:

```sh
./feeds/printing/setup-buildsystem.sh
```

This prepares the build configuration and builds the printing packages.

## 4. Serve the package repository

Start the repository server:

```sh
./feeds/printing/serve-repo.sh
```

The script generates the package index and starts an HTTP repository on port `8000`.

It prints the feed configuration line to add to `/etc/opkg/customfeeds.conf` on your router. Replace `BUILD_HOST_IP` with the LAN IP address of the host running Podman/Docker.

## 5. Install on the router

On the router, update the package lists and install the printing stack:

```sh
opkg update
opkg install cups cups-filters splix
```

Keep the official OpenWrt feeds enabled so dependencies can be obtained from them when available.

## Notes

- Use an [SDK](https://hub.docker.com/r/openwrt/sdk/tags) compatible with your router's OpenWrt version and architecture.
- Rebuild the package index by restarting `serve-repo.sh` after changing packages.
- Avoid replacing core system libraries with versions built for a different system.
