#!/bin/bash

INIT_CHECK="/.init_check"

if [[ -f $CH ]]; then
    echo "Horizon has been already initialized ."
    exec "$@"
fi

/horizon/manage.py make_web_conf --wsgi

touch $INIT_CHECK
echo "Horizon configuration completed."


exec "$@"
