FROM centos:centos7.6.1810

ADD dj /app
RUN curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo && \
   curl -o /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo && \ 
   yum makecache && yum install -y python-pip gcc python-devel readline-devel patch make && \
   yum clean all &&\
   pip install --no-cache-dir -r /app/requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
WORKDIR /app
  
CMD ["python","manage.py","runserver","0.0.0.0:5000"]
