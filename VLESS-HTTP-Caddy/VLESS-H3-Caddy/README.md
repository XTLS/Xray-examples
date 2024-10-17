# 原理图：
Xray client <--- H3 ---> Caddy2 <--- H3 ---> Xray server

注意：
由于 H3 没有解密的明文传输标准 这种模式 Caddy 解密流量之后 会重新加密 会增加少许延迟和负载

目前仅 Caddy2 的 v2.9.0-beta.2 版及以后完美支持 Xray 的 H3 入站。
