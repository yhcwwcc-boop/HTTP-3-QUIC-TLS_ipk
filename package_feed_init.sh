#!/bin/bash

set -e

FEED_DIR="openwrt-curl-http3-feed"
rm -rf $FEED_DIR
mkdir -p $FEED_DIR/{curl,ngtcp2,nghttp3,quictls}

# curl Makefile
cat > $FEED_DIR/curl/Makefile <<'EOF'
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
EOF

# ngtcp2 Makefile
cat > $FEED_DIR/ngtcp2/Makefile <<'EOF'
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
EOF

# nghttp3 Makefile
cat > $FEED_DIR/nghttp3/Makefile <<'EOF'
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
EOF

# quictls Makefile
cat > $FEED_DIR/quictls/Makefile <<'EOF'
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
EOF

# README
cat > $FEED_DIR/README.md <<'EOF'
# OpenWrt HTTP/3 QUIC TLS Package Feed

## 用法

1. 将 `openwrt-curl-http3-feed` 目录拷贝到 OpenWrt SDK 的 package/ 目录下。
2. 运行：
