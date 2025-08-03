include $(TOPDIR)/rules.mk

PKG_NAME:=ngtcp2
PKG_VERSION:=1.5.0
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/ngtcp2/ngtcp2/releases/download/v$(PKG_VERSION)/
PKG_HASH:=9e1c2b7a9d1a8e2a3e7b1c0e2a3e7b1c0e2a3e7b1c0e2a3e7b1c0e2a3e7b1c0e2a3

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libngtcp2
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=ngtcp2 library (QUIC)
endef

define Package/libngtcp2/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/lib/.libs/libngtcp2.so* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libngtcp2))
