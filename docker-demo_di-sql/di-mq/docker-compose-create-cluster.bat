docker-compose pull
docker-compose create

docker-compose cp ./nginx/nginx.conf hc-di-mq-nginx:/nginx/conf/

#Start container 'server'

docker-compose start hc-di-mq-nginx
docker-compose start hc-di-mq-a
docker-compose start hc-di-mq-b
docker-compose start hc-di-mq-b

#Enable Statistics

docker-compose exec -it hc-di-mq-a rabbitmq-plugins.bat enable rabbitmq_management
docker-compose exec -it hc-di-mq-b rabbitmq-plugins.bat enable rabbitmq_management
docker-compose exec -it hc-di-mq-c rabbitmq-plugins.bat enable rabbitmq_management

#set node 1

docker-compose exec -it hc-di-mq-a rabbitmqctl.bat set_cluster_name rabbit@rabbit-di
docker-compose exec -it hc-di-mq-a rabbitmqctl.bat cluster_status

#join node 2

docker-compose exec -it hc-di-mq-b rabbitmqctl.bat stop_app
docker-compose exec -it hc-di-mq-b rabbitmqctl.bat reset
docker-compose exec -it hc-di-mq-b rabbitmqctl.bat join_cluster rabbit@hc-di-mq-a
docker-compose exec -it hc-di-mq-b rabbitmqctl.bat start_app
docker-compose exec -it hc-di-mq-b rabbitmqctl.bat cluster_status

#join node 3

docker-compose exec -it hc-di-mq-c rabbitmqctl.bat stop_app
docker-compose exec -it hc-di-mq-c rabbitmqctl.bat reset
docker-compose exec -it hc-di-mq-c rabbitmqctl.bat join_cluster rabbit@hc-di-mq-a
docker-compose exec -it hc-di-mq-c rabbitmqctl.bat start_app
docker-compose exec -it hc-di-mq-c rabbitmqctl.bat cluster_status

#Policy (per ora no, usa code quorum invece che replicate con fed)

# docker-compose exec -it hc-di-mq-a rabbitmq-plugins.bat enable rabbitmq_federation
# docker-compose exec -it hc-di-mq-b rabbitmq-plugins.bat enable rabbitmq_federation
# docker-compose exec -it hc-di-mq-c rabbitmq-plugins.bat enable rabbitmq_federation
# 
# docker-compose exec -it hc-di-mq-a rabbitmqctl.bat set_policy ha-fed ".*" "{'federation-upstream-set':'all', 'ha-sync-mode':'automatic', 'ha-mode':'all'}" --priority 1 --apply-to queues

# Da testare
#
# docker-compose exec -it hc-di-mq-a rabbitmqctl.bat set_policy queue-quorum-mem-opt ".*" "{'x-max-in-memory-length':0}" --apply-to queues


#Account DEMO

docker-compose exec -it hc-di-mq-a c:\config\mq-prov.bat
