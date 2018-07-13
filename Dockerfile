FROM java:openjdk-8-jdk
MAINTAINER Charlie Jiang
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
CMD echo "------ Deploying mule application in runtime ! --------"
COPY  tmf-632-party-management-*.jar mule/apps/
RUN ls -ltr mule/apps/
# HTTP Service Port
# Expose the necessary port ranges as required by the Mule Apps
EXPOSE      8081-8082
EXPOSE      9000
EXPOSE      9082
# Mule remote debugger
EXPOSE      5000
# Mule JMX port (must match Mule config file)
EXPOSE      1098
# Mule MMC agent port
EXPOSE      7777
# AMC agent port
EXPOSE      9997
# Start Mule runtime
CMD echo "------ Start Mule runtime --------"
CMD         ["mule/bin/mule"]