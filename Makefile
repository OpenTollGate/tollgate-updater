include $(TOPDIR)/rules.mk

PKG_NAME:=tollgate-module-updater-go
PKG_VERSION:=0.0.2
PKG_RELEASE:=2

PKG_MAINTAINER:=Your Name <your@email.com>
PKG_LICENSE:=CC0-1.0
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

GO_PKG:=https://github.com/OpenTollGate/tollgate-updater.git
GO_PKG_BUILD_PKG:=$(GO_PKG)

include $(INCLUDE_DIR)/package.mk
include ../../feeds/packages/lang/golang/golang-package.mk

define Package/$(PKG_NAME)
  SECTION:=net
  CATEGORY:=Network
  TITLE:=TollGate Updater Module
  DEPENDS:=$(GO_ARCH_DEPENDS)
endef

define Package/$(PKG_NAME)/description
  TollGate Updater Module for OpenWrt
endef

define Build/Prepare
       mkdir -p $(PKG_BUILD_DIR)
       $(CP) ./src/* $(PKG_BUILD_DIR)/
       cd $(PKG_BUILD_DIR) && go mod tidy
endef

define Package/$(PKG_NAME)/install
       $(INSTALL_DIR) $(1)/usr/bin
       $(INSTALL_BIN) $(GO_PKG_BUILD_BIN_DIR)/tollgate-updater $(1)/usr/bin/tg-updater
endef

$(eval $(call GoBinPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)))
