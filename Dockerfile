FROM ubuntu:22.04
LABEL version="3" maintainer="Fedor Chulkov"

# Задаем пепременные
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

# Установка openjdk maven git wget
RUN apt update -y
RUN apt upgrade -y
RUN apt install default-jdk -y
RUN apt install maven -y
RUN apt install git -y
RUN apt install wget -y

# Установка Tomcat
# Создаем рабочую директорию и перехожим в /tmp
RUN mkdir /usr/local/tomcat
WORKDIR /tmp
# Скачиваем архив и распаковываем его
RUN wget https://archive.apache.org/dist/tomcat/tomcat-10/v10.0.20/bin/apache-tomcat-10.0.20.tar.gz
RUN tar xvfz apache-tomcat-10.0.20.tar.gz
# Копируем распакованные файлы в рабочую директорию
RUN cp -Rv /tmp/apache-tomcat-10.0.20/* /usr/local/tomcat/

# Далее сборка boxfuse
WORKDIR /opt
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
WORKDIR /opt/boxfuse-sample-java-war-hello
RUN mvn package
WORKDIR /opt/boxfuse-sample-java-war-hello/target
RUN cp -R hello-1.0.war /var/lib/tomcat9/webapps

EXPOSE 8080
# Устанавливаем в качестве основного процесса catalina.sh
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]