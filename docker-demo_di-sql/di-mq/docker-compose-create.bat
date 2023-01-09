docker-compose pull
docker-compose create
del volume-data\*.*

docker-compose start

timeout 60
docker exec -it di-mq-hc-di-mq-1 c:\config\mq-prov.bat

