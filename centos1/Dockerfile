FROM local/c7-systemd
RUN yum -y install httpd; yum clean all; systemctl enable httpd.service
RUN yum install -y java-1.8.0-openjdk-devel.x86_64
EXPOSE 8098
CMD ["/usr/sbin/init"]
WORKDIR /