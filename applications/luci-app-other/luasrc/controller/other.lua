--[[
Other module
Description: File upload / download, web camera
Author: yuleniwo  xzm2@qq.com  QQ:529698939
]]--

module("luci.controller.other", package.seeall)

function index()
	local page = entry({"admin", "system", "other"}, alias("admin", "system", "other", "updownload"), _("Other"), 89)
	entry({"admin", "system", "other", "updownload"}, form("updownload"), _("Upload / Download"))
	if nixio.fs.access("/etc/config/mjpg-streamer") then
		entry({"admin", "system", "other", "webcam"}, call("Webcam"), _("Web Camera"))
	end
	page.i18n = "other"
	page.dependent = true
end

local translate = luci.i18n.translate
local http = luci.http

function Webcam()
	local iframe = '<iframe src="http://%s:%s@%s:%s" frameborder="no" border="0" width="800" height="600" marginwidth="0" marginheight="0" allowtransparency="yes"></iframe>'
	local html, msg, status
	local act = http.formvalue("act")
	if act then
		if act == "start" then
			luci.sys.call("/etc/init.d/mjpg-streamer start")
		elseif act == "stop" then
			luci.sys.call("/etc/init.d/mjpg-streamer stop")
			luci.sys.call("sleep 1")
		end
	end
	local v = nixio.fs.glob("/dev/video[0-9]")()
	if v then
		if luci.sys.call("pidof mjpg_streamer > /dev/null") == 0 then
			local uci, user, pwd, ip, port
			uci = require "luci.model.uci".cursor()
			user = uci:get("mjpg-streamer", "core", "username")
			pwd = uci:get("mjpg-streamer", "core", "password")
			ip = uci:get("network", "lan", "ipaddr")
			port = uci:get("mjpg-streamer", "core", "port")
			html = string.format(iframe, user, pwd, ip, port)
			status = true
		else
			status = false
			msg = translate("Service 'mjpg_streamer' not started.")
		end
	else
		msg = translate("Video device not found.")
	end
	luci.template.render("webcam", {html = html, msg = msg, status = status})
end
