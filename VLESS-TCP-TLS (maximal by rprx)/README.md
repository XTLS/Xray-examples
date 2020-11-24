# VLESS over TCP with TLS + 回落（建站配置）

你应当先了解 [最简配置](<../VLESS-TCP-TLS%20(minimal%20by%20rprx)>) 等其它配置，若你有同时建站的需求，可以参考并结合此配置

此配置含 VLESS 回落高级用法：

1. PROXY protocol，专用于传递请求的真实来源 IP 和端口
2. 支持 h2 访问：ALPN 协商结果为 h2 时单独转发
3. 使用 Unix domain socket，比环回地址效率更高

Nginx 说明与注意事项：

1. nginx.conf 根据 CentOS 8 dnf 的 nginx 修改而来
2. 80 端口的 http 请求均被带 URI 301 到 https
3. 重启 nginx 时可能需要手动删除它 bind 的 socket

Xray 服务端 info 级别的 error 日志中有每次回落的详细原因</br>
Nginx 的 access 日志中每行末尾有请求的真实来源 IP 和端口
