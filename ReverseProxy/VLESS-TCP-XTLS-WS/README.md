# VLESS over TCP with XTLS + 回落 & 分流 

配合回落，使用 443 端口 + XTLS + WS 和路由分流，实现反向代理，增强隐蔽性。

客户端连接方式有 VLESS over WS with TLS / VLESS over TCP with XTLS 两种

portal 设置默认回落到 80 端口的 Web 服务器（也可以换成数据库、FTP 等），参考 [VLESS-TCP-XTLS-WHATEVER](https://github.com/XTLS/Xray-examples/blob/main/VLESS-TCP-XTLS-WHATEVER/README.md)

# 额外配置
如果你的 portal 在境外，可以使用路由分流来同时实现科学上网 + 访问内网设备。

## 路由分流 
根据配置内提示，在 `Portal` 配置中, 取消注释第一项路由中的：
```       
// "ip": [
//   "geoip:private"
// ],
```

此时流量匹配 `"external"` 或 `"externalws"` 标签，且访问的目标 ip 为`私有 ip 地址`时，才会将流量转发至 bridge，其余流量走 direct。

