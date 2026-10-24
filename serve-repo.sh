#!/bin/sh
set -e

# Locate the printing feed automatically.
FEED=$(find /builder/bin/packages -type d -name printing -print -quit)

# Fail if the feed cannot be found.
if [ -z "$FEED" ]; then
    echo "Error: printing feed not found."
    exit 1
fi

# Generate the package index using OpenWrt's hash utility.
export MKHASH="/builder/staging_dir/host/bin/mkhash"
/builder/scripts/ipkg-make-index.sh "$FEED" > "$FEED/Packages"

# Derive the feed's URL path relative to /builder/bin.
REL_PATH=${FEED#/builder/bin/}

# Print the configuration line for the router.
echo ""
echo "= Add this line to /etc/opkg/customfeeds.conf:"
echo "= Replace BUILD_HOST_IP with this machine's LAN IP address."
echo ""
echo "src/gz local_printing http://BUILD_HOST_IP:8000/$REL_PATH"
echo ""

# Serve the repository over the LAN.
exec python3 -m http.server 8000 --bind 0.0.0.0 --directory /builder/bin
