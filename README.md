# Mocking Distributed Databases

This project demonstrates the setup of a sharded MongoDB cluster using Docker. 



## Steps to Run the Project

### Clone the Repository

Clone this repository to your local machine and navigate into the project directory:

```bash
git clone git@github.com:nonlinearjunkie/Mocking-Distributed-Databases.git
cd Mocking-Distributed-Databases
```

### Update the Host IP Address
Use the following command to get your local machine's IP address:

```bash
hostname -I
```

Edit the setup_mongo_cluster.sh file and replace the HOSTIP placeholder with your local machine's IP address:

```bash
HOSTIP="192.168.52.25" # Replace with the output of hostname -I
```

### Change Permissions of Bash Scripts
Make the setup and data-loading scripts executable:

```bash
chmod +x setup_mongo_cluster.sh
chmod +x load_data_mongodb.sh
```

### Set Up the MongoDB Cluster
Run the setup script to create the sharded MongoDB cluster:

```bash
./setup_mongo_cluster.sh
```

### Prepare Data for MongoDB
Before running the following scripts, ensure you have downloaded the data generation script and placed the generated files inside the `db-generation` directory, which is located in the root of the project.

### Set Up the MongoDB Cluster
Once the cluster is running, use the following script to load the data into MongoDB:

```bash
./load_data_mongodb.sh
```



## Notes

- All bash scripts are designed for Linux. If you're using Windows, run them using **WSL (Windows Subsystem for Linux)**.

