include $(TOPDIR)/rules.mk

PKG_NAME:=nghttp3
PKG_VERSION:=1.2.0
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/ngtcp2/nghttp3/releases/download/v$(PKG_VERSION)/
PKG_HASH:=b6a9e7e1b6a9e7e1b6a9e7e1b6a9e7e1b6a9e7e1b6a9e7e1b6a9e7e1b6a9e7e1

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libnghttp3
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=nghttp3 library (HTTP/3)
endef

define Package/libnghttp3/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/lib/.libs/libnghttp3.so* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libnghttp3))
