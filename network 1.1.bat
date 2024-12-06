@echo off
:: 设置Wi-Fi名称
set wifiName=i-Star

:: 设置校园网账号
set userId=3020235103

:: 设置校园网密码
set Password=ZZj20050114.

:: 设置目标IP
set targetIP=202.195.64.98

:: 设置登录界面URL
set loginPageURL=http://202.195.64.98/eportal/index.jsp?wlanuserip=eeca0934a929967b3a9515283a5df31e&wlanacname=f79292c779ba613022cf572f09d96928&ssid=&nasip=35f11b1e8ffa899cbf81061ff6ad8dc4&mac=e263998cb73093f14e44191433461654&t=wireless-v2&url=fbf9194c3bd98c85273eedd6145f126601062e1baff13291&ticket=ST-1284601-Z8fbzcl127owulTeT2cJ94qUu6Mrg-sso-7f4fc7dc9f-w4gxt

:: 设置登录URL
set loginURL=http://202.195.64.98/eportal/success.jsp?userIndex=33356631316231653866666138393963626638313036316666366164386463345f31302e31392e35382e3134365f33303230323335313033&keepaliveInterval=0

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
