FROM ubuntu:22.04
LABEL version="1.2" maintainer="Fedor Chulkov"
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install openjdk-18-jdk wget
RUN apt install maven -y
RUN apt install git -y
# RUN apt install wget -y
RUN mkdir /usr/local/tomcat
ENV PATH /usr/local/tomcat/bin:$PATH
ENV CATALINA_BASE /usr/local/tomcat/bin
ENV CATALINA_HOME /usr/local/tomcat/bin
WORKDIR /tmp
RUN wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.71/bin/apache-tomcat-9.0.71.tar.gz
RUN tar xvfz apache-tomcat-9.0.71.tar.gz
RUN cp -Rv apache-tomcat-9.0.71/* /usr/local/tomcat
WORKDIR /opt
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
WORKDIR /opt/boxfuse-sample-java-war-hello
# RUN mvn package
WORKDIR /opt/boxfuse-sample-java-war-hello/target
# RUN cp hello-1.0.war /var/lib/tomcat9/webapps
EXPOSE 8080
EXPOSE 80
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]