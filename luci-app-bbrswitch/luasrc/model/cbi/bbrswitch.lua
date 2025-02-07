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

        -- 根据值启动或停止 BBR
        if value == "1" then
            -- 启动 BBR
            luci.sys.call("/etc/init.d/bbrswitch start >/dev/null 2>&1 &")
        else
            -- 停止 BBR
            luci.sys.call("/etc/init.d/bbrswitch stop >/dev/null 2>&1 &")
        end

        -- 刷新页面或返回当前页面
        luci.sys.call("uci commit bbr")
        luci.http.redirect(luci.dispatcher.build_url(luci.dispatcher.context.requestpath))  -- 刷新当前页面
    end
end

return m
