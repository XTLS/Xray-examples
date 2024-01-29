# Trojan-gRPC-Caddy2/Nginx
## Schematic (Caddy):
Xray client <--- gRPC(TLS) ---> Caddy2 <--- gRPC(cleartext) ---> Xray server
## Nginx:
At the same time, you can also choose to use Nginx. A sample configuration snippet is as follows (partially from [@xqzr](https://github.com/xqzr)):
```conf
server {
listen 443 ssl http2;
         listen [::]:443 ssl http2;
server_name example.com;

index index.html;
root /var/www/html;

ssl_certificate /path/to/example.cer;
ssl_certificate_key /path/to/example.key;
ssl_protocols TLSv1.2 TLSv1.3;
ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE -RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384;

client_header_timeout 1w;
keepalive_timeout 30m;
# Fill in /your ServiceName after location
location /your ServiceName {
if ($content_type !~ "application/grpc") {
return 404;
}
client_max_body_size 0;
client_body_buffer_size 512k;
grpc_set_header X-Real-IP $remote_addr;
client_body_timeout 1w;
grpc_read_timeout 1w;
grpc_send_timeout 1w;
grpc_pass unix:/dev/shm/Xray-Trojan-gRPC.socket;
}
}
```
