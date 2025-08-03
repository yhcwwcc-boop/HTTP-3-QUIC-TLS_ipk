include $(TOPDIR)/rules.mk

# 核心配置：匹配 Quictls 最新标签 `openssl-3.3.0-quic1`
PKG_NAME:=quictls
PKG_VERSION:=3.3.0-quic1  
PKG_RELEASE:=1

# 正确下载地址（GitHub 标签格式）
PKG_SOURCE_URL:=https://github.com/quictls/openssl/archive/refs/tags/
PKG_SOURCE:=openssl-$(PKG_VERSION).tar.gz  
PKG_HASH:=skip  # 临时跳过校验，生产环境需补全（见下方说明）

# 解压目录（与源码包名一致）
PKG_BUILD_DIR:=$(BUILD_DIR)/openssl-$(PKG_VERSION)

# 启用编译安装
PKG_INSTALL:=1
PKG_LICENSE:=OpenSSL
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

# 包定义：与工作流中 `package/quictls/compile` 对齐
define Package/quictls
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=QuicTLS (OpenSSL with QUIC support)
  URL:=https://github.com/quictls/openssl
endef

# 编译配置：指定 OpenSSL 编译参数
define Build/Configure
	$(call Build/Configure/Default, \
		no-shared \       # 静态编译（避免依赖问题）
		no-async \        # 禁用异步（简化环境）
		--prefix=/usr \   # 安装前缀
		--openssldir=/etc/ssl \  # SSL 配置目录
	)
endef

# 编译命令：调用 make 编译
define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		$(TARGET_CONFIGURE_OPTS) \
		all
endef

# 安装逻辑：复制库文件到目标系统
define Package/quictls/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/libcrypto.so* $(1)/usr/lib/
	$(CP) $(PKG_BUILD_DIR)/libssl.so* $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/etc/ssl
	$(CP) $(PKG_BUILD_DIR)/apps/openssl $(1)/usr/bin/
endef

# 注册包编译规则
$(eval $(call BuildPackage,quictls))
