--[[
openwrt-dist-luci: ShadowSocks
# Copyright (C) 2016 fw867 <ffkykzs@gmail.com>
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
]]--
local sys = require "luci.sys"
local wa = require "luci.tools.webadmin"

m = Map("shadowsocks")
-- [[ acl_rule ]]--
s = m:section(TypedSection, "acl_rule", translate("ShadowSocks ACLs"),
	translate("ACLs is a tools which used to designate specific IP proxy mode"))
s.template  = "cbi/tblsection"
s.sortable  = true
s.anonymous = true
s.addremove = true

o = s:option(Value, "aclremarks", translate("ACL Remarks"))
o.width = "30%"
o.rmempty = true

o = s:option(Value, "ipaddr", translate("IP Address"))
o.width = "20%"
o.datatype="ip4addr"
luci.ip.neighbors({family = 4}, function(neighbor)
if neighbor.reachable then
	o:value(neighbor.dest:string(), "%s (%s)" %{neighbor.dest:string(), neighbor.mac})
end
end)
o = s:option(ListValue, "proxy_mode", translate("Proxy Mode"))
o.width = "20%"
o.default = "disable"
o.rmempty = false
o:value("disable", translate("No Proxy"))
o:value("global", translate("Global Proxy"))
o:value("gfwlist", translate("GFW List"))
o:value("chnroute", translate("China WhiteList"))
o:value("gamemode", translate("Game Mode"))

o = s:option(Value, "ports", translate("Dest Ports"))
o.width = "30%"
o.placeholder = "80,443"

return m
