FROM local/c7-systemd
RUN yum -y install httpd; yum clean all; systemctl enable httpd.service
RUN yum install -y java-1.8.0-openjdk-devel.x86_64
RUN yum install -y firewalld
RUN yum install -y openssh-server
CMD ["/usr/sbin/init"]
WORKDIR /

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 CMD [ "ps" ]
