version: '2'
services:
  redis:
    image: disgone/redis-node:v3.0
    stdin_open: true
    network_mode: host
    tty: true
    ports:
     - "6379"
    labels:
      io.rancher.container.dns: true
      io.rancher.container.network: true
      io.rancher.scheduler.affinity:container_label_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
      io.rancher.sidekicks: redis-data


  redis-data:
    image: redis:3.2-alpine
    tty: true
    command:
     - cat
    stdin_open: true
    volumes:
     - /data

  sentinel:
    image: disgone/redis-sentinel:v3.0
    ports:
      - "26379"
    tty: true
    depends_on:
      - redis
    labels:
      io.rancher.container.dns: true
      io.rancher.container.network: true
      io.rancher.scheduler.affinity:container_label_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}