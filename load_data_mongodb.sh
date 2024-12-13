#!/bin/bash
echo "Copying data to Mongos Router container...."
docker cp db-generation/user.dat mongos_router:/user.dat
docker cp db-generation/article.dat mongos_router:/article.dat
docker cp db-generation/read.dat mongos_router:/read.dat
docker cp shard_loaders mongos_router:/shard_loaders

echo "Loading shards with user data...."
docker exec -it mongos_router bash -c "mongosh < shard_loaders/users_loader.js"
docker exec -it mongos_router bash -c "mongosh < shard_loaders/articles_loader.js"
docker exec -it mongos_router bash -c "mongosh < shard_loaders/sci_articles_shard_configurer.js"
docker exec -it mongos_router bash -c "mongosh < shard_loaders/reads_shard_configurer.js"

echo "Waiting for shards to stabilize..."
sleep 10
docker exec -it mongos_router bash -c "mongoimport --db readersDb --collection users --file user.dat"
docker exec -it mongos_router bash -c "mongoimport --db readersDb --collection articles --file article.dat"
docker exec -it mongos_router bash -c "mongoimport --db readersDb --collection reads --file read.dat"
sleep 3
docker exec -it mongos_router bash -c "mongosh < shard_loaders/sci_articles_loader.js"
docker exec -it mongos_router bash -c "mongosh < shard_loaders/reads_loader.js"

# echo "Loading data in Mongodb collections..."


# docker exec -it mongos_router bash -c "mongoimport --db readersDb --collection read --file read.dat"

echo "Data loaded into MongoDb collections...."