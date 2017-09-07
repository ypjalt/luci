module("luci.controller.shadowsocksr", package.seeall)
function index()
		if not nixio.fs.access("/etc/config/shadowsocksr") then
		return
	end
	local page
	page = entry({"admin", "vpn", "shadowsocksr"}, cbi("shadowsocksr"), _("ShadowsocksR Pro"))
	page.dependent = true
end
