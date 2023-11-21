FROM local/c7-systemd
RUN yum -y install httpd; yum clean all; systemctl enable httpd.service
EXPOSE 8098
CMD ["/usr/sbin/init"]
WORKDIR /