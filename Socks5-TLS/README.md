## 关于 SOCKS5 over TLS 方案的安全提示

该配置组合应仅供技术研究/参考使用，因为 **SOCKS5 over TLS 几乎不提供隐密性保证，可被简单地主动探测**。

### 探测方式
对任意未知 TLS 业务，若怀疑其为 SOCKS5/TLS 业务，审查者可向该端口建立一个 TLS 连接并在其上传送 SOCKS5 载荷。

若该服务对 SOCKS5 请求做出响应，无论是否设置 SOCKS5 的鉴权机制，审查者均可通过回包内容一次准确判断该业务是否为 SOCKS5 / TLS。

来自 [@studentmain](https://github.com/studentmain) 的两个典型样例对话：

```
-> 05 01 01
<- 05 ff
```

```
-> 05 02 00 02
<- 05 00 / 05 02
```

### 参考资料
[RFC1928](https://tools.ietf.org/html/rfc1928) 节录如下：
```
   The client connects to the server, and sends a version
   identifier/method selection message:

                   +----+----------+----------+
                   |VER | NMETHODS | METHODS  |
                   +----+----------+----------+
                   | 1  |    1     | 1 to 255 |
                   +----+----------+----------+

   The VER field is set to X'05' for this version of the protocol.  The
   NMETHODS field contains the number of method identifier octets that
   appear in the METHODS field.

   The server selects from one of the methods given in METHODS, and
   sends a METHOD selection message:

                         +----+--------+
                         |VER | METHOD |
                         +----+--------+
                         | 1  |   1    |
                         +----+--------+

   If the selected METHOD is X'FF', none of the methods listed by the
   client are acceptable, and the client MUST close the connection.

   The values currently defined for METHOD are:

          o  X'00' NO AUTHENTICATION REQUIRED
          o  X'01' GSSAPI
          o  X'02' USERNAME/PASSWORD
          o  X'03' to X'7F' IANA ASSIGNED
          o  X'80' to X'FE' RESERVED FOR PRIVATE METHODS
          o  X'FF' NO ACCEPTABLE METHODS

```

[RFC1929](https://tools.ietf.org/html/rfc1929) 节录如下：

```
   The server verifies the supplied UNAME and PASSWD, and sends the
   following response:

                        +----+--------+
                        |VER | STATUS |
                        +----+--------+
                        | 1  |   1    |
                        +----+--------+

   A STATUS field of X'00' indicates success. If the server returns a
   `failure' (STATUS value other than X'00') status, it MUST close the
   connection.
```
