
include $(TOPDIR)/rules.mk

PKG_NAME:=libppd
PKG_VERSION:=2.1.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://github.com/OpenPrinting/libppd/releases/download/$(PKG_VERSION)
PKG_HASH:=skip

PKG_LICENSE:=Apache-2.0 WITH LLVM-exception
PKG_LICENSE_FILES:=COPYING

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/autotools.mk

CONFIGURE_ARGS += \
	--disable-static \
	--with-cups-rundir=/var/run/cups

define Package/libppd
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=OpenPrinting PPD support library
  URL:=https://github.com/OpenPrinting/libppd
  DEPENDS:=+libcups +libcupsfilters
endef

define Package/libppd/description
 Legacy PPD support library for CUPS and OpenPrinting filters.
endef

define Package/libppd/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libppd.so* $(1)/usr/lib/
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/ppd $(1)/usr/include/

	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libppd.so* $(1)/usr/lib/

	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/libppd.pc $(1)/usr/lib/pkgconfig/
endef

$(eval $(call BuildPackage,libppd))
