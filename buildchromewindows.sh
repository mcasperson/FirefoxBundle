#!/bin/bash

./maven.sh

sudo apt-get install p7zip-full

wget $BROWSER -O chromium.7z
7z x chromium.7z
for d in ungoogled-chromium*; do mv $d ungoogled-chromium; done
wget $DRIVER
unzip chromedriver_win32.zip
cp chromedriver.exe ungoogled-chromium
pushd ungoogled-chromium
tar -cvf ../chromebundle.tar.bz2 *
popd

./apache-maven-3.6.3/bin/mvn deploy:deploy-file \
  -Dfile=chromebundle.tar.bz2 \
  -DgroupId=com.octopus.windows \
  -DartifactId=chromebundle \
  -Dversion=$VERSION \
  -Dpackaging=tar.bz2 \
  -DrepositoryId=octopus-maven-repo \
  -Durl=s3://octopus-maven-repo/release