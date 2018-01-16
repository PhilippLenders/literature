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
 ready
