#！/bin/bash

for DIR in db-generation/articles/*/
do
    for FILE in "${DIR}"*
        do
        BASEFILENAME=$(basename $FILE)
        mongofiles --host=${HOSTIP}:60001 --local=$FILE -d=ddbs put $BASEFILENAME 
        # echo "{$BASEFILENAME} loaded"
    done      
done