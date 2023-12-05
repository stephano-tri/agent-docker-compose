#!/bin/bash

destination_file="docker-compose.yml"

# Appending text to the destination file
last_number=$(docker ps --format '{{.Names}}' | sort -V | tail -n 1 | cut -c7-)
result=$((last_number + 1))

offsetContainerPort=8094
offsetSSHInstancePort=10022

manipulatedContainerPort=$((last_number + offsetContainerPort))
manipulatedSSHInstancePort=$(((last_number * 100) + offsetSSHInstancePort))

centos_docker="
  centos$result:
      networks:
        - network
      hostname: centos$result
      container_name: centos$result
      privileged: true
      command: /sbin/init
      healthcheck:
        test: [ \"CMD-SHELL\", \"ps\" ]
        interval: 30s
        timeout: 10s
        retries: 3
        start_period: 5s
      restart: always
      ports:
        - "$manipulatedContainerPort:$manipulatedContainerPort"
        - "$manipulatedSSHInstancePort:22"
      deploy:
        resources:
          limits:
            cpus: \"1\"
            memory: \"3g\"
      memswap_limit: \"5g\"
      build:
        context: .
        dockerfile: ./centos$result/Dockerfile
      stdin_open: true
      tty: true
      volumes:
        - ./centos$result/common:/common
        - ./disk$result:/sys/fs/cgroup"

echo -e "$centos_docker" >> $destination_file

cp -r "centos1" "centos$result"
cp -r "disk1" "disk$result"

docker-compose up -d

echo "New Container Configuration Added and Start"