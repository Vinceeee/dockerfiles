# How to run this image

- https://hub.docker.com/r/beginor/gitlab-ce/

docker run \
    --detach \
    --publish 8443:443 \
    --publish 8080:80 \
    --name gitlab \
    --restart unless-stopped \
    --volume /mnt/sda1/gitlab/etc:/etc/gitlab \
    --volume /mnt/sda1/gitlab/log:/var/log/gitlab \
    --volume /mnt/sda1/gitlab/data:/var/opt/gitlab \
    beginor/gitlab-ce:11.3.0-ce.0

- You can access a new installation with the login root and password 5iveL!fe, after login you are required to set a unique password.


