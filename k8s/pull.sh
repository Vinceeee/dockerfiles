#!/usr/bin/env sh

lc=mirrorgooglecontainers
#lc=gcr.io/google_containers
#lc=anjia0532

function pull_images() {
    #function_body
    docker pull $lc/kube-apiserver:v1.11.0
    docker pull $lc/kube-controller-manager:v1.11.0
    docker pull $lc/kube-scheduler:v1.11.0
    docker pull $lc/kube-proxy:v1.11.0
    docker pull $lc/pause-amd64:3.1
    docker pull $lc/etcd:3.2.18
#   docker pull coredns/coredns:1.1.3
}

function tag_images() {
    base=k8s.gcr.io
    docker tag  $lc/kube-apiserver:v1.11.0  $base/kube-apiserver:v1.11.0 
    docker tag  $lc/kube-controller-manager:v1.11.0  $base/kube-controller-manager:v1.11.0
    docker tag  $lc/kube-scheduler:v1.11.0  $base/kube-scheduler:v1.11.0
    docker tag  $lc/kube-proxy:v1.11.0  $base/kube-proxy:v1.11.0
    docker tag  $lc/pause-amd64:3.1 $base/pause-amd64:3.1
    docker tag  $lc/etcd:3.2.18 $base/etcd:3.2.18
#   docker tag  $lc/coredns:1.1.3 $base/coredns:1.1.3
}

function remove_images() {
    docker rmi -f $lc/kube-apiserver:v1.11.0
    docker rmi -f $lc/kube-controller-manager:v1.11.0
    docker rmi -f $lc/kube-scheduler:v1.11.0
    docker rmi -f $lc/kube-proxy:v1.11.0
    docker rmi -f $lc/pause:3.1
    docker rmi -f $lc/etcd:3.2.18
#   docker rmi -f $lc/coredns:1.1.3
}


pull_images
tag_images
remove_images
