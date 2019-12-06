#!/bin/bash

./maven.sh

wget https://download-chromium.appspot.com/dl/Linux_x64?type=snapshots -O chrome-linux.zip
unzip chrome-linux.zip
chmod +x chrome-linux/chrome
wget https://chromedriver.storage.googleapis.com/79.0.3945.36/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
chmod +x chromedriver
cp chromedriver chrome-linux
pushd chrome-linux
tar -cvf ../chromebundle.tar.bz2 *
popd

./apache-maven-3.6.3/bin/mvn deploy:deploy-file \
  -Dfile=chromebundle.tar.bz2 \
  -DgroupId=com.octopus.linux \
  -DartifactId=chromebundle \
  -Dversion=72.0 \
  -Dpackaging=tar.bz2 \
  -DrepositoryId=octopus-maven-repo \
  -Durl=s3://octopus-maven-repo/release