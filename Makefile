# Copyright (C) 2023  OpenWRT Contributors
# 
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk

PKG_NAME:=wg_wormhole
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/wg_wormhole
  SECTION:=net
  CATEGORY:=Network
  TITLE:=wg_wormhole - A UDP hole punching tool based on WireGuard
  DEPENDS:=+wireguard-tools
endef

define Package/wg_wormhole/description
  wg_wormhole is a UDP hole punching tool based on WireGuard.
endef

define Build/Prepare
    mkdir -p $(PKG_BUILD_DIR)
    $(CP) ./cmd $(PKG_BUILD_DIR)/cmd
    $(CP) ./go.mod $(PKG_BUILD_DIR)/go.mod
    $(CP) ./go.sum $(PKG_BUILD_DIR)/go.sum
    cd $(PKG_BUILD_DIR) && go mod tidy
endef

define Build/Compile
    cd $(PKG_BUILD_DIR) && go build -o wormhole ./cmd
endef

define Package/wg_wormhole/install
    $(INSTALL_DIR) $(1)/usr/bin
    $(INSTALL_BIN) $(PKG_BUILD_DIR)/wormhole $(1)/usr/bin/wg_wormhole
endef

$(eval $(call BuildPackage,wg_wormhole))
