#!/bin/bash
echo "Copying data to Mongos Router container...."
docker cp db-generation/user.dat mongos_router:/user.dat
docker cp db-generation/article.dat mongos_router:/article.dat
docker cp db-generation/read.dat mongos_router:/read.dat

echo "Loading data in Mongodb collections..."
docker exec -it mongos_router bash -c "mongoimport --db readersDb --collection user --file user.dat"
docker exec -it mongos_router bash -c "mongoimport --db readersDb --collection article --file article.dat"
docker exec -it mongos_router bash -c "mongoimport --db readersDb --collection read --file read.dat"

echo "Data loaded into MongoDb collections...."