# Access almost all websites & services directly, for every person in Iran

**Configs here can not contain "bypassing sanctions" contents (inappropriate on US GitHub)**

**Please join the official Xray Iranian group https://t.me/projectXhttp to get the whole working configs**

# Serverless for Iran

Bypass censorship using TCP/TLS fragment and UDP noises.

It doesn't change your local IP, so it is not suitable for anonymity.

# Serverless with MitM-Domain-Fronting for Iran (Xray-core v25.9.5+)

Same as "Serverless for Iran" but use "DoH h2c + domain fronting" for DNS and MitM for these services that support domain fronting:
* YouTube
* X
* Reddit
* Meta (Facebook, Instagram, ...)

(This list will be updated)

**Requires a self-signed-certificate: You can create it using "./xray tls cert -ca -file=mycert" command.**

**Also, the certificate must be imported into "Trusted-Root-Certification-Authorities" of system/browser.**

## How to import the certificate into the system/browser:

**Windows**:
  
  * System:
    
    Right click on the certificate -> Install certificate -> Local machine -> Place all certificates in the following store -> Select "Trusted Root Certification Authorities"
    
  * Browser(Chrome):
    
    Settings -> Privacy and security -> Security -> Manage certificates -> Manage imported certificates from Windows -> Trusted Root Certification Authorities -> Import -> Select the certificate file -> Place all certificates in the following store -> Select "Trusted Root Certification Authorities"

**Android**:

  * Chromium based browsers and Apps that support user-certificates:

    Setting -> Security and privacy -> More security settings -> Install from device storage -> CA Certificate -> Install anyway -> Select the Certificate file on your storage.

  * Firefox:

    Run the firefox browser -> Settings -> About Firefox -> Tap the Firefox logo five times -> Navigate to Settings -> Secret Settings -> Toggle "Use third party CA certificates"

