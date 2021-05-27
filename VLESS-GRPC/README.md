# VLESS-GRPC

## 原理图 (Caddy)：
Xray client <--- gRPC(TLS) ---> Caddy2 <--- gRPC(cleartext) ---> Xray server

## Nginx:

同时，您也可以选择使用 Nginx。示例配置片段如下（来自 [@xqzr](https://github.com/xqzr)）：
```conf
# 在 location 后填写 /{你的 ServiceName}
location {
    if ($content_type !~ "application/grpc") {
        return 404;
    }
    client_max_body_size 0;
    client_body_timeout 1071906480m;
    grpc_read_timeout 1071906480m;
    grpc_pass grpc://127.0.0.1:2002;
}

```
