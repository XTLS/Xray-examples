# Shadowsocks 2022

服务端 JSON

```json
{
  "inbounds": [
    {
      "port": 1234,
      "protocol": "shadowsocks",
      "settings": {
        "method": "2022-blake3-aes-128-gcm",
        "password": "{{ psk }}",
        "network": "tcp,udp"
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
```

客户端 JSON

```json
{
  "inbounds": [
    {
      "port": 10801,
      "protocol": "socks",
      "settings": {
        "udp": true
      }
    },
    {
      "port": 10802,
      "protocol": "http"
    }
  ],
  "outbounds": [
    {
      "protocol": "shadowsocks",
      "settings": {
        "servers": [
          {
            "address": "{{ host }}",
            "port": 1234,
            "method": "2022-blake3-aes-128-gcm",
            "password": "{{ psk }}"
          }
        ]
      }
    }
  ]
}
```

## Password

Shadowsocks 2022 使用与 WireGuard 类似的预共享密钥作为密码。

使用 `openssl rand -base64 <长度>` 以生成与 shadowsocks-rust 兼容的密钥，长度取决于所使用的加密方法。

| 加密方法                          | 密钥长度 |
|-------------------------------|-----:|
| 2022-blake3-aes-128-gcm       |   16 |
| 2022-blake3-aes-256-gcm       |   32 |
| 2022-blake3-chacha20-poly1305 |   32 |

在 Go 实现中，32 位密钥始终工作。