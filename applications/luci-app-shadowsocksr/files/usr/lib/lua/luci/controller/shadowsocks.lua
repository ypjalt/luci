module("luci.controller.shadowsocks",package.seeall)
function index()
if not nixio.fs.access("/etc/config/shadowsocks")then
return
end
entry({"admin","vpn","shadowsocks"},alias("admin","vpn","shadowsocks","settings"),_("ShadowSocks"),2).dependent=true
entry({"admin","vpn","shadowsocks","settings"},cbi("shadowsocks/global"),_("Basic Settings"),1).dependent=true
entry({"admin","vpn","shadowsocks","other"},cbi("shadowsocks/other"),_("Other Settings"),2).leaf=true
entry({"admin","vpn","shadowsocks","balancing"},cbi("shadowsocks/balancing"),_("Load Balancing"),3).leaf=true
entry({"admin","vpn","shadowsocks","kcp"},cbi("shadowsocks/kcp"),_("Kcp Settings"),4).leaf=true
entry({"admin","vpn","shadowsocks","rule"},cbi("shadowsocks/rule"),_("Rule Update"),5).leaf=true
entry({"admin","vpn","shadowsocks","acl"},cbi("shadowsocks/acl"),_("Access control"),6).leaf=true
entry({"admin","vpn","shadowsocks","blacklist"},cbi("shadowsocks/blacklist"),_("Set Blacklist"),7).leaf=true
entry({"admin","vpn","shadowsocks","whitelist"},cbi("shadowsocks/whitelist"),_("Set whitelist"),8).leaf=true
entry({"admin","vpn","shadowsocks","sslog"},cbi("shadowsocks/sslog"),_("Shadowsocks logs"),9).leaf=true
entry({"admin","vpn","shadowsocks","serverconfig"},cbi("shadowsocks/serverconfig")).leaf=true
entry({"admin","vpn","shadowsocks","status"},call("act_status")).leaf=true
entry({"admin","vpn","shadowsocks","kcpstatus"},call("kcp_status")).leaf=true
entry({"admin","vpn","shadowsocks","hrstatus"},call("hr_status")).leaf=true
entry({"admin","vpn","shadowsocks","ping"},call("act_ping")).leaf=true
entry({"admin","vpn","shadowsocks","china"},call("china_status")).leaf=true
entry({"admin","vpn","shadowsocks","foreign"},call("foreign_status")).leaf=true
end
function act_status()
local e={}
e.ss_redir=luci.sys.call("pgrep -l /usr/bin/ss|grep redir >/dev/null")==0
luci.http.prepare_content("application/json")
luci.http.write_json(e)
end
function hr_status()
local e={}
e.hrstatus=luci.sys.call("pidof %s >/dev/null"%"haproxy")==0
luci.http.prepare_content("application/json")
luci.http.write_json(e)
end
function kcp_status()
local e={}
e.kcpstatus=luci.sys.call("pidof %s >/dev/null"%"kcpclient")==0
luci.http.prepare_content("application/json")
luci.http.write_json(e)
end
function china_status()
local e={}
e.china=luci.sys.call("echo `curl -I -o /dev/null -s -m 10 --connect-timeout 2 -w %{http_code} 'http://www.baidu.com'`|grep 200 >/dev/null")==0
luci.http.prepare_content("application/json")
luci.http.write_json(e)
end
function foreign_status()
local e={}
e.foreign=luci.sys.call("echo `curl -I -o /dev/null -s -m 30 --connect-timeout 30 -w %{http_code} 'https://www.taobao.ab11cde'`|grep 200 >/dev/null")==0
luci.http.prepare_content("application/json")
luci.http.write_json(e)
end
function act_ping()
local e={}
e.index=luci.http.formvalue("index")
e.ping=luci.sys.exec("ping -c 1 -W 1 %q 2>&1|grep -o 'time=[0-9]*.[0-9]'|awk -F '=' '{print$2}'"%luci.http.formvalue("domain"))
luci.http.prepare_content("application/json")
luci.http.write_json(e)
end
