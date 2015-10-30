#!/bin/bash  

HOST=web1d

#check host and api in config
rm -rf ./dist
gulp
# TODO fix gulpfile.js to add admin.js and user.js
cp app/scripts/admin.js ./dist/scripts/
cp app/scripts/user.js ./dist/scripts/
cd ./dist
tar -zcvf ../starbucks.tar.gz .
cd ..
scp -i ~/.ssh/ICEsoft_Linux_Test_Key_Pair.pem starbucks.tar.gz ubuntu@$HOST:~/.
ssh -i ~/.ssh/ICEsoft_Linux_Test_Key_Pair.pem ubuntu@$HOST

# sudo tar -zxvf ./starbucks.tar.gz -C /usr/share/nginx/html/static/demos/starbucks
