#Shadowsocks AEAD Quick Start

Server-side JSON

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

Client JSON

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

No need for a graphical interface, just [**Xray-core**](https://github.com/XTLS/Xray-core) can quickly establish Shadowsocks AEAD encryption that supports Socks, HTTP proxy and **UDP FullCone** tunnel.

Xray-core has perfect support for UDP, thanks to the refactoring of each inbound and outbound code. The inbound UDP of Socks can accept requests from any network port.

As you can see, Xray-core also fully unleashes the potential of AEAD, **the server supports multiple users on a single port**, which is not implemented in any official version of Shadowsocks.

So when you need Shadowsocks, you only need Xray-core to solve the problem: high performance, cross-platform, easy to compile, and more powerful functions out of the box.
