FROM ubuntu:18.04 as build
RUN apt-get update
RUN apt install maven -y
RUN apt install openjdk-11-jdk -y
RUN apt install git -y
RUN git clone https://github.com/yankils/hello-world.git
RUN cd hello-world/ && mvn package
RUN cp hello-world/webapp/target/webapp.war /opt/tomcat/webapps/

FROM tomcat:9.0.8-jre8-alpine
COPY --from=build hello-world/webapp/target/webapp.war /usr/local/tomcat/webapps

