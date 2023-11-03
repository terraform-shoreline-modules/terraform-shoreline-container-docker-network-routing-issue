

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