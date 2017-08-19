include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-shadowsocksr-server
PKG_VERSION:=20170509
PKG_RELEASE:=1
PKG_MAINTAINER:=fw867

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
#PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	PKGARCH:=all
	TITLE:=luci for shadowsocksr-server
        DEPENDS:=+libc +libsodium +python
endef

define Package/$(PKG_NAME)/description
    A luci app for shadowsocksr-server
endef

define Package/$(PKG_NAME)/preinst
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	if [ -f /etc/uci-defaults/luci-ssr_server ]; then
		( . /etc/uci-defaults/luci-ssr_server ) && rm -f /etc/uci-defaults/luci-ssr_server
	fi
	rm -rf /tmp/luci-indexcache
fi
exit 0
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/postrm
#!/bin/sh
if [ -d "/usr/share/ssr/" ]; then
	rm -rf /usr/share/ssr/*
fi
exit 0
endef

define Package/$(PKG_NAME)/install

	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/etc/uci-defaults/luci-ssr_server $(1)/etc/uci-defaults/luci-ssr_server

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/etc/config/ssr_server $(1)/etc/config/

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/

	$(INSTALL_DIR) $(1)/usr/share/ssr
	$(CP) -R ./files/usr/share/ssr/* $(1)/usr/share/ssr/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/controller/*.lua $(1)/usr/lib/lua/luci/controller/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/model/cbi/ssr_server.lua $(1)/usr/lib/lua/luci/model/cbi/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/ssr_server
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/view/ssr_server/* $(1)/usr/lib/lua/luci/view/ssr_server/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/i18n/* $(1)/usr/lib/lua/luci/i18n/

endef

$(eval $(call BuildPackage,$(PKG_NAME)))