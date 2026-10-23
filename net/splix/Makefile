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
	#DESCRIPTION:=This variable is obsolete. use the Package/name/description define instead!
	DEPENDS:=+cups +libcupsimage +libtiff +libjbigkit
	URL:=http://pkgs.fedoraproject.org/cgit/splix.git/
endef

define Package/splix/description
	Splix is a driver for printers that speak SPL (Samsung Printer Language). This includes printers made by Samsung, Dell, and Xerox
endef

define Build/Configure
	$(SED) 's/(const PPDFile::Value::Value/(const PPDFile::Value/' $(PKG_BUILD_DIR)/src/ppdfile.cpp
	$(SED) "s/^CC\t\t:= gcc/CC\t\t:= $(TARGET_CC)/" -e "s/^CXX\t\t:= g++/CXX\t\t:= $(TARGET_CXX)/" -e "s/^AR\t\t:= ar/AR\t\t:= $(TARGET_AR)/" $(PKG_BUILD_DIR)/Makefile
	$(SED) 's|\(.*\)toqpdl_LDFLAGS\t*:=.*|\1toqpdl_LDFLAGS\t:=$(TARGET_LDFLAGS) -lpthread|' -e 's|\(.*\)toqpdl_LIBS\t*:=.*|\1toqpdl_LIBS\t:=-lpng -ltiff -lcups -lcupsimage|' -e 's|^CXXFLAGS\t\t+= `cups.*|CXXFLAGS\t\t+= $(TARGET_CFLAGS) -Iinclude -Wall $(TARGET_CPPFLAGS)|' -e 's|CUPSFILTER\t*:=.*|CUPSFILTER\t:= /usr/lib/cups/filter|' -e 's|CUPSPPD\t*:=.*|CUPSPPD\t:= /usr/share/cups/model|' $(PKG_BUILD_DIR)/module.mk
	$(SED) 's|g++|$(TARGET_CXX)|' $(PKG_BUILD_DIR)/rules.mk
	mv $(PKG_BUILD_DIR)/*.ppd $(PKG_BUILD_DIR)/ppd/
endef

$(eval $(call BuildPackage,splix))
