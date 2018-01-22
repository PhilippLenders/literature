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
 - [x] create file openssl.cnf in C:\base\openssl open it with editor and put contents from literature/openssl/openssl.cnf
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
