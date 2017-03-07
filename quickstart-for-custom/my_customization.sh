#!/bin/bash

### Anything in this script will run before chef-client
### and the Alfresco repo, Share or Solr reconfiguration

### The main goal for this script is to enable the jar extension
### capability in Alfresco and also allow deployments of
### more jar files outside alfresco.war or share.war
### to install amps refer to the chef-alfresco documentation

# custom packages

#Alfresco repo extension
mkdir -p /usr/share/tomcat-alfresco/modules/platform/
chown tomcat:tomcat /usr/share/tomcat-share/modules/share/
#curl -sL 'https://s3-eu-west-1.amazonaws.com/road2alfresco-utilities/alfresco.xml' -o /etc/tomcat-alfresco/Catalina/localhost/alfresco.xml
#chown tomcat:tomcat /etc/tomcat-alfresco/Catalina/localhost/alfresco.xml
#chmod 700 /etc/tomcat-alfresco/Catalina/localhost/alfresco.xml

# Share extension
mkdir -p /usr/share/tomcat-share/modules/share/
chown tomcat:tomcat /usr/share/tomcat-share/modules/share/
curl -sL 'https://s3-eu-west-1.amazonaws.com/road2alfresco-utilities/share.xml' -o /etc/tomcat-share/Catalina/localhost/share.xml
chown tomcat:tomcat /etc/tomcat-share/Catalina/localhost/share.xml
chmod 700 /etc/tomcat-alfresco/Catalina/localhost/share.xml

# Download support tools and log4j patch
curl -sL 'https://s3-eu-west-1.amazonaws.com/road2alfresco-utilities/jar-modules/platform/log4j-patched-1.0-AlfrescoPatched.jar' -o /usr/share/tomcat-alfresco/modules/platform/log4j-patched-1.0-AlfrescoPatched.jar
chown tomcat:tomcat /usr/share/tomcat-alfresco/modules/platform/log4j-patched-1.0-AlfrescoPatched.jar
curl -sL 'https://s3-eu-west-1.amazonaws.com/road2alfresco-utilities/jar-modules/platform/support-tools.jar' -o /usr/share/tomcat-alfresco/modules/platform/support-tools.jar
chown tomcat:tomcat /usr/share/tomcat-alfresco/modules/platform/support-tools.jar

# Download and replace tomcat context.xml
curl -sL 'https://s3-eu-west-1.amazonaws.com/road2alfresco-utilities/context.xml' -o /etc/tomcat/context.xml
chown tomcat:tomcat /etc/tomcat/context.xml

# Download additional tools:
curl -sL 'https://s3-eu-west-1.amazonaws.com/road2alfresco-utilities/jar-modules/platform/javascript-console-repo-0.7-SNAPSHOT.jar' -o /usr/share/tomcat-alfresco/modules/platform/javascript-console-repo-0.7-SNAPSHOT.jar
curl -sL 'https://s3-eu-west-1.amazonaws.com/road2alfresco-utilities/jar-modules/platform/r2a-bulk-import-api-1.0-SNAPSHOT.jar' -o /usr/share/tomcat-alfresco/modules/platform/r2a-bulk-import-api-1.0-SNAPSHOT.jar
curl -sL 'https://s3-eu-west-1.amazonaws.com/road2alfresco-utilities/jar-modules/platform/r2a-repo-jar-1.0-SNAPSHOT.jar' -o /usr/share/tomcat-alfresco/modules/platform/r2a-repo-jar-1.0-SNAPSHOT.jar
curl -sL 'https://s3-eu-west-1.amazonaws.com/road2alfresco-utilities/jar-modules/share/javascript-console-share-0.7-SNAPSHOT.jar' -o /usr/share/tomcat-share/modules/share/javascript-console-share-0.7-SNAPSHOT.jar
#curl -sL 'https://s3-eu-west-1.amazonaws.com/road2alfresco-utilities/p6spy-3.0.0.jar' -o /usr/share/tomcat-alfresco/lib/p6spy-3.0.0.jar
#curl -sL 'https://s3-eu-west-1.amazonaws.com/road2alfresco-utilities/spy.properties' -o /usr/share/tomcat-alfresco/lib/spy.properties
chown tomcat:tomcat /usr/share/tomcat-alfresco/lib/*
chown tomcat:tomcat  /usr/share/tomcat-alfresco/modules/platform/*
chown tomcat:tomcat  /usr/share/tomcat-alfresco/modules/share/*

# Mount remote filesystem
mkdir -p /usr/share/tomcat/alf_data/contentstore/s4hcdocumentumexport
mount -t nfs4 -o nfsvers=4.1 34.248.188.102:/ /usr/share/tomcat/alf_data/contentstore/s4hcdocumentumexport

# Set back logging to Tomcat files and restart rsyslog
#cat <<EOF > /etc/rsyslog.d/tomcat-alfresco.conf
#programname,contains,"server" /var/log/tomcat-alfresco/alfresco.log
#programname,contains,"server" ~
#EOF
#systemctl restart  rsyslog.service
