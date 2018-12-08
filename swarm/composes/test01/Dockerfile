FROM python:3.6-alpine3.7
ENV PYTHONUNBUFFERED 1
RUN pip3 install flask -i https://pypi.tuna.tsinghua.edu.cn/simple some-package
RUN mkdir /code
WORKDIR /code
ADD ./code/ /code/
CMD ["python","app.py"]
