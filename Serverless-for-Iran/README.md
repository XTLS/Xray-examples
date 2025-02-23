### Configs here can not contain "bypassing sanctions" contents (not allowed on US GitHub)

### Please join the official Xray Iranian group https://t.me/projectXhttp to get the whole working configs

# Serverless for Iran

bypass censorship using fragment and noise.

it doesn't change the IP, so it is not suitable for anonymity and websites that have sanctioned Iran.

# Serverless with MitM-Domain-Fronting for Iran (Xray-core v25.2.21+)

same as "serverless for Iran" but using h2c(doh domain fronting) for dns and MitM for these services that support domain fronting:
* youtube
* x
* reddit
* meta (facebook, instagram, ...)

(This list will be updated)

you need a self-signed-certificate: you can create with "./xray tls cert -ca -file=mycert" command.
also, the certificate must be imported into "Trusted-Root-Certification-Authorities" of system/browser.
