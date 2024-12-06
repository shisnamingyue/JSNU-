@echo off
:: 设置Wi-Fi名称
set wifiName=

:: 设置校园网账号
set userId=

:: 设置校园网密码
set Password=

:: 设置目标IP
set targetIP=

:: 设置登录界面URL 类似 http://<网关IP>/drcom/login 或 http://<网关IP>/eportal/ 的地址
set loginPageURL=

:: 设置登录URL 类似 http://<网关IP>/drcom/login 或 http://<网关IP>/eportal/success 的地址

set loginURL=

:: 测试网络连接
ping -n 1 -w 100 %targetIP% | findstr /i "TTL" >nul
if %ERRORLEVEL% equ 0 goto POST

@echo on
:: 如果没有连接Wi-Fi，则尝试连接
netsh wlan connect name=%wifiName%

@echo off
:CHECK_CONNECTION
:: 检查Wi-Fi连接状态
netsh wlan show interface | findstr /i /e %wifiName% >nul
if %ERRORLEVEL% neq 0 goto CHECK_CONNECTION

:POST
@echo on
:: 发送登录请求
curl --max-time 2 --retry 4 --retry-delay 1 -d "DDDDD=%userId%&upass=%Password%" %loginURL%

@echo off
:: 提示登录完成
echo 已尝试登录校园网
pause
