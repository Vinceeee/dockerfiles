#! /bin/sh
#
# check_galera.sh
# Copyright (C) 2019 vince <vince@tang-pc>
#
# Distributed under terms of the MIT license.
#

set +e
GALERA_CONF=/etc/mysql/conf.d/galera.cnf

# wsrep checking
function wsrep_check() {
    echo "checking wsrep ${GCOMM} ..."

    OLD_IFS=$IFS
    IFS=,
    for i in {10..0};do
        rc=100
        for host in ${GCOMM};do
            mysql -h ${host} -ugalera -pgalera -e "select 1;"
            rc=$?
            if [ $rc -eq 0 ]; then
                break
            fi
        done
        if [ $rc -eq 0 ]; then
            break
        fi
        echo "checking wsrep ..."
        sleep 1s
    done
    if [[ $i >  0 ]]; then
        return 0
    else
        echo "error in connecting GCOMM "
        return 1
    fi
    IFS=$OLD_IFS
}

if [ ${GALERA_INIT} -ne 1 ];then
    wsrep_check
fi
sed -i "s?wsrep-cluster-address=.*?wsrep-cluster-address=gcomm://${GCOMM}?g" ${GALERA_CONF}
