local kernel_version = luci.sys.exec("echo -n $(uname -r)")

m = Map("bbrswitch")
m.title	= translate("BBRswitch Settings")
m.description = translate("BBR Congestion Control Algorithm Switch")

m:append(Template("bbrswitch/bbrswitch_status"))

s = m:section(TypedSection, "bbrswitch", "")
s.addremove = false
s.anonymous = true

if nixio.fs.access("/lib/modules/" .. kernel_version .. "/tcp_bbr.ko") then
    bbr_cca = s:option(Flag, "bbr_cca", translate("BBR CCA"))
    bbr_cca.default = 0
    bbr_cca.description = translate("Using BBR CCA can improve TCP network performance effectively")

    function bbr_cca.write(self, section, value)
        -- 调用父类的 write 方法保存配置
        Flag.write(self, section, value)
        
        -- 判断开启或关闭 BBR
        if value == "1" then
            -- 开启 BBR
            luci.sys.call("/etc/init.d/bbrswitch start >/dev/null 2>&1 &")
        else
            -- 关闭 BBR
            luci.sys.call("/etc/init.d/bbrswitch stop >/dev/null 2>&1 &")
        end
    end
end

return m

