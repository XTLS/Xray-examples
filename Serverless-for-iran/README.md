**Project XHTTP https://t.me/projectXhttp**

# Serverless for Iran

bypass censorship without using any server.

Methods:
 * chain-fragment (tlshello + tcp-fragment)
 * noise
 * change hosts

Abilities:
* bypass DPI
* block ads
* direct route for Iran websites

currently(13/2/2025) all services except telegram are accessible in iran.

it doesn't change the IP, so it is not suitable for anonymity and websites that have sanctioned Iran.

Requirements:
* Xray-core
* Default Loyalsoldier's geoip and geosite
* [Iran Hosted Domains](https://github.com/bootmortis/iran-hosted-domains/releases/latest/download/iran.dat)


# Serverless with MitM for Iran

same as "serverless for iran" but using h2c for dns and MitM for these services that support domain fronting:
* youtube
* x
* reddit
* meta (facebook, instagram, ...)

(This list will be updated)

Requirements:
* Xray-core v25.2+
* Default Loyalsoldier's geoip and geosite
* [Iran Hosted Domains](https://github.com/bootmortis/iran-hosted-domains/releases/latest/download/iran.dat)
* a self-signed-certificate: you can create with "./xray tls cert -ca -file=mycert" command.
* also, the certificate must be imported into "Trusted-Root-Certification-Authorities" of system/browser

