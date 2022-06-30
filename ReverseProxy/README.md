# 反向代理
# 原理
Xray Client <--- VMESS/SS ---> Xray Portal(需要公网 IP) <--- VMESS/SS ---> Xray Bridge
# 说明
配置中，内网设备使用的配置为 `bridge.json`，有公网 ip 的设备使用 `portal.json`，通过`portal`连接到内网的设备使用`client.json`。

实际应用中，可以使用`VMESS-TCP、Shadowsocks-2022`等作为Xray Client 到 Xray Portal、Xray Bridge 到 Xray Portal 的传输协议。

## psk

Shadowsocks 2022 使用与 WireGuard 类似的预共享密钥作为密码。

使用 `openssl rand -base64 <长度>` 以生成与 shadowsocks-rust 兼容的密钥，长度取决于所使用的加密方法。

| 加密方法                          | 密钥长度 |
|-------------------------------|-----:|
| 2022-blake3-aes-128-gcm       |   16 |
| 2022-blake3-aes-256-gcm       |   32 |
| 2022-blake3-chacha20-poly1305 |   32 |

在 Go 实现中，32 位密钥始终工作。