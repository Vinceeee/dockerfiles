#!/usr/bin/env sh

fqdn="my.registry.com"
# create cerificate
function create_certs() {
    rm -rf certs
    mkdir certs
    openssl req -newkey rsa:4096 -nodes -sha256 -keyout certs/domain.key -x509 -days 1000 -out certs/domain.crt -subj "/C=CN/ST=Guangdong/L=Guangzhou/O=Ame.com/OU=IT/CN=${fqdn}"

    echo "certs generated"
}

# run registry
function create_registry() {
    docker rm -f registry
    rm -rf `pwd`/data
    docker run -d -p 5000:5000  --name registry \
        -v `pwd`/data:/var/lib/registry \
        -v `pwd`/certs:/certs \
        -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
        -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
        -e REGISTRY_HTTP_SECRET=mercury \
        registry
}


function grant_self_auth() {
    sudo mkdir -p /etc/docker/certs.d/$fqdn:5000
    sudo cp certs/domain.crt /etc/docker/certs.d/$fqdn:5000/ca.crt
}

create_certs
create_registry
grant_self_auth
