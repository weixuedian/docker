#!/usr/bin/env bash
echo `pwd`
docker rm -fv aaa
docker build -t "registry.cn-beijing.aliyuncs.com/tigers/gitlabci:1.8.3" .
docker push "registry.cn-beijing.aliyuncs.com/tigers/gitlabci:1.8.3"

#docker run --name=aaa -d docker-registry.hexun.com/docker/gitlabci:1.8.3