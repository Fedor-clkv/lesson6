FROM ubuntu:22.04
LABEL version="1.2" maintainer="Fedor Chulkov"
RUN apt-get -y update && apt-get -y upgrade
RUN apt install default-jdk -y
RUN apt install maven -y
RUN apt install git -y
ENV TOMCAT_VERSION 9.0.71
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir $CATALINA_HOME
RUN wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.71/bin/apache-tomcat-9.0.71.tar.gz -O /tmp/tomcat.tar.gz
RUN cd /tmp && tar xvfz tomcat.tar.gz
RUN cp -Rv /tmp/apache-tomcat-${TOMCAT_VERSION}/* $CATALINA_HOME
RUN rm -rf /tmp/apache-tomcat-${TOMCAT_VERSION}
RUN rm -rf /tmp/tomcat.tar.gz
WORKDIR /opt
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
WORKDIR /opt/boxfuse-sample-java-war-hello
RUN mvn package
WORKDIR /opt/boxfuse-sample-java-war-hello/target
RUN cp hello-1.0.war /var/lib/tomcat9/webapps
EXPOSE 8080
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]