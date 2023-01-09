cd "C:\inetpub\Sites\Yarp-di-user"

IISRESET /stop

Compress-Archive -Path C:\inetpub\Sites\Yarp-di-user -DestinationPath C:\inetpub\Sites\_backup\Yarp-di-user.zip -force

copy "C:\inetpub\Sites\Yarp-di-user\appsettings.json" "C:\inetpub\Sites\_web_config\Yarp-di-user_appsettings.json"
xcopy "\\di-web-1.progel.org\inetpub\Sites\Yarp-di-user" "C:\inetpub\Sites\Yarp-di-user" /E /S /J /Y /D
copy "C:\inetpub\Sites\Yarp-di-user\appsettings.json" "C:\inetpub\Sites\_web_config_dev\Yarp-di-user_appsettings.json"
copy "C:\inetpub\Sites\_web_config\Yarp-di-user_appsettings.json" "C:\inetpub\Sites\Yarp-di-user\appsettings.json"

del "C:\inetpub\Sites\Yarp-di-user\appsettings.Development.json"

IISRESET /start
