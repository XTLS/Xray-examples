# VLESS-XHTTP-Reality-steal_others

[Reality](https://github.com/XTLS/REALITY)与[XHTTP](https://github.com/XTLS/Xray-core/discussions/4113)是XTLS项目的两项主要且较新的技术。本示例配置提供一个极简配置，其可在较新版本的Xray-core使用（且无法在低版本使用，建议版本不旧于[v25.3.6](https://github.com/XTLS/Xray-core/releases/tag/v25.3.6)）。目前亦有社区成员在其他仓库提供更复杂的配置方案。

另外根据[一些经验](https://github.com/XTLS/Xray-core/issues/1027)，对于中国大陆用户建议使用[禁回国流量的路由规则](server-block-cn.jsonc)，以避免服务器向境内网站发起连接而被标记为代理。

#### 备注

* 待填字段尽可能留空了，确保未自行配置的用户将被xray-core回应以报错。
* 考虑到实用性，开启了[域名嗅探](https://xtls.github.io/config/inbound.html#sniffingobject)。

* Reality设定的`"fingerprint"`字段自24.12.18版本已有安全的默认值`"chrome"`，故不再标注。没有默认值的旧版Xray-core应该会因无法识别这个配置文件（因target字段），所以此处省略应该是安全的。