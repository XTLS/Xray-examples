# Xray - All-in-one Configuration + Nginx(decoy website)

The configuration uses xray's `fallbacks` feature to enable this **Protocol-Transport** combinations at the same time on port 443:
* HTTPS:443
    * Trojan-TCP-TLS
    * Trojan-WS-TLS
    * Trojan-gRPC-TLS
    * Trojan-H2-TLS
    * Vless-TCP-XTLS(flow: xtls-rprx-direct)
    * Vless-TCP-TLS
    * Vless-WS-TLS
    * Vless-gRPC-TLS
    * Vless-H2-TLS
    * VMESS-TCP-TLS
    * VMESS-WS-TLS
    * VMESS-gRPC-TLS
    * VMESS-H2-TLS
    * ShadowSocks-TCP-TLS
    * ShadowSocks-WS-TLS
    * ShadowSocks-gRPC
    * ShadowSocks-H2-TLS

[Fallback](https://xtls.github.io/config/features/fallback.html) enables an inbound to forward the incoming request to another inbound.

Nginx is used to serve a decoy website to avoid active probing. It is alsousedto route gRPC traffic(grpc_pass).

## How it works?
The Vless-TCP-XTLS is the HTTPS entrypoint. For every incoming request after doing TLS-Termination, based on the **Path**, **SNI** or **ALPN type**, the request is passed to another inbound(sub-config). For example:
* If the **Path=/vlessws**, the request is passed to **@vless-ws** inbound.
* If the **Path=/vmtc**, the request is passed to **@vmess-tcp**.

* If **ALPN=HTTP2** and at the same time the **SNI=trh2o.example.com** then the request is passed to **@trojan-h2**.
* In case of **ALPN=HTTP2**, it's first passed to **@trojan-tcp**. In trojan-tcp, if if it's not a valid request(for example the trojan password is wrong), another fallback is set, to once more pass the request to Nginx HTTP2 Unix Domain Socket and a decory website is served. When the request is using HTTP2, it could also be gRPC, so that is also checked in Nginx. This is how a VMESS-gRPC request is processed:

VMESS-gRPC Request ------> Xray Vless-TCP-XTLS(443) ----**alpn=h2**----> fallback to xray trojan-tcp ------> fallback to nginx /dev/shm/h2c.sock ---**path=/vmgrpc**---> grpc_pass to xray vmess-gRPC listener on 127.0.0.1:3003

## What to change before use?
* Xray server.json
    * **SSL Certificates and keys** absolute paths in Vless-TCP-XTLS (`inbounds[0].streamSettings.xtlsSettings.certificates`)
    * **Password** of Trojan and ShadowSocks configs
    * **UUID** of Vless and VMESS configs
    * **(Optional)** Path  of all sub-configs. For **Websocket**-->`wsSettings.path`, for **TCP**-->`tcpSettings.header.request.path`, for **gRPC**-->`grpcSettings.serviceName` and for **h2**-->`httpSettings.path`.
* Nginx nginx.conf
    * Domain names
    * **(Optional)** If gRPC serviceNames are changed in server.json, they **should** also be changed in Nginx config


## Notes:
* Tested with **Xray 1.6.1** (Xray, Penetrates Everything.) Custom (go1.19.2 linux/amd64)
* [HTTP2 Transport does not support fallback based on `path`](https://xtls.github.io/config/transports/h2.html#http-2). That's why SNI is used instead.
* For a little better performance, a DNS Cache could be setup (on 127.0.0.53 in this case) and used for resolving DNS queries. To enable xray to use it uncomment the corresponding rule from the `routing.settings.rules` in server.json.
* Multiple domains could be used at the same time, including domains behind cloudflare CDN. (For cloudflare, make sure websocket and gRPC are enabled in Network section). In this configuration these domains are **example.com** and **behindcdn.com**