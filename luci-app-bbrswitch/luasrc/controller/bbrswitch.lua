module("luci.controller.bbrswitch", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/bbrswitch") then
		return
	end
	local page
	page = entry({"admin", "network", "bbrswitch"}, cbi("bbrswitch"), _("BBRswitch"), 101)
	page.i18n = "bbrswitch"
	page.dependent = true
	
	entry({"admin", "network", "bbrswitch", "status"}, call("action_status"))
end

local function bbr_status()
	return luci.sys.call("/etc/init.d/bbrswitch check_status bbr") == 0
end

function action_status()
	luci.http.prepare_content("application/json")
	luci.http.write_json({
		bbr_state = bbr_status()
})
end