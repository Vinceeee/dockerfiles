# Account Server wsgi Template
#
# Change %SERVICECONF% to the service conf file you are using
#
# For example:
#     Replace %SERVICECONF% by account-server/1.conf
#
# This file than need to be saved under /var/www/swift/%SERVICENAME%.wsgi
# * Replace %SERVICENAME% with the service name you use your system
#   E.g. Replace %SERVICENAME% by account-server-1

from swift.common.wsgi import init_request_processor
application, conf, logger, log_name = \
    init_request_processor('/etc/swift/account-server.conf','account-server')
