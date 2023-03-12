# VLESS over TCP with TLS + fallback & split to WebSocket (advanced configuration)

This is a superset of [Minimal Configuration](<../VLESS-TCP-TLS%20(minimal%20by%20rprx)>), using the powerful fallback and distribution features of VLESS, it realizes port 443 VLESS over TCP with TLS and Perfect coexistence of any WSS

This configuration is for reference. You can replace VLESS on WS with any other protocol such as VMess, and set more PATHs and protocol coexistence.

After deployment, you can connect to the server through VLESS over TCP with TLS and any WebSocket with TLS at the same time, the latter of which can be through CDN

According to the actual measurement, the performance of VLESS fallback shunt WS is stronger than that of Nginx reverse generation WS. The traditional VMess + WSS solution can be completely migrated without loss of compatibility.

---

Next, you can try [Ultimate Configuration](../VLESS-TCP-XTLS-WHATEVER): switch to XTLS to achieve ultimate performance, and offload to VMess over TCP, and more fallback and offload suggestions, not only Xray
