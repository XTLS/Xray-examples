# Xray - All-in-one Configuration + Nginx(decoy website)

The configuration uses xray's `fallbacks` feature to enable these combinations at the same time on port 443:
* HTTPS:443
    * Trojan-TCP-TLS
    * Trojan-WS-TLS
    * Trojan-gRPC-TLS
    * Trojan-TCP-XTLS(flow: xtls-rprx-direct)
    * Vless-TCP-TLS
    * Vless-WS-TLS
    * Vless-gRPC-TLS
    * VMESS-TCP-TLS
    * VMESS-WS-TLS
    * VMESS-gRPC-TLS
    * ShadowSocks-gRPC

Nginx is used to serve a decory website and route gRPC traffic.

## How it works?
The Trojan-TCP-XTLS is the HTTPS entrypoint. For every incoming request after doing TLS-Termination, based on the **Path** or **ALPN type**, the request is passed to another sub-config. For example:
* If the **Path=/vlessws**, the request is passed to **@vless-ws** sub-config.
* If the **Path=/vmtc**, the request is passed to **@vmess-tcp**. 
* In case of **ALPN=HTTP2**, it's first passed to **@trojan-tcp**. In trojan-tcp, if if it's not a valid request(for example the trojan password is wrong), another fallback is set, to once more pass the request to Nginx HTTP2 Unix Domain Socket and a decory website is served. When the request is using HTTP2, it could also be gRPC, so that is also checked in Nginx. This is how a VMESS-gRPC request is processed:

VMESS-gRPC Request ------> Xray Trojan-TCP-XTLS(443) ----**alpn=h2**----> fallback to xray trojan-tcp ------> fallback to nginx /dev/shm/h2c.sock ---**path=/vmgrpc**---> grpc_pass to xray vmess-gRPC listener on 127.0.0.1:3003

## What to change before use?
* Xray server.json
    * **SSL Certificates and keys** absolute paths in Trojan-TCP-XTLS
    * **Password** of Trojan and ShadowSocks configs
    * **UUID** of Vless and VMESS configs
    * **(Optional)** Path  of all sub-configs. For **Websocket**->`wsSettings.path`, for **TCP**->`tcpSettings.header.request.path` and for **gRPC**->`grpcSettings.serviceName`.
* Nginx nginx.conf
    * Domain names
    * **(Optional)** If gRPC serviceNames are changed server.json, they **should** also be changed in Nginx config


## Notes:
* Tested with **Xray 1.6.1** (Xray, Penetrates Everything.) Custom (go1.19.2 linux/amd64)
* For a little better performance, a DNS Cache could be setup (on 127.0.0.53 in this case) and used for resolving DNS queries. To enable xray to use it uncomment the corresponding rule from the `routing.settings.rules` in server.json.
* Multiple domains could be used at the same time, including domains behind cloudflare CDN. (For cloudflare, make sure websocket and gRPC are enabled in Network section). In this configuration these domains are **example.com** and **behindcdn.com**