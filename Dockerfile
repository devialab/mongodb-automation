FROM ubuntu:16.04
MAINTAINER Alexander De Leon "alex@devialab.com"

ENV REFRESHED_AT 2016-02-25

RUN apt-get -qqy update && \
    apt-get install -qqy \
        ca-certificates \
        libsasl2-2

# MMS automation
VOLUME /var/lib/mongodb-mms-automation
ADD https://cloud.mongodb.com/download/agent/automation/mongodb-mms-automation-agent-manager_2.6.0.1551-1_amd64.ubuntu1604.deb /root/mongodb-mms-automation-agent-manager_2.6.0.deb
RUN dpkg -i /root/mongodb-mms-automation-agent-manager_2.6.0.deb

# MongoDB data volume
VOLUME /data
RUN chown mongodb:mongodb /data

# default MMS automation port
EXPOSE 27000

ENTRYPOINT ["/opt/mongodb-mms-automation/bin/mongodb-mms-automation-agent"]
