#!/bin/bash

# Step 1: Fetch the local machine's IP address
LOCAL_IP=$(hostname -I | awk '{print $1}')

# Step 2: Update the HOSTIP in setup_mongo_cluster.sh
SETUP_FILE="setup_mongo_cluster.sh"
if [[ -f "$SETUP_FILE" ]]; then
  sed -i "s/HOSTIP=.*/HOSTIP=\"$LOCAL_IP\" # Replaced with the output of hostname -I/" "$SETUP_FILE"
  echo "Updated HOSTIP in $SETUP_FILE to $LOCAL_IP"
else
  echo "Error: $SETUP_FILE not found. Make sure it exists in the current directory."
  exit 1
fi

# Step 3: Change permissions of Bash scripts
LOAD_DATA_FILE="load_data_mongodb.sh"
if [[ -f "$SETUP_FILE" ]]; then
  chmod +x "$SETUP_FILE"
  echo "Made $SETUP_FILE executable."
else
  echo "Error: $SETUP_FILE not found."
  exit 1
fi

if [[ -f "$LOAD_DATA_FILE" ]]; then
  chmod +x "$LOAD_DATA_FILE"
  echo "Made $LOAD_DATA_FILE executable."
else
  echo "Error: $LOAD_DATA_FILE not found."
  exit 1
fi

# Step 4: Set up the MongoDB cluster
echo "Setting up the MongoDB cluster..."
./$SETUP_FILE
if [[ $? -ne 0 ]]; then
  echo "Error: Failed to set up the MongoDB cluster."
  exit 1
fi

# Step 5: Load data into MongoDB
DATA_DIR="db-generation"
if [[ -d "$DATA_DIR" ]]; then
  echo "Found $DATA_DIR directory. Proceeding to load data into MongoDB..."
  ./$LOAD_DATA_FILE
  if [[ $? -ne 0 ]]; then
    echo "Error: Failed to load data into MongoDB."
    exit 1
  fi
else
  echo "Error: $DATA_DIR directory not found. Ensure the data files are in place."
  exit 1
fi

echo "All steps completed successfully!"
