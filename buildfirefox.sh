#!/bin/bash

./maven.sh

wget $BROWSER -O firefox.tar.bz2
tar xjf firefox.tar.bz2
wget $DRIVER
tar xzf geckodriver-v0.26.0-linux64.tar.gz
cp geckodriver firefox
pushd firefox
tar -cvjf ../firefoxbundle.tar.bz2 *
popd

./apache-maven-3.6.3/bin/mvn deploy:deploy-file \
  -Dfile=firefoxbundle.tar.bz2 \
  -DgroupId=com.octopus \
  -DartifactId=linuxfirefoxbundle \
  -Dversion=$VERSION \
  -Dpackaging=tar.bz2 \
  -DrepositoryId=octopus-maven-repo \
  -Durl=s3://octopus-maven-repo/release