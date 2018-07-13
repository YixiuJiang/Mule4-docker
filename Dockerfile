# spring-boot-centos7
FROM openshift/base-centos7

# TODO: Put the maintainer name in the image metadata
MAINTAINER Charlie Jiang <charlie.jiang@pactera.com>

# TODO: Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="Platform for building Mule4 application" \
      io.k8s.display-name="Mule4  builder 1.0" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,java,mule4" \
      io.openshift.s2i.scripts-url=image:///usr/libexec/s2i \
      io.openshift.s2i.destination="/opt/s2i/destination"


#Install Maven, Java
RUN INSTALL_PKGS="tar unzip bc which lsof java-1.8.0-openjdk java-1.8.0-openjdk-devel" && \
    yum install -y --enablerepo=centosplus $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y && \
    mkdir -p /opt/openshift && \
    mkdir -p /opt/app-root/src && chmod -R a+rwX /opt/app-root/src && \
    mkdir -p /opt/s2i/destination && chmod -R a+rwX /opt/s2i/destination

#Add Mule runtime in Docker Container
CMD echo "------ Add Mule runtime in Docker Container --------"
ADD  mule-ee-distribution-standalone-4.1.2.zip /opt
#Adding Work Directory
CMD echo "------ Adding Work Directory --------"
WORKDIR /opt
#Unzipping the added zip
CMD echo "------ Unzipping the added zip --------"
RUN         unzip mule-ee-distribution-standalone-4.1.2.zip
RUN ln -s ./mule-enterprise-standalone-4.1.2 /opt/mule
# Define mount points
VOLUME      ["/opt/mule/logs", "/opt/mule/apps", "/opt/mule/domains"]
# Copy and install license
CMD echo "------ Copy and install license --------"
COPY        mule-ee-license.lic mule/conf/
RUN         mule/bin/mule -installLicense mule/conf/mule-ee-license.lic
#Check if Mule Licence installed
RUN ls -ltr mule/conf/
CMD echo "------ Licence installed ! --------"
#Copy and deploy mule application in runtime

