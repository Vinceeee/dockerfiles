# ansible note

#### 设置密码登录并执行相关操作:
1. 在/etc/ansible/hosts中指定用户账号密码
2. 在/etc/ansible/ansible.cfg中将host_key_check 设为 False

#### 使用sudo执行安装yum
> ansible cluster -m yum -a "name=vim state=latest" --sudo
