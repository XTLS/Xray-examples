# VLESS over TCP with TLS + 回落（最简配置）

你需要有一个解析到服务器 IP 的域名，并且申请了证书，比如 let's encrypt

你还需要一个 Nginx：（或者 Caddy 等任一 Web 服务器）

1. 用系统自带的包管理器安装 nginx，具体方法请 Google
2. nginx 的默认配置就是监听 80 端口，无需修改
3. 可选：找到并替换掉 nginx 自带的 index.html 等文件
4. 执行 `systemctl enable nginx` 设置开机自启
5. 执行 `systemctl start nginx` 启动 nginx

若服务器开启了防火墙或 VPS 有安全组，记得放行 TCP/80、443 端口

---

接下来，你可以了解 [建站配置](<../VLESS-TCP-TLS%20(maximal%20by%20rprx)>)（回落高级用法）、尝试 [进阶配置](<../VLESS-TCP-TLS-WS%20(recommended)>)（分流 to WebSocket）
