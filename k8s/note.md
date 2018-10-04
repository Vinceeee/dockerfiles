# init
- 拉取镜像脚本 --- pull.sh
- 初始化脚本 -- init.sh 

# post action
### 设置 CNI 否则coreDNS无法启动
- flannel 在1.12.0 的bug 需要人为调整 , 不然无法启动(https://github.com/coreos/flannel/issues/1044)
kubectl apply -f kube-flannel.yml

# show join commands
sudo kubeadm token create --print-join-command
