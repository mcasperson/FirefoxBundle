#!/bin/bash

wget http://mirror.intergrid.com.au/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
tar xzf apache-maven-3.6.3-bin.tar.gz
wget https://archive.mozilla.org/pub/firefox/candidates/72.0b2-candidates/build1/linux-x86_64/en-US/firefox-72.0b2.tar.bz2
tar xjf firefox-72.0b2.tar.bz2
wget https://github.com/mozilla/geckodriver/releases/download/v0.26.0/geckodriver-v0.26.0-linux64.tar.gz
tar xzf geckodriver-v0.26.0-linux64.tar.gz
cp geckodriver firefox
pushd firefox
tar -cvf ../firefoxbundle.tar.bz2 *
popd
wget https://repo1.maven.org/maven2/org/springframework/build/aws-maven/5.0.0.RELEASE/aws-maven-5.0.0.RELEASE.jar
sudo cp aws-maven-5.0.0.RELEASE.jar apache-maven-3.6.3/lib
mkdir ~/.m2
echo "<servers><server><id>octopus-maven-repo</id><username>$AWS_SECRET_KEY</username><password>$AWS_ACCESS_KEY</password></server></servers>" > ~/.m2/settings.xml
./apache-maven-3.6.3/bin/mvn deploy:deploy-file \
  -Dfile=firefox.zip \
  -DgroupId=com.octopus.linux \
  -DartifactId=firefoxbundle \
  -Dversion=72.0 \
  -Dpackaging=tar.bz2 \
  -DrepositoryId=octopus-maven-repo \
  -Durl=s3://octopus-maven-repo/release