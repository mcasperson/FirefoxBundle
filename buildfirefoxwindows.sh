#!/bin/bash

./maven.sh

wget $BROWSER -O firefox.zip
unzip firefox.zip
wget $DRIVER -O geckodriver.zip
tar xzf geckodriver.zip
cp geckodriver.exe firefox
pushd firefox
tar -cvjf ../firefoxbundle.tar.bz2 *
popd

./apache-maven-3.6.3/bin/mvn deploy:deploy-file \
  -Dfile=firefoxbundle.tar.bz2 \
  -DgroupId=com.octopus \
  -DartifactId=windowsfirefoxbundle \
  -Dversion=$VERSION \
  -Dpackaging=tar.bz2 \
  -DrepositoryId=octopus-maven-repo \
  -Durl=s3://octopus-maven-repo/release