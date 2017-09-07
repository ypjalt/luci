local e=require"luci.sys"
m=Map("shadowsocks")
s=m:section(TypedSection,"acl_rule",translate("ShadowSocks ACLs"),
translate("ACLs is a tools which used to designate specific IP proxy mode"))
s.template="cbi/tblsection"
s.sortable=true
s.anonymous=true
s.addremove=true
o=s:option(Value,"aclremarks",translate("ACL Remarks"))
o.width="20%"
o.rmempty=true
o=s:option(Value,"ipaddr",translate("IP Address"))
o.width="30%"
o.datatype="ip4addr"
luci.ip.neighbors({family = 4}, function(neighbor)
if neighbor.reachable then
	o:value(neighbor.dest:string(), "%s (%s)" %{neighbor.dest:string(), neighbor.mac})
end
end)
o=s:option(Value,"macaddr",translate("MAC Address"))
o.width="30%"
o.rmempty=true
e.net.mac_hints(function(t,a)
o:value(t,"%s (%s)"%{t,a})
end)
o=s:option(ListValue,"proxy_mode",translate("Proxy Mode"))
o.width="20%"
o.default="disable"
o.rmempty=false
o:value("disable",translate("No Proxy"))
o:value("global",translate("Global Proxy"))
o:value("gfwlist",translate("GFW List"))
o:value("chnroute",translate("China WhiteList"))
o:value("gamemode",translate("Game Mode"))
o=s:option(Value,"ports",translate("Dest Ports"))
o.width="30%"
o.placeholder="80,443"
return m
