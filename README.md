
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Docker Network Routing Issue.
---

A Docker network routing issue occurs when containers are unable to communicate with each other due to problems with the network configuration. This can happen when network traffic is not properly routed between containers or when there are conflicts with IP addresses or port numbers. As a result, applications may experience connectivity issues or fail to function properly. This type of incident can be challenging to diagnose and resolve, requiring expertise in networking and containerization technologies.

### Parameters
```shell
export NETWORK_NAME="PLACEHOLDER"

export CONTAINER_NAME="PLACEHOLDER"

export YOUR_NETWORK_NAME="PLACEHOLDER"
```

## Debug

### Check Docker daemon status
```shell
systemctl status docker
```

### Check Docker network status
```shell
docker network ls
```

### Inspect Docker network to check for routing issues
```shell
docker network inspect ${NETWORK_NAME}
```

### Check Docker logs for any errors
```shell
journalctl -u docker.service
```

### Check container logs for any errors
```shell
docker logs ${CONTAINER_NAME}
```

### Check container IP address
```shell
docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CONTAINER_NAME}
```

### Check Docker daemon status
```shell
systemctl status docker
```

### Check Docker network status
```shell
docker network ls
```

### Inspect Docker network to check for routing issues
```shell
docker network inspect ${NETWORK_NAME}
```

### Check Docker logs for any errors
```shell
journalctl -u docker.service
```

### Check container logs for any errors
```shell
docker logs ${CONTAINER_NAME}
```

### Check container IP address
```shell
docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CONTAINER_NAME}
```

## Repair

### Check the Docker network configuration and ensure that it is set up properly to avoid any potential routing issues.
```shell


#!/bin/bash



# Check if Docker network is configured properly

docker network ls | grep -q ${NETWORK_NAME}



if [ $? -ne 0 ]; then

    # If network is not found, create it

    docker network create ${NETWORK_NAME}

    echo "Created ${NETWORK_NAME} network"

else

    echo "${NETWORK_NAME} network already exists"

fi


```

### If the issue is affecting multiple containers, consider recreating the network entirely.
```shell


#!/bin/bash



# Define the name of the Docker network

NETWORK=${YOUR_NETWORK_NAME}



# Check if the network exists

docker network inspect $NETWORK > /dev/null 2>&1

if [ $? -eq 0 ]; then

  # Remove the network

  docker network rm $NETWORK

  echo "Removed network $NETWORK"

fi



# Recreate the network

docker network create $NETWORK

echo "Created network $NETWORK"


```