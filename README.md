只是一个BBR开关




        o = s.option(form.Flag, 'bbr_enabled', _('Enable BBR Congestion Control'),
        _('Enables or disables BBR congestion control for this zone.'));
		o.default = o.enabled; // 默认启用 BBR



# ... existing firewall script code ...
load_global_bbr() {
    local bbr_enabled

    config_get bbr_enabled defaults bbr_enabled 0  # 从 'defaults' section 读取 bbr_enabled

    if [ "$bbr_enabled" -eq 1 ]; then
        echo "Enabling BBR globally"
        sysctl -w net.ipv4.tcp_congestion_control=bbr
        sysctl -w net.core.default_qdisc=fq_codel
    else
        echo "Disabling BBR globally"
        sysctl -w net.ipv4.tcp_congestion_control=cubic
        sysctl -w net.core.default_qdisc=fq_codel
    fi
}