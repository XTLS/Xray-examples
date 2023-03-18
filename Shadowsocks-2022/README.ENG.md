#Shadowsocks2022

Server-side JSON

```json
{
   "inbounds": [
     {
       "port": 1234,
       "protocol": "shadowsocks",
       "settings": {
         "method": "2022-blake3-aes-128-gcm",
         "password": "{{ psk }}",
         "network": "tcp,udp"
       }
     }
   ],
   "outbounds": [
     {
       "protocol": "freedom"
     }
   ]
}
```

Server-side JSON (multi-user)

```json
{
   "inbounds": [
     {
       "port": 1234,
       "protocol": "shadowsocks",
       "settings": {
         "method": "2022-blake3-aes-128-gcm",
         "password": "{{ server psk }}",
         "clients": [
           {
             "password": "{{ user psk }}",
             "email": "my user"
           }
         ],
         "network": "tcp,udp"
       }
     }
   ],
   "outbounds": [
     {
       "protocol": "freedom"
     }
   ]
}
```

Server-side JSON (transit)

```json
{
   "inbounds": [
     {
       "port": 1234,
       "protocol": "shadowsocks",
       "settings": {
         "method": "2022-blake3-aes-128-gcm",
         "password": "{{ relay psk }}",
         "clients": [
           {
             "address": "server",
             "port": 1234,
             "password": "{{ server/user psk }}",
             "email": "my server"
           }
         ],
         "network": "tcp,udp"
       }
     }
   ],
   "outbounds": [
     {
       "protocol": "freedom"
     }
   ]
}
```

Client JSON

```json
{
   "inbounds": [
     {
       "port": 10801,
       "protocol": "socks",
       "settings": {
         "udp": true
       }
     },
     {
       "port": 10802,
       "protocol": "http"
     }
   ],
   "outbounds": [
     {
       "protocol": "shadowsocks",
       "settings": {
         "servers": [
           {
             "address": "{{ host }}",
             "port": 1234,
             "method": "2022-blake3-aes-128-gcm",
             "password": "{{ psk }}"
           }
         ]
       }
     }
   ]
}
```

Client JSON (UDP over TCP)

```json
{
   "inbounds": [
     {
       "port": 10801,
       "protocol": "socks",
       "settings": {
         "udp": true
       }
     },
     {
       "port": 10802,
       "protocol": "http"
     }
   ],
   "outbounds": [
     {
       "protocol": "shadowsocks",
       "settings": {
         "servers": [
           {
             "address": "{{ host }}",
             "port": 1234,
             "method": "2022-blake3-aes-128-gcm",
             "password": "{{ psk }}",
             "uot": true
           }
         ]
       }
     }
   ]
}
```

Client JSON (multi-user)

```json
{
   "inbounds": [
     {
       "port": 10801,
       "protocol": "socks",
       "settings": {
         "udp": true
       }
     },
     {
       "port": 10802,
       "protocol": "http"
     }
   ],
   "outbounds": [
     {
       "protocol": "shadowsocks",
       "settings": {
         "servers": [
           {
             "address": "{{ host }}",
             "port": 1234,
             "method": "2022-blake3-aes-128-gcm",
             "password": "{{ server psk }}:{{ user psk }}"
           }
         ]
       }
     }
   ]
}
```

Client JSON (transit)

```json
{
   "inbounds": [
     {
       "port": 10801,
       "protocol": "socks",
       "settings": {
         "udp": true
       }
     },
     {
       "port": 10802,
       "protocol": "http"
     }
   ],
   "outbounds": [
     {
       "protocol": "shadowsocks",
       "settings": {
         "servers": [
           {
             "address": "{{ host }}",
             "port": 1234,
             "method": "2022-blake3-aes-128-gcm",
             "password": "{{ relay psk }}:{{ user psk }}"
           }
         ]
       }
     }
   ]
}
```

## Password

Shadowsocks 2022 uses a pre-shared key similar to WireGuard for the password.

Use `openssl rand -base64 <length>` to generate a shadowsocks-rust compatible key, the length depends on the encryption method used.

| encryption method | key length |
|--------------------------------|-----:|
| 2022-blake3-aes-128-gcm | 16 |
| 2022-blake3-aes-256-gcm | 32 |
| 2022-blake3-chacha20-poly1305 | 32 |

In the Go implementation, 32-bit keys always work.
