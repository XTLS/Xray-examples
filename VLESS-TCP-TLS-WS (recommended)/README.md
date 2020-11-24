# VLESS over TCP with TLS + 回落 & 分流 to WebSocket（进阶配置）

这里是 [最简配置](<../VLESS-TCP-TLS%20(minimal%20by%20rprx)>) 的超集，利用 VLESS 强大的回落分流特性，实现了 443 端口 VLESS over TCP with TLS 和任意 WSS 的完美共存

该配置供参考，你可以将 WS 上的 VLESS 换成 VMess 等其它任何协议，以及设置更多 PATH、协议共存，都可以做到

部署后，你可以同时通过 VLESS over TCP with TLS 和任意 WebSocket with TLS 方式连接到服务器，其中后者都可以通过 CDN

经实测，VLESS 回落分流 WS 比 Nginx 反代 WS 性能更强，传统的 VMess + WSS 方案完全可以迁移过来，且不失兼容

---

接下来，你可以尝试 [终极配置](../VLESS-TCP-XTLS-WHATEVER)：换用 XTLS 实现极致性能，还有分流到 VMess over TCP，以及更多回落分流建议，不只 Xray
