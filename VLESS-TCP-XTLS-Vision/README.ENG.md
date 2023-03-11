:+1:**XTLS Vision [Introduction](https://github.com/XTLS/Xray-core/discussions/1295)**

**Usage Reminder:**

:exclamation: Compared with the usage base of XTLS Vision, there are almost no reports of Vision being blocked with **correct configuration**. **Correct configuration** refers to:

1. The server uses a reasonable port and prohibits traffic returning to China
2. Only configure XTLS Vision, not compatible with ordinary TLS proxy
3. Fall back to the web page, do not fall back/distribute to other proxy agreements
4. Client enables uTLS (fingerprint) [#1](https://github.com/XTLS/Xray-core/issues/1544#issuecomment-1399194727)

First of all, if you really don't want to be blocked, **please choose a clean IP** first, and build and use XTLS Vision according to **correct configuration**.

**However, even if you do this, there is no guarantee that you will not be blocked** 100%. Since the end of last year, many people's unknown traffic has been blocked in seconds, and TLS in TLS traffic has been blocked every other day. XTLS Vision is not unknown traffic, and fully handles TLS in TLS features, so far it seems to be effective. **But this does not mean that XTLS Vision can be 100% unblocked. It is very, very important to realize this, and don't make a fuss if you are accidentally blocked**.

**Because besides the agreement itself, there are many angles that can block you**. Taking IP as an example, you can't guarantee that the IP is really clean, you can't avoid being affected by neighbors, and you can't avoid the entire IP segment being pulled out of the list. It is also possible that GFWs in certain regions have unique standards. For example, if a certain IP has only a few people accessing it, but it can run so much traffic, it will be blocked. **If your XTLS Vision is blocked, but there is no large-scale blocked report like TLS at the end of last year, I sincerely suggest that you change the port, change the IP, and change the service provider to try again**. [#2](https://github.com/XTLS/Xray-core/issues/1544#issuecomment-1402118517)
