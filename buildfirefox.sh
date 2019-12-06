#!/bin/bash

./maven.sh

wget https://archive.mozilla.org/pub/firefox/candidates/72.0b2-candidates/build1/linux-x86_64/en-US/firefox-72.0b2.tar.bz2
tar xjf firefox-72.0b2.tar.bz2
wget https://github.com/mozilla/geckodriver/releases/download/v0.26.0/geckodriver-v0.26.0-linux64.tar.gz
tar xzf geckodriver-v0.26.0-linux64.tar.gz
cp geckodriver firefox
pushd firefox
tar -cvf ../firefoxbundle.tar.bz2 *
popd

./apache-maven-3.6.3/bin/mvn deploy:deploy-file \
  -Dfile=firefoxbundle.tar.bz2 \
  -DgroupId=com.octopus.linux \
  -DartifactId=firefoxbundle \
  -Dversion=72.0 \
  -Dpackaging=tar.bz2 \
  -DrepositoryId=octopus-maven-repo \
  -Durl=s3://octopus-maven-repo/release