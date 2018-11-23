#!/usr/bin/env bash
# 测试构建并且发布docker文件
echo `pwd`
docker rm -fv testaa
 
docker build -t "registry.cn-beijing.aliyuncs.com/tigers/gogitlab:1.10" .
docker push "registry.cn-beijing.aliyuncs.com/tigers/gogitlab:1.10"

#docker build -t "docker-registry.hexun.com/golang/gogitlab:1.10" .
#docker push "docker-registry.hexun.com/golang/gogitlab:1.10"



docker run --name=testaa -d registry.cn-beijing.aliyuncs.com/tigers/gogitlab:1.12