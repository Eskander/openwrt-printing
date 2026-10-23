include $(TOPDIR)/rules.mk

PKG_NAME:=splix
PKG_VERSION:=2.0.2
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://github.com/OpenPrinting/splix/releases/download/$(PKG_VERSION)
PKG_HASH:=skip

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/splix
	SECTION:=net
	CATEGORY:=Network
	TITLE:=SPL printer driver for Unix
	DEPENDS:=+libcups +libcupsimage +libtiff +libpng +libjbigkit
	URL:=https://openprinting.github.io/splix/
endef

define Package/splix/description
	Splix is a driver for printers that speak SPL (Samsung Printer Language). This includes printers made by Samsung, Dell, and Xerox
endef

define Build/Configure
	$(SED) 's/^CC[[:space:]]*:=.*/CC := $(TARGET_CC)/' $(PKG_BUILD_DIR)/Makefile
	$(SED) 's/^CXX[[:space:]]*:=.*/CXX := $(TARGET_CXX)/' $(PKG_BUILD_DIR)/Makefile
	$(SED) 's/^AR[[:space:]]*:=.*/AR := $(TARGET_AR) crs/' $(PKG_BUILD_DIR)/Makefile

	$(SED) 's|^TARGETS[[:space:]]*:=.*|TARGETS := rastertoqpdl|' \
		$(PKG_BUILD_DIR)/module.mk

	$(SED) 's|^CXXFLAGS[[:space:]]*+=.*pkg-config.*|CXXFLAGS += -Iinclude -Wall $(TARGET_CPPFLAGS) $(TARGET_CXXFLAGS)|' \
		$(PKG_BUILD_DIR)/module.mk

	$(SED) 's|^rastertoqpdl_LDFLAGS[[:space:]]*:=.*|rastertoqpdl_LDFLAGS := $(TARGET_LDFLAGS)|' \
		$(PKG_BUILD_DIR)/module.mk

	$(SED) 's|^rastertoqpdl_LIBS[[:space:]]*:=.*|rastertoqpdl_LIBS := -lcupsimage -lcups -ltiff -lpng -ljbig85 -lpthread|' \
		$(PKG_BUILD_DIR)/module.mk

	$(SED) 's|^CUPSFILTER[[:space:]]*:=.*|CUPSFILTER := /usr/lib/cups/filter|' \
		$(PKG_BUILD_DIR)/module.mk
endef

define Build/Install
endef

define Package/splix/install
	$(INSTALL_DIR) $(1)/usr/lib/cups/filter
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/optimized/rastertoqpdl \
		$(1)/usr/lib/cups/filter/rastertoqpdl
endef

$(eval $(call BuildPackage,splix))
