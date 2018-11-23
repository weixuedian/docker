#base：centos:7
FROM centos:7.4.1708
#sign
MAINTAINER sujian "112606652@qq.com"

#install docker
ENV DOCKER_FILE=docker-engine-1.10.3-1.el7.centos.x86_64.rpm
COPY centos7_base.repo /etc/yum.repos.d/CentOS-Base.repo
RUN yum install -y docker-engine-selinux gcc-c++ make iptables libcgroup selinux-policy wget git libseccomp libtool-ltdl which 
COPY ${DOCKER_FILE} /opt/
COPY entry.sh /opt/
RUN rpm -ivh /opt/${DOCKER_FILE} && chmod +x /opt/*.sh


#install golang
ENV GO_FILE=go1.11.2.linux-amd64.tar.gz
COPY ${GO_FILE} /opt/
RUN cd /opt && tar zxvf ${GO_FILE} && cp -r  ${GO_FILE} /usr/local

#install jdk
#RUN yum install -y java-1.8.0-openjdk-devel

#install maven
#RUN cd /opt && wget https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz \
#&& ls -l && tar zxvf apache-maven-3.2.5-bin.tar.gz

#install env
#ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.171-7.b10.el7.x86_64
#ENV JRE_HOME=${JAVA_HOME}/jre
#ENV CLASSPATH=.:${JAVA_HOME}/lib:${JAVA_HOME}/jre/lib
ENV GOPATH /go
#ENV MAVEN_HOME=/opt/apache-maven-3.2.5 ${JAVA_HOME}/bin: ${MAVEN_HOME}/bin:${CLASSPATH}:${JRE_HOME}:
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${GOPATH}/bin

#RUN git clone https://github.com/weixuedian/go-module.git && cd go-module && chmod +x execGoMod.sh && sh execGoMod.sh

VOLUME  = ["/cache","/opt/gitlabci/.m2:/root/.m2","/opt/gitlabci/builds:/builds","/go"]
#set work dir
WORKDIR /opt
#enable systemd
CMD ["/opt/entry.sh"]
