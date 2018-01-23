@echo off
goto weiter
:setenv
set "Path=%SystemRoot%\system32;%SystemRoot%;"
set "Path=C:\Program Files\Git\bin;%PATH%;"
set "Path=C:\Program Files\Git;%PATH%;"
set "Path=C:\base\nodejs;%PATH%;"
set "Path=C:\base\python;%PATH%;"
set "Path=C:\base\php;%PATH%;"
set "Path=C:\base\openssl;%PATH%;"
set "Path=C:\base\maven\bin;%PATH%;"
set "Path=C:\base\tomee\bin;%PATH%;"

set "OPENSSL_CONF=C:\base\openssl\openssl.cnf"
set "JAVA_HOME=C:\base\java\jdk-8u152-windows-x64\jre"
rem set "JAVA_HOME=C:\base\java\jdk1.7.0_25\jre"

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
