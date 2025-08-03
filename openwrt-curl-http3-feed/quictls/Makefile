include $(TOPDIR)/rules.mk

PKG_NAME:=quictls
PKG_VERSION:=3.1.3
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/quictls/openssl/archive/refs/tags/
PKG_HASH:=c8c8c8c8c8c8c8c8c8c8c8c8c8c8c8c8c8c8c8c8c8c8c8c8c8c8c8c8c8c8c8c8

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libquictls
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=quictls library (OpenSSL QUIC fork)
endef

define Package/libquictls/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/libcrypto.so* $(1)/usr/lib/
	$(CP) $(PKG_BUILD_DIR)/libssl.so* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libquictls))
