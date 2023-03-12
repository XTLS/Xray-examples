# VLESS over TCP with XTLS + fallback & split

Cooperate with fallback, use port 443 + XTLS + WS and route diversion to realize reverse proxy and enhance concealment.

There are two client connection methods: VLESS over WS with TLS / VLESS over TCP with XTLS

The portal setting defaults to the web server on port 80 (it can also be replaced with a database, FTP, etc.), refer to [VLESS-TCP-XTLS-WHATEVER](https://github.com/XTLS/Xray-examples/blob/main/VLESS-TCP-XTLS-WHATEVER/README.md)

# additional configuration
If your portal is outside the country, you can use routing splitting to achieve scientific Internet access + access to intranet devices at the same time.

## Routing split
According to the prompt in the configuration, in the `Portal` configuration, uncomment the first route:
```
// "ip": [
// "geoip:private"
// ],
```

At this time, when the traffic matches the `"external"` or `"externalws"` label, and the target ip of the access is a `private ip address`, the traffic will be forwarded to the bridge, and the rest of the traffic will go direct.
