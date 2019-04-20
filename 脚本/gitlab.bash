#!/bin/bash
#gitlab安装
cat > /etc/yum.repos.d/gitlab-ce.repo << 'EOF'
[gitlab-ce]
name=Gitlab CE Repository
baseurl=https://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/yum/el$releasever/
gpgcheck=0
enabled=1
EOF
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
sleep 5
#pypi 镜像
#临时使用
yum install wget -y
yum -y install epel-release
yum install python-pip -y
pip install --upgrade pip
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple some-package
pip install pip -U
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pip -U 
#docker-ce
wget -O /etc/yum.repos.d/docker-ce.repo https://download.docker.com/linux/centos/docker-ce.repo
sed -i 's+download.docker.com+mirrors.tuna.tsinghua.edu.cn/docker-ce+g' /etc/yum.repos.d/docker-ce.repo
sed -i 's/enabled=0/enabled=1/g' /etc/yum.repos.d/*.repo 
#配置yum源
sed -i '/^GSSAPI/s/yes/no/g; /UseDNS/d; /Protocol/aUseDNS no' /etc/ssh/sshd_config 
sed -i 's/TimeoutSec=0/TimeoutSec=200/g' /usr/lib/systemd/system/rc-local.service 
sed -i 's#=enforcing#=disabled#g' /etc/selinux/config
setenforce 0
getenforce
systemctl stop firewalld.service
systemctl disable firewalld.service
rpm -aq | grep net-tools || yum install net-tools -y > /dev/null
#检测本机master IP地址
net=$(ls -l /etc/sysconfig/network-scripts/ifcfg-*|awk -F "-" '{print $NF}'|grep -v lo)
IP=$(for var in $net;do ifconfig $var 2>/dev/null;done|grep inet|grep -v inet6|awk '{print $2}')
yum makecache
yum install gitlab-ce.x86_64 -y
/usr/bin/gitlab-ctl reconfigure
sed "s/gitlab.example.com/$IP/g" /etc/gitlab/gitlab.rb |egrep $IP
sed "s/gitlab.example.com/$IP/g" /etc/gitlab/gitlab.rb -i
/usr/bin/gitlab-ctl reconfigure
/usr/bin/gitlab-ctl restart
grep gitlab-ctl /etc/rc.local || {
echo '/usr/bin/gitlab-ctl start' >>/etc/rc.local
chmod +x /etc/rc.local
}