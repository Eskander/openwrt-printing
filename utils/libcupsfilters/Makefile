include $(TOPDIR)/rules.mk

PKG_NAME:=libcupsfilters
PKG_VERSION:=2.1.2
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://github.com/OpenPrinting/libcupsfilters/releases/download/$(PKG_VERSION)
PKG_HASH:=skip

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=COPYING

PKG_INSTALL:=1

PKG_BUILD_DEPENDS:=qpdf

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/autotools.mk

CONFIGURE_ARGS += \
	--disable-static \
	--disable-rpath \
	--enable-poppler \
	--disable-ghostscript \
	--disable-dbus \
	--disable-exif \
	--disable-mutool \
	--disable-texttopdf \
	--disable-imagefilters \
	--without-fontconfig \
	--without-jpeg \
	--without-png \
	--without-tiff \
	--without-jpegxl

define Package/libcupsfilters
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=OpenPrinting CUPS filters library
  URL:=https://github.com/OpenPrinting/libcupsfilters
  DEPENDS:=+libcups +qpdf +lcms2 +poppler
endef

define Package/libcupsfilters/description
 Common library functions used by OpenPrinting CUPS filters.
endef

define Package/libcupsfilters/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libcupsfilters.so* $(1)/usr/lib/

	if [ -d $(PKG_INSTALL_DIR)/usr/share/cups ]; then \
		$(INSTALL_DIR) $(1)/usr/share; \
		$(CP) $(PKG_INSTALL_DIR)/usr/share/cups $(1)/usr/share/; \
	fi
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/cupsfilters
	$(CP) $(PKG_INSTALL_DIR)/usr/include/cupsfilters/* $(1)/usr/include/cupsfilters/

	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libcupsfilters.so* $(1)/usr/lib/

	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/libcupsfilters.pc $(1)/usr/lib/pkgconfig/
endef

$(eval $(call BuildPackage,libcupsfilters))
