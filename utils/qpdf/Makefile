#
# Copyright (C) 2007-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=qpdf
PKG_VERSION:=11.10.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/qpdf/qpdf/releases/download/v$(PKG_VERSION)
PKG_HASH:=skip

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_INSTALL:=1

CMAKE_BINARY_SUBDIR:=build
CMAKE_SOURCE_SUBDIR:=

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

CMAKE_OPTIONS += \
	-DBUILD_SHARED_LIBS=ON \
	-DBUILD_STATIC_LIBS=OFF \
	-DBUILD_DOC=OFF \
	-DINSTALL_EXAMPLES=OFF \
	-DINSTALL_CMAKE_PACKAGE=ON \
	-DINSTALL_PKGCONFIG=ON \
	-DREQUIRE_CRYPTO_NATIVE=ON \
	-DUSE_IMPLICIT_CRYPTO=OFF

define Package/qpdf
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=QPDF PDF transformation library and tools
  DEPENDS:=+libstdcpp +zlib +libjpeg +libatomic
  URL:=https://github.com/qpdf/qpdf
  SUBMENU:=Printing
endef

define Package/qpdf/description
 QPDF library and command-line tools for PDF transformations.
endef

define Package/qpdf/install
	$(INSTALL_DIR) $(1)/usr/bin $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libqpdf.so* $(1)/usr/lib/
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/include/qpdf $(1)/usr/include/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libqpdf.so* $(1)/usr/lib/

	$(INSTALL_DIR) $(1)/usr/lib/cmake
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/cmake/qpdf $(1)/usr/lib/cmake/

	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/libqpdf.pc $(1)/usr/lib/pkgconfig/

	$(SED) 's|^libdir=/usr/lib|libdir=$${prefix}/lib|' $(1)/usr/lib/pkgconfig/libqpdf.pc
	$(SED) 's|^includedir=/usr/include|includedir=$${prefix}/include|' $(1)/usr/lib/pkgconfig/libqpdf.pc
endef

$(eval $(call BuildPackage,qpdf))
