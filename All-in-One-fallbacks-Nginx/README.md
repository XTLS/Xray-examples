# Xray - All-in-one Configuration + Nginx(decoy website)

The configuration uses xray's `fallbacks` feature to enable these **Protocol-Transport** combinations at the same time on port 443:
* HTTPS:443
    * Trojan-TCP-TLS
    * Trojan-WS-TLS
    * Trojan-gRPC-TLS
    * Trojan-H2-TLS
    * Vless-TCP-XTLS(flow: xtls-rprx-vision)
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

[Fallback](https://xtls.github.io/config/features/fallback.html) feature enables an inbound to forward the incoming request to another inbound or another process.

Nginx is used to serve a decoy website to avoid active probing. It's also used to route gRPC traffic(grpc_pass).

## How it works?
The Vless-TCP-XTLS is the HTTPS entrypoint. For every incoming request after doing TLS-Termination, based on the **Path**, **SNI** or **ALPN type**, the request is passed to another inbound(sub-config). For example:
* If the **Path=/vlws**, the request is passed to **@vless-ws** inbound.
* If the **Path=/vmtc**, the request is passed to **@vmess-tcp**.

* If **ALPN=HTTP2** and at the same time the **SNI=trh2o.example.com** then the request is passed to **@trojan-h2**.
* In case of **ALPN=HTTP2**, it's first passed to **@trojan-tcp**. In trojan-tcp, if if it's not a valid request(for example the trojan password is wrong), another fallback is set, to once more pass the request to Nginx HTTP2 Unix Domain Socket and a decory website is served. When the request is using HTTP2, it could also be gRPC, so that is also checked in Nginx. This is how a VMESS-gRPC request is processed:

VMESS-gRPC Request ------> Xray Vless-TCP-XTLS(443) ----**alpn=h2**----> fallback to xray trojan-tcp ------> fallback to nginx /dev/shm/h2c.sock ---**path=/vmgrpc**---> grpc_pass to xray vmess-gRPC listener on [::1]:3003

## What to change before use?
* Xray server.json
    * **SSL Certificates and keys** absolute paths in Vless-TCP-XTLS (`inbounds[0].streamSettings.xtlsSettings.certificates`)
      * For the main domain: 
         * `sed -i 's/\/etc\/ssl\/example.com\/domain.pem/PATH_TO_YOUR_FULLCHAIN/g' *`
         * `sed -i 's/\/etc\/ssl\/example.com\/domain-key.pem/PATH_TO_THE_FULLCHAINS_CERT/g' *`
      * For the domain behind cdn:
         * `sed -i 's/\/etc\/ssl\/behindcdn.com\/domain.pem/PATH_TO_YOUR_FULLCHAIN/g' *`
         * `sed -i 's/\/etc\/ssl\/behindcdn.com\/domain-key.pem/PATH_TO_THE_FULLCHAINS_CERT/g' *`
    * **Your Domain** in both and server (for fallbacks section) and client configs.
      * `sed -i 's/example.com/YOUR_DOMAIN/g' *`  
      * `sed -i 's/behindcdn.com/YOUR_CDN_DOMAIN/g' *` (if you don't have one, remove the config for cdn domain from inbounds[0].streamSettings.tlsSettings.certificates in server.json)
    * **Password** of Trojan and ShadowSocks configs
      * `sed -i 's/desdemona99/YOUR_PASSWORD/g' *` 
    * **UUID** of Vless and VMESS configs
      * `sed -i 's/90e4903e-66a4-45f7-abda-fd5d5ed7f797/YOUR_UUID/g' *`  
    * **(Optional)** Path  of all sub-configs. For **Websocket**-->`wsSettings.path`, for **TCP**-->`tcpSettings.header.request.path`, for **gRPC**-->`grpcSettings.serviceName` and for **H2**-->`httpSettings.path`.
    * **(Optional)** The SNIs of H2 fallbacks (`inbounds[0].settings.fallbacks.[].name`) could also be changed but they should be consistent between client and server. (Read the notes on HTTP2 inbounds)

* Nginx nginx.conf
    * Domain names
      * `sed -i 's/example.com/YOUR_DOMAIN/g' *`
      * `sed -i 's/behindcdn.com/YOUR_CDN_DOMAIN/g' *` (if you don't have one, leave YOUR_CDN_DOMAIN blank.)
    * **(Optional)** If gRPC serviceNames are changed in server.json, they **should** also be changed in Nginx config

## Notes:
* Tested with **Xray 1.7.2** (Xray, Penetrates Everything.) Custom (go1.19.4 linux/amd64)
* For a little better performance, a DNS Cache could be setup (on ::1 in this case) and used for resolving DNS queries. To enable xray to use it uncomment the corresponding rule from the `routing.settings.rules` in server.json.
* Multiple domains could be used at the same time, including domains behind cloudflare CDN. (For cloudflare, make sure websocket and gRPC are enabled in Network section). In this configuration these domains are **example.com** and **behindcdn.com**
* HTTP2 inbounds (Trojan-H2, Vless-H2, VMESS-H2 and ShadowSocks-H2)
    * [HTTP2 Transport does not support fallback based on `path`](https://xtls.github.io/config/transports/h2.html#http-2). That's why SNI is used instead.
    * It's possible to create a CNAME dns record for all the H2 SNIs and use that as the address of the client config without setting custom SNI on client but it's optinal.

    * It is assumed that the **example.com** domain has a **wildcard certificate**. If it's **not** a wildcard certificate or if it's a self-signed certificate, then `streamSettings.tlsSettings.allowInsecure` in the **client configuration** must be `true`. 
* Put `nginx.conf` to your `/etc/nginx/conf.d/` then `systemctl restart nginx`
* If restarting nginx failed, you might have to remove socket files first `rm /dev/shm/{h1.sock,h2c.sock} && nginx -t && systemctl restart nginx` 

## Client link examples

| Combination | Link |
| ----------- | ---- |
| Trojan-TCP | `trojan://desdemona99@example.com:443?security=tls&type=tcp#Trojan-TCP` |
| Trojan-WS | `trojan://desdemona99@example.com:443?security=tls&type=ws&path=/trojanws#Trojna-WS` |
| Trojan-gRPC | `trojan://desdemona99@example.com:443?security=tls&type=grpc&serviceName=trgrpc#Trojan-gRPC` |
| Trojan-H2 | `trojan://desdemona99@example.com:443?sni=trh2o.example.com&security=tls&type=http&path=/trh2#Trojan-H2` |
| Vless-TCP | `vless://90e4903e-66a4-45f7-abda-fd5d5ed7f797@example.com:443?security=tls&type=tcp#Vless-TCP` |
| Vless-WS | `vless://90e4903e-66a4-45f7-abda-fd5d5ed7f797@example.com:443?security=tls&type=ws&path=/vlws#Vless-WS` |
| Vless-gRPC | `vless://90e4903e-66a4-45f7-abda-fd5d5ed7f797@example.com:443?security=tls&type=grpc&serviceName=vlgrpc#Vless-gRPC` |
| Vless-H2 | `vless://90e4903e-66a4-45f7-abda-fd5d5ed7f797@example.com:443?sni=vlh2o.example.com&security=tls&type=http&path=/vlh2#Vless-H2` |
| VMESS-TCP | `vmess://ewogICAgImFkZCI6ICJleGFtcGxlLmNvbSIsCiAgICAiYWlkIjogIjAiLAogICAgImhvc3QiOiAiIiwKICAgICJpZCI6ICI5MGU0OTAzZS02NmE0LTQ1ZjctYWJkYS1mZDVkNWVkN2Y3OTciLAogICAgIm5ldCI6ICJ0Y3AiLAogICAgInBhdGgiOiAiL3ZtdGMiLAogICAgInBvcnQiOiAiNDQzIiwKICAgICJwcyI6ICJWTUVTUy1UQ1AiLAogICAgInNjeSI6ICJub25lIiwKICAgICJzbmkiOiAiIiwKICAgICJ0bHMiOiAidGxzIiwKICAgICJ0eXBlIjogImh0dHAiLAogICAgInYiOiAiMiIKfQo=` |
| VMESS-WS | `vmess://ewogICAgImFkZCI6ICJleGFtcGxlLmNvbSIsCiAgICAiYWlkIjogIjAiLAogICAgImhvc3QiOiAiIiwKICAgICJpZCI6ICI5MGU0OTAzZS02NmE0LTQ1ZjctYWJkYS1mZDVkNWVkN2Y3OTciLAogICAgIm5ldCI6ICJ3cyIsCiAgICAicGF0aCI6ICIvdm13cyIsCiAgICAicG9ydCI6ICI0NDMiLAogICAgInBzIjogIlZNRVNTLVdTIiwKICAgICJzY3kiOiAibm9uZSIsCiAgICAic25pIjogIiIsCiAgICAidGxzIjogInRscyIsCiAgICAidHlwZSI6ICIiLAogICAgInYiOiAiMiIKfQo=` |
| VMESS-gRPC | `vmess://ewogICAgImFkZCI6ICJleGFtcGxlLmNvbSIsCiAgICAiYWlkIjogIjAiLAogICAgImhvc3QiOiAiIiwKICAgICJpZCI6ICI5MGU0OTAzZS02NmE0LTQ1ZjctYWJkYS1mZDVkNWVkN2Y3OTciLAogICAgIm5ldCI6ICJncnBjIiwKICAgICJwYXRoIjogInZtZ3JwYyIsCiAgICAicG9ydCI6ICI0NDMiLAogICAgInBzIjogIlZNRVNTLWdSUEMiLAogICAgInNjeSI6ICJub25lIiwKICAgICJzbmkiOiAiIiwKICAgICJ0bHMiOiAidGxzIiwKICAgICJ0eXBlIjogImh0dHAiLAogICAgInYiOiAiMiIKfQo=` |
| VMESS-H2 | `vmess://ewogICAgImFkZCI6ICJleGFtcGxlLmNvbSIsCiAgICAiYWlkIjogIjAiLAogICAgImhvc3QiOiAiIiwKICAgICJpZCI6ICI5MGU0OTAzZS02NmE0LTQ1ZjctYWJkYS1mZDVkNWVkN2Y3OTciLAogICAgIm5ldCI6ICJodHRwIiwKICAgICJwYXRoIjogIi92bWgyIiwKICAgICJwb3J0IjogIjQ0MyIsCiAgICAicHMiOiAiVk1FU1MtSDIiLAogICAgInNjeSI6ICJub25lIiwKICAgICJzbmkiOiAidm1oMm8uZXhhbXBsZS5jb20iLAogICAgInRscyI6ICJ0bHMiLAogICAgInR5cGUiOiAiaHR0cCIsCiAgICAidiI6ICIyIgp9Cg==` |

## Config generation script
To make all the necessary changes to all the files in this folder a simple script is provided.
### Steps
* Open `generate.sh` and change the top lines to your correct values.
* Run `bash generate.sh -m` inside this folder.
* All the files are changed and your config links are stored in `result.txt`
* Run `bash generate.sh -b` to get one base64 string for all of your configs.
* Run `bash generate.sh -q` to get separate qr codes for all your configs.
* Run `bash generate.sh -r` to revert all the changes. This is necessary for generating configs with new values.

### Important note
Run `-b` and `-q` only after running `-m`. The script should run inside this folder.
