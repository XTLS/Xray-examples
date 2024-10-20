Xray 基于 HTTP/2 或 HTTP/3 的传输方式完整按照 HTTP 标准实现，可以通过其它的 HTTP 服务器（如 Caddy）进行中转。

Caddy 使用 reverse_proxy 模块，一般使用 path 分流，主路径伪装为网站，中间人无法探测到 Xray-core（请使用复杂 path）。

Caddy 默认开启 UDP 同端口的 HTTP/3 服务器，目前支持三种中转方式

- HTTP/2
- HTTP/3 解密后重新加密
- HTTP/3 转 H2C
