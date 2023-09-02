# REALITY
### THE NEXT FUTURE
Server side implementation of REALITY protocol, a fork of package tls in Go 1.19.5.  
For client side, please follow https://github.com/XTLS/Xray-core/blob/main/transport/internet/reality/reality.go.  

TODO List: TODO

## VLESS-XTLS-uTLS-REALITY example for [Xray-core](https://github.com/XTLS/Xray-core) [ENG]
```json5
{
    "inbounds": [ // Server-side inbound configuration
        {
            "listen": "0.0.0.0",
            "port": 443,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "", // Required, generated with ./xray uuid or a 1-30 character string
                        "flow": "xtls-rprx-vision" // Optional, if specified, clients must enable XTLS
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "tcp",
                "security": "reality",
                "realitySettings": {
                    "show": false, // Optional, if true, outputs debug information
                    "dest": "example.com:443", // Required, format similar to VLESS fallbacks' dest
                    "xver": 0, // Optional, format similar to VLESS fallbacks' xver
                    "serverNames": [ // Required, list of serverNames available to clients, * wildcard is not supported yet
                        "example.com",
                        "www.example.com"
                    ],
                    "privateKey": "", // Required, generated with ./xray x25519
                    "minClientVer": "", // Optional, minimum client Xray version, format x.y.z
                    "maxClientVer": "", // Optional, maximum client Xray version, format x.y.z
                    "maxTimeDiff": 0, // Optional, maximum allowed time difference in milliseconds
                    "shortIds": [ // Required, list of shortIds available to clients, can be used to distinguish different clients
                        "", // If this item exists, client shortId can be empty
                        "0123456789abcdef" // 0 to f, length is a multiple of 2, maximum length is 16
                    ]
                }
            }
        }
    ]
}
```
By replacing TLS with REALITY, **you can eliminate server-side TLS fingerprint characteristics**, maintain forward secrecy, **and render certificate chain attacks ineffective**. **This allows for pointing to another website** without the need to purchase a domain or configure a TLS server, **making it more convenient to present a specified SNI throughout the entire TLS handshake**.

Typical use cases for proxying involve minimum requirements for target websites: **foreign websites, support for TLSv1.3 and H2, with non-redirected domains** (the primary domain may be used for redirection to www). Bonus features include proximity in IP (more similar with low latency), encrypted handshake messages after the Server Hello (e.g., dl.google.com), and OCSP Stapling. **Configuration bonuses include blocking traffic back to your country, forwarding TCP/80, and UDP/443** (REALITY externally appears as port forwarding, so it might be better for less commonly used destination IPs).

**REALITY can also be used in conjunction with proxy protocols other than XTLS**, but it is not recommended as they exhibit clear TLS-in-TLS characteristics that have already been targeted. REALITY's next major goal is the "**prebuilt mode**," which involves collecting target website features in advance, while XTLS's next major goal is **0-RTT**.

```json5
{
    "outbounds": [ // Client-side outbound configuration
        {
            "protocol": "vless",
            "settings": {
                "vnext": [
                    {
                        "address": "", // Server's domain or IP
                        "port": 443,
                        "users": [
                            {
                                "id": "", // Matching the server-side
                                "flow": "xtls-rprx-vision", // Matching the server-side
                                "encryption": "none"
                            }
                        ]
                    }
                ]
            },
            "streamSettings": {
                "network": "tcp",
                "security": "reality",
                "realitySettings": {
                    "show": false, // Optional, outputs debug information if true
                    "fingerprint": "chrome", // Required, simulates the client TLS fingerprint using the uTLS library
                    "serverName": "", // One of the server's serverNames
                    "publicKey": "", // The public key corresponding to the server's private key
                    "shortId": "", // One of the server's shortIds
                    "spiderX": "" // Initial path and parameters for web crawlers, recommended to be different for each client
                }
            }
        }
    ]
}
```
REALITY clients should receive a "**temporary trusted certificate**" signed by the "**temporary authentication key.**" However, three scenarios can lead to receiving the target website's genuine certificate:

1. The REALITY server rejects the client's Client Hello, and traffic is redirected to the target website.
2. The client's Client Hello is redirected to the target website by a man-in-the-middle.
3. A man-in-the-middle attack occurs, which could be assisted by the target website or be a certificate chain attack.    

REALITY clients can perfectly distinguish between temporary trusted certificates, genuine certificates, and invalid certificates, and decide the next steps:

1. When a temporary trusted certificate is received, the connection is usable, and everything proceeds as usual.
2. When a genuine certificate is received, the client enters spider mode.
3. When an invalid certificate is received, a TLS alert is triggered, and the connection is terminated.