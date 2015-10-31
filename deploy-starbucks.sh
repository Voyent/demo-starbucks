#!/bin/bash  
set +e

HOST=web1d

#check host and api in config
rm -rf ./dist
gulp || { exit 1; }
cd ./dist
tar -zcvf ../starbucks.tar.gz .
cd ..
scp -i ~/.ssh/ICEsoft_Linux_Test_Key_Pair.pem starbucks.tar.gz ubuntu@$HOST:~/. || { exit 1; }
ssh -i ~/.ssh/ICEsoft_Linux_Test_Key_Pair.pem ubuntu@$HOST

# sudo tar -zxvf ./starbucks.tar.gz -C /usr/share/nginx/html/static/demos/starbucks
