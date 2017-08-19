include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-pptpserver
PKG_VERSION:=20170516
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
	TITLE:=luci for pptpserver
        DEPENDS:=+libc +pptpd
endef

define Package/$(PKG_NAME)/description
    LuCI Support for pptp-server by fw867
endef

define Package/$(PKG_NAME)/preinst
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	if [ -f /etc/uci-defaults/luci-pptpd ]; then
		( . /etc/uci-defaults/luci-pptpd ) && rm -f /etc/uci-defaults/luci-pptpd
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

define Package/$(PKG_NAME)/install

	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/etc/uci-defaults/luci-pptpd $(1)/etc/uci-defaults/luci-pptpd

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/etc/config/pptpd $(1)/etc/config/
	
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/

	$(INSTALL_DIR) $(1)/usr/share/pptpd
	$(INSTALL_DATA) ./files/usr/share/pptpd/* $(1)/usr/share/pptpd/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/controller/*.lua $(1)/usr/lib/lua/luci/controller/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/i18n/*.lmo $(1)/usr/lib/lua/luci/i18n/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/pptpd
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/model/cbi/pptpd/*.lua $(1)/usr/lib/lua/luci/model/cbi/pptpd/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/pptpd
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/view/pptpd/* $(1)/usr/lib/lua/luci/view/pptpd/


endef

$(eval $(call BuildPackage,$(PKG_NAME)))
