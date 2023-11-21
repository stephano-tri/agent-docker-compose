FROM local/c7-systemd
RUN yum -y install httpd; yum clean all; systemctl enable httpd.service
EXPOSE 8099
CMD ["/usr/sbin/init"]
WORKDIR /