FROM centos:7.5.1804
RUN curl -o /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo && \
    yum install -y python-pip openssh-server openssh-clients && pip install --no-cache-dir ansible==2.6 -i https://mirrors.aliyun.com/pypi/simple/ && \
    yum clean all && rm -rf /var/cache/yum
# generate key
RUN sshd-keygen && ssh-keygen -t rsa -b 4096  -N '' -f /root/.ssh/id_rsa
CMD ["/usr/sbin/sshd","-D"]
