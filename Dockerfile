FROM centos8
LABEL name="joaorafaelbonilha"

RUN yum install -y java-1.8.0-openjdk.x86_64 wget && \
    yum clean all && \
    rm -rf /var/cache/yum

# Preparacao do ambiente
ENV TOMCAT_MAJOR_VERSION 7
ENV TOMCAT_MINOR_VERSION 7.0.99
ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin:$CATALINA_HOME/scripts

# Download Tomcat 7
RUN wget http://ftp.unicamp.br/pub/apache/tomcat/tomcat-$TOMCAT_MAJOR_VERSION/v$TOMCAT_MINOR_VERSION/bin/apache-tomcat-$TOMCAT_MINOR_VERSION.tar.gz -q && \
    tar -xzf apache-tomcat-$TOMCAT_MINOR_VERSION.tar.gz && \
    rm apache-tomcat-$TOMCAT_MINOR_VERSION.tar.gz && \
    mv apache-tomcat-$TOMCAT_MINOR_VERSION ${CATALINA_HOME}


# Install terraform
ENV TERRAFORM_VERSION 0.12.20
RUN mkdir -p /opt/terraform
RUN wget -nc -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -P /opt/terraform
RUN unzip -q /opt/terraform/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /opt/terraform
ENV PATH $PATH:/opt/terraform

# Make directory which will contain the terraform project and expose as volume
RUN mkdir -p /usr/src/app
VOLUME /usr/src/app

# Change working directory
WORKDIR /usr/src/app

EXPOSE 8080
CMD ["catalina.sh", "run"]