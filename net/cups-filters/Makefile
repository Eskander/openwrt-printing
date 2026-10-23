
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
	--disable-imagefilters \
	--disable-mutool \
	--disable-foomatic \
	--enable-poppler \
	--disable-driverless \
	--enable-individual-cups-filters

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
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/cups/filter/pdftopdf $(1)/usr/lib/cups/filter/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/cups/filter/gstoraster $(1)/usr/lib/cups/filter/

	$(INSTALL_DIR) $(1)/usr/share/cups/mime
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/share/cups/mime/cupsfilters.types $(1)/usr/share/cups/mime/
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/share/cups/mime/cupsfilters-individual.convs $(1)/usr/share/cups/mime/
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/share/cups/mime/cupsfilters-ghostscript.convs $(1)/usr/share/cups/mime/
endef

$(eval $(call BuildPackage,cups-filters))
