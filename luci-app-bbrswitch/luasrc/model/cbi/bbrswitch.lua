local kernel_version = luci.sys.exec("echo -n $(uname -r)")

m = Map("bbrswitch")
m.title	= translate("BBRswitch Settings")
m.description = translate("BBR Congestion Control Algorithm Switch")

m:append(Template("bbrswitch/bbrswitch_status"))

s = m:section(TypedSection, "bbrswitch", "")
s.addremove = false
s.anonymous = true

if nixio.fs.access("/lib/modules/" .. kernel_version .. "/tcp_bbr.ko") then
config_get bbr_cca "bbrswitch" "bbr_cca" "0"
bbr_cca = s:option(Flag, "bbr_cca", translate("BBR CCA"))
bbr_cca.default = bbr_cca
bbr_cca.description = translate("Using BBR CCA can improve TCP network performance effectively")
end

return m
