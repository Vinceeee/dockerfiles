#!/bin/bash

if [[ ! -f /etc/ssh/ssh_host_rsa_key ]]; then
    sshd-keygen
else
    echo "host sshd key already generated."
fi

if [[ ! -f /root/.ssh/id_rsa ]]; then
    ssh-keygen -t rsa -b 4096  -N '' -f /root/.ssh/id_rsa
else
    echo "ssh key already generated."
fi

exec "$@"
