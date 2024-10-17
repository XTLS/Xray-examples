# 原理图：
Xray client <--- H2 ---> Caddy2 <--- H2C ---> Xray server

注意：
目前仅 Caddy2 的 v2.2.0-rc.1 版及以后完美支持 Xray 的 H2C，实现 H2(HTTP/2)应用。
