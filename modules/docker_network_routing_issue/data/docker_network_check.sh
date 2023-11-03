

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