include $(TOPDIR)/rules.mk

PKG_NAME:=curl
PKG_VERSION:=8.12.0
PKG_RELEASE:=1
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://curl.se/download/
PKG_HASH:=d6b9e6068dbfae0f7a020429ba7f77f7d2c1d85b8e2e3e4c35abbf7d7e5e5b0e

PKG_BUILD_DEPENDS:=quictls ngtcp2 nghttp3
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/curl
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Curl with HTTP/3 (QUIC+TLS)
  DEPENDS:=+libngtcp2 +libnghttp3 +libquictls
endef

define Package/curl/description
  curl with HTTP/3 (ngtcp2, nghttp3, quictls) for OpenWrt.
endef

CONFIGURE_ARGS += \
  --with-ssl=$(STAGING_DIR)/usr \
  --with-nghttp3=$(STAGING_DIR)/usr \
  --with-ngtcp2=$(STAGING_DIR)/usr \
  --enable-alt-svc \
  --enable-http3 \
  --with-ca-path=/etc/ssl/certs

define Package/curl/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/curl $(1)/usr/bin/
endef

$(eval $(call BuildPackage,curl))
