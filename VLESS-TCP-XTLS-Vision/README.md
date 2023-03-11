:+1:**XTLS Vision [简介](https://github.com/XTLS/Xray-core/discussions/1295)**

[ENGLISH](README.ENG.md)

**使用提醒：** 

:exclamation:相对于 XTLS Vision 的使用基数，目前几乎没有收到 **配置正确** 的 Vision 被封端口的报告，**配置正确** 指的是：

1. 服务端使用合理的端口，禁回国流量
2. 只配置 XTLS Vision，不兼容普通 TLS 代理
3. 回落到网页，不回落/分流到其它代理协议
4. 客户端启用 uTLS（fingerprint） [#1](https://github.com/XTLS/Xray-core/issues/1544#issuecomment-1399194727)

首先，如果你特别不想被封，**请先选择一个干净的 IP**，并按照 **配置正确** 去搭建、使用 XTLS Vision。

**但是，即使你这样做了，也无法保证 100% 不被封**。自去年底始，很多人的未知流量秒封 IP，TLS in TLS 流量隔天封端口。XTLS Vision 不是未知流量，且完整处理了 TLS in TLS 特征，目前看来效果显著。**但这并不意味着，用 XTLS Vision 可以 100% 不被封，认识到这一点是非常、非常重要的，不要自己偶然被封就大惊小怪**。

**因为除了协议本身，还有很多角度能封你**。以 IP 为例，你无法保证 IP 真的干净，无法避免被邻居波及，无法避免整个 IP 段被重点拉清单。也有可能某些地区的 GFW 有独特的标准，比如某个 IP 只有寥寥数人访问连却能跑那么多流量，封。**如果你的 XTLS Vision 被封了，但没有出现去年底 TLS 那样的大规模被封报告，我真心建议你换端口、换 IP、换服务商依次试一遍**。 [#2](https://github.com/XTLS/Xray-core/issues/1544#issuecomment-1402118517)
