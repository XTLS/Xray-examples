# VLESS-XHTTP-Reality-steal_others

[Reality](https://github.com/XTLS/REALITY) and [XHTTP](https://github.com/XTLS/Xray-core/discussions/4113) are two major techniques of Project X which are up-to-date. This example provides a minimal configuration, which can be used for new versions of Xray-core (and cannot be used for low versions, recommended >= [v25.3.6](https://github.com/XTLS/Xray-core/releases/tag/v25.3.6) ). There are also more complicated configurations provided by other community repositories.

#### Note

* Leave the fields blank as much as possible to ensure that users who have not configured their own will be responded to by xray-core with an error.
* Considering practicality, [domain name sniffing](https://xtls.github.io/config/inbound.html#sniffingobject) is enabled.
* The `"fingerprint"` field for Reality has a safe default value of `"chrome"` since version 24.12.18, so it is omitted in this example. Old versions of Xray-Core without a default value should not be able to recognize this configuration file (due to the `"target"` field), so it should be safe to omit it here.