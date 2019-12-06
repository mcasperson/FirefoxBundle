#!/bin/bash

./maven.sh

wget $DOWNLOAD -O openjdk.tar.gz
tar xzf openjdk.tar.gz
for d in jdk*; do mv $d jdk; done
pushd jdk
tar -cvjf ../linuxopenjdk.tar.bz2 *
popd

./apache-maven-3.6.3/bin/mvn deploy:deploy-file \
  -Dfile=linuxopenjdk.tar.bz2 \
  -DgroupId=com.octopus \
  -DartifactId=linuxopenjdk \
  -Dversion=$VERSION \
  -Dpackaging=tar.bz2 \
  -DrepositoryId=octopus-maven-repo \
  -Durl=s3://octopus-maven-repo/release