# reverse proxy
# principle
Xray Client <--- VMESS/SS ---> Xray Portal (requires public IP) <--- VMESS/SS ---> Xray Bridge
# illustrate
In the configuration, the internal network device uses `bridge.json`, the device with public network ip uses `portal.json`, and the device connected to the intranet through `portal` uses `client.json`.

In practical applications, `VMESS-TCP, Shadowsocks-2022`, etc. can be used as the transmission protocols from Xray Client to Xray Portal, and from Xray Bridge to Xray Portal.

## psk

Shadowsocks 2022 uses a pre-shared key similar to WireGuard for the password.

Use `openssl rand -base64 <length>` to generate a shadowsocks-rust compatible key, the length depends on the encryption method used.

| encryption method | key length |
|--------------------------------|-----:|
| 2022-blake3-aes-128-gcm | 16 |
| 2022-blake3-aes-256-gcm | 32 |
| 2022-blake3-chacha20-poly1305 | 32 |

In the Go implementation, 32-bit keys always work.
