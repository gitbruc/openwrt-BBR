# SPDX-Identifier-License: GPL-3.0-only
#
# Copyright (C) 2023-2024 沉默の金 <cmzj@cmzj.org>
# Copyright (C) 2022 Lean <coolsnowwolf@gmail.com>
# Copyright (C) 2019-2022 ImmortalWrt.org

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-bbrswitch
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_LICENSE:=GPL-3.0-only
PKG_MAINTAINER:=gitbruc <nobody3@duck.com>

LUCI_TITLE:=LuCI support for BBR
LUCI_DEPENDS:= \
	+luci +luci-compat \
	+kmod-tcp-bbr
LUCI_PKGARCH:=all

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/bbrswitch $(1)/etc/init.d/bbrswitch
	chmod 0755 $(1)/etc/init.d/bbrswitch
endef

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
