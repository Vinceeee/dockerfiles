# How to run [reference](https://github.com/jenkinsci/docker/blob/master/README.md)

> docker run -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts
> docker run -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts

## or you could directly run below image:
```
docker run \
  -u root \
  --rm \
  -d \
  -p 8080:8080 \
  -p 50000:50000 \
  --name jenkins \
  -v jenkins-data:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkinsci/blueocean
```

after build-up , refer to [setup guide](https://jenkins.io/doc/book/installing) for configuration
