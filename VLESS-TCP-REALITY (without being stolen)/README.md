# 不会被偷跑流量的 REALITY

一个老生常谈的问题，对于非法请求, reality都会无脑转发流量去dest，如果reality的dest指向一个cloudflare网站，那么相当于服务端变成了CF的端口转发，任何人扫过来都可以拿来嫖。

目前的解决办法是不要使用这类的网站作为 dest, 懂一点的会告诉你用 nginx 的 stream 滤一遍 SNI 并丢掉非法请求，但是其实 Xray 本身就支持这种操作，这也是这个模板的原理