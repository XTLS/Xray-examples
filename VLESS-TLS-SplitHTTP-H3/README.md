# VLESS-TLS-SplitHTTP-H3

## 原理图：

直连：Xray client <--- HTTP3 ---> Xray server

配合 CDN 使用：Xray client <--- HTTP3 ---> CDN <--- HTTP2 or HTTP/1.1 ---> Xray server

## 注意：

默认配置仅支持客户端通过 HTTP3 直连服务端，如需和 CDN 一同使用，请参照注释修改服务端的 alpn。

