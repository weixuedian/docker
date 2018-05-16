#base：centos:7
FROM centos:7.4.1708
#sign
MAINTAINER sujian "112606652@qq.com"

#install docker
ENV DOCKER_FILE=docker-engine-1.8.3-1.el7.centos.x86_64.rpm
COPY Centos-7.repo /etc/yum.repos.d/CentOS-Base.repo
RUN yum install -y docker-engine-selinux gcc-c++ make iptables libcgroup selinux-policy wget git
COPY ${DOCKER_FILE} /opt/
COPY entry.sh /opt/
RUN rpm -ivh /opt/${DOCKER_FILE} && chmod +x /opt/*.sh

#install jdk
RUN yum install -y java-1.8.0-openjdk-devel

#install maven
RUN cd /opt && wget https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz \
&& ls -l && tar zxvf apache-maven-3.2.5-bin.tar.gz

#install env
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.161-0.b14.el7_4.x86_64
ENV JRE_HOME=${JAVA_HOME}/jre
ENV CLASSPATH=.:${JAVA_HOME}/lib:${JAVA_HOME}/jre/lib
ENV MAVEN_HOME=/opt/apache-maven-3.2.5
ENV PATH=${JAVA_HOME}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${MAVEN_HOME}/bin

#set work dir
WORKDIR /opt
#enable systemd
CMD ["/opt/entry.sh"]