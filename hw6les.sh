#!/bin/bash
apt update
apt install docker.io -y
touch Dockerfile
echo "FROM ubuntu:22.04
RUN apt update
RUN apt install default-jdk -y
RUN apt install tomcat9 -y
RUN apt install maven -y
RUN apt install git -y
EXPOSE 8080
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
RUN cd boxfuse-sample-java-war-hello
RUN nvm package
RUN cd target
RUN cp hello-1.0.war /var/lib/tomcat9/webapps
CMD ["catalina.sh", "run"]" > Dockerfile
docker build -t lesson_6 .
docker run -d -p 46850:8080 lesson_6