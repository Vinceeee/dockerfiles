#!/usr/bin/env sh

# load the required images at first

function init() {
    private_ip=192.168.10.10
    sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=192.168.10.10 --node-name=master10 --kubernetes-version=1.12.0 --ignore-preflight-errors=all
}

function post_action() {
    #function_body
    mkdir -p $HOME/.kube
    sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config
}

init
post_action
