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
wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-core/1.11.687/aws-java-sdk-core-1.11.687.jar
wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-s3/1.11.687/aws-java-sdk-s3-1.11.687.jar
wget https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.10.1/jackson-databind-2.10.1.jar
wget https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-core/2.10.1/jackson-core-2.10.1.jar
wget https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-annotations/2.10.1/jackson-annotations-2.10.1.jar
wget https://repo1.maven.org/maven2/org/apache/httpcomponents/httpclient/4.5.10/httpclient-4.5.10.jar
wget https://repo1.maven.org/maven2/org/apache/httpcomponents/httpcore/4.4.12/httpcore-4.4.12.jar
wget https://repo1.maven.org/maven2/joda-time/joda-time/2.10.5/joda-time-2.10.5.jar
cp aws-maven-5.0.0.RELEASE.jar apache-maven-3.6.3/lib
cp aws-java-sdk-core-1.11.687.jar apache-maven-3.6.3/lib
cp aws-java-sdk-s3-1.11.687.jar apache-maven-3.6.3/lib
cp jackson-databind-2.10.1.jar apache-maven-3.6.3/lib
cp jackson-core-2.10.1.jar apache-maven-3.6.3/lib
cp jackson-annotations-2.10.1.jar apache-maven-3.6.3/lib
cp httpclient-4.5.10.jar apache-maven-3.6.3/lib
cp httpcore-4.4.12.jar apache-maven-3.6.3/lib
cp joda-time-2.10.5.jar apache-maven-3.6.3/lib
mkdir ~/.m2
echo "<settings><servers><server><id>octopus-maven-repo</id><username>$AWS_ACCESS_KEY</username><password>$AWS_SECRET_KEY</password></server></servers></settings>" > ~/.m2/settings.xml
./apache-maven-3.6.3/bin/mvn deploy:deploy-file \
  -Dfile=firefoxbundle.tar.bz2 \
  -DgroupId=com.octopus.linux \
  -DartifactId=firefoxbundle \
  -Dversion=72.0 \
  -Dpackaging=tar.bz2 \
  -DrepositoryId=octopus-maven-repo \
  -Durl=s3://octopus-maven-repo/release