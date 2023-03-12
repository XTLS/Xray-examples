# VLESS over TCP with TLS + fallback (simplest configuration)
 

You need to have a domain name resolved to the server IP, and apply for a certificate, such as let's encrypt

You also need an Nginx: (or any web server like Caddy)

1. Use the package manager that comes with the system to install nginx. For details, please Google
2. The default configuration of nginx is to listen to port 80, no need to modify
3. Optional: Find and replace the index.html and other files that come with nginx
4. Execute `systemctl enable nginx` to set up autostart
5. Execute `systemctl start nginx` to start nginx

If the server has a firewall enabled or the VPS has a security group, remember to allow ports TCP/80 and 443

---

Next, you can learn about [site building configuration](<../VLESS-TCP-TLS%20(maximal%20by%20rprx)>) (fall back to advanced usage), try [advanced configuration](<../VLESS- TCP-TLS-WS%20(recommended)>) (distribution to WebSocket)
