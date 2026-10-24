#! /bin/sh
# execute this from your cross-compilation directory
set -e

# Update all feeds listed within feeds.conf.
./scripts/feeds update -a

# Uninstall all packages
./scripts/feeds uninstall -a

# Mark all packages from 'printing' to be installed as 'm'
./scripts/feeds install -a -p printing -d m

for pkg in cups cups-filters splix; do
    sed -i "/^CONFIG_PACKAGE_${pkg}=\\|^# CONFIG_PACKAGE_${pkg} is not set/d" .config
    echo "CONFIG_PACKAGE_${pkg}=m" >> .config
done

make defconfig

# Build
make -j"$(nproc)" package/feeds/printing/cups/compile \
    package/feeds/printing/cups-filters/compile \
    package/feeds/printing/splix/compile
