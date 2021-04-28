FROM amazonlinux

ARG splunkRPMURL
ARG splunkAdminPassword

LABEL maintainer="github.com/ua-iso"
LABEL version="2021.04.001"
LABEL description="Stand-alone container for Splunk Sandbox"

# Install EPEL
RUN amazon-linux-extras install epel -y

# Update, install applications, and clean updates
RUN yum update -y && \
  yum install python3 screen zsh ansible wget procps -y && \
  yum clean all && \
  rm -rf /var/cache/yum

# Install Splunk
RUN wget -O /opt/splunk.rpm "$splunkRPMURL" && \
	rpm -i /opt/splunk.rpm && \
	rm /opt/splunk.rpm && \
	chown -R splunk:splunk /opt/splunk
COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
RUN echo -e '\n[user_info] \nUSERNAME=admin \nPASSWORD='$splunkAdminPassword >> /opt/splunk/etc/system/default/user-seed.conf
USER splunk
RUN echo "OPTIMISTIC_ABOUT_FILE_LOCKING = 1" > /opt/splunk//etc/splunk-launch.conf && \
	/opt/splunk/bin/splunk start --accept-license && \
	/opt/splunk/bin/splunk stop && \
	mkdir /opt/splunk/etc/apps/splunkSandbox-workspace/

EXPOSE 8000

VOLUME /opt/splunk/etc/apps/splunkSandbox-workspace/

ENTRYPOINT ["/entrypoint.sh"]
CMD ["splunk"]