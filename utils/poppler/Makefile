#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=poppler
PKG_VERSION:=23.12.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://poppler.freedesktop.org/
PKG_HASH:=skip

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_INSTALL:=1

CMAKE_BINARY_SUBDIR:=build
CMAKE_SOURCE_SUBDIR:=

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

CMAKE_OPTIONS += \
	-DBUILD_SHARED_LIBS=ON \
	-DENABLE_UTILS=OFF \
	-DENABLE_CPP=ON \
	-DENABLE_GLIB=OFF \
	-DENABLE_GOBJECT_INTROSPECTION=OFF \
	-DENABLE_GTK_DOC=OFF \
	-DENABLE_QT5=OFF \
	-DENABLE_QT6=OFF \
	-DENABLE_BOOST=OFF \
	-DBUILD_GTK_TESTS=OFF \
	-DBUILD_QT5_TESTS=OFF \
	-DBUILD_QT6_TESTS=OFF \
	-DBUILD_CPP_TESTS=OFF \
	-DBUILD_MANUAL_TESTS=OFF \
	-DENABLE_LIBOPENJPEG=none \
	-DENABLE_DCTDECODER=libjpeg \
	-DENABLE_LCMS=ON \
	-DENABLE_LIBTIFF=OFF \
	-DENABLE_LIBCURL=OFF \
	-DENABLE_NSS3=OFF \
	-DENABLE_GPGME=OFF \
	-DENABLE_ZLIB_UNCOMPRESS=OFF \
	-DRUN_GPERF_IF_PRESENT=OFF

define Package/poppler
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Poppler PDF rendering library
  DEPENDS:=+libpng +libjpeg +zlib +lcms2 +fontconfig +libfreetype +libstdcpp
  URL:=https://poppler.freedesktop.org/
  SUBMENU:=Printing
endef

define Package/poppler/description
	Poppler is a PDF rendering library based on the xpdf-3.0 code base.
endef

define Package/poppler/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libpoppler.so* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libpoppler-cpp.so* $(1)/usr/lib/
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/include/poppler $(1)/usr/include/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libpoppler.so* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libpoppler-cpp.so* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/poppler*.pc $(1)/usr/lib/pkgconfig/
endef

$(eval $(call BuildPackage,poppler))
