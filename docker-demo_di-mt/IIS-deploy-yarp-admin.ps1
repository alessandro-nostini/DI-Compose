cd "C:\inetpub\Sites\Yarp-di-admin"

IISRESET /stop

Compress-Archive -Path C:\inetpub\Sites\Yarp-di-admin -DestinationPath C:\inetpub\Sites\_backup\Yarp-di-admin.zip -force

copy "C:\inetpub\Sites\Yarp-di-admin\appsettings.json" "C:\inetpub\Sites\_web_config\Yarp-di-admin_appsettings.json"
xcopy "\\di-web-1.progel.org\inetpub\Sites\Yarp-di-admin" "C:\inetpub\Sites\Yarp-di-admin" /E /S /J /Y /D
copy "C:\inetpub\Sites\Yarp-di-admin\appsettings.json" "C:\inetpub\Sites\_web_config_dev\Yarp-di-admin_appsettings.json"
copy "C:\inetpub\Sites\_web_config\Yarp-di-admin_appsettings.json" "C:\inetpub\Sites\Yarp-di-admin\appsettings.json"

del "C:\inetpub\Sites\Yarp-di-admin\appsettings.Development.json"

IISRESET /start