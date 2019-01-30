bind = '0.0.0.0:8888'
workers = 1
errorlog ='/var/log/gunicorn.log' 
loglevel = 'info'
accesslog = '/var/log/gunicorn_access.log' 
access_log_format = '%(h)s %(l)s %(u)s %(t)s "%(r)s" %(s)s %(b)s "%(f)s" "%(a)s"'
