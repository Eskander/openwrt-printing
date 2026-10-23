
include $(TOPDIR)/rules.mk

PKG_NAME:=cups-filters
PKG_VERSION:=2.0.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://github.com/OpenPrinting/cups-filters/releases/download/$(PKG_VERSION)
PKG_HASH:=skip

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=COPYING

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/autotools.mk

CONFIGURE_ARGS += \
	--disable-static \
	--disable-rpath \
	--disable-poppler \
	--disable-mutool

define Package/cups-filters
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Printing
  TITLE:=OpenPrinting CUPS filters
  URL:=https://github.com/OpenPrinting/cups-filters
  DEPENDS:=+cups +libcupsfilters +libppd +qpdf +ghostscript
endef

define Package/cups-filters/description
 OpenPrinting filters and backends for CUPS 2.x.
endef

define Package/cups-filters/install
	$(INSTALL_DIR) $(1)/usr/lib/cups/filter
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/cups/filter/* $(1)/usr/lib/cups/filter/

	if [ -d $(PKG_INSTALL_DIR)/usr/share/cups/mime ]; then \
		$(INSTALL_DIR) $(1)/usr/share/cups/mime; \
		$(CP) $(PKG_INSTALL_DIR)/usr/share/cups/mime/* $(1)/usr/share/cups/mime/; \
	fi

	if [ -d $(PKG_INSTALL_DIR)/usr/share/ppd/cupsfilters ]; then \
		$(INSTALL_DIR) $(1)/usr/share/ppd/cupsfilters; \
		$(CP) $(PKG_INSTALL_DIR)/usr/share/ppd/cupsfilters/* $(1)/usr/share/ppd/cupsfilters/; \
	fi
endef

$(eval $(call BuildPackage,cups-filters))
