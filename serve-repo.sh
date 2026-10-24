#!/bin/sh
set -e

# Locate the printing feed.
FEED=$(find /builder/bin/packages -type d -name printing -print -quit)

if [ -z "$FEED" ]; then
    echo "Error: printing feed not found."
    exit 1
fi

# Set paths for the index, signing tool, and persistent keys.
USIGN="/builder/staging_dir/host/bin/usign"
SECRET="/builder/printing-secret.key"
PUBLIC="/builder/printing-public.key"

# Generate a key pair on the first run.
if [ ! -f "$SECRET" ] || [ ! -f "$PUBLIC" ]; then
    "$USIGN" -G -s "$SECRET" -p "$PUBLIC"
    chmod 600 "$SECRET"
fi

# Generate and sign the package index.
export MKHASH="/builder/staging_dir/host/bin/mkhash"
/builder/scripts/ipkg-make-index.sh "$FEED" > "$FEED/Packages"
"$USIGN" -S -m "$FEED/Packages" -s "$SECRET" -x "$FEED/Packages.sig"

# Get the public key fingerprint and contents.
FINGERPRINT=$("$USIGN" -F -p "$PUBLIC")
PUB_HEADER=$(sed -n '1p' "$PUBLIC")
PUB_DATA=$(sed -n '2p' "$PUBLIC")

# Print a ready-to-run command for installing the trusted key.
echo ""
echo " ===> Add this command on your router to trust this feed's signing key:"
echo ""
echo "mkdir -p /etc/opkg/keys && echo '$PUB_HEADER' > /etc/opkg/keys/$FINGERPRINT && echo '$PUB_DATA' >> /etc/opkg/keys/$FINGERPRINT"
echo ""
echo ""
echo " ===> Add this feed to /etc/opkg/customfeeds.conf:"
echo ""
echo "src/local_printing local_printing http://BUILD_HOST_IP:8000/$REL_PATH/builder/bin"
echo ""
echo "Replace BUILD_HOST_IP with the build host's LAN IP."
echo "Keep /builder/printing-secret.key private."

# Serve the repository over the LAN.
exec python3 -m http.server 8000 --bind 0.0.0.0 --directory /builder/bin
