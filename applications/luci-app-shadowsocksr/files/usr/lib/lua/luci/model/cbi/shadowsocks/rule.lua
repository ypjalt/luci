local e=require"nixio.fs"
local e=require"luci.sys"
local e=luci.sys.exec("uci get shadowsocks.@global[0].gfwlist_version")
local t=luci.sys.exec("cat /etc/dnsmasq.d/gfwlist.conf|grep -c ipset")
m=Map("shadowsocks")
s=m:section(TypedSection,"global",translate("Rule status"))
s.anonymous=true
o=s:option(DummyValue,"satus1",nil,translate("gfwlist版本【"..e.."】 gfwlist规则数量【"..t.."】"))
o=s:option(Button,"_start",translate("Manually update rules"))
o.inputstyle="apply"
function o.write(e,e)
luci.sys.call("/usr/share/shadowsocks/ssruleupdate")
luci.http.redirect(luci.dispatcher.build_url("admin","vpn","shadowsocks","rule"))
end
o=s:option(Flag,"auto_update",translate("Enable auto update rules"))
o.default=0
o.rmempty=false
o=s:option(ListValue,"week_update",translate("Week update rules"))
o:value(7,translate("每天"))
for e=1,6 do
o:value(e,translate("周"..e))
end
o:value(0,translate("周日"))
o.default=0
o.rmempty=false
o=s:option(ListValue,"time_update",translate("Day update rules"))
for e=0,23 do
o:value(e,translate(e.."点"))
end
o.default=0
o.rmempty=false
s=m:section(TypedSection,"global",translate("SSR Server Subscribe"))
s.anonymous=true
o=s:option(DynamicList,"baseurl",translate("Subscribe URL"),translate("Servers unsubscribed will be deleted in next update; Please summit the Subscribe URL first before manually update."))
o=s:option(Button,"_update",translate("Manually update rules"))
o.inputstyle="apply"
function o.write(e,e)
luci.sys.exec("/usr/share/shadowsocks/onlineconfig start")
end
o=s:option(Button,"_stop",translate("Delete All Subscribe"))
o.inputstyle="apply"
function o.write(e,e)
luci.sys.exec("/usr/share/shadowsocks/onlineconfig stop")
end
o=s:option(Flag,"auto_update_subscribe",translate("Enable auto update subscribe"))
o.default=0
o.rmempty=false
o=s:option(ListValue,"week_update_subscribe",translate("Week update rules"))
o:value(7,translate("每天"))
for e=1,6 do
o:value(e,translate("周"..e))
end
o:value(0,translate("周日"))
o.default=0
o.rmempty=false
o=s:option(ListValue,"time_update_subscribe",translate("Day update rules"))
for e=0,23 do
o:value(e,translate(e.."点"))
end
o.default=0
o.rmempty=false
return m
