# Shadowsocks AEAD 快速上手

服务端 JSON

```json
{
    "inbounds": [
        {
            "port": 12345,
            "protocol": "shadowsocks",
            "settings": {
                "clients": [
                    {
                        "password": "example_user_1",
                        "method": "aes-128-gcm"
                    },
                    {
                        "password": "example_user_2",
                        "method": "aes-256-gcm"
                    },
                    {
                        "password": "example_user_3",
                        "method": "chacha20-poly1305"
                    }
                ],
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
                        "address": "",
                        "port": 12345,
                        "password": "example_user_1",
                        "method": "aes-128-gcm"
                    }
                ]
            }
        }
    ]
}
```

## What's happening

无需图形界面，只需 [**Xray-core**](https://github.com/XTLS/Xray-core) 即可快速建立支持 Socks、HTTP 代理以及 **UDP FullCone** 的 Shadowsocks AEAD 加密隧道。

Xray-core 对 UDP 有完美的支持，得益于重构了各出入站的代码。其中 Socks 入站的 UDP 可以接受来自任何网口的请求。

如你所见，Xray-core 还充分释放了 AEAD 的潜力，**服务端支持单端口多用户**，这是 Shadowsocks 各官方版本均未实现的。

所以当你需要 Shadowsocks 时，只需 Xray-core 即可解决问题：高性能、跨平台、易编译，还有更多强大的功能开箱即用。
