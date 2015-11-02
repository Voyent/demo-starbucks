#!/bin/bash
set +e
HOST=web1d

echo "...Updating from Git..."
git pull
echo "...Removing old Bower components and Dist..."
rm -rf ./bower_components
rm -rf ./dist
echo "...Updating Bower with new install..."
bower install
echo "...Processing Gulp for production..."
gulp || { exit 1; }
cd ./dist
echo "...Compressing Dist for transfer..."
tar -zcf ../starbucks.tar.gz .
cd ..
echo "...Copying Dist to server..."
scp -i ~/.ssh/ICEsoft_Linux_Test_Key_Pair.pem starbucks.tar.gz ubuntu@$HOST:~/. || { exit 1; }
echo "...Unpacking Dist on server..."
ssh -i ~/.ssh/ICEsoft_Linux_Test_Key_Pair.pem ubuntu@$HOST "sudo tar -zxf /home/ubuntu/starbucks.tar.gz -C /usr/share/nginx/html/static/demos/starbucks"
echo "...Cleaning up local compressed file..."
rm starbucks.tar.gz
