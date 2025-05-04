include $(TOPDIR)/rules.mk

PKG_NAME:=wg_wormhole
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/wg-wormhole
  SECTION:=net
  CATEGORY:=Network
  TITLE:=wg-wormhole - A UDP hole punching tool based on WireGuard
  DEPENDS:=+wireguard-tools
endef

define Package/wg-wormhole/description
  wg-wormhole is a UDP hole punching tool based on WireGuard.
endef

define Build/Prepare
    mkdir -p $(PKG_BUILD_DIR)
    $(CP) ./ $(PKG_BUILD_DIR)/
endef

define Build/Configure
endef

define Build/Compile
    $(GO_HOST) build -o $(PKG_BUILD_DIR)/wormhole ./cmd
endef

define Package/wg-wormhole/install
    $(INSTALL_DIR) $(1)/usr/bin
    $(INSTALL_BIN) $(PKG_BUILD_DIR)/wormhole $(1)/usr/bin/wg-wormhole
    # 安装服务文件（如果需要）
    $(INSTALL_DIR) $(1)/etc/init.d
    $(INSTALL_BIN) ./deploy/wormhole-node.init $(1)/etc/init.d/wormhole-node
    $(INSTALL_BIN) ./deploy/wormhole-registry.init $(1)/etc/init.d/wormhole-registry
endef

$(eval $(call BuildPackage,wg-wormhole))
