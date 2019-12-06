#!/bin/bash

wget http://mirror.intergrid.com.au/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
tar xzf apache-maven-3.6.3-bin.tar.gz
wget https://repo1.maven.org/maven2/com/gkatzioura/maven/cloud/s3-storage-wagon/2.3/s3-storage-wagon-2.3.jar
wget https://repo1.maven.org/maven2/com/gkatzioura/maven/cloud/cloud-storage-core/2.3/cloud-storage-core-2.3.jar
wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-core/1.11.687/aws-java-sdk-core-1.11.687.jar
wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-s3/1.11.687/aws-java-sdk-s3-1.11.687.jar
wget https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.10.1/jackson-databind-2.10.1.jar
wget https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-core/2.10.1/jackson-core-2.10.1.jar
wget https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-annotations/2.10.1/jackson-annotations-2.10.1.jar
wget https://repo1.maven.org/maven2/org/apache/httpcomponents/httpclient/4.5.10/httpclient-4.5.10.jar
wget https://repo1.maven.org/maven2/org/apache/httpcomponents/httpcore/4.4.12/httpcore-4.4.12.jar
wget https://repo1.maven.org/maven2/joda-time/joda-time/2.10.5/joda-time-2.10.5.jar
cp s3-storage-wagon-2.3.jar apache-maven-3.6.3/lib
cp cloud-storage-core-2.3.jar apache-maven-3.6.3/lib
cp aws-java-sdk-core-1.11.687.jar apache-maven-3.6.3/lib
cp aws-java-sdk-s3-1.11.687.jar apache-maven-3.6.3/lib
cp jackson-databind-2.10.1.jar apache-maven-3.6.3/lib
cp jackson-core-2.10.1.jar apache-maven-3.6.3/lib
cp jackson-annotations-2.10.1.jar apache-maven-3.6.3/lib
cp httpclient-4.5.10.jar apache-maven-3.6.3/lib
cp httpcore-4.4.12.jar apache-maven-3.6.3/lib
cp joda-time-2.10.5.jar apache-maven-3.6.3/lib
mkdir ~/.m2
echo "<settings><servers><server><id>octopus-maven-repo</id><username>$AWS_ACCESS_KEY</username><password>$AWS_SECRET_KEY</password><configuration><region>us-east-1</region><publicRepository>false</publicRepository></configuration></server></servers></settings>" > ~/.m2/settings.xml