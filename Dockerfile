FROM ubuntu:22.04
RUN apt update
RUN apt install tomcat9 -y
RUN apt install default-jdk -y
RUN apt install maven -y
RUN apt install git -y
CMD ["mvn"]
EXPOSE 8080
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
RUN cd boxfuse-sample-java-war-hello
RUN nvm package
RUN cd target
RUN cp hello-1.0.war /var/lib/tomcat9/webapps
