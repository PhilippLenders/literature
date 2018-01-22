# literature
#### install nodejs/npm local/portable on windows 10 64 bit, 16.01.2018
> download "node-v8.9.4-win-x64.zip" from https://nodejs.org/dist/v8.9.4/

 - [x] create folder C:\base
 - [x] extract node-v8.9.4-win-x64.zip to C:\base\nodejs, result should be C:\base\nodejs\node.exe
 - [x] create file npmrc in C:\base\nodejs
 - [x] open CMD, got to C:\base\nodejs an type: "rename npmrc .npmrc"
 - [x] open C:\base\nodejs\\.npmrc with editor and put
```
 prefix = C:\\base\\nodejs
```
 - [x] create folder C:\base\nodejs\etc
 - [x] create file npmrc in C:\base\nodejs\etc open it with editor and put
```
cache = C:\\base\\nodejs\\npm-cache
tmp = C:\\base\\nodejs\\tmp
```
now nodejs is fully installed local/portable to use it from CMD go on reading

for more informations on npm folders see https://docs.npmjs.com/files/folders
 - [x] create file console.bat in C:\base open it with editor and put
```
@echo off
goto weiter
:setenv
set "Path=C:\base\nodejs;"

goto :EOF
:weiter

if "%1" equ "setenv" (
    echo.
    echo  base console v0.1, logged in %date% %time%
    echo  environment set, ready to use
    echo  welcome %username% from %userdomain%
    call :setenv
) else (
    setlocal
    title console
    prompt $P#
    start "" /B %COMSPEC% /K "%~f0" setenv
)

```
 - [x] execute console.bat and type "node -v" you will see v8.9.4
 - [x] type "npm --version" you will see 5.6.0
 - [x] now when you install npm packages globaly (for example forever: "npm install -g forever") it works right out of the box
 - [x] type forever -h and see it in action
 
 ready

#### php with nginx on windows 10 64 bit, 17.01.2018
> download "php-7.2.1-nts-Win32-VC15-x86.zip" from http://windows.php.net/download
> download "RunHiddenConsole.zip" from http://redmine.lighttpd.net/attachments/660

 - [x] create folder C:\base\php
 - [x] extract php-7.2.1-nts-Win32-VC15-x86.zip to C:\base\php, result should be C:\base\php\php-cgi.exe
 - [x] extract RunHiddenConsole.zip to C:\base, result should be C:\base\RunHiddenConsole.exe
 - [x] copy C:\base\php\php.ini-development to C:\base\php\php.ini
 - [x] create file start.php-cgi.bat in C:\base open it with editor and put
 ```
@echo off
set "Path=C:\base\php;"
echo starting PHP FastCGI...
RunHiddenConsole.exe php-cgi.exe -c "php\php.ini" -b 127.0.0.1:9000
 ```
 - [x] create file stop.php-cgi.bat in C:\base open it with editor and put
 ```
@echo off
set "Path=C:\base\php;"
echo stopping PHP FastCGI...
C:\Windows\System32\taskkill.exe /F /IM php-cgi.exe
 ```
 - [x] now by doubleclick on start.php-cgi.bat, php-cgi runs and listens on 127.0.0.1:9000
 - [x] by doubleclick on stop.php-cgi.bat, php-cgi exits

 ready

#### install self signed certificate with openssl on nginx on windows 10 64 bit, 22.01.2018
> download "openssl-1.0.2l-x64_86-win64.zip" from https://indy.fulgan.com/SSL/ found under https://wiki.openssl.org/index.php/Binaries

 - [x] create folder C:\base\openssl
 - [x] extract openssl-1.0.2l-x64_86-win64.zip to C:\base\openssl, result should be C:\base\openssl\openssl.exe
 - [x] create file openssl.cnf in C:\base\openssl open it with editor and put
```
#
# OpenSSL example configuration file.
# This is mostly being used for generation of certificate requests.
#

# This definition stops the following lines choking if HOME isn't
# defined.
HOME			= .
RANDFILE		= $ENV::HOME/.rnd

# Extra OBJECT IDENTIFIER info:
#oid_file		= $ENV::HOME/.oid
oid_section		= new_oids

# To use this configuration file with the "-extfile" option of the
# "openssl x509" utility, name here the section containing the
# X.509v3 extensions to use:
# extensions		= 
# (Alternatively, use a configuration file that has only
# X.509v3 extensions in its main [= default] section.)

[ new_oids ]

# We can add new OIDs in here for use by 'ca' and 'req'.
# Add a simple OID like this:
# testoid1=1.2.3.4
# Or use config file substitution like this:
# testoid2=${testoid1}.5.6

####################################################################
[ ca ]
default_ca	= CA_default		# The default ca section

####################################################################
[ CA_default ]

dir		= ./CA			# Where everything is kept
certs		= $dir/certs		# Where the issued certs are kept
crl_dir		= $dir/crl		# Where the issued crl are kept
database	= $dir/index.txt	# database index file.
new_certs_dir	= $dir/newcerts		# default place for new certs.

certificate	= $dir/cacert.pem 	# The CA certificate
serial		= $dir/serial 		# The current serial number
crl		= $dir/crl.pem 		# The current CRL
private_key	= $dir/private/cakey.pem# The private key
RANDFILE	= $dir/private/.rand	# private random number file

x509_extensions	= usr_cert		# The extentions to add to the cert

# Extensions to add to a CRL. Note: Netscape communicator chokes on V2 CRLs
# so this is commented out by default to leave a V1 CRL.
# crl_extensions	= crl_ext

default_days	= 365			# how long to certify for
default_crl_days= 30			# how long before next CRL
default_md	= md5			# which md to use.
preserve	= no			# keep passed DN ordering

# A few difference way of specifying how similar the request should look
# For type CA, the listed attributes must be the same, and the optional
# and supplied fields are just that :-)
policy		= policy_match

# For the CA policy
[ policy_match ]
countryName		= match
stateOrProvinceName	= match
organizationName	= match
organizationalUnitName	= optional
commonName		= supplied
emailAddress		= optional

# For the 'anything' policy
# At this point in time, you must list all acceptable 'object'
# types.
[ policy_anything ]
countryName		= optional
stateOrProvinceName	= optional
localityName		= optional
organizationName	= optional
organizationalUnitName	= optional
commonName		= supplied
emailAddress		= optional

####################################################################
[ req ]
default_bits		= 2048
default_keyfile 	= privkey.pem
distinguished_name	= req_distinguished_name
attributes		= req_attributes
x509_extensions	= v3_ca	# The extentions to add to the self signed cert

# Passwords for private keys if not present they will be prompted for
# input_password = secret
# output_password = secret

# This sets a mask for permitted string types. There are several options. 
# default: PrintableString, T61String, BMPString.
# pkix	 : PrintableString, BMPString.
# utf8only: only UTF8Strings.
# nombstr : PrintableString, T61String (no BMPStrings or UTF8Strings).
# MASK:XXXX a literal mask value.
# WARNING: current versions of Netscape crash on BMPStrings or UTF8Strings
# so use this option with caution!
string_mask = nombstr

# req_extensions = v3_req # The extensions to add to a certificate request

[ req_distinguished_name ]
countryName			= Country Name (2 letter code)
countryName_default		= DE
countryName_min			= 2
countryName_max			= 2

stateOrProvinceName		= State or Province Name (full name)
stateOrProvinceName_default	= Some-State

localityName			= Locality Name (eg, city)

0.organizationName		= Organization Name (eg, company)
0.organizationName_default	= Internet Widgits Pty Ltd

# we can do this but it is not needed normally :-)
#1.organizationName		= Second Organization Name (eg, company)
#1.organizationName_default	= World Wide Web Pty Ltd

organizationalUnitName		= Organizational Unit Name (eg, section)
#organizationalUnitName_default	=

commonName			= Common Name (eg, YOUR name)
commonName_max			= 64

emailAddress			= Email Address
emailAddress_max		= 40

# SET-ex3			= SET extension number 3

[ req_attributes ]
challengePassword		= A challenge password
challengePassword_min		= 4
challengePassword_max		= 20

unstructuredName		= An optional company name

[ usr_cert ]

# These extensions are added when 'ca' signs a request.

# This goes against PKIX guidelines but some CAs do it and some software
# requires this to avoid interpreting an end user certificate as a CA.

basicConstraints=CA:FALSE

# Here are some examples of the usage of nsCertType. If it is omitted
# the certificate can be used for anything *except* object signing.

# This is OK for an SSL server.
# nsCertType			= server

# For an object signing certificate this would be used.
# nsCertType = objsign

# For normal client use this is typical
# nsCertType = client, email

# and for everything including object signing:
# nsCertType = client, email, objsign

# This is typical in keyUsage for a client certificate.
# keyUsage = nonRepudiation, digitalSignature, keyEncipherment

# This will be displayed in Netscape's comment listbox.
nsComment			= "OpenSSL Generated Certificate"

# PKIX recommendations harmless if included in all certificates.
subjectKeyIdentifier=hash
authorityKeyIdentifier=keyid,issuer:always

# This stuff is for subjectAltName and issuerAltname.
# Import the email address.
# subjectAltName=email:copy

# Copy subject details
# issuerAltName=issuer:copy

#nsCaRevocationUrl		= http://www.domain.dom/ca-crl.pem
#nsBaseUrl
#nsRevocationUrl
#nsRenewalUrl
#nsCaPolicyUrl
#nsSslServerName

[ v3_req ]

# Extensions to add to a certificate request

basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment

[ v3_ca ]


# Extensions for a typical CA


# PKIX recommendation.

subjectKeyIdentifier=hash

authorityKeyIdentifier=keyid:always,issuer:always

# This is what PKIX recommends but some broken software chokes on critical
# extensions.
#basicConstraints = critical,CA:true
# So we do this instead.
basicConstraints = CA:true

# Key usage: this is typical for a CA certificate. However since it will
# prevent it being used as an test self-signed certificate it is best
# left out by default.
# keyUsage = cRLSign, keyCertSign

# Some might want this also
# nsCertType = sslCA, emailCA

# Include email address in subject alt name: another PKIX recommendation
# subjectAltName=email:copy
# Copy issuer details
# issuerAltName=issuer:copy

# DER hex encoding of an extension: beware experts only!
# obj=DER:02:03
# Where 'obj' is a standard or added object
# You can even override a supported extension:
# basicConstraints= critical, DER:30:03:01:01:FF

[ crl_ext ]

# CRL extensions.
# Only issuerAltName and authorityKeyIdentifier make any sense in a CRL.

# issuerAltName=issuer:copy
authorityKeyIdentifier=keyid:always,issuer:always
```
 - [x] add following lines to console.bat in C:\base
```
set "Path=C:\base\openssl;%PATH%;"
set "OPENSSL_CONF=C:\base\openssl\openssl.cnf"
```
 - [x] create folder C:\base\openssl\ca, C:\base\openssl\ca\key, C:\base\openssl\ca\csr, C:\base\openssl\ca\crt, C:\base\openssl\ca\pem
 - [x] run console.bat **as Administrator**
 - [x] run command "openssl rand -out C:\base\openssl\.rnd -base64 4096"
 - [x] run command "openssl genrsa -des3 -out C:\base\openssl\ca\key\server.key 2048"
 - [x] Removing passphrase from key for nginx by running command "openssl rsa -in C:\base\openssl\ca\key\server.key -out C:\base\openssl\ca\key\server_without_pw.key"
 - [x] run command "openssl req -new -key C:\base\openssl\ca\key\server.key -out C:\base\openssl\ca\csr\localhost.csr"
 - [x] for Common Name (eg, YOUR name) []:localhost
 - [x] run command "openssl x509 -req -days 1024 -in C:\base\openssl\ca\csr\localhost.csr -signkey C:\base\openssl\ca\key\server.key -out C:\base\openssl\ca\crt\localhost.crt"
 - [x] optional: run command "openssl x509 -in C:\base\openssl\ca\crt\localhost.crt -out C:\base\openssl\ca\pem\localhost.pem -outform PEM"
 - [x] copy C:\base\openssl\ca\key\server_without_pw.key and C:\base\openssl\ca\csr\localhost.csr to C:\base\nginx\conf
 - [x] open C:\base\nginx\nginx.conf with editor and put between http {...}
 ```
server {
    listen       443 ssl;
    server_name  localhost;

    ssl_certificate      localhost.crt;
    ssl_certificate_key  server_without_pw.key;

    ssl_session_cache    shared:SSL:1m;
    ssl_session_timeout  5m;

    #ssl_ciphers  HIGH:!aNULL:!MD5;
    #ssl_prefer_server_ciphers  on;

    location / {
        root   "C:\base\www";
        index  index.html index.htm index.php;
    }

    location ~ \.php$ {
        root           "C:\base\www";
        fastcgi_pass   127.0.0.1:9000;
        fastcgi_index  index.php;
        fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
        include        fastcgi_params;
    }
}
 ```

 ready

#### install sublimetext 3 local/portable on windows 10 64 bit, upcoming
#### install git on windows 10 64 bit, upcoming
#### npm got to know, 16.01.2018
-dd, --verbose: --loglevel verbose
https://docs.npmjs.com/misc/config#shorthands-and-other-cli-niceties
