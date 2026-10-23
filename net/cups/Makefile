
#
# Copyright (C) 2006-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=cups
PKG_VERSION:=2.4.20
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-source.tar.gz
PKG_SOURCE_URL:=https://github.com/OpenPrinting/cups/releases/download/v$(PKG_VERSION)
PKG_HASH:=skip

PKG_BUILD_DEPENDS:=

TARGET_LDFLAGS+=-Wl,-rpath-link=$(STAGING_DIR)/usr/lib

include $(INCLUDE_DIR)/package.mk

define Package/cups/Default
  URL:=https://openprinting.github.io/cups/
  SUBMENU:=Printing
endef

define Package/cups
$(call Package/cups/Default)
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libcups +libusb-1.0 +libavahi-client +libstdcpp
  TITLE:=Common UNIX Printing System (daemon)
endef

define Package/cups/description
	Common UNIX Printing System (daemon)
endef

define Package/cups/conffiles
/etc/cups/classes.conf
/etc/cups/cupsd.conf
/etc/cups/printers.conf
endef

define Package/libcups
$(call Package/cups/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Common UNIX Printing System core library
  DEPENDS:=+zlib +libpthread +libpng +libjpeg +libavahi-client
endef

define Package/libcups/description
  Common UNIX Printing System core library.
endef

define Package/libcupsimage
$(call Package/cups/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Common UNIX Printing System image library
  DEPENDS:=+libcups +libpng +libjpeg
endef

define Package/libcupsimage/description
  Common UNIX Printing System image library.
endef

define Package/cups-client
$(call Package/cups/Default)
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Common UNIX Printing System client commands
  DEPENDS:=+libcups +libcupsimage
endef

define Package/cups-client/conffiles
/etc/cups/client.conf
endef

define Package/cups-bsd
$(call Package/cups/Default)
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Common UNIX Printing System BSD commands
  DEPENDS:=+libcups
endef

define Build/Configure
	$(call Build/Configure/Default, \
		--with-cups-user="nobody" \
		--with-cups-group="nogroup" \
		--with-system-groups="root" \
		--with-local-protocols="dnssd" \
		--with-dnssd=avahi \
		--with-rundir=/var/run/cups \
		--with-logdir=/var/log/cups \
		--with-cachedir=/var/cache/cups \
		--with-components=all \
		--with-languages="" \
		--with-max-log-size=0 \
		--with-log-level=warn \
		--with-access-log-level=none \
		--with-error-policy=stop-printer \
		--enable-shared \
		--enable-libusb \
		--disable-acl \
		--enable-webif \
		--disable-dbus \
		--disable-browsing \
		--disable-launchd \
		--disable-ldap \
		--disable-pam \
		--disable-slp \
		--disable-gssapi \
		--disable-tiff \
		--without-perl \
		--without-python \
		--without-php \
		--without-tls \
		--libdir=/usr/lib \
		UNAME="Linux" \
		LIBS="$(TARGET_LDFLAGS) -lz -lpng -ljpeg" \
	)
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		$(TARGET_CONFIGURE_OPTS) \
		DSTROOT="$(PKG_INSTALL_DIR)" \
		STRIP="/bin/true" \
		all install

	# Disable CUPS' legacy filters replaced by cups-filters.
	perl -p -i -e 's:^(.*\s+(pdftops|texttops|imagetops|bannertops|imagetoraster)\s*)$$$$:#\1:' \
		$(PKG_INSTALL_DIR)/usr/share/cups/mime/mime.convs
endef

define Build/InstallDev
	$(INSTALL_DIR) $(2)/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/cups-config $(2)/bin/

	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/cups $(1)/usr/include/

	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libcups*.so* $(1)/usr/lib/
endef

define Package/cups/install
	$(INSTALL_DIR) $(1)/etc/cups
	$(CP) $(PKG_INSTALL_DIR)/etc/cups/* $(1)/etc/cups/
	rm -rf $(1)/etc/cups/certs
	ln -sf /tmp $(1)/etc/cups/certs

	# Install the router-specific CUPS configuration.
	$(CP) ./files/etc/cups/* $(1)/etc/cups/

	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/cupsd $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/cupsctl $(1)/usr/sbin/

	$(INSTALL_DIR) $(1)/usr/lib/cups
	rm -f $(PKG_INSTALL_DIR)/usr/lib/cups/backend/parallel
	rm -f $(PKG_INSTALL_DIR)/usr/lib/cups/backend/serial
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/cups/backend $(1)/usr/lib/cups/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/cups/cgi-bin $(1)/usr/lib/cups/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/cups/daemon $(1)/usr/lib/cups/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/cups/monitor $(1)/usr/lib/cups/

	$(INSTALL_DIR) $(1)/usr/lib/cups/filter
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/lib/cups/filter/commandtops \
		$(PKG_INSTALL_DIR)/usr/lib/cups/filter/pstops \
		$(PKG_INSTALL_DIR)/usr/lib/cups/filter/gziptoany \
		$(1)/usr/lib/cups/filter/

	$(INSTALL_DIR) $(1)/usr/share/cups
	$(CP) $(PKG_INSTALL_DIR)/usr/share/cups/mime $(1)/usr/share/cups/

	$(INSTALL_DIR) $(1)/usr/share/cups/templates
	$(CP) $(PKG_INSTALL_DIR)/usr/share/cups/templates/*.tmpl \
		$(1)/usr/share/cups/templates/

	# The CUPS web interface uses installed documentation assets.
	$(INSTALL_DIR) $(1)/usr/share/doc/cups
	$(CP) $(PKG_INSTALL_DIR)/usr/share/doc/cups/*.*html \
		$(1)/usr/share/doc/cups/
	$(CP) $(PKG_INSTALL_DIR)/usr/share/doc/cups/*.css \
		$(1)/usr/share/doc/cups/
	$(CP) $(PKG_INSTALL_DIR)/usr/share/doc/cups/*.txt \
		$(1)/usr/share/doc/cups/
	$(CP) $(PKG_INSTALL_DIR)/usr/share/doc/cups/images \
		$(1)/usr/share/doc/cups/

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/cupsd.init $(1)/etc/init.d/cupsd

	# CUPS' USB backend must be executable by the daemon.
	chmod 0700 $(1)/usr/lib/cups/backend/usb
endef

define Package/libcups/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libcups.so* $(1)/usr/lib/
endef

define Package/libcupsimage/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libcupsimage.so* $(1)/usr/lib/
endef

define Package/cups-client/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/bin/lp \
		$(PKG_INSTALL_DIR)/usr/bin/cancel \
		$(PKG_INSTALL_DIR)/usr/bin/cupstestppd \
		$(PKG_INSTALL_DIR)/usr/bin/ipptool \
		$(PKG_INSTALL_DIR)/usr/bin/lpoptions \
		$(PKG_INSTALL_DIR)/usr/bin/lpstat \
		$(1)/usr/bin/

	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/sbin/cupsaccept \
		$(PKG_INSTALL_DIR)/usr/sbin/cupsfilter \
		$(PKG_INSTALL_DIR)/usr/sbin/lpadmin \
		$(PKG_INSTALL_DIR)/usr/sbin/lpinfo \
		$(PKG_INSTALL_DIR)/usr/sbin/lpmove \
		$(1)/usr/sbin/

	(cd $(1)/usr/sbin && \
		ln -sf cupsaccept accept && \
		ln -sf cupsaccept cupsenable && \
		ln -sf cupsaccept cupsdisable && \
		ln -sf cupsaccept reject && \
		ln -sf cupsaccept cupsreject)
endef

define Package/cups-bsd/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/bin/lpr \
		$(PKG_INSTALL_DIR)/usr/bin/lpq \
		$(PKG_INSTALL_DIR)/usr/bin/lprm \
		$(1)/usr/bin/

	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/lpc $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,cups))
$(eval $(call BuildPackage,libcups))
$(eval $(call BuildPackage,libcupsimage))
$(eval $(call BuildPackage,cups-client))
$(eval $(call BuildPackage,cups-bsd))
