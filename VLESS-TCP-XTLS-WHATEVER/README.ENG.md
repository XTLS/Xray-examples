# VLESS over TCP with XTLS + fallback & split to WHATEVER (ultimate configuration)

This is a superset of [Advanced Configuration](<../VLESS-TCP-TLS-WS%20(recommended)>), using the powerful fallback and shunt features of VLESS, it realizes as many protocols and configurations as possible on port 443. Perfect coexistence, including [XTLS Direct Mode](https://github.com/rprx/v2fly-github-io/blob/master/docs/config/protocols/vless.md#xtls-%E9%BB%91%E7%A7%91%E6%8A%80)

The client can connect to the server through the following methods at the same time, and WS can pass through the CDN

1. VLESS over TCP with XTLS, several times the performance, the preferred method
2. VLESS over TCP with TLS
3. VLESS over WS with TLS
4. VMess over TCP with TLS, not recommended
5. VMess over WS with TLS
6. Trojan over TCP with TLS

---

Here it is set to fall back to the Trojan protocol of Xray by default, and then continue to fall back to the web server on port 80 (it can also be replaced with a database, FTP, etc.)

You can also configure fallback to Caddy's forwardproxy and other proxies that are also anti-detection, and shunt to any proxy that supports WebSocket, no problem
