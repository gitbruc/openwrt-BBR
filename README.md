### 只是一个BBR开关
开启BBR执行
```sh
sysctl -w net.ipv4.tcp_congestion_control="bbr"
sysctl -w net.core.default_qdisc=fq_codel
```
关闭BBR执行
```sh
sysctl -w net.ipv4.tcp_congestion_control="cubic"
sysctl -w net.core.default_qdisc=pfifo_fast
```
