FROM centos:7.5.1804
RUN curl -o /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo && \
    yum install -y python-pip && pip install --no-cache-dir ansible==2.6 -i https://mirrors.aliyun.com/pypi/simple/ && \
    yum clean all && rm -rf /var/cache/yum
CMD ["/usr/sbin/init"]
