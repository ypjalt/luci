module("luci.controller.pptpd",package.seeall)
function index()
if not nixio.fs.access("/etc/config/pptpd")then
return
end
entry({"admin","services","pptpd"},
alias("admin","services","pptpd","settings"),
_("PPTP Server"),49)
entry({"admin","services","pptpd","settings"},
cbi("pptpd/settings"),
_("General Settings"),10).leaf=true
entry({"admin","services","pptpd","users"},
cbi("pptpd/users"),
_("Users Manager"),20).leaf=true
entry({"admin","services","pptpd","online"},
cbi("pptpd/online"),
_("Online Users"),30).leaf=true
entry({"admin","services","pptpd","status"},call("status")).leaf=true
end
function status()
local e={}
e.pptpd=luci.sys.call("pidof %s >/dev/null"%"pptpd")==0
luci.http.prepare_content("application/json")
luci.http.write_json(e)
end
