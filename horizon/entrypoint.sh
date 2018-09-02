#!/usr/bin/env sh


/opt/horizon/manage.py compilemessages
/opt/horizon/manage.py collectstatic
/opt/horizon/manage.py compress --force
/opt/horizon/manage.py make_web_conf --wsgi



exec "$@"
