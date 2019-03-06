#!/usr/bin/env sh


# create cerificate
function create_certs() {
    mkdir certs
    openssl req -newkey rsa:2048 -nodes -sha256 -keyout certs/domain.key -x509 -days 1000 -out certs/domain.crt
    exit 0
}

# make auth 
function make_auth() {
    mkdir auth
    docker run --rm --entrypoint htpasswd registry:2 -Bbn admin 123456 > auth/htpasswd
}

# run registry
function create_registry() {
    docker run -d -p 5000:5000 --restart=always --name registry \
        -v `pwd`/auth:/auth \
#       -e "REGISTRY_AUTH=htpasswd" \
#       -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
#       -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
        -v `pwd`/data:/var/lib/registry \
        -v `pwd`/certs:/certs \
        -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
        -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
        registry:2
}

function create_insecure_registry() {
    docker run -d -p 5000:5000 --restart=always --name registry \
        -v `pwd`/data:/var/lib/registry \
        registry:2
}

# 
function grant_self_auth() {
    fqdn="my.registry.com"
    sudo mkdir -p /etc/docker/certs.d/$fqdn:5000
    sudo cp certs/domain.crt /etc/docker/certs.d/$fqdn:5000/ca.crt
    sudo systemctl restart docker
}

create_certs
make_auth
create_registry
grant_self_auth
#create_insecure_registry
