FROM ubuntu:22.04
LABEL version="1.3" maintainer="Fedor Chulkov"
# Установку tomcat я посмотрел тут https://gist.github.com/karlhillx/9209ca8e319594888e800bc59a7d0d39

# Создаем переменные
ENV TOMCAT_VERSION 9.0.71
ENV CATALINA_HOME /usr/local/tomcat
ENV JAVA_HOME /usr/lib/jvm/java-18-openjdk-amd64
ENV PATH $CATALINA_HOME/bin:$PATH

# Устанавливаем пакеты openjdk-18-jdk wget maven git
RUN apt-get -y update && apt-get -y upgrade
RUN apt install openjdk-18-jdk -y
RUN apt install wget -y
RUN apt install maven -y
RUN apt install git -y
# Установка tomcat 9
RUN mkdir /usr/local/tomcat
WORKDIR /tmp
RUN wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.71/bin/apache-tomcat-9.0.71.tar.gz
RUN tar xvfz apache-tomcat-9.0.71.tar.gz
RUN cp -Rv apache-tomcat-9.0.71/* /usr/local/tomcat

# Распаковка boxfuse
WORKDIR /opt
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
WORKDIR /opt/boxfuse-sample-java-war-hello
# RUN mvn package
WORKDIR /opt/boxfuse-sample-java-war-hello/target
# RUN cp hello-1.0.war /var/lib/tomcat9/webapps
EXPOSE 8080
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]